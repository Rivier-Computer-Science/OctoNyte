// 32×32 Register File with synchronous write, asynchronous read
module RegisterFile(
    input         clk,
    input         reg_write,
    input  [4:0]  rs1_addr,
    input  [4:0]  rs2_addr,
    input  [4:0]  rd_addr,
    input  [31:0] rd_data,
    output [31:0] rs1_data,
    output [31:0] rs2_data
);
    reg [31:0] regs [0:31];

    // x0 is always zero
    assign rs1_data = (rs1_addr == 0) ? 32'b0 : regs[rs1_addr];
    assign rs2_data = (rs2_addr == 0) ? 32'b0 : regs[rs2_addr];

    always @(posedge clk) begin
        if (reg_write && rd_addr != 0)
            regs[rd_addr] <= rd_data;
    end
endmodule
