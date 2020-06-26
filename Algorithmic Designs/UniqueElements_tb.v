// Test Bench for the unique elements module
module UEtb ;
wire [31:0] A [0:127];
wire [31:0] B [0:127];
wire done,count;
reg En,Ld,clk,rst;
UE Bubbly (A,B,En, Ld, clk, rst,done,count);

initial
begin
// Initialize the Input

rst=1;
clk=0;
En=0;
Ld=0;
// Inputs!
  #40;
  rst=0;
  En=0;
  Ld=1; 
  #20;
  En=1;
end 
// Make Clk
always #10 clk=~clk;

endmodule
