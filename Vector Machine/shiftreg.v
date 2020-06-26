module shifter#(parameter word_size=24) (  input [word_size-1:0] d,                      // Declare input for data to the first flop in the shift register
                                        //input clk,                    // Declare input for clock to all flops in the shift register
                                        input [7:0]exponent,                     // Declare input for enable to switch the shift register on/off
                                        //input rstn,                   // Declare input to reset the register to a default value
                                        output [word_size-1:0] out);    // Declare output to read out the current value of all flops in this register
 
 
   // This always block will "always" be triggered on the rising edge of clock
   // Once it enters the block, it will first check to see if reset is 0 and if yes then reset register
   // If no, then check to see if the shift register is enabled
   // If no => maintain previous output. If yes, then shift based on the requested direction
    //reg [7:0] shiftammount;
    //reg [word_size-1:0] result;
//    always @(clk,rstn)
//    begin
//          if (rstn)
//          begin 
//          result<= d;
//          out <= 0;
//          shiftammount<=0;
//          end
//    shiftammount<=exponent;
//    result<=d;
//    end
//    always @ (shiftammount)
//     begin
//         if (shiftammount==0)
//         out<=result;
//         else if (shiftammount>0)
//          begin
         
//             shiftammount<= shiftammount-1;
//             result<={result[22:1],1'b0}; //lower to greater
    
//          end
//       end


assign out = d << exponent; 


endmodule