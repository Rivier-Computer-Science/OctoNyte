module RegFileMT2R1WVec (
	clock,
	reset,
	io_threadID,
	io_src1,
	io_src2,
	io_dst1,
	io_wen,
	io_dst1data,
	io_src1data,
	io_src2data
);
	input clock;
	input reset;
	input [1:0] io_threadID;
	input [4:0] io_src1;
	input [4:0] io_src2;
	input [4:0] io_dst1;
	input io_wen;
	input [31:0] io_dst1data;
	output wire [31:0] io_src1data;
	output wire [31:0] io_src2data;
	wire [4095:0] _regs_WIRE = 4096'h0;
	wire [113:0] io;
	reg [4095:0] regs;
	wire [6:0] effectiveSrc1 = {io[113-:2], io[111-:5]};
	wire [6:0] effectiveSrc2 = {io[113-:2], io[106-:5]};
	wire [6:0] effectiveDst1 = {io[113-:2], io[101-:5]};
	assign io = {io_threadID, io_src1, io_src2, io_dst1, io_wen, io_dst1data, regs[effectiveSrc1 * 32+:32], regs[effectiveSrc2 * 32+:32]};
	always @(posedge clock)
		if (reset)
			regs <= _regs_WIRE;
		else if (io[96])
			regs[effectiveDst1 * 32+:32] <= io[95-:32];
	initial begin : sv2v_autoblock_1
		reg [31:0] _RANDOM [0:127];
	end
	assign io_src1data = io[63-:32];
	assign io_src2data = io[31-:32];
