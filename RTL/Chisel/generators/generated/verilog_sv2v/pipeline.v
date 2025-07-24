// ---------------------------------------------
// 4-Stage RISC-V Pipeline in Verilog-2001
// Filename: pipeline.v
// ---------------------------------------------

// IF/ID pipeline register
module IF_ID(
    input          clk,
    input          rst,
    input          if_id_write,
    input          flush,
    input  [31:0]  pc_in,
    input  [31:0]  instr_in,
    output reg [31:0] pc_out,
    output reg [31:0] instr_out
);
  always @(posedge clk or posedge rst) begin
    if (rst || flush) begin
      pc_out    <= 32'd0;
      instr_out <= 32'd0;
    end else if (if_id_write) begin
      pc_out    <= pc_in;
      instr_out <= instr_in;
    end
  end
endmodule

// ID/EX pipeline register
module ID_EX(
    input          clk,
    input          rst,
    input          id_ex_flush,
    input  [31:0]  pc_in,
    input  [31:0]  rs1_data_in,
    input  [31:0]  rs2_data_in,
    input  [31:0]  imm_in,
    input  [4:0]   rs1_addr_in,
    input  [4:0]   rs2_addr_in,
    input  [4:0]   rd_in,
    input  [3:0]   alu_ctrl_in,
    input  [2:0]   funct3_in,
    input          reg_write_in,
    input          mem_read_in,
    input          mem_write_in,
    input          mem_to_reg_in,
    input          branch_in,
    output reg [31:0] pc_out,
    output reg [31:0] rs1_data_out,
    output reg [31:0] rs2_data_out,
    output reg [31:0] imm_out,
    output reg [4:0]  rs1_addr_out,
    output reg [4:0]  rs2_addr_out,
    output reg [4:0]  rd_out,
    output reg [3:0]  alu_ctrl_out,
    output reg [2:0]  funct3_out,
    output reg       reg_write_out,
    output reg       mem_read_out,
    output reg       mem_write_out,
    output reg       mem_to_reg_out,
    output reg       branch_out
);
  always @(posedge clk or posedge rst) begin
    if (rst || id_ex_flush) begin
      pc_out           <= 32'd0;
      rs1_data_out     <= 32'd0;
      rs2_data_out     <= 32'd0;
      imm_out          <= 32'd0;
      rs1_addr_out     <= 5'd0;
      rs2_addr_out     <= 5'd0;
      rd_out           <= 5'd0;
      alu_ctrl_out     <= 4'd0;
      funct3_out       <= 3'd0;
      reg_write_out    <= 1'b0;
      mem_read_out     <= 1'b0;
      mem_write_out    <= 1'b0;
      mem_to_reg_out   <= 1'b0;
      branch_out       <= 1'b0;
    end else begin
      pc_out           <= pc_in;
      rs1_data_out     <= rs1_data_in;
      rs2_data_out     <= rs2_data_in;
      imm_out          <= imm_in;
      rs1_addr_out     <= rs1_addr_in;
      rs2_addr_out     <= rs2_addr_in;
      rd_out           <= rd_in;
      alu_ctrl_out     <= alu_ctrl_in;
      funct3_out       <= funct3_in;
      reg_write_out    <= reg_write_in;
      mem_read_out     <= mem_read_in;
      mem_write_out    <= mem_write_in;
      mem_to_reg_out   <= mem_to_reg_in;
      branch_out       <= branch_in;
    end
  end
endmodule

// EX/MEM pipeline register
module EX_MEM(
    input          clk,
    input          rst,
    input  [31:0]  alu_result_in,
    input  [31:0]  rs2_data_in,
    input  [4:0]   rd_in,
    input          reg_write_in,
    input          mem_read_in,
    input          mem_write_in,
    input          mem_to_reg_in,
    input          branch_in,
    input          branch_taken_in,
    input  [31:0]  branch_target_in,
    input  [2:0]   funct3_in,
    output reg [31:0] alu_result_out,
    output reg [31:0] rs2_data_out,
    output reg [4:0]  rd_out,
    output reg       reg_write_out,
    output reg       mem_read_out,
    output reg       mem_write_out,
    output reg       mem_to_reg_out,
    output reg       branch_out,
    output reg       branch_taken_out,
    output reg [31:0] branch_target_out,
    output reg [2:0]  funct3_out
);
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      alu_result_out    <= 32'd0;
      rs2_data_out      <= 32'd0;
      rd_out            <= 5'd0;
      reg_write_out     <= 1'b0;
      mem_read_out      <= 1'b0;
      mem_write_out     <= 1'b0;
      mem_to_reg_out    <= 1'b0;
      branch_out        <= 1'b0;
      branch_taken_out  <= 1'b0;
      branch_target_out <= 32'd0;
      funct3_out        <= 3'd0;
    end else begin
      alu_result_out    <= alu_result_in;
      rs2_data_out      <= rs2_data_in;
      rd_out            <= rd_in;
      reg_write_out     <= reg_write_in;
      mem_read_out      <= mem_read_in;
      mem_write_out     <= mem_write_in;
      mem_to_reg_out    <= mem_to_reg_in;
      branch_out        <= branch_in;
      branch_taken_out  <= branch_taken_in;
      branch_target_out <= branch_target_in;
      funct3_out        <= funct3_in;
    end
  end
