module Alu_RISC (alu_zero_flag, alu_out, data_1, data_2, sel);
parameter word_size = 8;
parameter op_size = 8;
// Opcodes
parameter NOP = 8'b0000;
parameter ADD = 8'b0001;
parameter ADDI= 8'b0010;
parameter SUB = 8'b0011;
parameter INC = 8'b0100;
parameter DEC = 8'b0101;
parameter MOD = 8'b0110;
parameter MOVE= 8'b0111;

parameter SWAP = 8'b1000;
parameter SLT  = 8'b1001;
parameter SGT  = 8'b1010;
parameter AND  = 8'b1011;
parameter ANDI = 8'b1100;
parameter OR   = 8'b1101;
parameter ORI  = 8'b1110;
parameter NAND = 8'b1111;

parameter NANDI = 8'b10000;
parameter NOR = 8'b10001;
parameter NORI= 8'b10010;
parameter XOR = 8'b10011;
parameter XORI = 8'b10100;
parameter LI = 8'b10101;
parameter LD = 8'b10110;
parameter LDR= 8'b10111;

parameter ST = 8'b11000;
parameter STR  = 8'b11001;
parameter J  = 8'b11010;
parameter JR  = 8'b11011;
parameter JAL = 8'b11100;
parameter JRAL   = 8'b11101;
parameter SKIP  = 8'b11110;
parameter BRZ = 8'b11111;
parameter BRNZ = 8'b00100000;
parameter HALT =8'b11111111;

output alu_zero_flag;
output [word_size-1: 0] alu_out;
input [word_size-1: 0] data_1, data_2;
input [op_size-1: 0] sel;
reg alu_out;
assign alu_zero_flag = ~|alu_out; // nor reduction operator
always @ (sel or data_1 or data_2)
case (sel)

    NOP: alu_out = 0;
    ADD,ADDI: alu_out = data_1 + data_2; // Reg_Y + Bus_1
    SUB: alu_out = data_2 - data_1;
    AND: alu_out = data_1 & data_2;
    INC,LDR,STR: alu_out= data_2+1;
    DEC: alu_out= data_2-1;
    MOD: alu_out=data_2 % data_1;
    SLT: alu_out=(data_2<data_1);
    SGT: alu_out=(data_2>data_1);
    AND:alu_out=data_1 & data_2;
    ANDI:alu_out=data_1 & data_2;// coming from Immediate
    OR,ORI:alu_out=data_1 | data_2;
    NAND,NANDI:alu_out=!(data_1 & data_2);
    NOR,NORI: alu_out=!(data_1 | data_2);
    XOR,XORI: alu_out=!(data_1 ^ data_2);
    SKIP:alu_out=(data_2==data_1);
    default: alu_out = 0;

endcase
endmodule