module Bubble_Sort #(parameter buff_size=128)(A1,En, Ld, clk, rst);
output [31:0] A1,B [0:buff_size-1];
input En, Ld, clk, rst;
parameter N = 8;
parameter word_size = 31;
parameter a1 = 8, a2 = 1, a3 = 8, a4 = 1, a5 = 8, a6 = 1, a7 = 8, a8 = 1;
reg [word_size -1: 0] A [1: N]; // Array of words
wire [3:0] A1 = A[1], A2 = A[2], A3 = A[3], A4 = A[4];
wire [3:0] A5 = A[5], A6 = A[6], A7 = A[7], A8 = A[8];
parameter S_idle = 0, S_run = 1,s_categorize=2;
reg [31: 0] i, j,k,m;
reg [31: 0] minval,locmin;
reg swap, incr_j, incr_i, set_i, set_j,set_m,set_k,incr_m,incr_k;
reg state, next_state;
integer resettervar;
wire gt = (temp > A[j]); 
wire dup=(A[m]==B[k-1])
reg done; 


always @ (posedge clk) 
if (rst) state <= S_idle; 
else state <= next_state;


always @ (state or En or Ld or gt or i or j ) begin
swap = 0; incr_j=0; incr_i=0; set_i=0;  set_j=0; set_m=0; set_k=0; incr_m=0; incr_k=0;
case (state)
S_idle: if (Ld) 
        begin next_state = S_idle; end
        else if (En)
        begin 
        next_state = S_run;
        if (gt)
        begin swap = 1; incr_j = 1; end 
        else next_state = S_idle;
        end
S_run:  if (i >= N) 
        begin next_state = s_categorize; set_k = 1; set_m=1;end
        else if (j >= N) 
        begin next_state = S_run; incr_i = 1; set_j=1;end
        if (gt) swap = 1; end
        else
        begin next_state = S_run; incr_j = 1; 
        end
        
s_categorize: 
        if (m >= N) 
        begin next_state = S_idle; count = k; Done=1;
        if (gt) swap = 1; end
        else if (i <= N) 
        begin next_state = S_run; set_j = 1; incr_i = 1; 
        end
        else 
        begin next_state = s_categorize; set_j = 1; set_i = 1; 
        end

endcase
end

always @ (posedge clk) // Datapath and status registers
if (rst) begin i <= 0; j <= 0; m<=0 ; k<=0 ;
for (resettervar	=	0;	resettervar	<=	buff_size -1;	resettervar	=	resettervar+1)
A[resettervar]	<=	0;
end
else if (Ld) begin 
i <= 0; j <= 0; m<=0 ; k<=0 ;
A[1] <= a1; A[2] <= a2; A[3] <= a3; A[4] <= a4;
A[5] <= a5; A[6] <= a6; A[7] <= a7; A[8] <= a8;
for (resettervar	=	9;	resettervar	<=	buff_size -1;	resettervar	=	resettervar+1)
A[resettervar]	<=	resettervar;
end
else begin /*#1 // Unit delay for display only; remove for synthesis */
if (tempassign) begin minval <= A[j]; locmin j; end
if (incr_j) j <= j+1;
if (incr_i) i <= i+1;
if (set_j) j <= N;
if (set_i) i <= 2;
end
endmodule