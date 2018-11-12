module Processing_Unit (instruction, Zflag, address, Bus_1, mem_word,Load_R0, Load_R1, Load_R2, Load_R3, Load_PC, Inc_PC,Sel_Bus_1_Mux, Load_IR, Load_Add_R, Load_Reg_Y, Load_Reg_Z,Sel_Bus_2_Mux, clk, rst);
//Inout//
parameter word_size = 8;
parameter op_size = 4;
parameter Sel1_size = 3;
parameter Sel2_size = 2;
output [word_size-1: 0] instruction, address, Bus_1;
output Zflag;
input [word_size-1: 0] mem_word;
input Load_R0, Load_R1, Load_R2, Load_R3, Load_PC, Inc_PC;
input [Sel1_size-1: 0] Sel_Bus_1_Mux;
input [Sel2_size-1: 0] Sel_Bus_2_Mux;
input Load_IR, Load_Add_R, Load_Reg_Y, Load_Reg_Z;
input clk, rst;
//Wires
wire Load_R0, Load_R1, Load_R2, Load_R3;
wire [word_size-1: 0] Bus_2;
wire [word_size-1: 0] R0_out, R1_out, R2_out, R3_out;
wire [word_size-1: 0] PC_count, Y_value, alu_out;
wire alu_zero_flag;
wire [op_size-1 : 0] opcode = instruction [word_size-1: word_size-op_size];
//Main Register Bank
Register_Unit R0 (R0_out, Bus_2, Load_R0, clk, rst);
Register_Unit R1 (R1_out, Bus_2, Load_R1, clk, rst);
Register_Unit R2 (R2_out, Bus_2, Load_R2, clk, rst);
Register_Unit R3 (R3_out, Bus_2, Load_R3, clk, rst);
Register_Unit R4 (R4_out, Bus_2, Load_R4, clk, rst);
Register_Unit R5 (R5_out, Bus_2, Load_R5, clk, rst);
Register_Unit R6 (R6_out, Bus_2, Load_R6, clk, rst);
Register_Unit R7 (R7_out, Bus_2, Load_R7, clk, rst);
Register_Unit PC1 (PC1_out, Bus_2, Load_PC1, clk, rst);
Register_Unit PC2 (PC2_out, Bus_2, Load_PC2, clk, rst);
Register_Unit Reg_Y (Y_value, Bus_2, Load_Reg_Y, clk, rst);
//D flipflop
D_flop Reg_Z (Zflag, alu_zero_flag, Load_Reg_Z, clk, rst);
//Other Registers
Address_Register Add_R (address, Bus_2, Load_Add_R, clk, rst);
Instruction_Register IR (instruction, Bus_2, Load_IR, clk, rst);
Program_Counter PC (PC_count, Bus_2, Load_PC, Inc_PC, clk, rst);
//Multiplexers
Multiplexer_5ch Mux_1 (Bus_1, R0_out, R1_out, R2_out,R3_out, PC_count, Sel_Bus_1_Mux);
Multiplexer_3ch Mux_2 (Bus_2, alu_out, Bus_1, mem_word, Sel_Bus_2_Mux);
Alu_RISC ALU (alu_zero_flag, alu_out, Y_value, Bus_1, PC1_out);

endmodule // Processing_Unit