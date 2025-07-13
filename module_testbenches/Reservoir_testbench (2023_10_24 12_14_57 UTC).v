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

reg [0:15] spikes_in;

reg clock;

reg reset;

reg write;

//input [0:15] parallel_Ein_exhibit;

wire flush_weight;

wire   [0:Spike_neurons] spike_record;

wire [0:E_reg_width] E_reg;

Reservoir_crossbar reservoir (Ein_ext,spikes_in,clock,reset,write,flush_weight,spike_record,E_reg);


initial
begin

Ein_ext=8'b11111111;

reset=0;

spikes_in=16'b1011110111110110;

write=1;

end

always 

forever begin

#5 clock=~clock;

end




//reg [0:Spike_neurons]spike_middle;

//wire reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14,reg15;





endmodule
