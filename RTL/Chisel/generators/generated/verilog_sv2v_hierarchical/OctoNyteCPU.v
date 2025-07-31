module BranchUnit (
	io_rs1,
	io_rs2,
	io_pc,
	io_imm,
	io_branchOp,
	io_taken,
	io_target,
	io_nextPc,
	io_misaligned
);
	input [31:0] io_rs1;
	input [31:0] io_rs2;
	input [31:0] io_pc;
	input [11:0] io_imm;
	input [2:0] io_branchOp;
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
	wire _io_taken_T_22 = _io_taken_T_21;
	wire _io_taken_T_23 = ~io[0];
	wire _io_taken_T_24 = _io_taken_T_22 & _io_taken_T_23;
	wire [32:0] _io_nextPc_T = {1'h0, _targetAddr_T} + 33'h000000004;
	wire [31:0] _io_nextPc_T_1 = _io_nextPc_T[31:0];
	wire [31:0] _io_nextPc_T_2 = (io[65] ? io[64-:32] : _io_nextPc_T_1);
	assign io = {io_rs1, io_rs2, io_pc, io_imm, io_branchOp, 1'h1, _io_taken_T_24, _io_target_T, _io_nextPc_T_2, _io_misaligned_T_1};
	assign io_taken = io[65];
	assign io_target = io[64-:32];
	assign io_nextPc = io[32-:32];
	assign io_misaligned = io[0];
endmodule
module ALU32 (
	io_a,
	io_b,
	io_result,
	io_opcode
);
	input [31:0] io_a;
	input [31:0] io_b;
	output wire [31:0] io_result;
	input [5:0] io_opcode;
	wire [101:0] io;
	wire [31:0] _result_T_2 = io[101-:32];
	wire [31:0] _result_T_8 = io[101-:32];
	wire [31:0] _result_T_31 = io[101-:32];
	wire [31:0] _result_T_37 = io[101-:32];
	wire [31:0] _result_T_3 = io[69-:32];
	wire [31:0] _result_T_9 = io[69-:32];
	wire [31:0] _result_T_38 = io[69-:32];
	wire [3:0] _result_T = io[3:0];
	wire [3:0] _result_T_6 = io[3:0];
	wire [3:0] _result_T_12 = io[3:0];
	wire [3:0] _result_T_15 = io[3:0];
	wire [3:0] _result_T_18 = io[3:0];
	wire [3:0] _result_T_21 = io[3:0];
	wire [3:0] _result_T_25 = io[3:0];
	wire [3:0] _result_T_29 = io[3:0];
	wire [3:0] _result_T_35 = io[3:0];
	wire [3:0] _result_T_41 = io[3:0];
	wire _result_T_1 = _result_T == 4'h0;
	wire [32:0] _result_T_4 = {_result_T_2[31], _result_T_2} + {_result_T_3[31], _result_T_3};
	wire [32:0] _result_T_5 = _result_T_4;
	wire _result_T_7 = _result_T_6 == 4'h1;
	wire [32:0] _result_T_10 = {_result_T_8[31], _result_T_8} - {_result_T_9[31], _result_T_9};
	wire [32:0] _result_T_11 = _result_T_10;
	wire _result_T_13 = _result_T_12 == 4'h8;
	wire [31:0] _result_T_14 = io[101-:32] ^ io[69-:32];
	wire _result_T_16 = _result_T_15 == 4'hc;
	wire [31:0] _result_T_17 = io[101-:32] | io[69-:32];
	wire _result_T_19 = _result_T_18 == 4'he;
	wire [31:0] _result_T_20 = io[101-:32] & io[69-:32];
	wire _result_T_22 = _result_T_21 == 4'h2;
	wire [5:0] _result_T_23 = io[43:38];
	wire [5:0] _result_T_27 = io[43:38];
	wire [5:0] _result_T_32 = io[43:38];
	wire [94:0] _result_T_24 = {63'h0000000000000000, io[101-:32]} << _result_T_23;
	wire _result_T_26 = _result_T_25 == 4'ha;
	wire [31:0] _result_T_28 = io[101-:32] >> _result_T_27;
	wire _result_T_30 = _result_T_29 == 4'hb;
	wire [31:0] _result_T_33 = $signed($signed(_result_T_31) >>> _result_T_32);
	wire [31:0] _result_T_34 = _result_T_33;
	wire _result_T_36 = _result_T_35 == 4'h4;
	wire _result_T_39 = $signed(_result_T_37) < $signed(_result_T_38);
	wire _result_T_40 = _result_T_39;
	wire _result_T_42 = _result_T_41 == 4'h6;
	wire _result_T_43 = io[101-:32] < io[69-:32];
	wire _result_T_44 = _result_T_43;
	wire [31:0] _result_T_45 = (_result_T_42 ? {31'h00000000, _result_T_44} : 32'h00000000);
	wire [31:0] _result_T_46 = (_result_T_36 ? {31'h00000000, _result_T_40} : _result_T_45);
	wire [31:0] _result_T_47 = (_result_T_30 ? _result_T_34 : _result_T_46);
	wire [31:0] _result_T_48 = (_result_T_26 ? _result_T_28 : _result_T_47);
	wire [94:0] _result_T_49 = (_result_T_22 ? _result_T_24 : {63'h0000000000000000, _result_T_48});
	wire [94:0] _result_T_50 = (_result_T_19 ? {63'h0000000000000000, _result_T_20} : _result_T_49);
	wire [94:0] _result_T_51 = (_result_T_16 ? {63'h0000000000000000, _result_T_17} : _result_T_50);
	wire [94:0] _result_T_52 = (_result_T_13 ? {63'h0000000000000000, _result_T_14} : _result_T_51);
	wire [94:0] _result_T_53 = (_result_T_7 ? {62'h0000000000000000, _result_T_11} : _result_T_52);
	wire [94:0] result = (_result_T_1 ? {62'h0000000000000000, _result_T_5} : _result_T_53);
	assign io = {io_a, io_b, result[31:0], io_opcode};
	assign io_result = io[37-:32];
endmodule
module LoadUnit (
	io_addr,
	io_dataIn,
	io_funct3,
	io_dataOut
);
	input [31:0] io_addr;
	input [31:0] io_dataIn;
	input [2:0] io_funct3;
	output wire [31:0] io_dataOut;
	wire [31:0] extractedData;
	wire [1:0] _loadWidth_T_7 = 2'h2;
	wire [98:0] io;
	wire [31:0] _extractedData_T_5 = io[66-:32];
	wire [1:0] _loadWidth_T_9;
	wire _isSigned_T_4;
	wire _GEN = io[34-:3] == 3'h0;
	wire _loadWidth_T;
	assign _loadWidth_T = _GEN;
	wire _isSigned_T;
	assign _isSigned_T = _GEN;
	wire _loadWidth_T_1 = io[34-:3] == 3'h4;
	wire _loadWidth_T_2 = _loadWidth_T | _loadWidth_T_1;
	wire _GEN_0 = io[34-:3] == 3'h1;
	wire _loadWidth_T_3;
	assign _loadWidth_T_3 = _GEN_0;
	wire _isSigned_T_1;
	assign _isSigned_T_1 = _GEN_0;
	wire _loadWidth_T_4 = io[34-:3] == 3'h5;
	wire _loadWidth_T_5 = _loadWidth_T_3 | _loadWidth_T_4;
	wire _GEN_1 = io[34-:3] == 3'h2;
	wire _loadWidth_T_6;
	assign _loadWidth_T_6 = _GEN_1;
	wire _isSigned_T_3;
	assign _isSigned_T_3 = _GEN_1;
	wire [1:0] _loadWidth_T_8 = (_loadWidth_T_5 ? 2'h1 : 2'h2);
	assign _loadWidth_T_9 = (_loadWidth_T_2 ? 2'h0 : _loadWidth_T_8);
	wire [1:0] loadWidth = _loadWidth_T_9;
	wire _isSigned_T_2 = _isSigned_T | _isSigned_T_1;
	assign _isSigned_T_4 = _isSigned_T_2 | _isSigned_T_3;
	wire isSigned = _isSigned_T_4;
	wire [31:0] _extractedData_T_8;
	wire [31:0] _io_dataOut_T = extractedData;
	wire _extractedData_T = loadWidth == 2'h0;
	wire [7:0] _extractedData_T_1 = _extractedData_T_5[7:0];
	wire _extractedData_T_2 = loadWidth == 2'h1;
	wire [15:0] _extractedData_T_3 = _extractedData_T_5[15:0];
	wire _extractedData_T_4 = loadWidth == 2'h2;
	wire [31:0] _extractedData_T_6 = (_extractedData_T_4 ? _extractedData_T_5 : _extractedData_T_5);
	wire [31:0] _extractedData_T_7 = (_extractedData_T_2 ? {16'h0000, _extractedData_T_3} : _extractedData_T_6);
	assign _extractedData_T_8 = (_extractedData_T ? {24'h000000, _extractedData_T_1} : _extractedData_T_7);
	assign extractedData = _extractedData_T_8;
	wire [31:0] _io_dataOut_T_1 = _io_dataOut_T;
	wire [32:0] _io_dataOut_T_2 = {1'h0, extractedData};
	wire [32:0] _io_dataOut_T_3 = _io_dataOut_T_2;
	wire [32:0] _io_dataOut_T_4 = (isSigned ? {1'h0, _io_dataOut_T_1} : _io_dataOut_T_3);
	assign io = {io_addr, io_dataIn, io_funct3, _io_dataOut_T_4[31:0]};
	assign io_dataOut = io[31-:32];
endmodule
module StoreUnit (
	io_addr,
	io_dataIn,
	io_funct3,
	io_memWrite
);
	input [31:0] io_addr;
	input [31:0] io_dataIn;
	input [2:0] io_funct3;
	output wire [31:0] io_memWrite;
	wire [98:0] io;
	wire [7:0] _dataOut_T = io[42:35];
	wire [31:0] _dataOut_T_1 = {24'h000000, _dataOut_T};
	wire [15:0] _dataOut_T_2 = io[50:35];
	wire [31:0] _dataOut_T_3 = {16'h0000, _dataOut_T_2};
	wire [31:0] dataOut = (io[34-:3] == 3'h0 ? _dataOut_T_1 : (io[34-:3] == 3'h1 ? _dataOut_T_3 : (io[34-:3] == 3'h2 ? io[66-:32] : 32'h00000000)));
	assign io = {io_addr, io_dataIn, io_funct3, dataOut};
	assign io_memWrite = io[31-:32];
endmodule
module regFile_32x32 (
	R0_addr,
	R0_en,
	R0_clk,
	R0_data,
	R1_addr,
	R1_en,
	R1_clk,
	R1_data,
	W0_addr,
	W0_en,
	W0_clk,
	W0_data
);
	input [4:0] R0_addr;
	input R0_en;
	input R0_clk;
	output wire [31:0] R0_data;
	input [4:0] R1_addr;
	input R1_en;
	input R1_clk;
	output wire [31:0] R1_data;
	input [4:0] W0_addr;
	input W0_en;
	input W0_clk;
	input [31:0] W0_data;
	reg [31:0] Memory [0:31];
	always @(posedge W0_clk)
		if (W0_en & 1'h1)
			Memory[W0_addr] <= W0_data;
	assign R0_data = (R0_en ? Memory[R0_addr] : 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
	assign R1_data = (R1_en ? Memory[R1_addr] : 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
endmodule
module OctoNyteCPU (
	clock,
	reset,
	io_memAddr,
	io_memData,
	io_memWrite,
	io_inst
);
	input clock;
	input reset;
	output wire [31:0] io_memAddr;
	input [31:0] io_memData;
	output wire io_memWrite;
	input [31:0] io_inst;
	wire [31:0] imm;
	wire [31:0] _storeUnit_io_memWrite;
	wire [31:0] _alu_io_result;
	wire _branchUnit_io_taken;
	wire [31:0] _branchUnit_io_target;
	wire [31:0] _regFile_ext_R0_data;
	wire [31:0] _regFile_ext_R1_data;
	wire [96:0] io;
	reg [31:0] IF_ID;
	reg [31:0] MEM_WB;
	reg [31:0] pc;
	wire [6:0] opcode = IF_ID[6:0];
	wire [4:0] rs1 = IF_ID[19:15];
	wire [4:0] rs2 = IF_ID[24:20];
	wire [4:0] rd = IF_ID[11:7];
	wire [2:0] funct3 = IF_ID[14:12];
	wire [2:0] branchOp = funct3;
	wire [6:0] funct7 = IF_ID[31:25];
	wire [31:0] _branchUnit_io_imm_T = imm;
	wire _imm_T = opcode == 7'h03;
	wire [11:0] _imm_T_1 = IF_ID[31:20];
	wire [11:0] _imm_T_3 = IF_ID[31:20];
	wire [11:0] _imm_T_5 = IF_ID[31:20];
	wire _imm_T_2 = opcode == 7'h63;
	wire _imm_T_4 = opcode == 7'h13;
	wire _imm_T_6 = opcode == 7'h6f;
	wire [19:0] _imm_T_7 = IF_ID[31:12];
	wire [19:0] _imm_T_8 = (_imm_T_6 ? _imm_T_7 : 20'h00000);
	wire [19:0] _imm_T_9 = (_imm_T_4 ? {8'h00, _imm_T_5} : _imm_T_8);
	wire [19:0] _imm_T_10 = (_imm_T_2 ? {8'h00, _imm_T_3} : _imm_T_9);
	wire [19:0] _imm_T_11 = (_imm_T ? {8'h00, _imm_T_1} : _imm_T_10);
	assign imm = {12'h000, _imm_T_11};
	wire [5:0] _alu_io_opcode_T = IF_ID[5:0];
	wire [31:0] _MEM_WB_T = (_branchUnit_io_taken ? _branchUnit_io_target : _alu_io_result);
	wire [32:0] _pc_T = {1'h0, pc} + 33'h000000004;
	wire [31:0] _pc_T_1 = _pc_T[31:0];
	assign io = {_alu_io_result, io_memData, _storeUnit_io_memWrite[0], io_inst};
	wire [31:0] nextPc;
	always @(posedge clock)
		if (reset) begin
			IF_ID <= 32'h00000000;
			MEM_WB <= 32'h00000000;
			pc <= 32'h00000000;
		end
		else begin
			IF_ID <= io[31-:32];
			MEM_WB <= _MEM_WB_T;
			pc <= (_branchUnit_io_taken ? nextPc : _pc_T_1);
		end
	regFile_32x32 regFile_ext(
		.R0_addr(rs2),
		.R0_en(1'h1),
		.R0_clk(clock),
		.R0_data(_regFile_ext_R0_data),
		.R1_addr(rs1),
		.R1_en(1'h1),
		.R1_clk(clock),
		.R1_data(_regFile_ext_R1_data),
		.W0_addr(rd),
		.W0_en(|MEM_WB),
		.W0_clk(clock),
		.W0_data(MEM_WB)
	);
	BranchUnit branchUnit(
		.io_rs1(_regFile_ext_R1_data),
		.io_rs2(_regFile_ext_R0_data),
		.io_pc(pc),
		.io_imm(_branchUnit_io_imm_T[11:0]),
		.io_branchOp(branchOp),
		.io_taken(_branchUnit_io_taken),
		.io_target(_branchUnit_io_target),
		.io_nextPc(nextPc),
		.io_misaligned()
	);
	ALU32 alu(
		.io_a(_regFile_ext_R1_data),
		.io_b(_regFile_ext_R0_data),
		.io_result(_alu_io_result),
		.io_opcode(_alu_io_opcode_T)
	);
	LoadUnit loadUnit(
		.io_addr(_alu_io_result),
		.io_dataIn(io[64-:32]),
		.io_funct3(funct3),
		.io_dataOut()
	);
	StoreUnit storeUnit(
		.io_addr(_alu_io_result),
		.io_dataIn(_regFile_ext_R0_data),
		.io_funct3(funct3),
		.io_memWrite(_storeUnit_io_memWrite)
	);
	assign io_memAddr = io[96-:32];
	assign io_memWrite = io[32];
endmodule
