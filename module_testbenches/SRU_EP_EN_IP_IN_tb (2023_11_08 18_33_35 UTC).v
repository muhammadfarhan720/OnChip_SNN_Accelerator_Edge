`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2023 01:54:25 PM
// Design Name: 
// Module Name: SRU_EP_EN_IP_IN_tb
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
module SRU_EP_EN_IP_IN_tb;

  reg clk;
  reg reset;
//  reg [4:0] count;
  reg E_plus; //spike input
  reg [3:0] wi;
//  wire [15:0] ES_plus;
  wire [15:0] ES_plus_reg;
  
  reg Ein; //For determining exhibitory or inhibitory neuron
  
  wire [15:0] ES_minus_reg;
  
  wire [15:0] IS_plus_reg;
  
  wire [15:0] IS_minus_reg;

  SRU_EP_EN_IP_IN dut (
    .clk(clk),
    .reset(reset),
    .E_plus(E_plus),
//    .count(count),
    .wi(wi),
    .Ein(Ein),
//    .ES_plus(ES_plus),
    .ES_plus_reg(ES_plus_reg),
    .ES_minus_reg(ES_minus_reg),
    .IS_plus_reg(IS_plus_reg),
    .IS_minus_reg(IS_minus_reg)
    
    
  );
  
initial 
begin
E_plus<=0;
#10;
E_plus<=1;

#110

E_plus<=0;
end

initial 
begin
Ein<=1;
//#10;
//Ein<=0;

//#112

//Ein<=0;
end



  

  initial begin
    clk = 0;
    reset = 1;
  //  count = 0;
    wi = 0;

    // Toggle the reset signal for 10 clock cycles
    repeat (10) begin
      #5 clk = ~clk;
    end
    reset = 0; // Assert reset signal


    // Provide test inputs and monitor outputs
    repeat (16) begin
      #5 clk = ~clk; // Toggle clock
      #5 wi = wi + 1; // Increment wi value
      
      $display("ES_plus_reg = %h", ES_plus_reg);
       $display("ES_minus_reg = %h", ES_minus_reg);
    end

//reset=1;


    $finish;
  end

  always #5 clk = ~clk; // Generate clock signal

endmodule
