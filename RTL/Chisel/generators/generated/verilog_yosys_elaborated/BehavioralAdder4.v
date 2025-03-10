/* Generated by Yosys 0.48+5 (git sha1 7a362f1f7, clang++ 18.1.8 -fPIC -O3) */

(* src = "generators/generated/verilog_sv2v_clean/BehavioralAdder4.v:1.1-10.10" *)
module BehavioralAdder(io_a, io_b, io_sum);
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
  (* src = "generators/generated/verilog_sv2v_clean/BehavioralAdder4.v:6.14-6.18" *)
  input [3:0] io_a;
  wire [3:0] io_a;
  (* src = "generators/generated/verilog_sv2v_clean/BehavioralAdder4.v:7.14-7.18" *)
  input [3:0] io_b;
  wire [3:0] io_b;
  (* src = "generators/generated/verilog_sv2v_clean/BehavioralAdder4.v:8.20-8.26" *)
  output [3:0] io_sum;
  wire [3:0] io_sum;
  assign _00_ = io_a[1] ^ io_b[1];
  assign _01_ = ~(io_a[0] & io_b[0]);
  assign io_sum[1] = ~(_01_ ^ _00_);
  assign _02_ = io_a[2] ^ io_b[2];
  assign _03_ = ~(io_a[1] & io_b[1]);
  assign _04_ = _00_ & ~(_01_);
  assign _05_ = _03_ & ~(_04_);
  assign io_sum[2] = ~(_05_ ^ _02_);
  assign _06_ = ~(io_a[3] ^ io_b[3]);
  assign _07_ = ~(io_a[2] & io_b[2]);
  assign _08_ = _02_ & ~(_05_);
  assign _09_ = _07_ & ~(_08_);
  assign io_sum[3] = _09_ ^ _06_;
  assign io_sum[0] = io_a[0] ^ io_b[0];
endmodule

(* top =  1  *)
(* src = "generators/generated/verilog_sv2v_clean/BehavioralAdder4.v:11.1-28.10" *)
module BehavioralAdder4(clock, reset, io_a, io_b, io_sum);
  (* src = "generators/generated/verilog_sv2v_clean/BehavioralAdder4.v:18.8-18.13" *)
  input clock;
  wire clock;
  (* src = "generators/generated/verilog_sv2v_clean/BehavioralAdder4.v:20.14-20.18" *)
  input [3:0] io_a;
  wire [3:0] io_a;
  (* src = "generators/generated/verilog_sv2v_clean/BehavioralAdder4.v:21.14-21.18" *)
  input [3:0] io_b;
  wire [3:0] io_b;
  (* src = "generators/generated/verilog_sv2v_clean/BehavioralAdder4.v:22.20-22.26" *)
  output [3:0] io_sum;
  wire [3:0] io_sum;
  (* src = "generators/generated/verilog_sv2v_clean/BehavioralAdder4.v:19.8-19.13" *)
  input reset;
  wire reset;
  (* module_not_derived = 32'd1 *)
  (* src = "generators/generated/verilog_sv2v_clean/BehavioralAdder4.v:23.18-27.3" *)
  BehavioralAdder io_sum_adder (
    .io_a(io_a),
    .io_b(io_b),
    .io_sum(io_sum)
  );
endmodule
