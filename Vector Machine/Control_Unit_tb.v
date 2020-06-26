
module ControlUnit_tb ();
reg [23:0] data_1, data_2; 
wire E_Square,E_Sum,Store_D,Done;
wire [8:0] Adress1,Adress2;
reg clk, rst,start;

Control_Unit I_love_control (Adress1,Adress2,Done,E_Square,E_Sum,Store_D, clk, rst,start, data_1,data_2);
// each initial applies inputs one at a time

initial #1000 $finish;

 initial 
 begin clk = 0; 
 forever #5 clk = ~clk; 
 end


initial fork
#3 start=1;
join
initial fork
     rst=0; #1
       rst=1;#2
      rst=0;
join
initial fork
     data_1=31; #9
      data_1=50;#19
      data_1=0;
join
initial fork
     data_2=12; #9
      data_2=32;#19
      data_2=21;
join
 
endmodule