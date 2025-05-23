/* Generated by Yosys 0.48+5 (git sha1 7a362f1f7, clang++ 18.1.8 -fPIC -O3) */

(* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:1.1-26.10" *)
module BehavioralAdderSubtractor(io_a, io_b, io_subtract, io_result);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  wire _15_;
  wire _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:16.13-16.17" *)
  wire [4:0] _GEN;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:17.13-17.19" *)
  wire [4:0] _GEN_0;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:14.7-14.20" *)
  wire _fullResult_T;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:18.13-18.28" *)
  wire [4:0] _fullResult_T_1;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:19.13-19.28" *)
  wire [3:0] _fullResult_T_2;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:20.13-20.28" *)
  wire [4:0] _fullResult_T_3;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:21.13-21.28" *)
  wire [3:0] _fullResult_T_4;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:15.13-15.25" *)
  wire [3:0] _io_result_T;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:22.13-22.23" *)
  wire [3:0] fullResult;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:7.14-7.18" *)
  input [3:0] io_a;
  wire [3:0] io_a;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:11.13-11.19" *)
  wire [3:0] io_a_0;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:8.14-8.18" *)
  input [3:0] io_b;
  wire [3:0] io_b;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:12.13-12.19" *)
  wire [3:0] io_b_0;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:10.20-10.29" *)
  output [3:0] io_result;
  wire [3:0] io_result;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:24.13-24.24" *)
  wire [3:0] io_result_0;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:9.8-9.19" *)
  input io_subtract;
  wire io_subtract;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:13.7-13.20" *)
  wire io_subtract_0;
  assign io_result[0] = io_a[0] ^ io_b[0];
  assign _00_ = ~io_b[1];
  assign _01_ = ~(io_b[0] ^ io_b[1]);
  assign _02_ = io_subtract ? _00_ : _01_;
  assign _03_ = _02_ ^ io_a[1];
  assign _04_ = io_b[0] & ~(io_a[0]);
  assign io_result[1] = ~(_04_ ^ _03_);
  assign _05_ = ~io_b[2];
  assign _06_ = ~(io_b[0] | io_b[1]);
  assign _07_ = _06_ ^ io_b[2];
  assign _08_ = io_subtract ? _05_ : _07_;
  assign _09_ = _08_ ^ io_a[2];
  assign _10_ = ~(_02_ & io_a[1]);
  assign _11_ = _03_ & ~(_04_);
  assign _12_ = _10_ & ~(_11_);
  assign io_result[2] = ~(_12_ ^ _09_);
  assign _13_ = ~(_06_ & _05_);
  assign _14_ = _13_ ^ io_b[3];
  assign _15_ = io_subtract ? io_b[3] : _14_;
  assign _16_ = _15_ ^ io_a[3];
  assign _17_ = ~(_08_ & io_a[2]);
  assign _18_ = _09_ & ~(_12_);
  assign _19_ = _17_ & ~(_18_);
  assign io_result[3] = _19_ ^ _16_;
  assign _GEN = { 1'h0, io_a };
  assign _GEN_0 = { 1'h0, io_b };
  assign _fullResult_T = io_subtract;
  assign _fullResult_T_1 = 5'hxx;
  assign _fullResult_T_2 = 4'hx;
  assign _fullResult_T_3 = 5'hxx;
  assign _fullResult_T_4 = 4'hx;
  assign _io_result_T = io_result;
  assign fullResult = io_result;
  assign io_a_0 = io_a;
  assign io_b_0 = io_b;
  assign io_result_0 = io_result;
  assign io_subtract_0 = io_subtract;
endmodule

(* top =  1  *)
(* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:27.1-52.10" *)
module BehavioralAdderSubtractorHW4(clock, reset, io_a, io_b, io_subtract, io_sum);
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:35.8-35.13" *)
  input clock;
  wire clock;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:37.14-37.18" *)
  input [3:0] io_a;
  wire [3:0] io_a;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:42.13-42.19" *)
  wire [3:0] io_a_0;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:38.14-38.18" *)
  input [3:0] io_b;
  wire [3:0] io_b;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:43.13-43.19" *)
  wire [3:0] io_b_0;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:39.8-39.19" *)
  input io_subtract;
  wire io_subtract;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:44.7-44.20" *)
  wire io_subtract_0;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:40.20-40.26" *)
  output [3:0] io_sum;
  wire [3:0] io_sum;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:41.13-41.21" *)
  wire [3:0] io_sum_0;
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:36.8-36.13" *)
  input reset;
  wire reset;
  (* module_not_derived = 32'd1 *)
  (* src = "generators/generated/verilog_sv2v/BehavioralAdderSubtractorHW4.v:45.28-50.3" *)
  BehavioralAdderSubtractor io_sum_module (
    .io_a(io_a),
    .io_b(io_b),
    .io_result(io_sum_0),
    .io_subtract(io_subtract)
  );
  assign io_a_0 = io_a;
  assign io_b_0 = io_b;
  assign io_subtract_0 = io_subtract;
  assign io_sum = io_sum_0;
endmodule
