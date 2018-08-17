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

module sram_l15_tag
(
input wire MEMCLK,
input wire RESET_N,
input wire CE,
input wire [6:0] A,
input wire RDWEN,
input wire [131:0] BW,
input wire [131:0] DIN,
output wire [131:0] DOUT,

input wire [`BIST_OP_WIDTH-1:0] BIST_COMMAND,
input wire [`SRAM_WRAPPER_BUS_WIDTH-1:0] BIST_DIN,
output reg [`SRAM_WRAPPER_BUS_WIDTH-1:0] BIST_DOUT,
input wire [`BIST_ID_WIDTH-1:0] SRAMID
);

wire           write_en;
wire           read_en;
wire  [19:0]   wen_mask;
wire  [159:0]  data_in;
wire  [159:0]  data_out;


assign write_en   = CE & (RDWEN == 1'b0);
assign read_en    = CE & (RDWEN == 1'b1);
assign wen_mask   = {{5{BW[99]}},{5{BW[66]}},{5{BW[33]}},{5{BW[0]}}};
assign data_in    = {7'b0,DIN[131:99],7'b0,DIN[98:66],7'b0,DIN[65:33],7'b0,DIN[32:0]};
assign DOUT       = {data_out[152:120],data_out[112:80],data_out[72:40],data_out[32:0]};

always @*
   BIST_DOUT = {`SRAM_WRAPPER_BUS_WIDTH{1'b0}};


bram_128x160 mem (
   .clka    (MEMCLK     ),
   .ena     (write_en   ),
   .wea     (wen_mask   ),
   .addra   (A          ),
   .dina    (data_in    ),

   .clkb    (MEMCLK     ),
   .enb     (read_en    ),
   .addrb   (A          ),
   .doutb   (data_out   )
);

endmodule
