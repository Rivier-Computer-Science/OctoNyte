module BranchUnit (
	clock,
	reset,
	io_rs1,
	io_rs2,
	io_pc,
	io_imm,
	io_branchOp,
	io_valid,
	io_taken,
	io_target,
	io_nextPc,
	io_misaligned
);
	input clock;
	input reset;
	input [31:0] io_rs1;
	input [31:0] io_rs2;
	input [31:0] io_pc;
	input [11:0] io_imm;
	input [2:0] io_branchOp;
	input io_valid;
	output wire io_taken;
	output wire [31:0] io_target;
	output wire [31:0] io_nextPc;
	output wire io_misaligned;
	wire [177:0] io;
	wire [31:0] _io_taken_T_5 = io[177-:32];
	wire [31:0] _io_taken_T_9 = io[177-:32];
	wire [31:0] _io_taken_T_6 = io[145-:32];
	wire [31:0] _io_taken_T_10 = io[145-:32];
	wire [31:0] _targetAddr_T = io[113-:32];
	wire [32:0] _targetAddr_T_1 = {_targetAddr_T[31], _targetAddr_T} + {{21 {io[81]}}, io[81-:12]};
	wire [31:0] _targetAddr_T_2 = _targetAddr_T_1[31:0];
	wire [31:0] _targetAddr_T_3 = _targetAddr_T_2;
	wire [31:0] targetAddr = _targetAddr_T_3;
	wire [31:0] _io_target_T = targetAddr & 32'hfffffffc;
	wire [1:0] _io_misaligned_T = targetAddr[1:0];
	wire _io_misaligned_T_1 = |_io_misaligned_T;
	wire _io_taken_T = io[69-:3] == 3'h0;
	wire _io_taken_T_1 = io[177-:32] == io[145-:32];
	wire _io_taken_T_2 = io[69-:3] == 3'h1;
	wire _io_taken_T_3 = io[177-:32] != io[145-:32];
	wire _io_taken_T_4 = io[69-:3] == 3'h4;
	wire _io_taken_T_7 = $signed(_io_taken_T_5) < $signed(_io_taken_T_6);
	wire _io_taken_T_8 = io[69-:3] == 3'h5;
	wire _io_taken_T_11 = $signed(_io_taken_T_9) >= $signed(_io_taken_T_10);
	wire _io_taken_T_12 = io[69-:3] == 3'h6;
	wire _io_taken_T_13 = io[177-:32] < io[145-:32];
	wire _io_taken_T_14 = &io[69-:3];
	wire _io_taken_T_15 = io[177-:32] >= io[145-:32];
	wire _io_taken_T_16 = _io_taken_T_14 & _io_taken_T_15;
	wire _io_taken_T_17 = (_io_taken_T_12 ? _io_taken_T_13 : _io_taken_T_16);
	wire _io_taken_T_18 = (_io_taken_T_8 ? _io_taken_T_11 : _io_taken_T_17);
	wire _io_taken_T_19 = (_io_taken_T_4 ? _io_taken_T_7 : _io_taken_T_18);
	wire _io_taken_T_20 = (_io_taken_T_2 ? _io_taken_T_3 : _io_taken_T_19);
	wire _io_taken_T_21 = (_io_taken_T ? _io_taken_T_1 : _io_taken_T_20);
	wire _io_taken_T_22 = _io_taken_T_21 & io[66];
	wire _io_taken_T_23 = ~io[0];
	wire _io_taken_T_24 = _io_taken_T_22 & _io_taken_T_23;
	wire [32:0] _io_nextPc_T = {1'h0, _targetAddr_T} + 33'h000000004;
	wire [31:0] _io_nextPc_T_1 = _io_nextPc_T[31:0];
	wire [31:0] _io_nextPc_T_2 = (io[65] ? io[64-:32] : _io_nextPc_T_1);
	assign io = {io_rs1, io_rs2, io_pc, io_imm, io_branchOp, io_valid, _io_taken_T_24, _io_target_T, _io_nextPc_T_2, _io_misaligned_T_1};
	assign io_taken = io[65];
	assign io_target = io[64-:32];
	assign io_nextPc = io[32-:32];
	assign io_misaligned = io[0];
endmodule
