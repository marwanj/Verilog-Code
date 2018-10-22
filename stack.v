module StackStructure (input [31:0] In ,input pop,push,clk,rst,output empty,full,half_full,three_quarter_full,output reg [31:0] Out);
reg [31:0] Stack [0:15];
reg [3:0] Count=0,wrc=0;
assign empty=(Count==0)? 1'b1:1'b0;
assign full=(Count==16)? 1'b1:1'b0;
assign half_full=(Count==8)? 1'b1:1'b0;
assign three_quarter_full=(Count==12)? 1'b1:1'b0;

always @(clk) 
begin

  if (rst==1) begin
    wrc=0;
    end
else if (pop==1 && empty==0)
begin
Out=Stack[wrc];
wrc=wrc-1;
end
else if (push==1 && full==0)
  begin 
  Stack [wrc]=In;
  wrc=wrc+1;  
end
assign Count=wrc;
end
endmodule
