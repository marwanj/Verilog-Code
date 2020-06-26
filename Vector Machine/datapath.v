module Calculation #(parameter word_size=24)(Sum,data_1,data_2,E_Square,E_Sum,Store_D,clk, rst);


output [word_size-1:0] Sum;

input clk,rst;
input [word_size-1:0] data_1,data_2;
input E_Square,E_Sum,Store_D;

wire [word_size-1:0] square_1,square_2;
wire [word_size-1:0] squareout_1,squareout_2;
wire  [word_size-1:0] sumtemp;
wire [word_size-1:0] s_data_1,s_data_2;
wire [word_size-1:0] sum;

Register_Unit #(word_size) DataReg1 (s_data_1, data_1, Store_D, clk, rst);
Register_Unit #(word_size) DataReg2 (s_data_2, data_2, Store_D, clk, rst);

Square #(word_size) S1 (square_1,square_2, s_data_1, s_data_2); //outputs the values of the square of data1 and data2

Register_Unit #(word_size) Square1 (squareout_1, square_1, E_Square, clk, rst); 
Register_Unit #(word_size) Square2  (squareout_2, square_2, E_Square, clk, rst);

Adder #(word_size) A1 (sumtemp, squareout_1, squareout_2);

Accumilate #(word_size) Accumilator1 (sum, sumtemp,E_Sum,clk,rst);
// Adder #(word_size) Accumilatorr (sumout2, sumtemp, sum);

// Register_Unit #(word_size) R2S (sum, sumout2, E_Sum, clk, rst);
assign Sum=sum;
endmodule 