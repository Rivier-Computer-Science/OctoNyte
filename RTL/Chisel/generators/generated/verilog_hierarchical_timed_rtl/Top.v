`timescale 1ns/1ps
// Turn off these warning classes in this file
// verilator lint_off WIDTHEXPAND
// verilator lint_off CASEINCOMPLETE

module Top #(
    parameter MEMORY_SIZE = 1048576 //262144  // 262kW = 1MB
)(
    input wire clock,
    input wire reset,
    output reg trap
);

// ========== PIPELINE REGISTERS ==========

// Stage 1: Fetch (F)
reg [31:0] pc;

// Stage 2: Decode/Read RF (D)
reg [31:0] D_pc, D_instruction;
reg D_valid;

// Stage 3: Execute (E) 
reg [31:0] E_pc, E_instruction;
reg [31:0] E_rs1_data, E_rs2_data;
reg [31:0] E_imm_i, E_imm_s, E_imm_b, E_imm_u, E_imm_j;
reg [4:0] E_rd, E_rs1, E_rs2;
reg [6:0] E_opcode;
reg [2:0] E_funct3;
reg [6:0] E_funct7;
reg E_valid;

// Stage 4: Writeback (W)
reg [31:0] W_pc, W_instruction;
reg [31:0] W_alu_result, W_write_data;
reg [4:0] W_rd;
reg [6:0] W_opcode;
reg [2:0] W_funct3;
reg W_reg_write, W_mem_write;
reg [31:0] W_mem_addr, W_mem_wdata;
reg W_valid;

// ========== SHARED RESOURCES ==========

// Register file and memory
reg [31:0] registers [0:31];
reg [31:0] memory [0:MEMORY_SIZE-1];

// Pipeline control
reg pipeline_stall, pipeline_flush;
reg [31:0] branch_target;
reg branch_taken;

integer i;

// Add string variable for memory file
reg [8*256:1] memfile;

// Calculate memory address bounds based on parameter
// Updated to use 0x00000000 base address to match memory file format
wire [31:0] memory_base = 32'h0000_0000;
wire [31:0] memory_size_bytes = MEMORY_SIZE * 4;  // Convert to bytes first
wire [31:0] memory_top = memory_base + memory_size_bytes;

// ========== INITIALIZATION ==========
initial begin
    trap = 1'b0;
    
    // Initialize pipeline registers
    D_valid = 1'b0;
    E_valid = 1'b0;
    W_valid = 1'b0;
    
    // Display memory configuration
    $display("Memory configuration: %0d words (%0d KB) from 0x%08x to 0x%08x", 
             MEMORY_SIZE, (MEMORY_SIZE * 4) / 1024, memory_base, memory_top - 1);
    
    // Check for memory file parameter
    if ($test$plusargs("MEMFILE")) begin
        $value$plusargs("MEMFILE=%s", memfile);
        $readmemh(memfile, memory);
        $display("Loaded memory from file: %s", memfile);
    end else begin
        // Initialize memory to zero if no file provided
        for (i = 0; i < MEMORY_SIZE; i = i + 1) memory[i] = 32'h0;
    end
    
    // Initialize registers
    for (i = 0; i < 32; i = i + 1) registers[i] = 32'h0;
end

// ========== STAGE 1: FETCH ==========
reg [31:0] F_instruction;

always @(*) begin
    if (pc >= memory_base && pc < memory_top) begin
        // Updated memory access: no offset needed since memory_base is 0
        F_instruction = memory[pc >> 2];
    end else begin
        F_instruction = 32'h00000013; // NOP for out-of-bounds access
        if (pc != memory_base) // Don't warn on initial PC
            $display("Warning: PC 0x%08x is outside memory bounds [0x%08x, 0x%08x)", 
                     pc, memory_base, memory_top - 1);
    end
end

// ========== STAGE 2: DECODE/READ RF ==========
wire [6:0] D_opcode = D_instruction[6:0];
wire [4:0] D_rd = D_instruction[11:7];
wire [4:0] D_rs1 = D_instruction[19:15];
wire [4:0] D_rs2 = D_instruction[24:20];
wire [2:0] D_funct3 = D_instruction[14:12];
wire [6:0] D_funct7 = D_instruction[31:25];

// Immediate generation
wire [31:0] D_imm_i = {{20{D_instruction[31]}}, D_instruction[31:20]};
wire [31:0] D_imm_s = {{20{D_instruction[31]}}, D_instruction[31:25], D_instruction[11:7]};
wire [31:0] D_imm_b = {{19{D_instruction[31]}}, D_instruction[31], D_instruction[7],
                       D_instruction[30:25], D_instruction[11:8], 1'b0};
wire [31:0] D_imm_u = {D_instruction[31:12], 12'b0};
wire [31:0] D_imm_j = {{11{D_instruction[31]}}, D_instruction[31], D_instruction[19:12],
                       D_instruction[20], D_instruction[30:21], 1'b0};

// Register file read with forwarding
wire [31:0] D_rs1_data, D_rs2_data;

assign D_rs1_data = (D_rs1 == 0) ? 32'h0 :
                    (W_valid && W_reg_write && W_rd == D_rs1) ? W_write_data :
                    registers[D_rs1];

assign D_rs2_data = (D_rs2 == 0) ? 32'h0 :
                    (W_valid && W_reg_write && W_rd == D_rs2) ? W_write_data :
                    registers[D_rs2];

// ========== STAGE 3: EXECUTE ==========
reg [31:0] E_alu_result;

// ALU computation
always @(*) begin
    E_alu_result = 32'h0;
    case (E_opcode)
        7'b0010011: begin // I-type
            case (E_funct3)
                3'b000: E_alu_result = E_rs1_data + E_imm_i;                    // ADDI
                3'b010: E_alu_result = ($signed(E_rs1_data) < $signed(E_imm_i)) ? 1 : 0; // SLTI
                3'b011: E_alu_result = (E_rs1_data < E_imm_i)                   ? 1 : 0; // SLTIU
                3'b100: E_alu_result = E_rs1_data ^ E_imm_i;                    // XORI
                3'b110: E_alu_result = E_rs1_data | E_imm_i;                    // ORI
                3'b111: E_alu_result = E_rs1_data & E_imm_i;                    // ANDI
                3'b001: E_alu_result = E_rs1_data << E_imm_i[4:0];              // SLLI
                3'b101: E_alu_result = E_funct7[5] 
                    ? ($signed(E_rs1_data) >>> E_imm_i[4:0])  // SRAI
                    : (E_rs1_data >> E_imm_i[4:0]);           // SRLI
                default: E_alu_result = 0;
            endcase
        end
        
        7'b0110011: begin // R-type
            case (E_funct3)
                3'b000: E_alu_result = E_funct7[5] 
                    ? (E_rs1_data - E_rs2_data)               // SUB
                    : (E_rs1_data + E_rs2_data);              // ADD
                3'b001: E_alu_result = E_rs1_data << E_rs2_data[4:0];           // SLL
                3'b010: E_alu_result = ($signed(E_rs1_data) < $signed(E_rs2_data)) ? 1 : 0; // SLT
                3'b011: E_alu_result = (E_rs1_data < E_rs2_data) ? 1 : 0;       // SLTU
                3'b100: E_alu_result = E_rs1_data ^ E_rs2_data;                 // XOR
                3'b101: E_alu_result = E_funct7[5]
                    ? ($signed(E_rs1_data) >>> E_rs2_data[4:0]) // SRA
                    : (E_rs1_data >> E_rs2_data[4:0]);          // SRL
                3'b110: E_alu_result = E_rs1_data | E_rs2_data;                 // OR
                3'b111: E_alu_result = E_rs1_data & E_rs2_data;                 // AND
                default: E_alu_result = 0;
            endcase
        end
        
        7'b0000011: E_alu_result = E_rs1_data + E_imm_i;   // Load
        7'b0100011: E_alu_result = E_rs1_data + E_imm_s;   // Store
        7'b1100011: E_alu_result = E_rs1_data - E_rs2_data; // Branch compare
        7'b0110111: E_alu_result = E_imm_u;                // LUI
        7'b0010111: E_alu_result = E_pc + E_imm_u;         // AUIPC
        7'b1101111,
        7'b1100111: E_alu_result = E_pc + 4;               // JAL / JALR writeback
        default: E_alu_result = 0;
    endcase
end

// Branch/Jump logic
always @(*) begin
    branch_taken = 1'b0;
    branch_target = E_pc + 4;
    
    case (E_opcode)
        7'b1100011: begin // Branches
            case (E_funct3)
                3'b000: branch_taken = (E_alu_result == 0);                 // BEQ
                3'b001: branch_taken = (E_alu_result != 0);                 // BNE
                3'b100: branch_taken = ($signed(E_alu_result) < 0);         // BLT
                3'b101: branch_taken = ($signed(E_alu_result) >= 0);        // BGE
                3'b110: branch_taken = (E_rs1_data < E_rs2_data);           // BLTU
                3'b111: branch_taken = (E_rs1_data >= E_rs2_data);          // BGEU
                default: branch_taken = 0;
            endcase
            if (branch_taken)
                branch_target = E_pc + E_imm_b;
        end
        
        7'b1101111: begin // JAL
            branch_taken = 1'b1;
            branch_target = E_pc + E_imm_j;
        end
        
        7'b1100111: begin // JALR
            branch_taken = 1'b1;
            branch_target = (E_rs1_data + E_imm_i) & ~32'h1;
        end
    endcase
end

// Control signal generation for writeback stage
reg E_reg_write, E_mem_read, E_mem_write;
reg [31:0] E_write_data;

always @(*) begin
    E_reg_write = 1'b0;
    E_mem_read = 1'b0;
    E_mem_write = 1'b0;
    E_write_data = E_alu_result;
    
    case (E_opcode)
        7'b0010011, 7'b0110111, 7'b0010111: begin // I-type, LUI, AUIPC
            E_reg_write = (E_rd != 0);
        end
        
        7'b0110011: begin // R-type
            E_reg_write = (E_rd != 0);
        end
        
        7'b0000011: begin // Load
            E_reg_write = (E_rd != 0);
            E_mem_read = 1'b1;
        end
        
        7'b0100011: begin // Store
            E_mem_write = 1'b1;
        end
        
        7'b1101111, 7'b1100111: begin // JAL, JALR
            E_reg_write = (E_rd != 0);
        end
    endcase
end

// ========== STAGE 4: WRITEBACK ==========

// Memory read logic
always @(*) begin
    if (W_opcode == 7'b0000011) begin // Load
        if (W_mem_addr >= memory_base && W_mem_addr < memory_top) begin
            // Updated memory access: no offset needed since memory_base is 0
            W_write_data = memory[W_mem_addr >> 2];
        end else begin
            W_write_data = 32'h0;
            if (W_valid)
                $display("Warning: Load from address 0x%08x is outside memory bounds", W_mem_addr);
        end
    end else begin
        W_write_data = W_alu_result;
    end
end

// ========== PIPELINE CONTROL ==========

// Stall detection (for now, no stalls - can be extended for data hazards)
always @(*) begin
    pipeline_stall = 1'b0;
    pipeline_flush = branch_taken && E_valid;
end

// ========== SEQUENTIAL LOGIC ==========
always @(posedge clock) begin
    if (reset) begin
        // Reset all pipeline stages
        pc <= memory_base;  // PC now starts at 0x00000000
        D_valid <= 1'b0;
        E_valid <= 1'b0;
        W_valid <= 1'b0;
        trap <= 1'b0;
        
        // Reset registers
        for (i = 0; i < 32; i = i + 1) registers[i] <= 32'h0;
        
    end else if (!pipeline_stall) begin
        
        // ========== STAGE 4: WRITEBACK ==========
        if (W_valid) begin
            // Register writeback
            if (W_reg_write && W_rd != 0) begin
                registers[W_rd] <= W_write_data;
            end
            
            // Memory write
            if (W_mem_write) begin
                if (W_mem_addr >= memory_base && W_mem_addr < memory_top) begin
                    // Updated memory access: no offset needed since memory_base is 0
                    memory[W_mem_addr >> 2] <= W_mem_wdata;
                end else begin
                    $display("Warning: Store to address 0x%08x is outside memory bounds", W_mem_addr);
                end
            end
            
            // EBREAK detection
            if (W_instruction == 32'h00100073) begin
                trap <= 1'b1;
            end
        end
        
        // ========== STAGE 3: EXECUTE -> WRITEBACK ==========
        W_pc <= E_pc;
        W_instruction <= E_instruction;
        W_alu_result <= E_alu_result;
        W_rd <= E_rd;
        W_opcode <= E_opcode;
        W_funct3 <= E_funct3;
        W_reg_write <= E_reg_write;
        W_mem_write <= E_mem_write;
        W_mem_addr <= E_alu_result;
        W_mem_wdata <= E_rs2_data;
        W_valid <= E_valid;
        
        // ========== STAGE 2: DECODE -> EXECUTE ==========
        if (!pipeline_flush) begin
            E_pc <= D_pc;
            E_instruction <= D_instruction;
            E_rs1_data <= D_rs1_data;
            E_rs2_data <= D_rs2_data;
            E_imm_i <= D_imm_i;
            E_imm_s <= D_imm_s;
            E_imm_b <= D_imm_b;
            E_imm_u <= D_imm_u;
            E_imm_j <= D_imm_j;
            E_rd <= D_rd;
            E_rs1 <= D_rs1;
            E_rs2 <= D_rs2;
            E_opcode <= D_opcode;
            E_funct3 <= D_funct3;
            E_funct7 <= D_funct7;
            E_valid <= D_valid;
        end else begin
            // Flush execute stage
            E_valid <= 1'b0;
        end
        
        // ========== STAGE 1: FETCH -> DECODE ==========
        if (!pipeline_flush) begin
            D_pc <= pc;
            D_instruction <= F_instruction;
            D_valid <= 1'b1;
        end else begin
            // Flush decode stage
            D_valid <= 1'b0;
        end
        
        // ========== PC UPDATE ==========
        if (branch_taken && E_valid) begin
            pc <= branch_target;
        end else begin
            pc <= pc + 4;
        end
    end
end

endmodule