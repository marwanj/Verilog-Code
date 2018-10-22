// This code outputs a one if the number of 1 is a multiple of 4
module onecount (output reg y_out, input x_in,clk,reset);
    reg[2:0] state,nextstate;
    reg q;
    parameter S0=0;
    parameter S1=1;
    parameter S2=2;
    parameter S3=3;
    parameter S4=4;

    always @(posedge clk)
    begin
       if (reset==1) state <=S0;
       else
       begin
     state <= nextstate;
     y_out<=q;
     end
    end
    always @(state,x_in,reset)
        case (state)
        S0:
        begin 
        if (x_in==1) 
        begin
            nextstate=S1;
            q='b0;
        end
        else 
        begin
            nextstate=S0;
            q='b0;
        end
        end
        S1:
           begin 
        if (x_in==1) 
        begin
            nextstate=S2;
            q='b0;
        end
        else 
        begin
            nextstate=S1;
            q='b0;
        end
        end
        S2:
        begin 
        if (x_in==1) 
        begin
            nextstate=S3;
            q='b0;
        end
        else 
        begin
            nextstate<=S2;
            q='b0;
        end
        end
        S3:      
        begin 
        if (x_in==1) 
        begin
            nextstate<=S4;
            q='b1;
        end
        else 
        begin
            nextstate<=S3;
            q='b0;
        end
        end
        S4:
        begin 
        if (x_in==1) 
        begin
            nextstate<=S0;
            q='b0;
        end
        else 
        begin
            nextstate<=S4;
            q='b1;
        end
        end
        default:
        begin 
        nextstate=S0;
        q=0;
        end
        endcase

    


endmodule