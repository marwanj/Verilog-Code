
module Calculation_tb ();
wire [23:0] Sum;
reg [23:0] data_1, data_2; 
reg E_Square,E_Sum,Store_D,clk, rst;
Calculation #(24) Calc (Sum,data_1,data_2,E_Square,E_Sum,Store_D,clk, rst);
// each initial applies inputs one at a time

initial #1000 $finish;

 initial 
 begin clk = 0; 
       E_Sum =0;
       E_Square =0;
       Store_D = 1; 
 forever #5 clk = ~clk; 
 end


initial fork
data_1 =1; #9
data_1 =10; #19
data_1 =40;
join
initial fork
data_2 =2; #9
data_2 =30; #19
data_2 =77;
join
initial fork

E_Sum =1; #19
E_Sum=1; #40
E_Sum=0; 
join
initial fork
E_Square =1; #9
E_Square =1; #40
E_Square=0; 
join
initial fork
     rst=0; #1
       rst=1;#2
      rst=0;
join
 
endmodule