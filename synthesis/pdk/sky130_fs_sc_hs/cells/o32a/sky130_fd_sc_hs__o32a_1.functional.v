/*
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


`ifndef SKY130_FD_SC_HS__O32A_1_FUNCTIONAL_V
`define SKY130_FD_SC_HS__O32A_1_FUNCTIONAL_V

/**
 * o32a: 3-input OR and 2-input OR into 2-input AND.
 *
 *       X = ((A1 | A2 | A3) & (B1 | B2))
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import sub cells.
`include "../../models/udp_pwrgood_pp_pg/sky130_fd_sc_hs__udp_pwrgood_pp_pg.v"

`celldefine
module sky130_fd_sc_hs__o32a_1 (
    VPWR,
    VGND,
    X   ,
    A1  ,
    A2  ,
    A3  ,
    B1  ,
    B2
);

    // Module ports
    input  VPWR;
    input  VGND;
    output X   ;
    input  A1  ;
    input  A2  ;
    input  A3  ;
    input  B1  ;
    input  B2  ;

    // Local signals
    wire    or0_out           ;
    wire    or1_out           ;
    wire    and0_out_X        ;
    wire    udp_pwrgood_pp$PG0_out_X;

    //                           Name          Output              Other arguments
    or                           or0          (or0_out           , A2, A1, A3            );
    or                           or1          (or1_out           , B2, B1                );
    and                          and0         (and0_out_X        , or0_out, or1_out      );
    sky130_fd_sc_hs__udp_pwrgood_pp$PG udp_pwrgood_pp$PG0 (udp_pwrgood_pp$PG0_out_X, and0_out_X, VPWR, VGND);
    buf                          buf0         (X                 , udp_pwrgood_pp$PG0_out_X    );

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HS__O32A_1_FUNCTIONAL_V