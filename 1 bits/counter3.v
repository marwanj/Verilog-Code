// Counter for the '1' bit inputs
module counter3 (output reg[2:0] count, input clk,reset,up,load, input [2:0] data);
    reg [2:0] state,nextstate;
    parameter S0=0;
    parameter S1=1;
    parameter S2=2;
    parameter S3=3;
    parameter S4=4;
    parameter S5=5;
    parameter S6=6;
    parameter S7=7;
    always @(posedge clk)
    begin
     if (reset==1) state <=S0;
     else if (load==1) state<=data;
     else state <= nextstate;
     
     end

    always @(state,up)
    begin
        case (state)
        S0:if (up==1) nextstate=S3;else nextstate=S5;
        S1:if (up==1) nextstate=S4;else nextstate=S6;
        S2:if (up==1) nextstate=S5;else nextstate=S7;
        S3:if (up==1) nextstate=S6;else nextstate=S0;
        S4:if (up==1) nextstate=S7;else nextstate=S1;
        S5:if (up==1) nextstate=S0;else nextstate=S2;
        S6:if (up==1) nextstate=S1;else nextstate=S3;
        S7:if (up==1) nextstate=S2;else nextstate=S4;
        default: nextstate=S0;
        endcase
        count = state;
        end



endmodule