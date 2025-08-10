`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2023 12:21:22 PM
// Design Name: 
// Module Name: SRU_EP_EN_IP_IN
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


module SRU_EP_EN_IP_IN_OE(

  input  clk,
  input  reset,
//  input [4:0] count,
  input     [15:0] wi,
  input  E_plus,
  input  Ein,
  input spike,
//  output reg [15:0] ES_plus,
  output reg   [15:0] ES_plus_reg,
  
  output reg    [15:0] ES_minus_reg,
  
  output reg    [15:0] IS_plus_reg,
  
  output reg    [15:0] IS_minus_reg
  
);
 // reg [15:0] ES_plus_reg;
//  reg [15:0] sum;



initial
begin
ES_plus_reg<=0;
ES_minus_reg<=0;
IS_plus_reg <= 0;
IS_minus_reg<=0;
end


  always @(negedge clk) 
  
  begin
  if (reset) begin
	ES_plus_reg <= 16'b0;
      ES_minus_reg<=16'b0;
      IS_plus_reg <= 16'b0;
      IS_minus_reg<=16'b0;
  end
  else begin
     if (E_plus==1 & reset==0 & Ein==1)
     begin
      ES_plus_reg <= ES_plus_reg-(ES_plus_reg >> 2)+(wi <<5) ; //why we left shift the weight by 5 instead of 1
      
      ES_minus_reg <= ES_minus_reg-(ES_minus_reg >> 3)+(wi<<5) ;
      
     end      
     
     
   else if (E_plus==0 & reset==0 & Ein==1)
   begin
      ES_plus_reg <= ES_plus_reg-(ES_plus_reg >> 2);
      
      ES_minus_reg <= ES_minus_reg-(ES_minus_reg >> 3) ;
   end
   
   
   else if (E_plus==1 & reset==0 & Ein==0)
   begin
      IS_plus_reg <= IS_plus_reg-(IS_plus_reg >> 2)+(wi<<5);
      
      IS_minus_reg <= IS_minus_reg-(IS_minus_reg >> 1)+(wi<<5) ;
   end
   
   
     
   else if (E_plus==0 & reset==0 & Ein==0)
   begin
      IS_plus_reg <= IS_plus_reg-(IS_plus_reg >> 2);
      
      IS_minus_reg <= IS_minus_reg-(IS_minus_reg >> 1) ;
   end
   
   end
 //     ES_plus <= ES_plus_reg;
//      sum <= 16'b0;
//     end  begin
      // Calculate the sum of (wi * E_plus) for next 16 clock cycles
      
//      sum <= sum + (wi & E_plus);
      
      // Update ES_plus using the equation

   //   sum<=0; 
      end
 //   end
 // end

//  assign ES_plus = ES_plus_reg;

endmodule
