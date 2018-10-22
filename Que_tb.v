module fifotb ;
reg write,clk,read,rst;
reg [31:0] data;
wire [31:0] out;
wire empty,half_full,full,three_quarter_full;
fifoController FIFO1 (data ,read,write,clk,rst,empty,full,half_full,three_quarter_full,out);


initial
begin
// Initialize the Input

rst=1;
clk=0;
data=32'b0;
read=0;
write=0;
// Inputs!

  #40;
  rst=0;
  write  = 1'b1;
  data  = 32'hABCD;
  #20;
  data  = 32'h1234;
  #20;
  data  = 32'h2345;
  #20;
  write = 0;
  read = 1'b1;  
end 
// Make Clk

always #10 clk=~clk;

endmodule