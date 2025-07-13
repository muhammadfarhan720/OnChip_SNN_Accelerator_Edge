`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/03/2023 12:33:02 PM
// Design Name: 
// Module Name: SIP_tb
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


//module SIP_tb;


//reg clock;  

//reg reset;  

////reg [15:0]Er; //For selecting inhibitory or exhibitory presynaptic neuron

////input [15:0]Sin; //For incoming spikes from presynapses (Either internal or external)

////reg  [3:0] weight;

////output reg [15:0] EP, EN, IP, IN;

//reg [3:0] parallel_in_weight[0:15];

//reg [15:0] parallel_spike_in;

//reg [15:0] parallel_Ein;

//wire  flush_weight;

//wire  flush_Ein;

//wire  flush_spike;




    
//endmodule




module SIP_tb;

  reg clock;  
  reg reset;
  reg write;  
  reg [3:0] parallel_in_weight[0:15];
  reg [15:0] parallel_spike_in;
  reg [15:0] parallel_Ein;
  reg ST_and, CT_and, ST, CT;
  
  wire flush_weight;
  wire flush_Ein;
  wire flush_spike;
  
  wire spike;
//  reg load;
  
  wire [3:0] select;
//  wire toggle;
//  wire [3:0] weight_new2;

Synaptic_Input_Processor SIP_LIF (clock,reset,write,ST_and, CT_and, ST, CT, parallel_spike_in,parallel_Ein,flush_weight,flush_Ein,flush_spike,spike,select);
initial begin
write = 0;
#150;
write = 1;
end

  initial begin
    clock = 0;
    reset = 0;
    
    #50 reset = 1;
//    load=1;
    
    #100 reset = 0; // De-assert reset after 5 time units
//    load=0;
    #100;
    
    
    // Sending initial data to parallel_in_weight, parallel_spike_in, and parallel_Ein arrays
//    for (int i = 0; i < 16; i=i+1) begin
//      parallel_in_weight[i] = i; // Sending values 0 to 15 in parallel_in_weight array
//    end
    parallel_spike_in = 16'b1010101010101010; // Sending binary pattern 1010101010101010 to parallel_spike_in
    parallel_Ein = 16'b1111111111110000; // Sending all 1's to parallel_Ein
end
   
   
   always 
   begin    
//    if (flush_weight==1)
//    begin
    // Sending new data after flush signals are asserted
//    for (int i = 0; i < 16; i=i+1) begin
//      parallel_in_weight[i] = i*2; // Sending values 0 to 30 in parallel_in_weight array
//    end
    
//    end
    
    if(flush_spike==1)
    begin
    parallel_spike_in = 16'b1101010101011101; // Sending binary pattern 0101010101010101 to parallel_spike_in
    end
    
//    if(flush_Ein==1)
//    begin
//    parallel_Ein = 16'hAAAA; // Sending alternating pattern 1010101010101010 to parallel_Ein
//    end
//    #100;

    #100;
 //   $finish; // End simulation
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
ST <=1;
//#5000;
//ST <= 0;
//#6000;
//ST <= 1; 

end

initial 
begin
CT<=1;
//#5000;
//CT<=0;
//#1000;
//CT <= 1; 

end
  always #50 clock = ~clock; // 20mHz

  // Rest of the SIP_tb code

endmodule
