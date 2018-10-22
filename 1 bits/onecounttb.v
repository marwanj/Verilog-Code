module onecounttb ;
reg x_in,clk,reset;
wire y_out;

onecount C2(y_out, x_in,clk,reset);

initial
begin
#1 reset=1;
#3 reset=0;x_in=0;clk=0;

forever 
begin
#12 x_in=~x_in;
#5 clk=~clk; 
end
end
endmodule