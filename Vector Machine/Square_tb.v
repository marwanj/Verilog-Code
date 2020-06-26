
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
data_1 =24'b100000000001010000000001; #10
data_1 =24'b100000000001010000000010; #20
data_1 =24'b100000000001010000000000;
join
initial fork
data_2 =24'b100000000001010000000011; #10
data_2 =24'b100000000001010000001011; #20
data_2 =24'b100001000001000000001011;
join
endmodule