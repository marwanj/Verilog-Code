module countertb ;
reg reset,up,clk;
reg [3:0] data;
wire [2:0] count;
counter3 C1(count,clk,reset,up,0,data);

initial
begin
reset=1;up=1;clk=0;data=1111;
#10 clk=1;
#10 clk=0;reset=0;
forever #5 clk=~clk;
end
endmodule