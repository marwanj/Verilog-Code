module Memory_Unit (data_out1,data_out2, address1,address2,load);
parameter word_size = 24;
parameter memory_size = 512;
output [word_size-1: 0] data_out1,data_out2;
input [8: 0] address1,address2;
integer set=0;
input load;
reg [word_size-1: 0] memory [memory_size-1: 0];
assign data_out1 = memory[address1];
assign data_out2 = memory[address2];
always @ (load)
begin
for (set=0;set<512;set=set+1)
begin
memory[set]=0;
end
  memory[0]=49;
  memory[1]=34;
  memory[2]=24'b010000100100000000000110;
  memory[3]=24'b110111110000000000000101;


  memory[5]=17;
  memory[6]=40;
  memory[7]=24'b110011000010000000000101;
  memory[8]=24'b111001100000000000000111;


  memory[11]=22;
  memory[12]=18;
  memory[13]=24'b111001100000000000000101;
  memory[14]=24'b010111010010000000000111;


  memory[17]=11;
  memory[18]=6;
  memory[19]=24'b110000010000000000000100;
  memory[20]=24'b110110100001100000000111;


  memory[22]=33;
  memory[23]=12;
memory[24]=24'b111111010010000000000101;
memory[25]=24'b110000001011000000000110;

  memory[28]=102;
  memory[29]=240;
memory[30]=24'b110111100010000000000110;
memory[31]=24'b010110111100000000000100;


  memory[33]=0;
  memory[34]=23;
memory[35]=24'b111001110000000000000101;
memory[36]=24'b110110000010000000000111;


  memory[39]=5;
  memory[40]=50;
memory[41]=24'b111100010011000000000110;
memory[42]=24'b111000010101000000000110;


memory[44]=56;
memory[45]=88;
memory[46]=24'b111100001011100000000111;
memory[47]=24'b110001011100100000000111;


memory[49]=39;
memory[50]=1;
memory[51]=24'b 111001011111100000000111;
memory[52]= 24'b 111111101000000000000110;

end

endmodule