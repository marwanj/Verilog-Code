module Square #(parameter word_size=24)(square_1,square_2, data_1, data_2);

output reg[word_size-1: 0] square_1,square_2;
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

always @ (data_1 or data_2)
begin
square_1={1'b0,mantissa_1*mantissa_1,exponent_1<<1};
square_2={1'b0,mantissa_2*mantissa_2,exponent_2<<1};
end

endmodule