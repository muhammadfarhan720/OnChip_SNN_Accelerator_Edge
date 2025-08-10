`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2023 12:43:34 PM
// Design Name: 
// Module Name: Reservoir_testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Reservoir_testbench;


parameter Spike_neurons=15;

parameter External_Ein=7;

parameter E_reg_width=15;


reg [0:External_Ein] Ein_ext;

reg [0:Spike_neurons] spikes_in;

reg clock;

reg reset;

reg write;

reg ST_and; //new added for OE_STDP

reg CT_and;

reg ST1,ST2;

reg CT1,CT2;
//input [0:15] parallel_Ein_exhibit;

wire output_reg1, output_reg2;

//wire  [0:Spike_neurons] spike_record;

//wire [0:E_reg_width] E_reg;

LSM_reservoir reservoir (Ein_ext,spikes_in,clock,reset,write,ST_and, CT_and, ST1,ST2,CT1,CT2,output_reg1,output_reg2);


initial
begin

Ein_ext=8'b11111111;

reset=0;

spikes_in=16'b1011110000110010
;



clock=1;

#5
reset=1;
#10
reset=0;

end

always 

forever begin

#5 clock=~clock;

end


initial 
begin
ST_and <=0;
CT_and <=1;
#9500000;
ST_and<=1;
CT_and <= 0;

end
initial 
begin
ST1 <=1;
ST2 <=0;
#9500000;
ST1 <= 1;
ST2 <=1;

end

initial 
begin
CT1<=1;
CT2<=1;
#9500000;
CT1<=1;
CT2 <= 0; 

end

//reg [0:Spike_neurons]spike_middle;

//wire reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14,reg15;

initial begin
write <= 1;

#19500000;

write<= 0;
end


endmodule
