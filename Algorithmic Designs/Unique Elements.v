module Bubble_Sort #(parameter buff_size=128,parameter word_size = 32)(A,B,En, Ld, clk, rst,done,count);
output reg [32-1:0] A [0:128-1];
output reg [32-1:0] B [0:128-1];
input En, Ld, clk, rst;
output reg done;
parameter N=buff_size;
parameter a1 = 8, a2 = 1, a3 = 8, a4 = 1, a5 = 8, a6 = 1, a7 = 8, a8 = 1;
parameter S_idle = 0, S_run = 1,s_categorize=2;
reg [31: 0] i, j,k,m;
reg [31: 0] minval,locmin;
reg tempassign,copyval, incr_j, incr_i, set_i, set_j,set_m,set_k,incr_m,incr_k,set_minval;
reg state, next_state;
output reg [31:0] count ;
integer resettervar;
wire gt = (minval > A[j]); 
wire dup= (A[m]==B[k-1]);

always @ (posedge clk) 
if (rst) state <= S_idle; 
else state <= next_state;


always @ (state or En or Ld or gt or i or j ) begin
tempassign = 0; incr_j=0; incr_i=0; set_i=0;  set_j=0; set_m=0; set_k=0; incr_m=0; incr_k=0; set_minval=0;
case (state)
S_idle: if (Ld) 
        begin next_state = S_idle; end
        else if (En)
        begin 
        next_state = S_run;
        set_minval=1;end
        else begin next_state = S_idle;end
S_run:  if (i >= N) 
        begin next_state = s_categorize; set_k = 1; set_m=1 ;set_minval=1; end
        else if (j >= N) 
        begin next_state = S_run; incr_i = 1; set_j=1;end
        else if (minval > A[j]) begin tempassign = 1; end
        else
        begin next_state = S_run; incr_j = 1; 
        end
        
s_categorize: 
        if (m >= N) 
        begin next_state = S_idle; count = k; done=1;set_i=1; set_j=1;set_m=1;set_k=1;end
        else if (dup) begin next_state = s_categorize;incr_m=1; end
        else 
        begin next_state = s_categorize; copyval=1;incr_m=1;incr_k=1;
        end
endcase
end

always @ (posedge clk) // Datapath and status registers
if (rst) begin i <= 0; j <= 0; m<=0 ; k<=0 ;
for (resettervar	=	0;	resettervar	<=	buff_size -1;	resettervar	=	resettervar+1)
begin
B[resettervar]	<=	0;
A[resettervar]	<=	0;
end
end
else if (Ld) begin 
i <= 0; j <= 0; m<=0 ; k<=0 ;
A[0]<=9;A[1] <= a1; A[2] <= a2; A[3] <= a3; A[4] <= a4;
A[5] <= a5; A[6] <= a6; A[7] <= a7; A[8] <= a8;
for (resettervar	=	9;	resettervar	<=	buff_size -1;	resettervar	=	resettervar+1)
A[resettervar]	<=	resettervar;
end
else begin /*#1 // Unit delay for display only; remove for synthesis */
if (tempassign) begin minval <= A[j]; locmin<=j; end
if (incr_j) j <= j+1;
if (incr_i) i <= i+1;
if (set_j) j <= 0;
if (set_i) i <= 0;
if (copyval) B[k]<= A[m];
if(set_m) m<=0;
if (set_k) k<=0;
if (incr_m) m<=m+1;
if(incr_k) k<=k+1;
if(set_minval) minval<=A[i];
end


endmodule