module Control_Unit (
Load_R0, Load_R1,
Load_R2, Load_R3,
Load_R4, Load_R5,
Load_R6, Load_R7,Load_Immediate,
Load_PC,Load_IR1,Load_IR2, Inc_PC,
Sel_Bus_1_Mux, Sel_Bus_2_Mux,
Load_IR, Load_Add_R, Load_Reg_Y, Load_Reg_Z,Load_IR1,Load_IR2,
write, instruction,opcode,destsrc, zero, clk, rst);
parameter word_size = 8, op_size = 8, state_size = 4;
parameter src_size = 4, dest_size = 4, Sel1_size = 4, Sel2_size = 2;
// State Codes
parameter S_idle = 0, S_fet1 = 1, S_fet2 = 2, S_dec = 3;
parameter S_ex1 = 4, S_rd1 = 5, S_rd2 = 6;
parameter S_wr1 = 7, S_wr2 = 8, S_br1 = 9, S_br2 = 10, S_halt = 11;

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

parameter ST    = 8'b11000;
parameter STR   = 8'b11001;
parameter J     = 8'b11010;
parameter JR    = 8'b11011;
parameter JAL   = 8'b11100;
parameter JRAL  = 8'b11101;
parameter SKIP  = 8'b11110;
parameter BRZ   = 8'b11111;
parameter BRNZ  = 8'b00100000;
parameter HALT  = 8'b11111111;



// parameter NOP = 0, ADD = 1, SUB = 2, AND = 3, NOT = 4;
// parameter RD = 5, WR = 6, BR = 7, BRZ = 8;

// Source and Destination Codes
parameter R0 = 0, R1 = 1, R2 = 2, R3 = 3,R4=4,R5=5,R6=6,R7=7;
// Ports
output Load_R0, Load_R1, Load_R2, Load_R3,Load_R4, Load_R5,
Load_R6, Load_R7;
output Load_PC, Inc_PC;
output [Sel1_size-1: 0] Sel_Bus_1_Mux;
output Load_IR, Load_Add_R,Load_IR1,Load_IR2;
output Load_Reg_Y, Load_Reg_Z;
output [Sel2_size-1: 0] Sel_Bus_2_Mux;
output write;
input [word_size-1: 0] instruction;
input zero;
input clk, rst;
// Datapath and State Register Variables
reg [state_size-1: 0] state, next_state;
reg Load_R0, Load_R1, Load_R2, Load_R3, Load_PC, Inc_PC;
reg Load_IR, Load_Add_R, Load_Reg_Y,Load_IR1,Load_IR2;
reg Sel_ALU, Sel_Bus_1, Sel_Mem;
reg Sel_R0, Sel_R1, Sel_R2, Sel_R3,Sel_R4, Sel_R5 ,Sel_R6 , Sel_R7,Sel_PC;
reg Load_Reg_Z, write;
reg err_flag;
// Structural connections
wire [op_size-1: 0] opcode = opcode [word_size-1: word_size - op_size];
wire [src_size-1: 0] src = destsrc [src_size + dest_size -1: dest_size];
wire [dest_size-1: 0] dest = destsrc [dest_size -1: 0];
// Datapath mux selectors
assign Sel_Bus_1_Mux[Sel1_size-1: 0] = Sel_R0 ? 0:
                                        Sel_R1 ? 1:
                                        Sel_R2 ? 2:
                                        Sel_R3 ? 3:
                                        Sel_R4 ? 4:
                                        Sel_R5 ? 5:
                                        Sel_R6 ? 6:
                                        Sel_R7 ? 7:
                                        Sel_PC ? 8: 3'bx; // 3-bits, sized number
assign Sel_Bus_2_Mux[Sel2_size-1: 0] = Sel_ALU ? 0:
                                        Sel_Bus_1 ? 1:
                                        Sel_Mem ? 2: 2'bx;
// State machine
always @ (posedge clk or negedge rst) begin: State_transitions
    if (rst == 0) 
        state <= S_idle; 
    else 
        state <= next_state; 
    end
