module StoreUnit (
	clock,
	reset,
	io_addr,
	io_dataIn,
	io_funct3,
	io_memWrite
);
	input clock;
	input reset;
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
