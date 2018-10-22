module fifoController (input [31:0] In ,input read,write,clk,rst,output empty,full,half_full,three_quarter_full,output reg  [31:0] Out);
reg [31:0] FIFO [0:15];
reg [3:0] Count=0,readc=0,writec=0;
assign empty=(Count==0)? 1'b1:1'b0;
assign full=(Count==16)? 1'b1:1'b0;
assign half_full=(Count==8)? 1'b1:1'b0;
assign three_quarter_full=(Count==12)? 1'b1:1'b0;
always @(clk) 
begin

  if (rst==1) begin
    readc=0;
    writec=0;
    end
else if (read==1 && empty==0)
begin
Out=FIFO[readc];
readc=readc+1;
end
else if (write==1 && full==0)
  begin 
  FIFO [writec]=In;
  writec=writec+1;  
end

if (readc==16)
readc=0;
if (writec==16)
writec=0;

if (writec>readc)
Count=writec-readc;
else 
Count=readc-writec;


end
endmodule
