module Multiplexer_9ch # (parameter word_size = 8) ( 
output reg [word_size-1: 0] mux_out,
input [word_size-1: 0] data_a, data_b, data_c, data_d, data_e,data_f,data_g,data_h,data_i,
input [4: 0] sel
);

always @ (sel, data_a, data_b, data_c, data_d, data_e)
case (sel)
0: mux_out = data_a;
1: mux_out = data_b;
2: mux_out = data_c;
3: mux_out = data_d;
4: mux_out = data_e;
5: mux_out = data_f;
6: mux_out = data_g;
7: mux_out = data_h;
8: mux_out = data_i;

default: mux_out = 'bx;
endcase
endmodule