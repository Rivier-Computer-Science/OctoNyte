// Generated by CIRCT firtool-1.99.1
module SevenSegmentDisplay(	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7
  input        clock,	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7
               reset,	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7
  input  [3:0] io_binIn,	// src/main/scala/scabook/SevenSegmentDisplay.scala:9:14
  output [6:0] io_segOut	// src/main/scala/scabook/SevenSegmentDisplay.scala:9:14
);

  wire [3:0]       io_binIn_0 = io_binIn;	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7
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
      7'h7E};
  wire             _B0_T = io_binIn_0[0];	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7, :15:34
  wire             B0 = _B0_T;	// src/main/scala/scabook/SevenSegmentDisplay.scala:15:{25,34}
  wire             _B1_T = io_binIn_0[1];	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7, :16:34
  wire             B1 = _B1_T;	// src/main/scala/scabook/SevenSegmentDisplay.scala:16:{25,34}
  wire             _B2_T = io_binIn_0[2];	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7, :17:34
  wire             B2 = _B2_T;	// src/main/scala/scabook/SevenSegmentDisplay.scala:17:{25,34}
  wire             _B3_T = io_binIn_0[3];	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7, :18:34
  wire             B3 = _B3_T;	// src/main/scala/scabook/SevenSegmentDisplay.scala:18:{25,34}
  wire [6:0]       io_segOut_0;	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7
  wire             _a_T = io_segOut_0[6];	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7, :21:34
  wire             a = _a_T;	// src/main/scala/scabook/SevenSegmentDisplay.scala:21:{24,34}
  wire             _b_T = io_segOut_0[5];	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7, :22:34
  wire             b = _b_T;	// src/main/scala/scabook/SevenSegmentDisplay.scala:22:{24,34}
  wire             _c_T = io_segOut_0[4];	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7, :23:34
  wire             c = _c_T;	// src/main/scala/scabook/SevenSegmentDisplay.scala:23:{24,34}
  wire             _d_T = io_segOut_0[3];	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7, :24:34
  wire             d = _d_T;	// src/main/scala/scabook/SevenSegmentDisplay.scala:24:{24,34}
  wire             _e_T = io_segOut_0[2];	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7, :25:34
  wire             e = _e_T;	// src/main/scala/scabook/SevenSegmentDisplay.scala:25:{24,34}
  wire             _f_T = io_segOut_0[1];	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7, :26:34
  wire             f = _f_T;	// src/main/scala/scabook/SevenSegmentDisplay.scala:26:{24,34}
  wire             _g_T = io_segOut_0[0];	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7, :27:34
  wire             g = _g_T;	// src/main/scala/scabook/SevenSegmentDisplay.scala:27:{24,34}
  assign io_segOut_0 = _GEN[io_binIn_0];	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7, :44:{35,47}, :45:35
  assign io_segOut = io_segOut_0;	// src/main/scala/scabook/SevenSegmentDisplay.scala:8:7
endmodule
