// Hazard Detection Unit
// Detects load-use hazard and stalls IF/ID & PC for one cycle

module HazardUnit(
    input        id_ex_mem_read,
    input  [4:0] id_ex_rd,
    input  [4:0] if_id_rs1,
    input  [4:0] if_id_rs2,
    output reg   pc_write,
    output reg   if_id_write,
    output reg   id_ex_flush
);
    always @(*) begin
        if (id_ex_mem_read &&
           ((id_ex_rd == if_id_rs1) || (id_ex_rd == if_id_rs2))) begin
            // Stall
            pc_write    = 0;
            if_id_write = 0;
            id_ex_flush = 1;
        end else begin
            // Normal operation
            pc_write    = 1;
            if_id_write = 1;
            id_ex_flush = 0;
        end
    end
endmodule
