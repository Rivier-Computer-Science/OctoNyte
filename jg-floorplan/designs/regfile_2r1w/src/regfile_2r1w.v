module regfile_2r1w(
    input  wire         clk,
    input  wire         rs1_read,
    input  wire [3:0]   rs1_addr,
    output wire [31:0]  rs1_rdata,
    input  wire         rs2_read,
    input  wire [3:0]   rs2_addr,
    output wire [31:0]  rs2_rdata,
    input  wire [3:0]   rd_addr,
    input  wire [31:0]  rd_wdata,
    input  wire         rd_write
);

    mem_1r1w lane0 (
        .clk        (clk),
        .read_addr  (rs1_addr),
        .read       (rs1_read),
        .read_data  (rs1_rdata),
        .write_addr (rd_addr),
        .write      (rd_write),
        .write_data (rd_wdata)
    );

    mem_1r1w lane1 (
        .clk        (clk),
        .read_addr  (rs2_addr),
        .read       (rs2_read),
        .read_data  (rs2_rdata),
        .write_addr (rd_addr),
        .write      (rd_write),
        .write_data (rd_wdata)
    );

endmodule
