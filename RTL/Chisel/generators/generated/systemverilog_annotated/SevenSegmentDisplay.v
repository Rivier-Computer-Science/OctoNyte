// Generated by CIRCT firtool-1.99.1
module SevenSegmentDisplay(	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:2:3
  input        clock,	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:2:37
               reset,	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:2:53
  input  [3:0] io_binIn,	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:2:69
  output [6:0] io_segOut	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:2:89
);

  wire [15:0][6:0] _GEN =
    '{7'h0,
      7'h0,
      7'h0,
      7'h0,
      7'h0,
      7'h0,
      7'h7B,
      7'h7F,
      7'h70,
      7'h5F,
      7'h5B,
      7'h33,
      7'h79,
      7'h6D,
      7'h30,
      7'h7E};	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:3:10
  wire struct packed {logic [3:0] binIn; logic [6:0] segOut; } io;	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:6:11
  wire             B0 = io.binIn[0];	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:7:10, :8:14, :11:10, :12:11
  wire             B1 = io.binIn[1];	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:7:10, :8:14, :15:10, :16:11
  wire             B2 = io.binIn[2];	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:7:10, :8:14, :19:10, :20:11
  wire             B3 = io.binIn[3];	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:7:10, :8:14, :23:11, :24:11
  wire             a = io.segOut[6];	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:7:10, :10:15, :27:11, :28:10
  wire             b = io.segOut[5];	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:7:10, :10:15, :31:11, :32:10
  wire             c = io.segOut[4];	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:7:10, :10:15, :35:11, :36:10
  wire             d = io.segOut[3];	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:7:10, :10:15, :39:11, :40:10
  wire             e = io.segOut[2];	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:7:10, :10:15, :43:11, :44:10
  wire             f = io.segOut[1];	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:7:10, :10:15, :47:11, :48:10
  wire             g = io.segOut[0];	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:7:10, :10:15, :51:11, :52:10
  assign io = '{binIn: io_binIn, segOut: _GEN[io.binIn]};	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:3:10, :7:10, :8:14, :56:11, :57:11, :58:5
  assign io_segOut = io.segOut;	// /home/jglossner/GitRepos/Structured_Computer_Architecture/RTL/Chisel/generators/generated/firrtl/SevenSegmentDisplay.fir.mlir:7:10, :10:15, :74:5
endmodule
