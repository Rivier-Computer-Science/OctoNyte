/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_SC_HS__DFBBN_TB_V
`define SKY130_FD_SC_HS__DFBBN_TB_V

/**
 * dfbbn: Delay flop, inverted set, inverted reset, inverted clock,
 *        complementary outputs.
 *
 * Autogenerated test bench.
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

`include "sky130_fd_sc_hs__dfbbn.v"

module top();

    // Inputs are registered
    reg D;
    reg SET_B;
    reg RESET_B;
    reg VPWR;
    reg VGND;

    // Outputs are wires
    wire Q;
    wire Q_N;

    initial
    begin
        // Initial state is x for all inputs.
        D       = 1'bX;
        RESET_B = 1'bX;
        SET_B   = 1'bX;
        VGND    = 1'bX;
        VPWR    = 1'bX;

        #20   D       = 1'b0;
        #40   RESET_B = 1'b0;
        #60   SET_B   = 1'b0;
        #80   VGND    = 1'b0;
        #100  VPWR    = 1'b0;
        #120  D       = 1'b1;
        #140  RESET_B = 1'b1;
        #160  SET_B   = 1'b1;
        #180  VGND    = 1'b1;
        #200  VPWR    = 1'b1;
        #220  D       = 1'b0;
        #240  RESET_B = 1'b0;
        #260  SET_B   = 1'b0;
        #280  VGND    = 1'b0;
        #300  VPWR    = 1'b0;
        #320  VPWR    = 1'b1;
        #340  VGND    = 1'b1;
        #360  SET_B   = 1'b1;
        #380  RESET_B = 1'b1;
        #400  D       = 1'b1;
        #420  VPWR    = 1'bx;
        #440  VGND    = 1'bx;
        #460  SET_B   = 1'bx;
        #480  RESET_B = 1'bx;
        #500  D       = 1'bx;
    end

    // Create a clock
    reg CLK_N;
    initial
    begin
        CLK_N = 1'b0;
    end

    always
    begin
        #5 CLK_N = ~CLK_N;
    end

    sky130_fd_sc_hs__dfbbn dut (.D(D), .SET_B(SET_B), .RESET_B(RESET_B), .VPWR(VPWR), .VGND(VGND), .Q(Q), .Q_N(Q_N), .CLK_N(CLK_N));

endmodule

`default_nettype wire
`endif  // SKY130_FD_SC_HS__DFBBN_TB_V