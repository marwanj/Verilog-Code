module Accumilate_tb ();
wire [23:0] sum ;
reg [23:0] data_1; 
reg clk,load,reset;
Accumilate #(24) acccu (sum, data_1,load,clk,reset);

initial 
 begin 
 clk = 0; 
 forever #5 clk = ~clk; 
end

initial fork
data_1 =24'b110000000001010000000001; #10
data_1 =24'b110100000001010000000010; #20
data_1 =24'b110000000001010000000000;
join
initial fork
load=0;
#9 load =1; 
load =0; #19
load =1;
join
initial fork
reset=1; 
#2 reset=0; 
#3 reset=0; 
join
endmodule