endmodule

// MEM/WB pipeline register
module MEM_WB(
    input          clk,
    input          rst,
    input  [31:0]  mem_data_in,
    input  [31:0]  alu_result_in,
    input  [4:0]   rd_in,
    input          reg_write_in,
    input          mem_to_reg_in,
    output reg [31:0] mem_data_out,
    output reg [31:0] alu_result_out,
    output reg [4:0]  rd_out,
    output reg       reg_write_out,
    output reg       mem_to_reg_out
);
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      mem_data_out    <= 32'd0;
      alu_result_out  <= 32'd0;
      rd_out          <= 5'd0;
      reg_write_out   <= 1'b0;
      mem_to_reg_out  <= 1'b0;
    end else begin
      mem_data_out    <= mem_data_in;
      alu_result_out  <= alu_result_in;
      rd_out          <= rd_in;
      reg_write_out   <= reg_write_in;
      mem_to_reg_out  <= mem_to_reg_in;
    end
  end
endmodule

// Top-level Pipeline
module Pipeline(
    input          clk,
    input          rst,
    input  [31:0]  instr_mem_data,
    output [31:0]  instr_mem_addr,
    input  [31:0]  data_mem_rdata,
    output [31:0]  data_mem_addr,
    output [31:0]  data_mem_wdata,
    output         data_mem_write
);
  // PC logic and IF stage
  reg  [31:0] pc;
  wire [31:0] pc_plus4 = pc + 32'd4;
  wire        pc_write;
  always @(posedge clk or posedge rst) begin
    if (rst) pc <= 32'd0;
    else if (pc_write) pc <= pc_plus4;
  end
  assign instr_mem_addr = pc;
  wire [31:0] instr_if = instr_mem_data;

  // IF/ID register
  wire         if_id_write, if_id_flush;
  wire [31:0]  pc_id, instr_id;
  IF_ID u_if_id(
    .clk(clk), .rst(rst),
    .if_id_write(if_id_write), .flush(if_id_flush),
    .pc_in(pc_plus4), .instr_in(instr_if),
    .pc_out(pc_id), .instr_out(instr_id)
  );

  // ID stage
  wire [4:0]   rs1_id    = instr_id[19:15];
  wire [4:0]   rs2_id    = instr_id[24:20];
  wire [4:0]   rd_id     = instr_id[11:7];
  wire [2:0]   funct3_id = instr_id[14:12];
  wire [31:0]  imm_id;
  wire         reg_write_id, mem_read_id, mem_write_id, mem_to_reg_id, branch_id;
  wire [3:0]   alu_ctrl_id;
  ImmGen      u_imm(.instr(instr_id), .imm_out(imm_id));
  ControlUnit u_ctrl(
    .opcode(instr_id[6:0]),
    .reg_write(reg_write_id),
    .mem_read(mem_read_id),
    .mem_write(mem_write_id),
    .mem_to_reg(mem_to_reg_id),
    .branch(branch_id),
    .alu_ctrl(alu_ctrl_id)
  );
  wire [31:0]  rs1_data_id, rs2_data_id, wb_data;
  wire [4:0]   rd_wb;
  wire         reg_write_wb;
  RegisterFile u_rf(
    .clk(clk), .reg_write(reg_write_wb),
    .rs1_addr(rs1_id), .rs2_addr(rs2_id),
    .rd_addr(rd_wb), .rd_data(wb_data),
    .rs1_data(rs1_data_id), .rs2_data(rs2_data_id)
  );

  // Hazards
  wire id_ex_flush;
  HazardUnit u_hz(
    .id_ex_mem_read(mem_read_ex),
    .id_ex_rd(rd_ex),
    .if_id_rs1(rs1_id),
    .if_id_rs2(rs2_id),
    .pc_write(pc_write),
    .if_id_write(if_id_write),
    .id_ex_flush(id_ex_flush)
  );
  assign if_id_flush = branch_taken_ex;

  // ID/EX register
  wire [31:0] pc_ex, rs1_ex, rs2_ex, imm_ex;
  wire [4:0]  rs1_addr_ex, rs2_addr_ex, rd_ex;
  wire [3:0]  alu_ctrl_ex;
  wire [2:0]  funct3_ex;
  wire        reg_write_ex, mem_read_ex, mem_write_ex, mem_to_reg_ex, branch_ex;
  ID_EX u_id_ex(
    .clk(clk), .rst(rst), .id_ex_flush(id_ex_flush),
    .pc_in(pc_id), .rs1_data_in(rs1_data_id), .rs2_data_in(rs2_data_id),
    .imm_in(imm_id), .rs1_addr_in(rs1_id), .rs2_addr_in(rs2_id),
    .rd_in(rd_id), .alu_ctrl_in(alu_ctrl_id), .funct3_in(funct3_id),
    .reg_write_in(reg_write_id), .mem_read_in(mem_read_id),
    .mem_write_in(mem_write_id), .mem_to_reg_in(mem_to_reg_id),
    .branch_in(branch_id),
    .pc_out(pc_ex), .rs1_data_out(rs1_ex), .rs2_data_out(rs2_ex),
    .imm_out(imm_ex), .rs1_addr_out(rs1_addr_ex), .rs2_addr_out(rs2_addr_ex),
    .rd_out(rd_ex), .alu_ctrl_out(alu_ctrl_ex), .funct3_out(funct3_ex),
    .reg_write_out(reg_write_ex), .mem_read_out(mem_read_ex),
    .mem_write_out(mem_write_ex), .mem_to_reg_out(mem_to_reg_ex),
    .branch_out(branch_ex)
  );

  // Forwarding
  wire [1:0] forward_a, forward_b;
  ForwardUnit u_fwd(
    .ex_mem_rd(rd_mem),
    .ex_mem_reg_write(reg_write_mem),
    .mem_wb_rd(rd_wb),
    .mem_wb_reg_write(reg_write_wb),
    .id_ex_rs1(rs1_addr_ex),
    .id_ex_rs2(rs2_addr_ex),
    .forward_a(forward_a),
    .forward_b(forward_b)
  );
  wire [31:0] op1_ex = (forward_a==2'b10) ? alu_result_mem :
                       (forward_a==2'b01) ? wb_data : rs1_ex;
  wire [31:0] op2_ex = (forward_b==2'b10) ? alu_result_mem :
                       (forward_b==2'b01) ? wb_data : rs2_ex;

  // EX stage: ALU + Branch
  wire [31:0] alu_result_ex;
  ALU32 u_alu(
    .clock(clk), .reset(rst),
    .io_a(op1_ex),
    .io_b((mem_read_ex||mem_write_ex)? imm_ex : op2_ex),
    .io_opcode({2'b00, alu_ctrl_ex}),
    .io_result(alu_result_ex)
  );
  wire        branch_taken_ex;
  wire [31:0] branch_target_ex = pc_ex + imm_ex;
  BranchUnit u_br(
    .rs1(op1_ex),.rs2(op2_ex),.funct3(funct3_ex),.branch_taken(branch_taken_ex)
  );

  // EX/MEM register
  wire [31:0] alu_result_mem, rs2_data_mem;
  wire [4:0]  rd_mem;
  wire        reg_write_mem, mem_read_mem, mem_write_mem, mem_to_reg_mem, branch_mem;
  wire [2:0]  funct3_mem;
  EX_MEM u_ex_mem(
    .clk(clk), .rst(rst),
    .alu_result_in(alu_result_ex), .rs2_data_in(op2_ex),
    .rd_in(rd_ex), .reg_write_in(reg_write_ex),
    .mem_read_in(mem_read_ex), .mem_write_in(mem_write_ex),
    .mem_to_reg_in(mem_to_reg_ex), .branch_in(branch_ex),
    .branch_taken_in(branch_taken_ex), .branch_target_in(branch_target_ex),
    .funct3_in(funct3_ex),
    .alu_result_out(alu_result_mem), .rs2_data_out(rs2_data_mem),
    .rd_out(rd_mem), .reg_write_out(reg_write_mem),
    .mem_read_out(mem_read_mem), .mem_write_out(mem_write_mem),
    .mem_to_reg_out(mem_to_reg_mem), .branch_out(),
    .branch_taken_out(), .branch_target_out(), .funct3_out(funct3_mem)
  );

  // MEM stage: Load/Store
  wire [31:0] load_data;
  LoadUnit u_load(
    .clock(clk), .reset(rst),
    .io_addr(alu_result_mem),
    .io_dataIn(data_mem_rdata),
    .io_funct3(funct3_mem),
    .io_dataOut(load_data)
  );
  StoreUnit u_store(
    .clock(clk), .reset(rst),
    .address(alu_result_mem),
    .data_in(rs2_data_mem),
    .wen(mem_write_mem),
    .mem_out(data_mem_wdata)
  );
  assign data_mem_addr  = alu_result_mem;
  assign data_mem_write = mem_write_mem;

  // MEM/WB register
  wire [31:0] mem_data_wb, alu_result_wb;
  wire        mem_to_reg_wb;
  MEM_WB u_mem_wb(
    .clk(clk), .rst(rst),
    .mem_data_in(load_data), .alu_result_in(alu_result_mem),
    .rd_in(rd_mem), .reg_write_in(reg_write_mem),
    .mem_to_reg_in(mem_to_reg_mem),
    .mem_data_out(mem_data_wb), .alu_result_out(alu_result_wb),
    .rd_out(rd_wb), .reg_write_out(reg_write_wb),
    .mem_to_reg_out(mem_to_reg_wb)
  );

  // WB stage: writeback data
  assign wb_data = mem_to_reg_wb ? mem_data_wb : alu_result_wb;
endmodule