always @ (state or opcode or src or dest or zero) begin: Output_and_next_state
    // Initialize to default values
    Sel_R0 = 0; Sel_R1 = 0; Sel_R2 = 0; Sel_R3 = 0;Sel_R4 = 0; Sel_R5 = 0; Sel_R6 = 0; Sel_R7 = 0; Sel_PC = 0;
    Load_R0 = 0; Load_R1 = 0; Load_R2 = 0; Load_R3 = 0;Load_R4 = 0; 
    Load_R5 = 0; Load_R6 = 0; Load_R7 = 0; Load_PC = 0;
    Load_IR = 0; Load_Add_R = 0; Load_Reg_Y = 0; Load_Reg_Z = 0;Load_IR1 = 0;Load_IR2 = 0;
    Inc_PC = 0;
    Sel_Bus_1 = 0;
    Sel_ALU = 0;
    Sel_Mem = 0;
    write = 0;
    err_flag = 0; // Used for de-bug in simulation
    next_state = state;
    case (state)    
        S_idle: 
            next_state = S_fet1;
        S_fet1: begin
            next_state = S_fet2;
            Sel_PC = 1;
            Sel_Bus_1 = 1;
            Load_Add_R = 1;
            end
        S_fet2: begin
            next_state = S_dec;
            Sel_Mem = 1;
            Load_IR = 1;
            Inc_PC = 1;
        end
        S_dec: begin
            case (instruction)
                NOP: 
                    next state = S fetch1;
                ADD, SUB, AND,INC,DEC,MOD,SLT,SGT,NAND,NOR,XOR: 
                    begin
                    Load_IR1 = 1;
                    next_state = S_ex1 ;
                    Sel_Bus_1 = 1;
                    Sel_PC=1;
                    Load_Add_R = 1;
                    end //Arithmetic
                NOT: 
                    begin
                        next_state = S_fet1;
                        Load_Reg_Z = 1;
                        Sel_Bus_1 = 1;
                        Sel_ALU = 1;
                        case (src) // Select the ALU source reg
                            R0: Sel_R0 = 1;
                            R1: Sel_R1 = 1;
                            R2: Sel_R2 = 1;
                            R3: Sel_R3 = 1;
                            R4: Sel_R4 = 1;
                            R5: Sel_R5 = 1;
                            R6: Sel_R6 = 1;
                            R7: Sel_R7 = 1;
                            default : err_flag = 1;
                        endcase
                        case (dest) // Select the ALU destination reg
                            R0: Load_R0 = 1;
                            R1: Load_R1 = 1;
                            R2: Load_R2 = 1;
                            R3: Load_R3 = 1;
                            R4: Load_R4 = 1;
                            R5: Load_R5 = 1;
                            R6: Load_R6 = 1;
                            R7: Load_R7 = 1;
                            default: err_flag = 1;
                            endcase
                    end // NOT
                RD: 
                    begin
                        next_state = S_rd1;
                        Load_Add_R = 1;
                        Sel_Bus_1 = 1;
                        Sel_PC = 1;
                    end // Read
                WR:
                    begin   
                        next_state=S_wr1;
                        Sel_PC=1;
                        Sel_Bus_1=1;
                        Load_Add_R=1;
                    end //WR
                BR:
                    begin 
                        next_state=S_br1;
                        Sel_PC=1;
                        Sel_Bus_1=1;
                        Load_Add_R=1;
                    end //BR
                BRZ: 
                    if (zero==1)
                        begin 
                            next_state=S_br1;
                            Sel_PC=1;
                            Sel_Bus_1=1;
                            Load_Add_R=1;
                        end //if
                    else 
                        begin
                          next_state = S_fet1;
                          Inc_PC=1;
                    end  //else
                default: next_state=S_halt;
        endcase // Opcode
    end //Decode
        S_ex1:  begin
                    next_state=S_ex2;
                    Sel_Mem=1;
                    Load_Add_R=1;
                  //  Inc_PC=1;

                    Sel_Bus_1 = 1;
                    Inc_PC = 1;
                    Load_Reg_Y = 1;
                    case (src) // Select ALU src reg
                        R0: Sel_R0 = 1;
                        R1: Sel_R1 = 1;
                        R2: Sel_R2 = 1;
                        R3: Sel_R3 = 1;
                        R4: Sel_R4 = 1;
                        R5: Sel_R5 = 1;
                        R6: Sel_R6 = 1;
                        R7: Sel_R7 = 1;
                    default : err_flag = 1;
                    endcase
                end // S_ex1
         S_ex2:  begin
                    
                    next_state=S_fet1;
                    Load_Reg_Z=1;
                    Sel_ALU=1;
                    case (dest) // Select the ALU destination reg
                        R0: begin Sel_R0=1;Load_R0 = 1; end
                        R1: begin Load_R1 = 1;Sel_R1=1; end
                        R2: begin Load_R2 = 1;Sel_R2=1; end
                        R3: begin Load_R3 = 1;Sel_R3=1; end
                        R4: begin Load_R4 = 1;Sel_R4=1; end
                        R5: begin Load_R5 = 1;Sel_R5=1; end
                        R6: begin Load_R6 = 1;Sel_R6=1; end
                        R7: begin Load_R7 = 1;Sel_R7=1; end

                    default: err_flag = 1;
                    endcase//dest
                end // S_ex2

        S_rd1:  begin
                    next_state=S_rd2;
                    Sel_Mem=1;
                    Load_Add_R=1;
                    Inc_PC=1;
                end // S_rd1
        S_rd2:  begin
                    next_state=S_fet1;
                    Sel_Mem=1;
                    case (dest) // Select the ALU destination reg
                        R0: begin Load_R0 = 1; end
                        R1: begin Load_R1 = 1; end
                        R2: begin Load_R2 = 1; end
                        R3: begin Load_R3 = 1; end
                        R4: begin Load_R4 = 1; end
                        R5: begin Load_R5 = 1; end
                        R6: begin Load_R6 = 1; end
                        R7: begin Load_R7 = 1; end
                    default: err_flag = 1;
                    endcase//dest
                end // S_rd2
         S_wr1:  begin
                    next_state=S_wr2;
                    Sel_Mem=1;
                    Load_Add_R=1;
                    Inc_PC=1;
                end // S_rd1
        S_wr2:  begin
                    next_state=S_fet1;
                    write=1;
                    case (src) // Select write src reg
                                    R0: Sel_R0 = 1;
                                    R1: Sel_R1 = 1;
                                    R2: Sel_R2 = 1;
                                    R3: Sel_R3 = 1;
                                    R4: Sel_R4 = 1;
                                    R5: Sel_R5 = 1;
                                    R6: Sel_R6 = 1;
                                    R7: Sel_R7 = 1;
                                default : err_flag = 1;
                    endcase
                end //wr2
        S_br1:  begin
                    next_state=S_br2;
                    Sel_Mem=1;
                    Load_Add_R=1; 
                end //br1  
        S_br2:  begin
                    next_state=S_fet1;
                    Sel_Mem=1;
                    Load_PC=1; 
                end //br2   
        S_halt: begin
                    next_state=S_halt;
                end
        default : next_state=S_idle;
    endcase // State
end

endmodule