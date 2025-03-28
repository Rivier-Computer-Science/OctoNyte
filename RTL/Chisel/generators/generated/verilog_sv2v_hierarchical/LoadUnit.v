module LoadUnit (
	clock,
	reset,
	io_addr,
	io_dataIn,
	io_funct3,
	io_dataOut
);
	input clock;
	input reset;
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
