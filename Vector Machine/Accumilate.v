module Accumilate #(parameter word_size=24)(sum, data_1,load,clk,rst);
input clk,rst,load;
output [word_size-1: 0] sum;
input [word_size-1: 0] data_1;
reg [word_size-1: 0] sum;
wire [word_size-1:0]sumtemp;
Adder #(word_size)Accuadder(sumtemp, data_1, sum);
always @ (posedge clk or posedge rst)
    begin
        if (rst == 1)
            begin
             sum <= 0; 
            end
        else if (load==1) 
            begin 
                sum <= sumtemp;
            end
        end
endmodule