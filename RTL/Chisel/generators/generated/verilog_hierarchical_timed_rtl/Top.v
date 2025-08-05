`timescale 1ns/1ps

module Top #(
    parameter MEMORY_SIZE = 524288  // 2MB (512K words), configurable
) (
    input wire clock,
    input wire reset,
    output reg trap
);

// Memory configuration
wire [31:0] memory_base = 32'h0000_0000;
wire [31:0] memory_size_bytes = MEMORY_SIZE * 4;  // Convert to bytes first
wire [31:0] memory_top = memory_base + memory_size_bytes;

// Memory array - parameterized size
reg [31:0] memory [0:MEMORY_SIZE-1];

// Pipeline registers
// Fetch stage
reg [31:0] pc;
reg [31:0] F_instruction;

// Decode stage  
reg [31:0] D_pc;
reg [31:0] D_instruction;
reg [4:0] D_rd, D_rs1, D_rs2;
reg [2:0] D_funct3;
reg [6:0] D_funct7, D_opcode;
reg [31:0] D_imm_i, D_imm_s, D_imm_b, D_imm_u, D_imm_j;
reg [31:0] D_rs1_data, D_rs2_data;

// Execute stage
reg [31:0] E_pc;
reg [4:0] E_rd;
reg [6:0] E_opcode;
reg [2:0] E_funct3;
reg [6:0] E_funct7;
reg [31:0] E_rs1_data, E_rs2_data;
reg [31:0] E_imm_i, E_imm_s, E_imm_b, E_imm_u, E_imm_j;
reg [31:0] E_alu_result;
reg E_reg_write, E_mem_read, E_mem_write, E_branch_taken;
reg [31:0] E_mem_addr, E_mem_wdata, E_write_data;
reg [31:0] E_next_pc;

// Writeback stage
reg [31:0] W_pc;
reg [4:0] W_rd;
reg [6:0] W_opcode;
reg [2:0] W_funct3;
reg [31:0] W_alu_result;
reg W_reg_write, W_mem_read, W_mem_write;
reg [31:0] W_mem_addr, W_mem_wdata, W_write_data;

// Register file
reg [31:0] registers [0:31];

// Pipeline control
reg pipeline_flush;
reg pipeline_stall;

// Warning suppression counters
reg [15:0] load_warning_count;
reg [15:0] store_warning_count;
parameter MAX_WARNINGS = 10;  // Limit warnings to reduce output spam

// Memory file handling
reg [8*256:1] memfile;

integer i;

// Initialization
initial begin
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
    
    // Initialize warning counters
    load_warning_count = 0;
    store_warning_count = 0;
    
    // Display memory configuration
    $display("Memory configuration: %d words (%d KB) from 0x%08x to 0x%08x", 
             MEMORY_SIZE, (MEMORY_SIZE * 4) / 1024, memory_base, memory_top-1);
end

// FETCH STAGE
always @(*) begin
    if (pc >= memory_base && pc < memory_top && ((pc - memory_base) >> 2) < MEMORY_SIZE) begin
        F_instruction = memory[pc >> 2];
    end else begin
        F_instruction = 32'h00000013; // NOP
        if (pc != memory_base) // Don't warn on initial PC
            $display("Warning: PC 0x%08x is outside memory bounds [0x%08x, 0x%08x)", pc, memory_base, memory_top);
    end
end

// DECODE STAGE
always @(posedge clock) begin
    if (reset || pipeline_flush) begin
        D_pc <= 0;
        D_instruction <= 32'h00000013; // NOP
        D_rd <= 0;
        D_rs1 <= 0;
        D_rs2 <= 0;
        D_funct3 <= 0;
        D_funct7 <= 0;
        D_opcode <= 0;
        D_imm_i <= 0;
        D_imm_s <= 0;
        D_imm_b <= 0;
        D_imm_u <= 0;
        D_imm_j <= 0;
        D_rs1_data <= 0;
        D_rs2_data <= 0;
    end else if (!pipeline_stall) begin
        D_pc <= pc;
        D_instruction <= F_instruction;
        
        // Decode instruction fields
        D_opcode <= F_instruction[6:0];
        D_rd <= F_instruction[11:7];
        D_rs1 <= F_instruction[19:15];
        D_rs2 <= F_instruction[24:20];
        D_funct3 <= F_instruction[14:12];
        D_funct7 <= F_instruction[31:25];
        
        // Generate immediates
        D_imm_i <= {{20{F_instruction[31]}}, F_instruction[31:20]};
        D_imm_s <= {{20{F_instruction[31]}}, F_instruction[31:25], F_instruction[11:7]};
        D_imm_b <= {{19{F_instruction[31]}}, F_instruction[31], F_instruction[7],
                     F_instruction[30:25], F_instruction[11:8], 1'b0};
        D_imm_u <= {F_instruction[31:12], 12'b0};
        D_imm_j <= {{11{F_instruction[31]}}, F_instruction[31], F_instruction[19:12],
                     F_instruction[20], F_instruction[30:21], 1'b0};
        
        // Read register file with forwarding
        D_rs1_data <= (F_instruction[19:15] == 0) ? 0 : 
                      (W_reg_write && W_rd == F_instruction[19:15]) ? W_write_data : 
                      registers[F_instruction[19:15]];
        D_rs2_data <= (F_instruction[24:20] == 0) ? 0 : 
                      (W_reg_write && W_rd == F_instruction[24:20]) ? W_write_data : 
                      registers[F_instruction[24:20]];
    end
end

// EXECUTE STAGE
always @(posedge clock) begin
    if (reset || pipeline_flush) begin
        E_pc <= 0;
        E_rd <= 0;
        E_opcode <= 0;
        E_funct3 <= 0;
        E_funct7 <= 0;
        E_rs1_data <= 0;
        E_rs2_data <= 0;
        E_imm_i <= 0;
        E_imm_s <= 0;
        E_imm_b <= 0;
        E_imm_u <= 0;
        E_imm_j <= 0;
        E_alu_result <= 0;
        E_reg_write <= 0;
        E_mem_read <= 0;
        E_mem_write <= 0;
        E_branch_taken <= 0;
        E_mem_addr <= 0;
        E_mem_wdata <= 0;
        E_write_data <= 0;
        E_next_pc <= 0;
    end else if (!pipeline_stall) begin
        E_pc <= D_pc;
        E_rd <= D_rd;
        E_opcode <= D_opcode;
        E_funct3 <= D_funct3;
        E_funct7 <= D_funct7;
        E_rs1_data <= D_rs1_data;
        E_rs2_data <= D_rs2_data;
        E_imm_i <= D_imm_i;
        E_imm_s <= D_imm_s;
        E_imm_b <= D_imm_b;
        E_imm_u <= D_imm_u;
        E_imm_j <= D_imm_j;
        
        // ALU computation
        case (D_opcode)
            7'b0010011: begin // I-type
                case (D_funct3)
                    3'b000: E_alu_result <= D_rs1_data + D_imm_i;                    // ADDI
                    3'b010: E_alu_result <= ($signed(D_rs1_data) < $signed(D_imm_i)) ? 1 : 0; // SLTI
                    3'b011: E_alu_result <= (D_rs1_data < D_imm_i) ? 1 : 0;         // SLTIU
                    3'b100: E_alu_result <= D_rs1_data ^ D_imm_i;                    // XORI
                    3'b110: E_alu_result <= D_rs1_data | D_imm_i;                    // ORI
                    3'b111: E_alu_result <= D_rs1_data & D_imm_i;                    // ANDI
                    3'b001: E_alu_result <= D_rs1_data << D_imm_i[4:0];              // SLLI
                    3'b101: E_alu_result <= D_funct7[5] 
                        ? ($signed(D_rs1_data) >>> D_imm_i[4:0])  // SRAI
                        : (D_rs1_data >> D_imm_i[4:0]);           // SRLI
                    default: E_alu_result <= 0;
                endcase
            end
            
            7'b0110011: begin // R-type
                case (D_funct3)
                    3'b000: E_alu_result <= D_funct7[5] 
                        ? (D_rs1_data - D_rs2_data)               // SUB
                        : (D_rs1_data + D_rs2_data);              // ADD
                    3'b001: E_alu_result <= D_rs1_data << D_rs2_data[4:0];           // SLL
                    3'b010: E_alu_result <= ($signed(D_rs1_data) < $signed(D_rs2_data)) ? 1 : 0; // SLT
                    3'b011: E_alu_result <= (D_rs1_data < D_rs2_data) ? 1 : 0;       // SLTU
                    3'b100: E_alu_result <= D_rs1_data ^ D_rs2_data;                 // XOR
                    3'b101: E_alu_result <= D_funct7[5]
                        ? ($signed(D_rs1_data) >>> D_rs2_data[4:0]) // SRA
                        : (D_rs1_data >> D_rs2_data[4:0]);          // SRL
                    3'b110: E_alu_result <= D_rs1_data | D_rs2_data;                 // OR
                    3'b111: E_alu_result <= D_rs1_data & D_rs2_data;                 // AND
                    default: E_alu_result <= 0;
                endcase
            end
            
            7'b0000011: E_alu_result <= D_rs1_data + D_imm_i;   // Load
            7'b0100011: E_alu_result <= D_rs1_data + D_imm_s;   // Store
            7'b1100011: E_alu_result <= D_rs1_data - D_rs2_data; // Branch compare
            7'b0110111: E_alu_result <= D_imm_u;                // LUI
            7'b0010111: E_alu_result <= D_pc + D_imm_u;         // AUIPC
            7'b1101111,
            7'b1100111: E_alu_result <= D_pc + 4;               // JAL / JALR writeback
            default: E_alu_result <= 0;
        endcase
        
        // Control signals
        E_reg_write <= 0;
        E_write_data <= E_alu_result;
        E_mem_read <= 0;
        E_mem_write <= 0;
        E_mem_addr <= E_alu_result;
        E_mem_wdata <= D_rs2_data;
        E_branch_taken <= 0;
        E_next_pc <= D_pc + 4;
        
        case (D_opcode)
            7'b0010011, 7'b0110111, 7'b0010111: begin
                E_reg_write <= (D_rd != 0);
            end
            
            7'b0000011: begin // Load
                E_reg_write <= (D_rd != 0);
                E_mem_read <= 1;
            end
            
            7'b0100011: E_mem_write <= 1; // Store
            
            7'b1100011: begin // Branches
                case (D_funct3)
                    3'b000: E_branch_taken <= (E_alu_result == 0);                 // BEQ
                    3'b001: E_branch_taken <= (E_alu_result != 0);                 // BNE
                    3'b100: E_branch_taken <= ($signed(E_alu_result) < 0);         // BLT
                    3'b101: E_branch_taken <= ($signed(E_alu_result) >= 0);        // BGE
                    3'b110: E_branch_taken <= (D_rs1_data < D_rs2_data);           // BLTU
                    3'b111: E_branch_taken <= (D_rs1_data >= D_rs2_data);          // BGEU
                    default: E_branch_taken <= 0;
                endcase
                if (E_branch_taken)
                    E_next_pc <= D_pc + D_imm_b;
            end
            
            7'b1101111: begin // JAL
                E_reg_write <= (D_rd != 0);
                E_next_pc <= D_pc + D_imm_j;
            end
            
            7'b1100111: begin // JALR
                E_reg_write <= (D_rd != 0);
                E_next_pc <= (D_rs1_data + D_imm_i) & ~32'h1;
            end
            
            default: begin
                // Default case for unrecognized opcodes - treat as NOP
                E_reg_write <= 0;
                E_mem_read <= 0;
                E_mem_write <= 0;
                E_branch_taken <= 0;
                E_next_pc <= D_pc + 4;
            end
        endcase
    end
end

// WRITEBACK STAGE
always @(posedge clock) begin
    if (reset) begin
        W_pc <= 0;
        W_rd <= 0;
        W_opcode <= 0;
        W_funct3 <= 0;
        W_alu_result <= 0;
        W_reg_write <= 0;
        W_mem_read <= 0;
        W_mem_write <= 0;
        W_mem_addr <= 0;
        W_mem_wdata <= 0;
        W_write_data <= 0;
    end else if (!pipeline_stall) begin
        W_pc <= E_pc;
        W_rd <= E_rd;
        W_opcode <= E_opcode;
        W_funct3 <= E_funct3;
        W_alu_result <= E_alu_result;
        W_reg_write <= E_reg_write;
        W_mem_read <= E_mem_read;
        W_mem_write <= E_mem_write;
        W_mem_addr <= E_mem_addr;
        W_mem_wdata <= E_mem_wdata;
        W_write_data <= E_write_data;
        
        // Handle memory reads
        if (E_mem_read) begin
            if (E_mem_addr >= memory_base && E_mem_addr < memory_top && ((E_mem_addr - memory_base) >> 2) < MEMORY_SIZE) begin
                W_write_data <= memory[E_mem_addr >> 2];
            end else begin
                W_write_data <= 0;
                // Only show first few warnings to avoid spam
                if (load_warning_count < MAX_WARNINGS) begin
                    if (E_mem_addr >= 32'hFFFFF000) begin
                        // High address - likely stack or memory-mapped I/O, show condensed warning
                        if (load_warning_count == 0)
                            $display("Warning: Load from high address 0x%08x (stack/MMIO) - suppressing further high address load warnings", E_mem_addr);
                    end else begin
                        // Regular out-of-bounds access
                        $display("Warning: Load from address 0x%08x is outside memory bounds [0x%08x, 0x%08x)", 
                                 E_mem_addr, memory_base, memory_top);
                    end
                    load_warning_count <= load_warning_count + 1;
                end else if (load_warning_count == MAX_WARNINGS) begin
                    $display("Warning: Suppressing further load warnings (total: %d)", load_warning_count + 1);
                    load_warning_count <= load_warning_count + 1;
                end
            end
        end
    end
end

// PC UPDATE AND PIPELINE CONTROL
always @(posedge clock) begin
    if (reset) begin
        pc <= memory_base;
        pipeline_flush <= 0;
        pipeline_stall <= 0;
        trap <= 0;
        load_warning_count <= 0;
        store_warning_count <= 0;
    end else begin
        pipeline_flush <= 0;
        pipeline_stall <= 0;
        
        // Handle branches and jumps
        if (E_branch_taken || E_opcode == 7'b1101111 || E_opcode == 7'b1100111) begin
            pc <= E_next_pc;
            pipeline_flush <= 1; // Flush fetch and decode stages
        end else begin
            pc <= pc + 4;
        end
        
        // Register writeback
        if (W_reg_write && W_rd != 0) begin
            registers[W_rd] <= W_write_data;
        end
        
        // Memory writes
        if (W_mem_write) begin
            if (W_mem_addr >= memory_base && W_mem_addr < memory_top && ((W_mem_addr - memory_base) >> 2) < MEMORY_SIZE) begin
                memory[W_mem_addr >> 2] <= W_mem_wdata;
            end else begin
                // Only show first few warnings to avoid spam
                if (store_warning_count < MAX_WARNINGS) begin
                    if (W_mem_addr >= 32'hFFFFF000) begin
                        // High address - likely stack or memory-mapped I/O, show condensed warning
                        if (store_warning_count == 0)
                            $display("Warning: Store to high address 0x%08x (stack/MMIO) - suppressing further high address store warnings", W_mem_addr);
                    end else begin
                        // Regular out-of-bounds access
                        $display("Warning: Store to address 0x%08x is outside memory bounds [0x%08x, 0x%08x)", 
                                 W_mem_addr, memory_base, memory_top);
                    end
                    store_warning_count <= store_warning_count + 1;
                end else if (store_warning_count == MAX_WARNINGS) begin
                    $display("Warning: Suppressing further store warnings (total: %d)", store_warning_count + 1);
                    store_warning_count <= store_warning_count + 1;
                end
            end
        end
        
        // EBREAK detection
        if (W_opcode == 7'b1110011 && W_funct3 == 3'b000 && W_alu_result == 32'h00100073) begin
            trap <= 1;
        end
    end
end

endmodule