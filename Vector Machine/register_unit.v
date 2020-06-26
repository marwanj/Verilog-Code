module Register_Unit #(parameter word_size=24) (data_out, data_in, load, clk, rst);
output reg [word_size-1: 0] data_out;
input [word_size-1: 0] data_in;
input load, clk, rst;
always @ (posedge clk or posedge rst)
if (rst == 1) data_out <= 0; else if (load) data_out <= data_in;
endmodule