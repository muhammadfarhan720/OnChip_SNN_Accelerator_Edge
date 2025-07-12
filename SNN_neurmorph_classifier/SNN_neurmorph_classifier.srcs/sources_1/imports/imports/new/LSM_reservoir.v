`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2023 03:42:53 AM
// Design Name: 
// Module Name: Reservoir_crossbar
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


module LSM_reservoir ( Ein_ext,spikes_in,clock,reset,write,
ST_and, CT_and, ST1,ST2,CT1,CT2,output_reg1,output_reg2
    );

parameter Spike_neurons=15;

parameter External_Ein=7;

parameter E_reg_width=15;


input [0:External_Ein] Ein_ext;

input [0:15] spikes_in;

input clock;

input reset;

input write;
//training signal
input ST_and; //new added for OE_STDP

input CT_and;

input ST1,ST2;

input CT1,CT2;
//input [0:15] parallel_Ein_exhibit;

//output wire flush_weight;

//output reg  [0:Spike_neurons] spike_record;

//output reg [0:E_reg_width] E_reg;

wire flush_weight;

reg [0:Spike_neurons] spike_record;
reg [0:E_reg_width] E_reg;
//reg [0:Spike_neurons]spike_middle;

reg [3:0] counter; // Create a 4-bit counter to count up to 16

wire reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14,reg15;

output output_reg1,output_reg2;

initial
begin
spike_record=16'd0;
E_reg=16'b1101011110010000;

end



//output [9:0] exhibitory_spikes;


Synaptic_Input_Processor Exhibitory_0 (.clock(clock),.reset(reset),.write(write),.parallel_spike_in({spikes_in[0:7],spike_record[8:15]}),.parallel_Ein({Ein_ext,E_reg[8:15]}) ,.flush_weight(flush_weight),.spike(reg0));


Synaptic_Input_Processor Exhibitory_1 (.clock(clock),.reset(reset),.write(write),.parallel_spike_in({spikes_in[8:15],spike_record[8:15]}),.parallel_Ein({Ein_ext,E_reg[8:15]}) ,.flush_weight(),.spike(reg1));


Synaptic_Input_Processor Exhibitory_2 (.clock(clock),.reset(reset),.write(write),.parallel_spike_in({spikes_in[0:7],spike_record[8:15]}),.parallel_Ein({Ein_ext,E_reg[8:15]}) ,.flush_weight(),.spike(reg2));


Synaptic_Input_Processor Exhibitory_3 (.clock(clock),.reset(reset),.write(write),.parallel_spike_in({spikes_in[8:15],spike_record[8:15]}),.parallel_Ein({Ein_ext,E_reg[8:15]}) ,.flush_weight(),.spike(reg3));


Synaptic_Input_Processor Exhibitory_4 (.clock(clock),.reset(reset),.write(write),.parallel_spike_in({spikes_in[0:7],spike_record[8:15]}),.parallel_Ein({Ein_ext,E_reg[8:15]}) ,.flush_weight(),.spike(reg4));



Synaptic_Input_Processor Exhibitory_5 (.clock(clock),.reset(reset),.write(write),.parallel_spike_in({spikes_in[8:15],spike_record[8:15]}),.parallel_Ein({Ein_ext,E_reg[8:15]}) ,.flush_weight(),.spike(reg5));



Synaptic_Input_Processor Exhibitory_6 (.clock(clock),.reset(reset),.write(write),.parallel_spike_in({spikes_in[0:7],spike_record[8:15]}),.parallel_Ein({Ein_ext,E_reg[8:15]}) ,.flush_weight(),.spike(reg6));



Synaptic_Input_Processor Exhibitory_7 (.clock(clock),.reset(reset),.write(write),.parallel_spike_in({spikes_in[8:15],spike_record[8:15]}),.parallel_Ein({Ein_ext,E_reg[8:15]}) ,.flush_weight(),.spike(reg7));




Synaptic_Input_Processor Exhibitory_8 (.clock(clock),.reset(reset),.write(write),.parallel_spike_in({spikes_in[0:7],spike_record[0:7]}),.parallel_Ein({Ein_ext,E_reg[0:3],E_reg[12:15]}) ,.flush_weight(),.spike(reg8));




Synaptic_Input_Processor Exhibitory_9 (.clock(clock),.reset(reset),.write(write),.parallel_spike_in({spikes_in[8:15],spike_record[0:7]}),.parallel_Ein({Ein_ext,E_reg[0:3],E_reg[12:15]}) ,.flush_weight(),.spike(reg9));





Synaptic_Input_Processor Exhibitory_10 (.clock(clock),.reset(reset),.write(write),.parallel_spike_in({spikes_in[0:7],spike_record[0:7]}),.parallel_Ein({Ein_ext,E_reg[0:3],E_reg[12:15]}) ,.flush_weight(),.spike(reg10));





Synaptic_Input_Processor Exhibitory_11 (.clock(clock),.reset(reset),.write(write),.parallel_spike_in({spikes_in[8:15],spike_record[0:7]}),.parallel_Ein({Ein_ext,E_reg[0:3],E_reg[12:15]}) ,.flush_weight(),.spike(reg11));






Synaptic_Input_Processor Inhibitory_12 (.clock(clock),.reset(reset),.write(write),.parallel_spike_in({spikes_in[0:7],spike_record[0:7]}),.parallel_Ein({Ein_ext,E_reg[4:7],E_reg[12:15]}) ,.flush_weight(),.spike(reg12));





Synaptic_Input_Processor Inhibitory_13 (.clock(clock),.reset(reset),.write(write),.parallel_spike_in({spikes_in[8:15],spike_record[0:7]}),.parallel_Ein({Ein_ext,E_reg[4:7],E_reg[12:15]}) ,.flush_weight(),.spike(reg13));





Synaptic_Input_Processor Inhibitory_14 (.clock(clock),.reset(reset),.write(write),.parallel_spike_in({spikes_in[0:7],spike_record[0:7]}),.parallel_Ein({Ein_ext,E_reg[4:7],E_reg[12:15]}) ,.flush_weight(),.spike(reg14));




Synaptic_Input_Processor Inhibitory_15 (.clock(clock),.reset(reset),.write(write),.parallel_spike_in({spikes_in[8:15],spike_record[0:7]}),.parallel_Ein({Ein_ext,E_reg[4:7],E_reg[12:15]}) ,.flush_weight(),.spike(reg15));


//always @(negedge clock)

//begin

//spike_record={reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14,reg15};

//end

always @(negedge clock) begin
  if (reset) begin
    // Reset the counter and spike_record when a reset signal is asserted
  //  counter <= 4'b0;
    spike_record <= 16'b0;
  end else begin
    if (flush_weight == 1) begin
      // When the counter reaches 16 (binary 1111), update spike_record
      spike_record <= {reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15};
  //    counter <= 4'b0; // Reset the counter to 0
    end 
//    else begin
//      // Increment the counter on each clock cycle
//      counter <= counter + 1'b1;
//    end
  end
end


OE_layer output_layer(
.clock(clock),.reset(reset),.write(write),.flush_weight1(),.flush_weight2()
,.flush_Ein1(),.flush_Ein2(),.flush_spike1(),.flush_spike2()
, .spike_record(spike_record),.E_reg(16'hFFF0),.ST1(ST1),.ST2(ST2),.CT1(CT1),.CT2(CT2),.ST_and(ST_and)
,.CT_and(CT_and),.select1(),.select2(),.reg1(output_reg1),.reg2(output_reg2)
    );


endmodule
