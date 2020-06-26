
module Shiftertb ();
parameter word_size=24;
reg [word_size-1:0] d; 
wire [word_size-1:0] out;
reg [7:0]  exponent;
// reg clk, rst;

shifter #(word_size) Shiftme (  d,                      // Declare input for data to the first flop in the shift register
                                        //  clk,                    // Declare input for clock to all flops in the shift register
                                         exponent,                     // Declare input for enable to switch the shift register on/off
                                        // rst,                   // Declare input to reset the register to a default value
                                        out);    // Declare output to read out the current value of all flops in this register
 
// each initial applies inputs one at a time

initial #1000 $finish;

//  initial 
//  begin clk = 0; 
//  forever #10 clk = ~clk; 
//  end
initial fork
exponent=1;
#3 exponent=4;
#15 exponent=2;
join
// initial fork
//      rst=0; #1
//      rst=1;#2
//      rst=0;
// join
initial fork
     d=32; #9
     d=2;#19
     d=8;
join
 
endmodule