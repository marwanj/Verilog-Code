module Adder #(parameter word_size=24)(sum, data_1, data_2);

output reg [word_size-1: 0] sum;
input [word_size-1: 0] data_1, data_2;
wire [7:0]exponent_1;
wire [14:0]mantissa_1;
wire sign_1;
wire [7:0]exponent_2;
wire [14:0]mantissa_2;
wire sign_2;

assign exponent_1=data_1[7:0];
assign mantissa_1=data_1[word_size-2:8];
assign sign_1=data_1[word_size-1];

assign exponent_2=data_2[7:0];
assign mantissa_2=data_2[word_size-2:8];
assign sign_2=data_2[word_size-1];

 reg [14:0]shiftedmantissa;
 reg [15:0]mantissa_final;
 reg [7:0]exponent_final;
// wire[7:0] shiftexponent;
// assign exponent_2=data_2[7:0];
// wire lessthan=(exponent_1<exponent_2);

// assign shiftedmantissa = lessthan ?   mantissa_1 : mantissa_2 ;
// assign shiftexponent=lessthan? exponent_2-exponent_1:exponent_1-exponent_2;
// shifter#(word_size=15) shamt ( shiftedmantissa,  shiftexponent, out);

always @ (data_1 or data_2)
begin
if (exponent_1<exponent_2)
begin
shiftedmantissa=mantissa_1>>exponent_2-exponent_1;
mantissa_final=shiftedmantissa+mantissa_2;
if (mantissa_final [15]==1)
begin
mantissa_final=mantissa_final>>1;
exponent_final=exponent_2+1;
end
else
exponent_final=exponent_2;
end
else if (exponent_2<=exponent_1)
begin
shiftedmantissa=mantissa_2>>exponent_1-exponent_2;
mantissa_final=shiftedmantissa+mantissa_1;
if (mantissa_final [15]==1)
begin
mantissa_final=mantissa_final>>1;
exponent_final=exponent_1+1;
end
else
exponent_final=exponent_1;
end
sum={1'b0,mantissa_final[14:0],exponent_final};
end
endmodule