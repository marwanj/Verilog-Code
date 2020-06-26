module top_level #(parameter word_size=24)(Sum,start,clk,rst,Done);


output [word_size-1:0] Sum;
output Done;
input start;
input clk,rst;
wire E_Square,E_Sum,Store_D;
wire [word_size-1:0] data_1,data_2;
wire [8:0]Adress1,Adress2;


Control_Unit CU (Adress1,Adress2,Done,E_Square,E_Sum,Store_D, clk, rst,start, data_1,data_2);
Calculation #(24) Cal (Sum,data_1,data_2,E_Square,E_Sum,Store_D,clk,rst);
Memory_Unit MU (data_1,data_2, Adress1,Adress2,rst);

endmodule