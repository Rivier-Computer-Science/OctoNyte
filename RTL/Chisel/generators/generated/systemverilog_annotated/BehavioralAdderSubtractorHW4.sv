// Generated by CIRCT firtool-1.100.0
module BehavioralAdderSubtractor(	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:8:7
  input  [3:0] io_a,	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:10:14
               io_b,	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:10:14
  input        io_subtract,	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:10:14
  output [3:0] io_result	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:10:14
);

  wire [3:0] io_a_0 = io_a;	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:8:7
  wire [3:0] io_b_0 = io_b;	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:8:7
  wire       io_subtract_0 = io_subtract;	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:8:7
  wire       _fullResult_T = io_subtract_0;	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:8:7, :18:36
  wire [3:0] _io_result_T;	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:21:26
  wire [4:0] _GEN = {1'h0, io_a_0};	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:8:7, :18:49
  wire [4:0] _GEN_0 = {1'h0, io_b_0};	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:8:7, :18:49
  wire [4:0] _fullResult_T_1 = _GEN - _GEN_0;	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:18:49
  wire [3:0] _fullResult_T_2 = _fullResult_T_1[3:0];	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:18:49
  wire [4:0] _fullResult_T_3 = _GEN + _GEN_0;	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:18:{49,62}
  wire [3:0] _fullResult_T_4 = _fullResult_T_3[3:0];	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:18:62
  wire [3:0] fullResult = _fullResult_T ? _fullResult_T_2 : _fullResult_T_4;	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:18:{23,36,49,62}
  assign _io_result_T = fullResult;	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:18:23, :21:26
  wire [3:0] io_result_0 = _io_result_T;	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:8:7, :21:26
  assign io_result = io_result_0;	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractor.scala:8:7
endmodule

module BehavioralAdderSubtractorHW4(	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW4.scala:8:7
  input        clock,	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW4.scala:8:7
               reset,	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW4.scala:8:7
  input  [3:0] io_a,	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW4.scala:9:14
               io_b,	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW4.scala:9:14
  input        io_subtract,	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW4.scala:9:14
  output [3:0] io_sum	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW4.scala:9:14
);

  wire [3:0] io_sum_0;	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW4.scala:8:7
  wire [3:0] io_a_0 = io_a;	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW4.scala:8:7
  wire [3:0] io_b_0 = io_b;	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW4.scala:8:7
  wire       io_subtract_0 = io_subtract;	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW4.scala:8:7
  BehavioralAdderSubtractor io_sum_module (	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW.scala:28:24
    .io_a        (io_a_0),	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW4.scala:8:7
    .io_b        (io_b_0),	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW4.scala:8:7
    .io_subtract (io_subtract_0),	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW4.scala:8:7
    .io_result   (io_sum_0)
  );	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW.scala:28:24
  assign io_sum = io_sum_0;	// src/main/scala/scabook/addersubtractors/BehavioralAdderSubtractorHW4.scala:8:7
endmodule
