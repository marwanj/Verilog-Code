module toplvltb();

wire [23:0] Sum;
wire Done;
reg start ,clk,rst;
top_level #(24)Meow(Sum,start,clk,rst,Done);

initial 
 begin clk = 0; 
 forever #5 clk = ~clk; 
 end


initial fork
start=0;
#3 start=1;
join
initial fork
     rst=0; #1
       rst=1;#2
      rst=0;
join

endmodule

