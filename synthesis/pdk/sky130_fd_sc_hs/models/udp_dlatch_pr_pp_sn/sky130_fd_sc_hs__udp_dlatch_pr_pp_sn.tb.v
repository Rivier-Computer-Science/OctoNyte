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

`ifndef SKY130_FD_SC_HS__UDP_DLATCH_PR_PP_SN_TB_V
`define SKY130_FD_SC_HS__UDP_DLATCH_PR_PP_SN_TB_V

/**
 * udp_dlatch$PR_pp$sN: D-latch, gated clear direct / gate active high
 *                      (Q output UDP)
 *
 * Autogenerated test bench.
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

`include "sky130_fd_sc_hs__udp_dlatch_pr_pp_sn.v"

module top();

    // Inputs are registered
    reg D;
    reg RESET;
    reg SLEEP_B;
    reg NOTIFIER;

    // Outputs are wires
    wire Q;

    initial
    begin
        // Initial state is x for all inputs.
        D        = 1'bX;
        NOTIFIER = 1'bX;
        RESET    = 1'bX;
        SLEEP_B  = 1'bX;

        #20   D        = 1'b0;
        #40   NOTIFIER = 1'b0;
        #60   RESET    = 1'b0;
        #80   SLEEP_B  = 1'b0;
        #100  D        = 1'b1;
        #120  NOTIFIER = 1'b1;
        #140  RESET    = 1'b1;
        #160  SLEEP_B  = 1'b1;
        #180  D        = 1'b0;
        #200  NOTIFIER = 1'b0;
        #220  RESET    = 1'b0;
        #240  SLEEP_B  = 1'b0;
        #260  SLEEP_B  = 1'b1;
        #280  RESET    = 1'b1;
        #300  NOTIFIER = 1'b1;
        #320  D        = 1'b1;
        #340  SLEEP_B  = 1'bx;
        #360  RESET    = 1'bx;
        #380  NOTIFIER = 1'bx;
        #400  D        = 1'bx;
    end

    // Create a clock
    reg GATE;
    initial
    begin
        GATE = 1'b0;
    end

    always
    begin
        #5 GATE = ~GATE;
    end

    sky130_fd_sc_hs__udp_dlatch$PR_pp$sN dut (.D(D), .RESET(RESET), .SLEEP_B(SLEEP_B), .NOTIFIER(NOTIFIER), .Q(Q), .GATE(GATE));

endmodule

`default_nettype wire
`endif  // SKY130_FD_SC_HS__UDP_DLATCH_PR_PP_SN_TB_V