endmodule
module TetraNyteCore_Anon (
	io_a,
	io_b,
	io_fn,
	io_out
);
	input [31:0] io_a;
	input [31:0] io_b;
	input [4:0] io_fn;
	output wire [31:0] io_out;
	wire [100:0] io;
	wire [32:0] _GEN = {1'h0, io[100-:32]};
	wire [32:0] _GEN_0 = {1'h0, io[68-:32]};
	wire [32:0] _io_out_T = _GEN + _GEN_0;
	wire [31:0] _io_out_T_1 = _io_out_T[31:0];
	wire [32:0] _io_out_T_2 = _GEN - _GEN_0;
	wire [31:0] _io_out_T_3 = _io_out_T_2[31:0];
	assign io = {io_a, io_b, io_fn, (io[36-:5] == 5'h00 ? _io_out_T_1 : (io[36-:5] == 5'h01 ? _io_out_T_3 : 32'h00000000))};
	assign io_out = io[31-:32];
endmodule
module instrMem_1024x32 (
	R0_addr,
	R0_en,
	R0_clk,
	R0_data,
	W0_addr,
	W0_en,
	W0_clk,
	W0_data
);
	input [9:0] R0_addr;
	input R0_en;
	input R0_clk;
	output wire [31:0] R0_data;
	input [9:0] W0_addr;
	input W0_en;
	input W0_clk;
	input [31:0] W0_data;
	reg [31:0] Memory [0:1023];
	reg _R0_en_d0;
	reg [9:0] _R0_addr_d0;
	always @(posedge R0_clk) begin
		_R0_en_d0 <= R0_en;
		_R0_addr_d0 <= R0_addr;
	end
	always @(posedge W0_clk)
		if (W0_en & 1'h1)
			Memory[W0_addr] <= W0_data;
	assign R0_data = (_R0_en_d0 ? Memory[_R0_addr_d0] : 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
endmodule
module TetraNyteCore (
	clock,
	reset,
	io_memAddr,
	io_memWdata,
	io_memRdata,
	io_memWe,
	io_instrWriteEnable,
	io_instrWriteAddr,
	io_instrWriteData,
	io_debug
);
	input clock;
	input reset;
	output wire [31:0] io_memAddr;
	output wire [31:0] io_memWdata;
	input [31:0] io_memRdata;
	output wire io_memWe;
	input io_instrWriteEnable;
	input [9:0] io_instrWriteAddr;
	input [31:0] io_instrWriteData;
	input io_debug;
	wire [31:0] _alu_io_out;
	wire [31:0] _regFile_io_src1data;
	wire [31:0] _regFile_io_src2data;
	wire [31:0] _instrMem_ext_R0_data;
	wire [127:0] _pcRegs_WIRE = 128'h00000000000000000000000000000000;
	wire [320:0] _GEN = 321'h0;
	wire [320:0] _ifStage_WIRE;
	assign _ifStage_WIRE = _GEN;
	wire [320:0] _ifStage_WIRE_1;
	assign _ifStage_WIRE_1 = _GEN;
	wire [320:0] _ifStage_WIRE_2;
	assign _ifStage_WIRE_2 = _GEN;
	wire [320:0] _ifStage_WIRE_3;
	assign _ifStage_WIRE_3 = _GEN;
	wire [320:0] _decStage_WIRE;
	assign _decStage_WIRE = _GEN;
	wire [320:0] _decStage_WIRE_1;
	assign _decStage_WIRE_1 = _GEN;
	wire [320:0] _decStage_WIRE_2;
	assign _decStage_WIRE_2 = _GEN;
	wire [320:0] _decStage_WIRE_3;
	assign _decStage_WIRE_3 = _GEN;
	wire [320:0] _exStage_WIRE;
	assign _exStage_WIRE = _GEN;
	wire [320:0] _exStage_WIRE_1;
	assign _exStage_WIRE_1 = _GEN;
	wire [320:0] _exStage_WIRE_2;
	assign _exStage_WIRE_2 = _GEN;
	wire [320:0] _exStage_WIRE_3;
	assign _exStage_WIRE_3 = _GEN;
	wire [320:0] _memStage_WIRE;
	assign _memStage_WIRE = _GEN;
	wire [320:0] _memStage_WIRE_1;
	assign _memStage_WIRE_1 = _GEN;
	wire [320:0] _memStage_WIRE_2;
	assign _memStage_WIRE_2 = _GEN;
	wire [320:0] _memStage_WIRE_3;
	assign _memStage_WIRE_3 = _GEN;
	wire [320:0] _ifWire_WIRE;
	assign _ifWire_WIRE = _GEN;
	wire [320:0] _decWire_WIRE;
	assign _decWire_WIRE = _GEN;
	wire [320:0] _exWire_WIRE;
	assign _exWire_WIRE = _GEN;
	wire [320:0] _memWire_WIRE;
	assign _memWire_WIRE = _GEN;
	wire [140:0] io;
	reg [1:0] currentThread;
	wire [2:0] _currentThread_T = {1'h0, currentThread} + 3'h1;
	wire [1:0] _currentThread_T_1 = _currentThread_T[1:0];
	reg [127:0] pcRegs;
	reg [1283:0] ifStage;
	reg [1283:0] decStage;
	reg [1283:0] exStage;
	reg [1283:0] memStage;
	wire [31:0] _GEN_0 = pcRegs[currentThread * 32+:32];
	wire [29:0] _ifWire_instr_T = _GEN_0[31:2];
	wire [29:0] _ifWire_instr_WIRE = _ifWire_instr_T;
	wire [9:0] _ifWire_instr_T_1 = _ifWire_instr_WIRE[9:0];
	wire [320:0] ifWire = {currentThread, 1'h1, _GEN_0, _instrMem_ext_R0_data, 254'h0000000000000000000000000000000000000000000000000000000000000000};
	wire [32:0] _pcRegs_T = {1'h0, _GEN_0} + 33'h000000004;
	wire [31:0] _pcRegs_T_1 = _pcRegs_T[31:0];
	wire [320:0] _GEN_1 = decStage[currentThread * 321+:321];
	wire [320:0] decWire;
	wire [6:0] opcode = decWire[260:254];
	wire _T = opcode == 7'h33;
	wire _T_1 = opcode == 7'h03;
	wire [4:0] _decWire_rs1_T = decWire[273:269];
	wire [4:0] _decWire_rs2_T = decWire[278:274];
	wire [4:0] _decWire_rd_T = decWire[265:261];
	function automatic [1:0] sv2v_cast_2;
		input reg [1:0] inp;
		sv2v_cast_2 = inp;
	endfunction
	function automatic [31:0] sv2v_cast_32;
		input reg [31:0] inp;
		sv2v_cast_32 = inp;
	endfunction
	function automatic [0:0] sv2v_cast_1;
		input reg [0:0] inp;
		sv2v_cast_1 = inp;
	endfunction
	function automatic [4:0] sv2v_cast_5;
		input reg [4:0] inp;
		sv2v_cast_5 = inp;
	endfunction
	assign decWire = {sv2v_cast_2(_GEN_1[320-:2]), _GEN_1[318], sv2v_cast_32(_GEN_1[317-:32]), sv2v_cast_32(_GEN_1[285-:32]), sv2v_cast_1(_T | _GEN_1[253]), sv2v_cast_1((~_T & _T_1) | _GEN_1[252]), sv2v_cast_1((~(_T | _T_1) & (opcode == 7'h23)) | _GEN_1[251]), _GEN_1[250], _GEN_1[249], _GEN_1[248], _GEN_1[247], _GEN_1[246], _GEN_1[245], _GEN_1[244], sv2v_cast_5(_GEN_1[243-:5]), sv2v_cast_32(_GEN_1[238-:32]), _decWire_rs1_T, _decWire_rs2_T, _decWire_rd_T, _regFile_io_src1data, _regFile_io_src2data, sv2v_cast_32(_GEN_1[127-:32]), sv2v_cast_32(_GEN_1[95-:32]), sv2v_cast_32(_GEN_1[63-:32]), sv2v_cast_32(_GEN_1[31-:32])};
	wire [320:0] _GEN_2 = exStage[currentThread * 321+:321];
	wire [320:0] exWire;
	wire _T_3 = exWire[252] | exWire[251];
	wire [32:0] _exWire_memAddr_T = {1'h0, exWire[191-:32]} + {1'h0, exWire[238-:32]};
	wire [31:0] _exWire_memAddr_T_1 = _exWire_memAddr_T[31:0];
	assign exWire = {sv2v_cast_2(_GEN_2[320-:2]), _GEN_2[318], sv2v_cast_32(_GEN_2[317-:32]), sv2v_cast_32(_GEN_2[285-:32]), _GEN_2[253], _GEN_2[252], _GEN_2[251], _GEN_2[250], _GEN_2[249], _GEN_2[248], _GEN_2[247], _GEN_2[246], _GEN_2[245], _GEN_2[244], sv2v_cast_5(_GEN_2[243-:5]), sv2v_cast_32(_GEN_2[238-:32]), sv2v_cast_5(_GEN_2[206-:5]), sv2v_cast_5(_GEN_2[201-:5]), sv2v_cast_5(_GEN_2[196-:5]), sv2v_cast_32(_GEN_2[191-:32]), sv2v_cast_32(_GEN_2[159-:32]), sv2v_cast_32((_T_3 ? _exWire_memAddr_T_1 : _GEN_2[127-:32])), sv2v_cast_32((_T_3 ? exWire[159-:32] : _GEN_2[95-:32])), sv2v_cast_32(_GEN_2[63-:32]), _alu_io_out};
	wire [320:0] _GEN_3 = memStage[currentThread * 321+:321];
	wire [320:0] memWire;
	wire _io_memWe_T = memWire[251] & memWire[318];
	assign memWire = {sv2v_cast_2(_GEN_3[320-:2]), _GEN_3[318], sv2v_cast_32(_GEN_3[317-:32]), sv2v_cast_32(_GEN_3[285-:32]), _GEN_3[253], _GEN_3[252], _GEN_3[251], _GEN_3[250], _GEN_3[249], _GEN_3[248], _GEN_3[247], _GEN_3[246], _GEN_3[245], _GEN_3[244], sv2v_cast_5(_GEN_3[243-:5]), sv2v_cast_32(_GEN_3[238-:32]), sv2v_cast_5(_GEN_3[206-:5]), sv2v_cast_5(_GEN_3[201-:5]), sv2v_cast_5(_GEN_3[196-:5]), sv2v_cast_32(_GEN_3[191-:32]), sv2v_cast_32(_GEN_3[159-:32]), sv2v_cast_32(_GEN_3[127-:32]), sv2v_cast_32(_GEN_3[95-:32]), sv2v_cast_32(io[76-:32]), sv2v_cast_32(_GEN_3[31-:32])};
	wire [31:0] wbData = (memWire[252] ? memWire[63-:32] : memWire[31-:32]);
	wire _regFile_io_wen_T = |memWire[196-:5];
	wire _regFile_io_wen_T_1 = memWire[318] & _regFile_io_wen_T;
	wire _regFile_io_wen_T_2 = memWire[252] | memWire[253];
	wire _regFile_io_wen_T_3 = _regFile_io_wen_T_1 & _regFile_io_wen_T_2;
	wire [1283:0] _ifStage_WIRE_4 = {_ifStage_WIRE_3, _ifStage_WIRE_2, _ifStage_WIRE_1, _ifStage_WIRE};
	wire [1283:0] _decStage_WIRE_4 = {_decStage_WIRE_3, _decStage_WIRE_2, _decStage_WIRE_1, _decStage_WIRE};
	wire [1283:0] _exStage_WIRE_4 = {_exStage_WIRE_3, _exStage_WIRE_2, _exStage_WIRE_1, _exStage_WIRE};
	wire [1283:0] _memStage_WIRE_4 = {_memStage_WIRE_3, _memStage_WIRE_2, _memStage_WIRE_1, _memStage_WIRE};
	assign io = {sv2v_cast_32(memWire[127-:32]), sv2v_cast_32(memWire[95-:32]), io_memRdata, _io_memWe_T, io_instrWriteEnable, io_instrWriteAddr, io_instrWriteData, io_debug};
	always @(posedge clock)
		if (reset) begin
			currentThread <= 2'h0;
			pcRegs <= _pcRegs_WIRE;
			ifStage <= _ifStage_WIRE_4;
			decStage <= _decStage_WIRE_4;
			exStage <= _exStage_WIRE_4;
			memStage <= _memStage_WIRE_4;
		end
		else begin : sv2v_autoblock_1
			reg _GEN_4;
			reg _GEN_5;
			reg _GEN_6;
			_GEN_4 = currentThread == 2'h0;
			_GEN_5 = currentThread == 2'h1;
			_GEN_6 = currentThread == 2'h2;
			currentThread <= _currentThread_T_1;
			pcRegs[currentThread * 32+:32] <= _pcRegs_T_1;
			ifStage[0+:321] <= {sv2v_cast_2((_GEN_4 ? ifWire[320-:2] : ifStage[320-:2])), sv2v_cast_1(_GEN_4 | ifStage[318]), sv2v_cast_32((_GEN_4 ? ifWire[317-:32] : ifStage[317-:32])), sv2v_cast_32((_GEN_4 ? ifWire[285-:32] : ifStage[285-:32])), sv2v_cast_1(~_GEN_4 & ifStage[253]), sv2v_cast_1(~_GEN_4 & ifStage[252]), sv2v_cast_1(~_GEN_4 & ifStage[251]), sv2v_cast_1(~_GEN_4 & ifStage[250]), sv2v_cast_1(~_GEN_4 & ifStage[249]), sv2v_cast_1(~_GEN_4 & ifStage[248]), sv2v_cast_1(~_GEN_4 & ifStage[247]), sv2v_cast_1(~_GEN_4 & ifStage[246]), sv2v_cast_1(~_GEN_4 & ifStage[245]), sv2v_cast_1(~_GEN_4 & ifStage[244]), sv2v_cast_5((_GEN_4 ? 5'h00 : ifStage[243-:5])), sv2v_cast_32((_GEN_4 ? 32'h00000000 : ifStage[238-:32])), sv2v_cast_5((_GEN_4 ? 5'h00 : ifStage[206-:5])), sv2v_cast_5((_GEN_4 ? 5'h00 : ifStage[201-:5])), sv2v_cast_5((_GEN_4 ? 5'h00 : ifStage[196-:5])), sv2v_cast_32((_GEN_4 ? 32'h00000000 : ifStage[191-:32])), sv2v_cast_32((_GEN_4 ? 32'h00000000 : ifStage[159-:32])), sv2v_cast_32((_GEN_4 ? 32'h00000000 : ifStage[127-:32])), sv2v_cast_32((_GEN_4 ? 32'h00000000 : ifStage[95-:32])), sv2v_cast_32((_GEN_4 ? 32'h00000000 : ifStage[63-:32])), sv2v_cast_32((_GEN_4 ? 32'h00000000 : ifStage[31-:32]))};
			ifStage[321+:321] <= {sv2v_cast_2((_GEN_5 ? ifWire[320-:2] : ifStage[641-:2])), sv2v_cast_1(_GEN_5 | ifStage[639]), sv2v_cast_32((_GEN_5 ? ifWire[317-:32] : ifStage[638-:32])), sv2v_cast_32((_GEN_5 ? ifWire[285-:32] : ifStage[606-:32])), sv2v_cast_1(~_GEN_5 & ifStage[574]), sv2v_cast_1(~_GEN_5 & ifStage[573]), sv2v_cast_1(~_GEN_5 & ifStage[572]), sv2v_cast_1(~_GEN_5 & ifStage[571]), sv2v_cast_1(~_GEN_5 & ifStage[570]), sv2v_cast_1(~_GEN_5 & ifStage[569]), sv2v_cast_1(~_GEN_5 & ifStage[568]), sv2v_cast_1(~_GEN_5 & ifStage[567]), sv2v_cast_1(~_GEN_5 & ifStage[566]), sv2v_cast_1(~_GEN_5 & ifStage[565]), sv2v_cast_5((_GEN_5 ? 5'h00 : ifStage[564-:5])), sv2v_cast_32((_GEN_5 ? 32'h00000000 : ifStage[559-:32])), sv2v_cast_5((_GEN_5 ? 5'h00 : ifStage[527-:5])), sv2v_cast_5((_GEN_5 ? 5'h00 : ifStage[522-:5])), sv2v_cast_5((_GEN_5 ? 5'h00 : ifStage[517-:5])), sv2v_cast_32((_GEN_5 ? 32'h00000000 : ifStage[512-:32])), sv2v_cast_32((_GEN_5 ? 32'h00000000 : ifStage[480-:32])), sv2v_cast_32((_GEN_5 ? 32'h00000000 : ifStage[448-:32])), sv2v_cast_32((_GEN_5 ? 32'h00000000 : ifStage[416-:32])), sv2v_cast_32((_GEN_5 ? 32'h00000000 : ifStage[384-:32])), sv2v_cast_32((_GEN_5 ? 32'h00000000 : ifStage[352-:32]))};
			ifStage[642+:321] <= {sv2v_cast_2((_GEN_6 ? ifWire[320-:2] : ifStage[962-:2])), sv2v_cast_1(_GEN_6 | ifStage[960]), sv2v_cast_32((_GEN_6 ? ifWire[317-:32] : ifStage[959-:32])), sv2v_cast_32((_GEN_6 ? ifWire[285-:32] : ifStage[927-:32])), sv2v_cast_1(~_GEN_6 & ifStage[895]), sv2v_cast_1(~_GEN_6 & ifStage[894]), sv2v_cast_1(~_GEN_6 & ifStage[893]), sv2v_cast_1(~_GEN_6 & ifStage[892]), sv2v_cast_1(~_GEN_6 & ifStage[891]), sv2v_cast_1(~_GEN_6 & ifStage[890]), sv2v_cast_1(~_GEN_6 & ifStage[889]), sv2v_cast_1(~_GEN_6 & ifStage[888]), sv2v_cast_1(~_GEN_6 & ifStage[887]), sv2v_cast_1(~_GEN_6 & ifStage[886]), sv2v_cast_5((_GEN_6 ? 5'h00 : ifStage[885-:5])), sv2v_cast_32((_GEN_6 ? 32'h00000000 : ifStage[880-:32])), sv2v_cast_5((_GEN_6 ? 5'h00 : ifStage[848-:5])), sv2v_cast_5((_GEN_6 ? 5'h00 : ifStage[843-:5])), sv2v_cast_5((_GEN_6 ? 5'h00 : ifStage[838-:5])), sv2v_cast_32((_GEN_6 ? 32'h00000000 : ifStage[833-:32])), sv2v_cast_32((_GEN_6 ? 32'h00000000 : ifStage[801-:32])), sv2v_cast_32((_GEN_6 ? 32'h00000000 : ifStage[769-:32])), sv2v_cast_32((_GEN_6 ? 32'h00000000 : ifStage[737-:32])), sv2v_cast_32((_GEN_6 ? 32'h00000000 : ifStage[705-:32])), sv2v_cast_32((_GEN_6 ? 32'h00000000 : ifStage[673-:32]))};
			ifStage[963+:321] <= {sv2v_cast_2((&currentThread ? ifWire[320-:2] : ifStage[1283-:2])), sv2v_cast_1(&currentThread | ifStage[1281]), sv2v_cast_32((&currentThread ? ifWire[317-:32] : ifStage[1280-:32])), sv2v_cast_32((&currentThread ? ifWire[285-:32] : ifStage[1248-:32])), sv2v_cast_1(~(&currentThread) & ifStage[1216]), sv2v_cast_1(~(&currentThread) & ifStage[1215]), sv2v_cast_1(~(&currentThread) & ifStage[1214]), sv2v_cast_1(~(&currentThread) & ifStage[1213]), sv2v_cast_1(~(&currentThread) & ifStage[1212]), sv2v_cast_1(~(&currentThread) & ifStage[1211]), sv2v_cast_1(~(&currentThread) & ifStage[1210]), sv2v_cast_1(~(&currentThread) & ifStage[1209]), sv2v_cast_1(~(&currentThread) & ifStage[1208]), sv2v_cast_1(~(&currentThread) & ifStage[1207]), sv2v_cast_5((&currentThread ? 5'h00 : ifStage[1206-:5])), sv2v_cast_32((&currentThread ? 32'h00000000 : ifStage[1201-:32])), sv2v_cast_5((&currentThread ? 5'h00 : ifStage[1169-:5])), sv2v_cast_5((&currentThread ? 5'h00 : ifStage[1164-:5])), sv2v_cast_5((&currentThread ? 5'h00 : ifStage[1159-:5])), sv2v_cast_32((&currentThread ? 32'h00000000 : ifStage[1154-:32])), sv2v_cast_32((&currentThread ? 32'h00000000 : ifStage[1122-:32])), sv2v_cast_32((&currentThread ? 32'h00000000 : ifStage[1090-:32])), sv2v_cast_32((&currentThread ? 32'h00000000 : ifStage[1058-:32])), sv2v_cast_32((&currentThread ? 32'h00000000 : ifStage[1026-:32])), sv2v_cast_32((&currentThread ? 32'h00000000 : ifStage[994-:32]))};
			decStage[0+:321] <= {sv2v_cast_2((_GEN_4 ? decWire[320-:2] : decStage[320-:2])), (_GEN_4 ? decWire[318] : decStage[318]), sv2v_cast_32((_GEN_4 ? decWire[317-:32] : decStage[317-:32])), sv2v_cast_32((_GEN_4 ? decWire[285-:32] : decStage[285-:32])), (_GEN_4 ? decWire[253] : decStage[253]), (_GEN_4 ? decWire[252] : decStage[252]), (_GEN_4 ? decWire[251] : decStage[251]), (_GEN_4 ? decWire[250] : decStage[250]), (_GEN_4 ? decWire[249] : decStage[249]), (_GEN_4 ? decWire[248] : decStage[248]), (_GEN_4 ? decWire[247] : decStage[247]), (_GEN_4 ? decWire[246] : decStage[246]), (_GEN_4 ? decWire[245] : decStage[245]), (_GEN_4 ? decWire[244] : decStage[244]), sv2v_cast_5((_GEN_4 ? decWire[243-:5] : decStage[243-:5])), sv2v_cast_32((_GEN_4 ? decWire[238-:32] : decStage[238-:32])), sv2v_cast_5((_GEN_4 ? decWire[206-:5] : decStage[206-:5])), sv2v_cast_5((_GEN_4 ? decWire[201-:5] : decStage[201-:5])), sv2v_cast_5((_GEN_4 ? decWire[196-:5] : decStage[196-:5])), sv2v_cast_32((_GEN_4 ? decWire[191-:32] : decStage[191-:32])), sv2v_cast_32((_GEN_4 ? decWire[159-:32] : decStage[159-:32])), sv2v_cast_32((_GEN_4 ? decWire[127-:32] : decStage[127-:32])), sv2v_cast_32((_GEN_4 ? decWire[95-:32] : decStage[95-:32])), sv2v_cast_32((_GEN_4 ? decWire[63-:32] : decStage[63-:32])), sv2v_cast_32((_GEN_4 ? decWire[31-:32] : decStage[31-:32]))};
			decStage[321+:321] <= {sv2v_cast_2((_GEN_5 ? decWire[320-:2] : decStage[641-:2])), (_GEN_5 ? decWire[318] : decStage[639]), sv2v_cast_32((_GEN_5 ? decWire[317-:32] : decStage[638-:32])), sv2v_cast_32((_GEN_5 ? decWire[285-:32] : decStage[606-:32])), (_GEN_5 ? decWire[253] : decStage[574]), (_GEN_5 ? decWire[252] : decStage[573]), (_GEN_5 ? decWire[251] : decStage[572]), (_GEN_5 ? decWire[250] : decStage[571]), (_GEN_5 ? decWire[249] : decStage[570]), (_GEN_5 ? decWire[248] : decStage[569]), (_GEN_5 ? decWire[247] : decStage[568]), (_GEN_5 ? decWire[246] : decStage[567]), (_GEN_5 ? decWire[245] : decStage[566]), (_GEN_5 ? decWire[244] : decStage[565]), sv2v_cast_5((_GEN_5 ? decWire[243-:5] : decStage[564-:5])), sv2v_cast_32((_GEN_5 ? decWire[238-:32] : decStage[559-:32])), sv2v_cast_5((_GEN_5 ? decWire[206-:5] : decStage[527-:5])), sv2v_cast_5((_GEN_5 ? decWire[201-:5] : decStage[522-:5])), sv2v_cast_5((_GEN_5 ? decWire[196-:5] : decStage[517-:5])), sv2v_cast_32((_GEN_5 ? decWire[191-:32] : decStage[512-:32])), sv2v_cast_32((_GEN_5 ? decWire[159-:32] : decStage[480-:32])), sv2v_cast_32((_GEN_5 ? decWire[127-:32] : decStage[448-:32])), sv2v_cast_32((_GEN_5 ? decWire[95-:32] : decStage[416-:32])), sv2v_cast_32((_GEN_5 ? decWire[63-:32] : decStage[384-:32])), sv2v_cast_32((_GEN_5 ? decWire[31-:32] : decStage[352-:32]))};
			decStage[642+:321] <= {sv2v_cast_2((_GEN_6 ? decWire[320-:2] : decStage[962-:2])), (_GEN_6 ? decWire[318] : decStage[960]), sv2v_cast_32((_GEN_6 ? decWire[317-:32] : decStage[959-:32])), sv2v_cast_32((_GEN_6 ? decWire[285-:32] : decStage[927-:32])), (_GEN_6 ? decWire[253] : decStage[895]), (_GEN_6 ? decWire[252] : decStage[894]), (_GEN_6 ? decWire[251] : decStage[893]), (_GEN_6 ? decWire[250] : decStage[892]), (_GEN_6 ? decWire[249] : decStage[891]), (_GEN_6 ? decWire[248] : decStage[890]), (_GEN_6 ? decWire[247] : decStage[889]), (_GEN_6 ? decWire[246] : decStage[888]), (_GEN_6 ? decWire[245] : decStage[887]), (_GEN_6 ? decWire[244] : decStage[886]), sv2v_cast_5((_GEN_6 ? decWire[243-:5] : decStage[885-:5])), sv2v_cast_32((_GEN_6 ? decWire[238-:32] : decStage[880-:32])), sv2v_cast_5((_GEN_6 ? decWire[206-:5] : decStage[848-:5])), sv2v_cast_5((_GEN_6 ? decWire[201-:5] : decStage[843-:5])), sv2v_cast_5((_GEN_6 ? decWire[196-:5] : decStage[838-:5])), sv2v_cast_32((_GEN_6 ? decWire[191-:32] : decStage[833-:32])), sv2v_cast_32((_GEN_6 ? decWire[159-:32] : decStage[801-:32])), sv2v_cast_32((_GEN_6 ? decWire[127-:32] : decStage[769-:32])), sv2v_cast_32((_GEN_6 ? decWire[95-:32] : decStage[737-:32])), sv2v_cast_32((_GEN_6 ? decWire[63-:32] : decStage[705-:32])), sv2v_cast_32((_GEN_6 ? decWire[31-:32] : decStage[673-:32]))};
			decStage[963+:321] <= {sv2v_cast_2((&currentThread ? decWire[320-:2] : decStage[1283-:2])), (&currentThread ? decWire[318] : decStage[1281]), sv2v_cast_32((&currentThread ? decWire[317-:32] : decStage[1280-:32])), sv2v_cast_32((&currentThread ? decWire[285-:32] : decStage[1248-:32])), (&currentThread ? decWire[253] : decStage[1216]), (&currentThread ? decWire[252] : decStage[1215]), (&currentThread ? decWire[251] : decStage[1214]), (&currentThread ? decWire[250] : decStage[1213]), (&currentThread ? decWire[249] : decStage[1212]), (&currentThread ? decWire[248] : decStage[1211]), (&currentThread ? decWire[247] : decStage[1210]), (&currentThread ? decWire[246] : decStage[1209]), (&currentThread ? decWire[245] : decStage[1208]), (&currentThread ? decWire[244] : decStage[1207]), sv2v_cast_5((&currentThread ? decWire[243-:5] : decStage[1206-:5])), sv2v_cast_32((&currentThread ? decWire[238-:32] : decStage[1201-:32])), sv2v_cast_5((&currentThread ? decWire[206-:5] : decStage[1169-:5])), sv2v_cast_5((&currentThread ? decWire[201-:5] : decStage[1164-:5])), sv2v_cast_5((&currentThread ? decWire[196-:5] : decStage[1159-:5])), sv2v_cast_32((&currentThread ? decWire[191-:32] : decStage[1154-:32])), sv2v_cast_32((&currentThread ? decWire[159-:32] : decStage[1122-:32])), sv2v_cast_32((&currentThread ? decWire[127-:32] : decStage[1090-:32])), sv2v_cast_32((&currentThread ? decWire[95-:32] : decStage[1058-:32])), sv2v_cast_32((&currentThread ? decWire[63-:32] : decStage[1026-:32])), sv2v_cast_32((&currentThread ? decWire[31-:32] : decStage[994-:32]))};
			exStage[0+:321] <= {sv2v_cast_2((_GEN_4 ? exWire[320-:2] : exStage[320-:2])), (_GEN_4 ? exWire[318] : exStage[318]), sv2v_cast_32((_GEN_4 ? exWire[317-:32] : exStage[317-:32])), sv2v_cast_32((_GEN_4 ? exWire[285-:32] : exStage[285-:32])), (_GEN_4 ? exWire[253] : exStage[253]), (_GEN_4 ? exWire[252] : exStage[252]), (_GEN_4 ? exWire[251] : exStage[251]), (_GEN_4 ? exWire[250] : exStage[250]), (_GEN_4 ? exWire[249] : exStage[249]), (_GEN_4 ? exWire[248] : exStage[248]), (_GEN_4 ? exWire[247] : exStage[247]), (_GEN_4 ? exWire[246] : exStage[246]), (_GEN_4 ? exWire[245] : exStage[245]), (_GEN_4 ? exWire[244] : exStage[244]), sv2v_cast_5((_GEN_4 ? exWire[243-:5] : exStage[243-:5])), sv2v_cast_32((_GEN_4 ? exWire[238-:32] : exStage[238-:32])), sv2v_cast_5((_GEN_4 ? exWire[206-:5] : exStage[206-:5])), sv2v_cast_5((_GEN_4 ? exWire[201-:5] : exStage[201-:5])), sv2v_cast_5((_GEN_4 ? exWire[196-:5] : exStage[196-:5])), sv2v_cast_32((_GEN_4 ? exWire[191-:32] : exStage[191-:32])), sv2v_cast_32((_GEN_4 ? exWire[159-:32] : exStage[159-:32])), sv2v_cast_32((_GEN_4 ? exWire[127-:32] : exStage[127-:32])), sv2v_cast_32((_GEN_4 ? exWire[95-:32] : exStage[95-:32])), sv2v_cast_32((_GEN_4 ? exWire[63-:32] : exStage[63-:32])), sv2v_cast_32((_GEN_4 ? exWire[31-:32] : exStage[31-:32]))};
			exStage[321+:321] <= {sv2v_cast_2((_GEN_5 ? exWire[320-:2] : exStage[641-:2])), (_GEN_5 ? exWire[318] : exStage[639]), sv2v_cast_32((_GEN_5 ? exWire[317-:32] : exStage[638-:32])), sv2v_cast_32((_GEN_5 ? exWire[285-:32] : exStage[606-:32])), (_GEN_5 ? exWire[253] : exStage[574]), (_GEN_5 ? exWire[252] : exStage[573]), (_GEN_5 ? exWire[251] : exStage[572]), (_GEN_5 ? exWire[250] : exStage[571]), (_GEN_5 ? exWire[249] : exStage[570]), (_GEN_5 ? exWire[248] : exStage[569]), (_GEN_5 ? exWire[247] : exStage[568]), (_GEN_5 ? exWire[246] : exStage[567]), (_GEN_5 ? exWire[245] : exStage[566]), (_GEN_5 ? exWire[244] : exStage[565]), sv2v_cast_5((_GEN_5 ? exWire[243-:5] : exStage[564-:5])), sv2v_cast_32((_GEN_5 ? exWire[238-:32] : exStage[559-:32])), sv2v_cast_5((_GEN_5 ? exWire[206-:5] : exStage[527-:5])), sv2v_cast_5((_GEN_5 ? exWire[201-:5] : exStage[522-:5])), sv2v_cast_5((_GEN_5 ? exWire[196-:5] : exStage[517-:5])), sv2v_cast_32((_GEN_5 ? exWire[191-:32] : exStage[512-:32])), sv2v_cast_32((_GEN_5 ? exWire[159-:32] : exStage[480-:32])), sv2v_cast_32((_GEN_5 ? exWire[127-:32] : exStage[448-:32])), sv2v_cast_32((_GEN_5 ? exWire[95-:32] : exStage[416-:32])), sv2v_cast_32((_GEN_5 ? exWire[63-:32] : exStage[384-:32])), sv2v_cast_32((_GEN_5 ? exWire[31-:32] : exStage[352-:32]))};
			exStage[642+:321] <= {sv2v_cast_2((_GEN_6 ? exWire[320-:2] : exStage[962-:2])), (_GEN_6 ? exWire[318] : exStage[960]), sv2v_cast_32((_GEN_6 ? exWire[317-:32] : exStage[959-:32])), sv2v_cast_32((_GEN_6 ? exWire[285-:32] : exStage[927-:32])), (_GEN_6 ? exWire[253] : exStage[895]), (_GEN_6 ? exWire[252] : exStage[894]), (_GEN_6 ? exWire[251] : exStage[893]), (_GEN_6 ? exWire[250] : exStage[892]), (_GEN_6 ? exWire[249] : exStage[891]), (_GEN_6 ? exWire[248] : exStage[890]), (_GEN_6 ? exWire[247] : exStage[889]), (_GEN_6 ? exWire[246] : exStage[888]), (_GEN_6 ? exWire[245] : exStage[887]), (_GEN_6 ? exWire[244] : exStage[886]), sv2v_cast_5((_GEN_6 ? exWire[243-:5] : exStage[885-:5])), sv2v_cast_32((_GEN_6 ? exWire[238-:32] : exStage[880-:32])), sv2v_cast_5((_GEN_6 ? exWire[206-:5] : exStage[848-:5])), sv2v_cast_5((_GEN_6 ? exWire[201-:5] : exStage[843-:5])), sv2v_cast_5((_GEN_6 ? exWire[196-:5] : exStage[838-:5])), sv2v_cast_32((_GEN_6 ? exWire[191-:32] : exStage[833-:32])), sv2v_cast_32((_GEN_6 ? exWire[159-:32] : exStage[801-:32])), sv2v_cast_32((_GEN_6 ? exWire[127-:32] : exStage[769-:32])), sv2v_cast_32((_GEN_6 ? exWire[95-:32] : exStage[737-:32])), sv2v_cast_32((_GEN_6 ? exWire[63-:32] : exStage[705-:32])), sv2v_cast_32((_GEN_6 ? exWire[31-:32] : exStage[673-:32]))};
			exStage[963+:321] <= {sv2v_cast_2((&currentThread ? exWire[320-:2] : exStage[1283-:2])), (&currentThread ? exWire[318] : exStage[1281]), sv2v_cast_32((&currentThread ? exWire[317-:32] : exStage[1280-:32])), sv2v_cast_32((&currentThread ? exWire[285-:32] : exStage[1248-:32])), (&currentThread ? exWire[253] : exStage[1216]), (&currentThread ? exWire[252] : exStage[1215]), (&currentThread ? exWire[251] : exStage[1214]), (&currentThread ? exWire[250] : exStage[1213]), (&currentThread ? exWire[249] : exStage[1212]), (&currentThread ? exWire[248] : exStage[1211]), (&currentThread ? exWire[247] : exStage[1210]), (&currentThread ? exWire[246] : exStage[1209]), (&currentThread ? exWire[245] : exStage[1208]), (&currentThread ? exWire[244] : exStage[1207]), sv2v_cast_5((&currentThread ? exWire[243-:5] : exStage[1206-:5])), sv2v_cast_32((&currentThread ? exWire[238-:32] : exStage[1201-:32])), sv2v_cast_5((&currentThread ? exWire[206-:5] : exStage[1169-:5])), sv2v_cast_5((&currentThread ? exWire[201-:5] : exStage[1164-:5])), sv2v_cast_5((&currentThread ? exWire[196-:5] : exStage[1159-:5])), sv2v_cast_32((&currentThread ? exWire[191-:32] : exStage[1154-:32])), sv2v_cast_32((&currentThread ? exWire[159-:32] : exStage[1122-:32])), sv2v_cast_32((&currentThread ? exWire[127-:32] : exStage[1090-:32])), sv2v_cast_32((&currentThread ? exWire[95-:32] : exStage[1058-:32])), sv2v_cast_32((&currentThread ? exWire[63-:32] : exStage[1026-:32])), sv2v_cast_32((&currentThread ? exWire[31-:32] : exStage[994-:32]))};
			memStage[0+:321] <= {sv2v_cast_2((_GEN_4 ? memWire[320-:2] : memStage[320-:2])), (_GEN_4 ? memWire[318] : memStage[318]), sv2v_cast_32((_GEN_4 ? memWire[317-:32] : memStage[317-:32])), sv2v_cast_32((_GEN_4 ? memWire[285-:32] : memStage[285-:32])), (_GEN_4 ? memWire[253] : memStage[253]), (_GEN_4 ? memWire[252] : memStage[252]), (_GEN_4 ? memWire[251] : memStage[251]), (_GEN_4 ? memWire[250] : memStage[250]), (_GEN_4 ? memWire[249] : memStage[249]), (_GEN_4 ? memWire[248] : memStage[248]), (_GEN_4 ? memWire[247] : memStage[247]), (_GEN_4 ? memWire[246] : memStage[246]), (_GEN_4 ? memWire[245] : memStage[245]), (_GEN_4 ? memWire[244] : memStage[244]), sv2v_cast_5((_GEN_4 ? memWire[243-:5] : memStage[243-:5])), sv2v_cast_32((_GEN_4 ? memWire[238-:32] : memStage[238-:32])), sv2v_cast_5((_GEN_4 ? memWire[206-:5] : memStage[206-:5])), sv2v_cast_5((_GEN_4 ? memWire[201-:5] : memStage[201-:5])), sv2v_cast_5((_GEN_4 ? memWire[196-:5] : memStage[196-:5])), sv2v_cast_32((_GEN_4 ? memWire[191-:32] : memStage[191-:32])), sv2v_cast_32((_GEN_4 ? memWire[159-:32] : memStage[159-:32])), sv2v_cast_32((_GEN_4 ? memWire[127-:32] : memStage[127-:32])), sv2v_cast_32((_GEN_4 ? memWire[95-:32] : memStage[95-:32])), sv2v_cast_32((_GEN_4 ? memWire[63-:32] : memStage[63-:32])), sv2v_cast_32((_GEN_4 ? memWire[31-:32] : memStage[31-:32]))};
			memStage[321+:321] <= {sv2v_cast_2((_GEN_5 ? memWire[320-:2] : memStage[641-:2])), (_GEN_5 ? memWire[318] : memStage[639]), sv2v_cast_32((_GEN_5 ? memWire[317-:32] : memStage[638-:32])), sv2v_cast_32((_GEN_5 ? memWire[285-:32] : memStage[606-:32])), (_GEN_5 ? memWire[253] : memStage[574]), (_GEN_5 ? memWire[252] : memStage[573]), (_GEN_5 ? memWire[251] : memStage[572]), (_GEN_5 ? memWire[250] : memStage[571]), (_GEN_5 ? memWire[249] : memStage[570]), (_GEN_5 ? memWire[248] : memStage[569]), (_GEN_5 ? memWire[247] : memStage[568]), (_GEN_5 ? memWire[246] : memStage[567]), (_GEN_5 ? memWire[245] : memStage[566]), (_GEN_5 ? memWire[244] : memStage[565]), sv2v_cast_5((_GEN_5 ? memWire[243-:5] : memStage[564-:5])), sv2v_cast_32((_GEN_5 ? memWire[238-:32] : memStage[559-:32])), sv2v_cast_5((_GEN_5 ? memWire[206-:5] : memStage[527-:5])), sv2v_cast_5((_GEN_5 ? memWire[201-:5] : memStage[522-:5])), sv2v_cast_5((_GEN_5 ? memWire[196-:5] : memStage[517-:5])), sv2v_cast_32((_GEN_5 ? memWire[191-:32] : memStage[512-:32])), sv2v_cast_32((_GEN_5 ? memWire[159-:32] : memStage[480-:32])), sv2v_cast_32((_GEN_5 ? memWire[127-:32] : memStage[448-:32])), sv2v_cast_32((_GEN_5 ? memWire[95-:32] : memStage[416-:32])), sv2v_cast_32((_GEN_5 ? memWire[63-:32] : memStage[384-:32])), sv2v_cast_32((_GEN_5 ? memWire[31-:32] : memStage[352-:32]))};
			memStage[642+:321] <= {sv2v_cast_2((_GEN_6 ? memWire[320-:2] : memStage[962-:2])), (_GEN_6 ? memWire[318] : memStage[960]), sv2v_cast_32((_GEN_6 ? memWire[317-:32] : memStage[959-:32])), sv2v_cast_32((_GEN_6 ? memWire[285-:32] : memStage[927-:32])), (_GEN_6 ? memWire[253] : memStage[895]), (_GEN_6 ? memWire[252] : memStage[894]), (_GEN_6 ? memWire[251] : memStage[893]), (_GEN_6 ? memWire[250] : memStage[892]), (_GEN_6 ? memWire[249] : memStage[891]), (_GEN_6 ? memWire[248] : memStage[890]), (_GEN_6 ? memWire[247] : memStage[889]), (_GEN_6 ? memWire[246] : memStage[888]), (_GEN_6 ? memWire[245] : memStage[887]), (_GEN_6 ? memWire[244] : memStage[886]), sv2v_cast_5((_GEN_6 ? memWire[243-:5] : memStage[885-:5])), sv2v_cast_32((_GEN_6 ? memWire[238-:32] : memStage[880-:32])), sv2v_cast_5((_GEN_6 ? memWire[206-:5] : memStage[848-:5])), sv2v_cast_5((_GEN_6 ? memWire[201-:5] : memStage[843-:5])), sv2v_cast_5((_GEN_6 ? memWire[196-:5] : memStage[838-:5])), sv2v_cast_32((_GEN_6 ? memWire[191-:32] : memStage[833-:32])), sv2v_cast_32((_GEN_6 ? memWire[159-:32] : memStage[801-:32])), sv2v_cast_32((_GEN_6 ? memWire[127-:32] : memStage[769-:32])), sv2v_cast_32((_GEN_6 ? memWire[95-:32] : memStage[737-:32])), sv2v_cast_32((_GEN_6 ? memWire[63-:32] : memStage[705-:32])), sv2v_cast_32((_GEN_6 ? memWire[31-:32] : memStage[673-:32]))};
			memStage[963+:321] <= {sv2v_cast_2((&currentThread ? memWire[320-:2] : memStage[1283-:2])), (&currentThread ? memWire[318] : memStage[1281]), sv2v_cast_32((&currentThread ? memWire[317-:32] : memStage[1280-:32])), sv2v_cast_32((&currentThread ? memWire[285-:32] : memStage[1248-:32])), (&currentThread ? memWire[253] : memStage[1216]), (&currentThread ? memWire[252] : memStage[1215]), (&currentThread ? memWire[251] : memStage[1214]), (&currentThread ? memWire[250] : memStage[1213]), (&currentThread ? memWire[249] : memStage[1212]), (&currentThread ? memWire[248] : memStage[1211]), (&currentThread ? memWire[247] : memStage[1210]), (&currentThread ? memWire[246] : memStage[1209]), (&currentThread ? memWire[245] : memStage[1208]), (&currentThread ? memWire[244] : memStage[1207]), sv2v_cast_5((&currentThread ? memWire[243-:5] : memStage[1206-:5])), sv2v_cast_32((&currentThread ? memWire[238-:32] : memStage[1201-:32])), sv2v_cast_5((&currentThread ? memWire[206-:5] : memStage[1169-:5])), sv2v_cast_5((&currentThread ? memWire[201-:5] : memStage[1164-:5])), sv2v_cast_5((&currentThread ? memWire[196-:5] : memStage[1159-:5])), sv2v_cast_32((&currentThread ? memWire[191-:32] : memStage[1154-:32])), sv2v_cast_32((&currentThread ? memWire[159-:32] : memStage[1122-:32])), sv2v_cast_32((&currentThread ? memWire[127-:32] : memStage[1090-:32])), sv2v_cast_32((&currentThread ? memWire[95-:32] : memStage[1058-:32])), sv2v_cast_32((&currentThread ? memWire[63-:32] : memStage[1026-:32])), sv2v_cast_32((&currentThread ? memWire[31-:32] : memStage[994-:32]))};
		end
	initial begin : sv2v_autoblock_2
		reg [31:0] _RANDOM [0:164];
	end
	instrMem_1024x32 instrMem_ext(
		.R0_addr(_ifWire_instr_T_1),
		.R0_en(1'h1),
		.R0_clk(clock),
		.R0_data(_instrMem_ext_R0_data),
		.W0_addr(io[42-:10]),
		.W0_en(io[43]),
		.W0_clk(clock),
		.W0_data(io[32-:32])
	);
	RegFileMT2R1WVec regFile(
		.clock(clock),
		.reset(reset),
		.io_threadID(currentThread),
		.io_src1(decWire[206-:5]),
		.io_src2(decWire[201-:5]),
		.io_dst1(memWire[196-:5]),
		.io_wen(_regFile_io_wen_T_3),
		.io_dst1data(wbData),
		.io_src1data(_regFile_io_src1data),
		.io_src2data(_regFile_io_src2data)
	);
	TetraNyteCore_Anon alu(
		.io_a(exWire[191-:32]),
		.io_b(exWire[159-:32]),
		.io_fn(exWire[243-:5]),
		.io_out(_alu_io_out)
	);
	assign io_memAddr = io[140-:32];
	assign io_memWdata = io[108-:32];
	assign io_memWe = io[44];
endmodule
