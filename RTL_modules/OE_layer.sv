`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2023 10:28:24 PM
// Design Name: 
// Module Name: OE_layer
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


module OE_layer(
clock,reset,write,flush_weight1,flush_weight2
,flush_Ein1,flush_Ein2,flush_spike1,flush_spike2
, spike_record,E_reg,ST1,ST2,CT1,CT2,ST_and
,CT_and,select1,select2,reg1,reg2
    );
    parameter Spike_neurons=15;

//parameter External_Ein=7;

parameter E_reg_width=15;
    
//input [0:External_Ein] Ein_ext;


input clock;

input reset;

input write;

input ST_and; //new added for OE_STDP

input CT_and;

input ST1,ST2;

input CT1,CT2;
//input [0:15] parallel_Ein_exhibit;

output reg flush_weight1, flush_weight2;

input [0:Spike_neurons] spike_record;

input [0:E_reg_width] E_reg;

output reg flush_Ein1,flush_Ein2;

output reg flush_spike1,flush_spike2;

output [3:0] select1, select2;
output reg1, reg2;
    
Synaptic_Input_Processor_OE Exhibitory_0 (.clock(clock),.reset(reset),.write(write),.ST_and(ST_and),.CT_and(CT_and),.ST(ST1),.CT(CT1),.select(select1),.parallel_spike_in(spike_record),.parallel_Ein(E_reg) ,.flush_weight(flush_weight1),.flush_Ein(flush_Ein1),.flush_spike(flush_spike1),.spike(reg1));


Synaptic_Input_Processor_OE Exhibitory_1 (.clock(clock),.reset(reset),.write(write),.ST_and(ST_and),.CT_and(CT_and),.ST(ST2),.CT(CT2),.select(select2),.parallel_spike_in(spike_record),.parallel_Ein(E_reg) ,.flush_weight(flush_weight2),.flush_Ein(flush_Ein2),.flush_spike(flush_spike2),.spike(reg2));
endmodule
