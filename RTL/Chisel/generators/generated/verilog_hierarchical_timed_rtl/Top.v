`timescale 1ns/1ps
// Turn off these warning classes in this file
// verilator lint_off WIDTHEXPAND
// verilator lint_off CASEINCOMPLETE

module Top #(
    parameter MEMORY_SIZE = 65536  // Default 256KB (64K words), configurable
)(
    input wire clock,
    input wire reset,
    output reg trap
);

// Program counter and register file
reg [31:0] pc;
reg [31:0] registers [0:31];

// Parameterized data memory, exposed to the Verilator harness:
reg [31:0] memory [0:MEMORY_SIZE-1];

// Instruction word and next-PC logic
reg [31:0] instruction;
reg [31:0] next_pc;

// Decode fields
wire [6:0] opcode = instruction[6:0];
wire [4:0] rd = instruction[11:7];
wire [4:0] rs1 = instruction[19:15];
wire [4:0] rs2 = instruction[24:20];
wire [2:0] funct3 = instruction[14:12];
wire [6:0] funct7 = instruction[31:25];

// Immediates
wire [31:0] imm_i = {{20{instruction[31]}}, instruction[31:20]};
wire [31:0] imm_s = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
wire [31:0] imm_b = {{19{instruction[31]}}, instruction[31], instruction[7],
                     instruction[30:25], instruction[11:8], 1'b0};

wire [31:0] imm_u = {instruction[31:12], 12'b0};
wire [31:0] imm_j = {{11{instruction[31]}}, instruction[31], instruction[19:12],
                     instruction[20], instruction[30:21], 1'b0};

// ALU & control signals
reg [31:0] alu_result, rs1_data, rs2_data, write_data;
reg reg_write, mem_read, mem_write, branch_taken;
reg [31:0] mem_addr, mem_wdata;

integer i;

// Add string variable for memory file
reg [8*256:1] memfile;

// Calculate memory address bounds based on parameter
wire [31:0] memory_base = 32'h8000_0000;
wire [31:0] memory_top = memory_base + (MEMORY_SIZE << 2); // MEMORY_SIZE * 4 bytes

// Reset/initialization
initial begin
    pc = memory_base;
    trap = 1'b0;
    
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

// FETCH stage with bounds checking
always @(*) begin
    if (pc >= memory_base && pc < memory_top) begin
        instruction = memory[(pc - memory_base) >> 2];
    end else begin
        instruction = 32'h00000013; // NOP for out-of-bounds access
        if (pc != memory_base) // Don't warn on initial PC
            $display("Warning: PC 0x%08x is outside memory bounds [0x%08x, 0x%08x)", 
                     pc, memory_base, memory_top - 1);
    end
end

// READ register file
always @(*) begin
    rs1_data = (rs1 == 0) ? 0 : registers[rs1];
    rs2_data = (rs2 == 0) ? 0 : registers[rs2];
end

// ALU computation
always @(*) begin
    alu_result = 32'h0;
    case (opcode)
        7'b0010011: begin // I-type
            case (funct3)
                3'b000: alu_result = rs1_data + imm_i;                    // ADDI
                3'b010: alu_result = ($signed(rs1_data) < $signed(imm_i)) ? 1 : 0; // SLTI
                3'b011: alu_result = (rs1_data < imm_i)                   ? 1 : 0; // SLTIU
                3'b100: alu_result = rs1_data ^ imm_i;                    // XORI
                3'b110: alu_result = rs1_data | imm_i;                    // ORI
                3'b111: alu_result = rs1_data & imm_i;                    // ANDI
                3'b001: alu_result = rs1_data << imm_i[4:0];              // SLLI
                3'b101: alu_result = funct7[5] 
                    ? ($signed(rs1_data) >>> imm_i[4:0])  // SRAI
                    : (rs1_data >> imm_i[4:0]);           // SRLI
                default: alu_result = 0;
            endcase
        end
        
        7'b0110011: begin // R-type
            case (funct3)
                3'b000: alu_result = funct7[5] 
                    ? (rs1_data - rs2_data)               // SUB
                    : (rs1_data + rs2_data);              // ADD
                3'b001: alu_result = rs1_data << rs2_data[4:0];           // SLL
                3'b010: alu_result = ($signed(rs1_data) < $signed(rs2_data)) ? 1 : 0; // SLT
                3'b011: alu_result = (rs1_data < rs2_data) ? 1 : 0;       // SLTU
                3'b100: alu_result = rs1_data ^ rs2_data;                 // XOR
                3'b101: alu_result = funct7[5]
                    ? ($signed(rs1_data) >>> rs2_data[4:0]) // SRA
                    : (rs1_data >> rs2_data[4:0]);          // SRL
                3'b110: alu_result = rs1_data | rs2_data;                 // OR
                3'b111: alu_result = rs1_data & rs2_data;                 // AND
                default: alu_result = 0;
            endcase
        end
        
        7'b0000011: alu_result = rs1_data + imm_i;   // Load
        7'b0100011: alu_result = rs1_data + imm_s;   // Store
        7'b1100011: alu_result = rs1_data - rs2_data; // Branch compare
        7'b0110111: alu_result = imm_u;              // LUI
        7'b0010111: alu_result = pc + imm_u;         // AUIPC
        7'b1101111,
        7'b1100111: alu_result = pc + 4;             // JAL / JALR writeback
        default: alu_result = 0;
    endcase
end

// CONTROL & NEXT_PC decision
always @(*) begin
    reg_write = 0;
    write_data = alu_result;
    mem_read = 0;
    mem_write = 0;
    mem_addr = alu_result;
    mem_wdata = rs2_data;
    branch_taken = 0;
    next_pc = pc + 4;
    
    case (opcode)
        7'b0010011, 7'b0110111, 7'b0010111: begin
            reg_write = (rd != 0);
        end
        
        7'b0000011: begin // Load with bounds checking
            reg_write = (rd != 0);
            mem_read = 1;
            if (mem_addr >= memory_base && mem_addr < memory_top) begin
                write_data = memory[(mem_addr - memory_base) >> 2];
            end else begin
                write_data = 0;
                $display("Warning: Load from address 0x%08x is outside memory bounds", mem_addr);
            end
        end
        
        7'b0100011: mem_write = 1; // Store
        
        7'b1100011: begin // Branches
            case (funct3)
                3'b000: branch_taken = (alu_result == 0);                 // BEQ
                3'b001: branch_taken = (alu_result != 0);                 // BNE
                3'b100: branch_taken = ($signed(alu_result) < 0);         // BLT
                3'b101: branch_taken = ($signed(alu_result) >= 0);        // BGE
                3'b110: branch_taken = (rs1_data < rs2_data);             // BLTU
                3'b111: branch_taken = (rs1_data >= rs2_data);            // BGEU
                default: branch_taken = 0;
            endcase
            if (branch_taken)
                next_pc = pc + imm_b;
        end
        
        7'b1101111: begin // JAL
            reg_write = (rd != 0);
            next_pc = pc + imm_j;
        end
        
        7'b1100111: begin // JALR
            reg_write = (rd != 0);
            next_pc = (rs1_data + imm_i) & ~32'h1;
        end
    endcase
end

// SEQUENTIAL - PC update, writes, EBREAK-trap
always @(posedge clock) begin
    if (reset) begin
        pc <= memory_base;
        trap <= 1'b0;
        for (i = 0; i < 32; i = i + 1) registers[i] <= 32'h0;
    end else begin
        pc <= next_pc;
        
        // Register write
        if (reg_write && rd != 0)
            registers[rd] <= write_data;
        
        // Memory write with bounds checking
        if (mem_write) begin
            if (mem_addr >= memory_base && mem_addr < memory_top) begin
                memory[(mem_addr - memory_base) >> 2] <= mem_wdata;
            end else begin
                $display("Warning: Store to address 0x%08x is outside memory bounds", mem_addr);
            end
        end
        
        // EBREAK detection
        if (instruction == 32'h00100073)
            trap <= 1'b1;
    end
end

endmodule

