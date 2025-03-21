module ALU32 (
	clock,
	reset,
	io_a,
	io_b,
	io_result,
	io_opcode
);
	input clock;
	input reset;
	input [31:0] io_a;
	input [31:0] io_b;
	output wire [31:0] io_result;
	input [5:0] io_opcode;
	wire [31:0] io_a_0 = io_a;
	wire [31:0] io_b_0 = io_b;
	wire [5:0] io_opcode_0 = io_opcode;
	wire [31:0] _result_T_2 = io_a_0;
	wire [31:0] _result_T_8 = io_a_0;
	wire [31:0] _result_T_31 = io_a_0;
	wire [31:0] _result_T_37 = io_a_0;
	wire [31:0] _result_T_3 = io_b_0;
	wire [31:0] _result_T_9 = io_b_0;
	wire [31:0] _result_T_38 = io_b_0;
	wire [3:0] _result_T = io_opcode_0[3:0];
	wire [3:0] _result_T_6 = io_opcode_0[3:0];
	wire [3:0] _result_T_12 = io_opcode_0[3:0];
	wire [3:0] _result_T_15 = io_opcode_0[3:0];
	wire [3:0] _result_T_18 = io_opcode_0[3:0];
	wire [3:0] _result_T_21 = io_opcode_0[3:0];
	wire [3:0] _result_T_25 = io_opcode_0[3:0];
	wire [3:0] _result_T_29 = io_opcode_0[3:0];
	wire [3:0] _result_T_35 = io_opcode_0[3:0];
	wire [3:0] _result_T_41 = io_opcode_0[3:0];
	wire _result_T_1 = _result_T == 4'h0;
	wire [32:0] _result_T_4 = {_result_T_2[31], _result_T_2} + {_result_T_3[31], _result_T_3};
	wire [32:0] _result_T_5 = _result_T_4;
	wire _result_T_7 = _result_T_6 == 4'h1;
	wire [32:0] _result_T_10 = {_result_T_8[31], _result_T_8} - {_result_T_9[31], _result_T_9};
	wire [32:0] _result_T_11 = _result_T_10;
	wire _result_T_13 = _result_T_12 == 4'h8;
	wire [31:0] _result_T_14 = io_a_0 ^ io_b_0;
	wire _result_T_16 = _result_T_15 == 4'hc;
	wire [31:0] _result_T_17 = io_a_0 | io_b_0;
	wire _result_T_19 = _result_T_18 == 4'he;
	wire [31:0] _result_T_20 = io_a_0 & io_b_0;
	wire _result_T_22 = _result_T_21 == 4'h2;
	wire [5:0] _result_T_23 = io_b_0[5:0];
	wire [5:0] _result_T_27 = io_b_0[5:0];
	wire [5:0] _result_T_32 = io_b_0[5:0];
	wire [94:0] _result_T_24 = {63'h0000000000000000, io_a_0} << _result_T_23;
	wire _result_T_26 = _result_T_25 == 4'ha;
	wire [31:0] _result_T_28 = io_a_0 >> _result_T_27;
	wire _result_T_30 = _result_T_29 == 4'hb;
	wire [31:0] _result_T_33 = $signed($signed(_result_T_31) >>> _result_T_32);
	wire [31:0] _result_T_34 = _result_T_33;
	wire _result_T_36 = _result_T_35 == 4'h4;
	wire _result_T_39 = $signed(_result_T_37) < $signed(_result_T_38);
	wire _result_T_40 = _result_T_39;
	wire _result_T_42 = _result_T_41 == 4'h6;
	wire _result_T_43 = io_a_0 < io_b_0;
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
	wire [31:0] io_result_0 = result[31:0];
	assign io_result = io_result_0;
endmodule
