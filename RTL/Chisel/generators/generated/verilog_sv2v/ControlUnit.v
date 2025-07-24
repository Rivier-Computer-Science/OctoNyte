// Control Unit
// Generates RegWrite, MemRead, MemWrite, MemToReg, Branch,
// and a simple 4-bit ALU control field from opcode.

module ControlUnit(
    input  [6:0] opcode,
    output reg       reg_write,
    output reg       mem_read,
    output reg       mem_write,
    output reg       mem_to_reg,
    output reg       branch,
    output reg [3:0] alu_ctrl
);
    always @(*) begin
        // defaults
        reg_write  = 0;
        mem_read   = 0;
        mem_write  = 0;
        mem_to_reg = 0;
        branch     = 0;
        alu_ctrl   = 4'b0000;

        case (opcode)
            7'b0110011: begin // R-type
                reg_write = 1;
                alu_ctrl  = 4'b0010; // use funct fields to refine
            end
            7'b0000011: begin // Load
                reg_write  = 1;
                mem_read   = 1;
                mem_to_reg = 1;
                alu_ctrl   = 4'b0010; // ADD for addr
            end
            7'b0100011: begin // Store
                mem_write = 1;
                alu_ctrl   = 4'b0010;
            end
            7'b1100011: begin // Branch
                branch   = 1;
                alu_ctrl = 4'b0110; // SUB for compare
            end
            default: ;
        endcase
    end
endmodule
