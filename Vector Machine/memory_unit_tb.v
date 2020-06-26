module memorytb();

wire [23:0] data_out1,data_out2;
reg [8:0] address1,address2;
reg load;
Memory_Unit Mem (data_out1,data_out2, address1,address2,load);

initial #100 $finish;

initial fork

address1 =0; #9
address1 =1; #19
address1 =88;
join
initial fork
address2 =2; #9
address2 =30; #19
address2 =77;
join
initial fork
load=1;
join
endmodule