`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 09:17:01 AM
// Design Name: 
// Module Name: new_SRU_ruizhe
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


module new_SRU_simplified(

  input  clk,
  input  reset,
//  input [4:0] count,
  input  [15:0] w_old,
  input input_spike,
//  output reg [15:0] ES_plus,
  output reg [15:0] weight_sum
  
  
);

  always @(negedge clk) 
  
  begin
  if(!reset)
    weight_sum <= 0;
  else begin
    if(input_spike)
        weight_sum <= weight_sum + w_old;
  
  end
  
  end

endmodule
