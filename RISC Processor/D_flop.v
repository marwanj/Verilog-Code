module D_flop (data_out, data_in, load, clk, rst);
output data_out;
input data_in;
input load;
input clk, rst;
reg data_out;
always @ (posedge clk or negedge rst)
if (rst == 0) data_out <= 0; else if (load == 1) data_out <= data_in;
endmodule
module Address_Register (data_out, data_in, load, clk, rst);
parameter word_size = 8;
output [word_size-1: 0] data_out;
input [word_size-1: 0] data_in;
input load, clk, rst;
reg data_out;
always @ (posedge clk or negedge rst)
if (rst == 0) data_out <= 0; else if (load) data_out <= data_in;
endmodule