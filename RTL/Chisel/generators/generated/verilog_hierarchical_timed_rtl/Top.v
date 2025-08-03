module Top(
    input wire clock,
    input wire reset
);

    // Internal signals
    reg [31:0] pc;
    reg [31:0] registers [0:31];
    reg [31:0] memory [0:16383]; // 64KB memory
    reg [31:0] instruction;
    reg [31:0] next_pc;
    
    // Instruction decode
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [2:0] funct3;
    wire [6:0] funct7;
    
    assign opcode = instruction[6:0];
    assign rd = instruction[11:7];
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];
    
    // Immediate generation
    wire [31:0] imm_i;
    wire [31:0] imm_s;
    wire [31:0] imm_b;
    wire [31:0] imm_u;
    wire [31:0] imm_j;
    
    assign imm_i = {{20{instruction[31]}}, instruction[31:20]};
    assign imm_s = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
    assign imm_b = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
    assign imm_u = {instruction[31:12], 12'b0};
    assign imm_j = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
    
    // ALU and control signals
    reg [31:0] alu_result;
    reg [31:0] rs1_data, rs2_data;
    reg reg_write;
    reg [31:0] write_data;
    reg mem_read, mem_write;
    reg [31:0] mem_addr, mem_wdata;
    reg branch_taken;
    
    // Loop variable for initialization
    integer i;
    
    // Initialize memory and registers
    initial begin
        pc = 32'h80000000;
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'h0;
        end
        for (i = 0; i < 16384; i = i + 1) begin
            memory[i] = 32'h0;
        end
        // Load a simple NOP instruction pattern
        memory[0] = 32'h00000013; // addi x0, x0, 0 (NOP)
        memory[1] = 32'h00000013; // addi x0, x0, 0 (NOP)
        memory[2] = 32'h00000013; // addi x0, x0, 0 (NOP)
        memory[3] = 32'h00000013; // addi x0, x0, 0 (NOP)
    end
    
    // Instruction fetch
    always @(*) begin
        if ((pc >= 32'h80000000) && (pc < 32'h80010000)) begin
            instruction = memory[(pc - 32'h80000000) >> 2];
        end else begin
            instruction = 32'h00000013; // NOP for invalid addresses
        end
    end
    
    // Register file read
    always @(*) begin
        rs1_data = (rs1 == 5'b0) ? 32'h0 : registers[rs1];
        rs2_data = (rs2 == 5'b0) ? 32'h0 : registers[rs2];
    end
    
    // ALU
    always @(*) begin
        alu_result = 32'h0;
        case (opcode)
            7'b0010011: begin // I-type (ADDI, etc.)
                case (funct3)
                    3'b000: alu_result = rs1_data + imm_i; // ADDI
                    3'b010: alu_result = ($signed(rs1_data) < $signed(imm_i)) ? 32'h1 : 32'h0; // SLTI
                    3'b011: alu_result = (rs1_data < imm_i) ? 32'h1 : 32'h0; // SLTIU
                    3'b100: alu_result = rs1_data ^ imm_i; // XORI
                    3'b110: alu_result = rs1_data | imm_i; // ORI
                    3'b111: alu_result = rs1_data & imm_i; // ANDI
                    3'b001: alu_result = rs1_data << imm_i[4:0]; // SLLI
                    3'b101: begin
                        if (funct7[5]) begin
                            alu_result = $signed(rs1_data) >>> imm_i[4:0]; // SRAI
                        end else begin
                            alu_result = rs1_data >> imm_i[4:0]; // SRLI
                        end
                    end
                    default: alu_result = 32'h0;
                endcase
            end
            7'b0110011: begin // R-type (ADD, SUB, etc.)
                case (funct3)
                    3'b000: begin
                        if (funct7[5]) begin
                            alu_result = rs1_data - rs2_data; // SUB
                        end else begin
                            alu_result = rs1_data + rs2_data; // ADD
                        end
                    end
                    3'b001: alu_result = rs1_data << rs2_data[4:0]; // SLL
                    3'b010: alu_result = ($signed(rs1_data) < $signed(rs2_data)) ? 32'h1 : 32'h0; // SLT
                    3'b011: alu_result = (rs1_data < rs2_data) ? 32'h1 : 32'h0; // SLTU
                    3'b100: alu_result = rs1_data ^ rs2_data; // XOR
                    3'b101: begin
                        if (funct7[5]) begin
                            alu_result = $signed(rs1_data) >>> rs2_data[4:0]; // SRA
                        end else begin
                            alu_result = rs1_data >> rs2_data[4:0]; // SRL
                        end
                    end
                    3'b110: alu_result = rs1_data | rs2_data; // OR
                    3'b111: alu_result = rs1_data & rs2_data; // AND
                    default: alu_result = 32'h0;
                endcase
            end
            7'b0000011: begin // Load
                alu_result = rs1_data + imm_i;
            end
            7'b0100011: begin // Store
                alu_result = rs1_data + imm_s;
            end
            7'b1100011: begin // Branch
                alu_result = rs1_data - rs2_data;
            end
            7'b0110111: begin // LUI
                alu_result = imm_u;
            end
            7'b0010111: begin // AUIPC
                alu_result = pc + imm_u;
            end
            7'b1101111: begin // JAL
                alu_result = pc + 4;
            end
            7'b1100111: begin // JALR
                alu_result = pc + 4;
            end
            default: alu_result = 32'h0;
        endcase
    end
    
    // Control logic
    always @(*) begin
        reg_write = 1'b0;
        write_data = alu_result;
        mem_read = 1'b0;
        mem_write = 1'b0;
        mem_addr = alu_result;
        mem_wdata = rs2_data;
        branch_taken = 1'b0;
        next_pc = pc + 4;
        
        case (opcode)
            7'b0010011, 7'b0110011, 7'b0110111, 7'b0010111: begin // I-type, R-type, LUI, AUIPC
                reg_write = (rd != 5'b0) ? 1'b1 : 1'b0;
            end
            7'b0000011: begin // Load
                reg_write = (rd != 5'b0) ? 1'b1 : 1'b0;
                mem_read = 1'b1;
                if ((mem_addr >= 32'h80000000) && (mem_addr < 32'h80010000)) begin
                    write_data = memory[(mem_addr - 32'h80000000) >> 2];
                end else begin
                    write_data = 32'h0;
                end
            end
            7'b0100011: begin // Store
                mem_write = 1'b1;
            end
            7'b1100011: begin // Branch
                case (funct3)
                    3'b000: branch_taken = (alu_result == 32'h0) ? 1'b1 : 1'b0; // BEQ
                    3'b001: branch_taken = (alu_result != 32'h0) ? 1'b1 : 1'b0; // BNE
                    3'b100: branch_taken = ($signed(alu_result) < 0) ? 1'b1 : 1'b0; // BLT
                    3'b101: branch_taken = ($signed(alu_result) >= 0) ? 1'b1 : 1'b0; // BGE
                    3'b110: branch_taken = (rs1_data < rs2_data) ? 1'b1 : 1'b0; // BLTU
                    3'b111: branch_taken = (rs1_data >= rs2_data) ? 1'b1 : 1'b0; // BGEU
                    default: branch_taken = 1'b0;
                endcase
                if (branch_taken) begin
                    next_pc = pc + imm_b;
                end
            end
            7'b1101111: begin // JAL
                reg_write = (rd != 5'b0) ? 1'b1 : 1'b0;
                next_pc = pc + imm_j;
            end
            7'b1100111: begin // JALR
                reg_write = (rd != 5'b0) ? 1'b1 : 1'b0;
                next_pc = (rs1_data + imm_i) & (~32'h1);
            end
            default: begin
                // Default case - do nothing
            end
        endcase
    end
    
    // Sequential logic
    always @(posedge clock) begin
        if (reset) begin
            pc <= 32'h80000000;
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'h0;
            end
        end else begin
            // Update PC
            pc <= next_pc;
            
            // Register write
            if (reg_write && (rd != 5'b0)) begin
                registers[rd] <= write_data;
            end
            
            // Memory write
            if (mem_write && (mem_addr >= 32'h80000000) && (mem_addr < 32'h80010000)) begin
                memory[(mem_addr - 32'h80000000) >> 2] <= mem_wdata;
            end
        end
    end
    
endmodule
