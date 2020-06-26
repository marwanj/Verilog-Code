
module Square_tb ();
wire [23:0] square_1,square_2 ;
reg [23:0] data_1, data_2; 
Square #(24) Squarie (square_1,square_2, data_1, data_2);
// each initial applies inputs one at a time

initial #1000 $finish;

// initial 
// begin clk = 0; 
// forever #5 clk = ~clk; 
// end

initial fork
data_1 =1; #10
data_1 =10; #20
data_1 =40;
join
initial fork
data_2 =2; #10
data_2 =30; #20
data_2 =77;
join
endmodule