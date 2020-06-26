module Control_Unit (output reg [8:0] Adress1,Adress2, output reg Done,E_Square,E_Sum,Store_D,input clk, reset,start,input [23:0] Data1,Data2);
parameter word_size = 24, state_size = 3;
// State Codes
parameter S_idle = 0, S_halt = 7, S_fetch1 = 1,S_fetch2=2,S_Square=3,S_Sum=4,S_halt_1=5,S_halt_2=6;

// Datapath and State Register Variables
reg NextAddress,PrevAddress;
reg [state_size-1: 0] state, next_state;
wire [8:0]Adressn,Adressp;
// State machine
always @ (posedge clk or posedge reset) begin: State_transitions

    if (reset == 1) 
        state <= S_idle; 
    else 
    begin
        state <= next_state; 
        end
          if (state==S_fetch1 ||state== S_Sum)
        begin
        Adress1<=Adress1+2;
        Adress2<=Adress2+2;
        end 
        else if (state==S_Square)
        begin
          Adress1<=Adressn;
          Adress2<=Adressn+1;
         end 

    end

Register_Unit #(9) Nexti(Adressn, Data1[8:0], NextAddress, clk, reset);
Register_Unit #(9) Previousi(Adressp, Data2[8:0], PrevAddress, clk, reset);
//Combinational Logic
always @ (state,start,Data1,Data2) begin: Output_and_next_state
    // Initialize to default values
    Done=0;
    next_state = state;
    E_Square=0;
    E_Sum=0;
    Store_D=0;
    NextAddress=0;
    PrevAddress=0;
    case (state)    
        S_idle:
            begin 
                  if (start==1)
                    begin
                    next_state = S_fetch1;
                    NextAddress=1;
                    PrevAddress=1;
                    Adress1<=0;
                    Adress2<=1;
                    end
                 else 
                    next_state=S_idle;
            end
        S_fetch1:
            begin
                next_state=S_Square;
                Store_D=1;
            end
        S_Square:
            begin
                next_state=S_Sum;
                E_Square=1;
            end
        S_Sum:
            begin
            if (Adressn==0)
            next_state=S_halt_1;
            else 
            begin
                next_state=S_Square;
                E_Sum=1;
                NextAddress=1;
                PrevAddress=1;
                Store_D=1;
            end
            end
        S_halt_1: begin
                    next_state=S_halt_2;
                    E_Square=1;
                end
        S_halt_2: begin
                    next_state=S_halt;
                    E_Sum=1;
                end
        S_halt: begin
                    next_state=S_halt;
                    Done=1;
                end
        default : next_state=S_idle;
    endcase // State
end

endmodule