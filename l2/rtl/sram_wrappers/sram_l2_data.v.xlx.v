// ========== Copyright Header Begin ============================================
// Copyright (c) 2015 Princeton University
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of Princeton University nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY PRINCETON UNIVERSITY "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL PRINCETON UNIVERSITY BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// ========== Copyright Header End ============================================

// 17/02/2015 17:18:31
// This file is auto-generated
// Author: Tri Nguyen
`include "define.vh"
`ifdef L15_EXTRA_DEBUG
`default_nettype none
`endif
module sram_l2_data
(
input wire MEMCLK,
input wire RESET_N,
input wire CE,

`ifdef L2_32K_4WAY
   input wire [10:0] A,
`else    // assume 64K L2
   input wire [11:0] A,
`endif

input wire RDWEN,
input wire [143:0] BW,
input wire [143:0] DIN,
output wire [143:0] DOUT,
input wire [`BIST_OP_WIDTH-1:0] BIST_COMMAND,
input wire [`SRAM_WRAPPER_BUS_WIDTH-1:0] BIST_DIN,
output reg [`SRAM_WRAPPER_BUS_WIDTH-1:0] BIST_DOUT,
input wire [`BIST_ID_WIDTH-1:0] SRAMID
);

always @*
   BIST_DOUT = {`SRAM_WRAPPER_BUS_WIDTH{1'b0}};

`ifdef L2_32K_4WAY
   bram_sdp_2048x144_wrapper #(
      .ADDR_WIDTH    (11         ),
      .BITMASK_WIDTH (144        ),
      .DATA_WIDTH    (144        )
   )   bram_wrapper (
      .MEMCLK        (MEMCLK     ),
      .CE            (CE         ),
      .A             (A          ),
      .RDWEN         (RDWEN      ),
      .BW            (BW         ),
      .DIN           (DIN        ),
      .DOUT          (DOUT       )
   );
`else
   bram_sdp_4096x144_wrapper #(
      .ADDR_WIDTH    (12         ),
      .BITMASK_WIDTH (144        ),
      .DATA_WIDTH    (144        )
   )   bram_wrapper (
      .MEMCLK        (MEMCLK     ),
      .CE            (CE         ),
      .A             (A          ),
      .RDWEN         (RDWEN      ),
      .BW            (BW         ),
      .DIN           (DIN        ),
      .DOUT          (DOUT       )
   );
`endif
endmodule
