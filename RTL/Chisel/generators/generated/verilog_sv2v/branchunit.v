module BranchUnit (
    input  [31:0] rs1,
    input  [31:0] rs2,
    input  [2:0]  funct3,        // from instruction[14:12] (e.g., BEQ, BNE, etc.)
    output        branch_taken
);
    wire equal      = (rs1 == rs2);
    wire not_equal  = (rs1 != rs2);
    wire slt_signed = $signed(rs1) < $signed(rs2);
    wire sge_signed = $signed(rs1) >= $signed(rs2);
    wire slt_unsigned = rs1 < rs2;
    wire sge_unsigned = rs1 >= rs2;

    reg taken;
    always @(*) begin
        case (funct3)
            3'b000: taken = equal;          // BEQ
            3'b001: taken = not_equal;      // BNE
            3'b100: taken = slt_signed;     // BLT
            3'b101: taken = sge_signed;     // BGE
            3'b110: taken = slt_unsigned;   // BLTU
            3'b111: taken = sge_unsigned;   // BGEU
            default: taken = 1'b0;
        endcase
    end

    assign branch_taken = taken;
endmodule
