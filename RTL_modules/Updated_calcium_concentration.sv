`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2023 05:46:58 AM
// Design Name: 
// Module Name: Updated_calcium_concentration
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


module Updated_calcium_concentration(clock,reset,ST_and,CT_and,spike,time_difference,calcium_status

    );


input clock;

input reset;

input ST_and;

input CT_and;


input spike;

input signed [4:0] time_difference;

output reg calcium_status;

wire Potentiation_depression_status;

reg [9:0] calcium_level;

integer ctheta=320; //Value 5 is shifted 6 times left in binary mode

integer delta=192; //Value 3 is shifted 6 times left in binary mode




//initial 

//begin

//calcium_status<=1;

//calcium_level<=0;

//end



assign Potentiation_depression_status = (time_difference >0)?1'b1 :1'b0;  //if potentiation happens, status=1 otherwise 0


always @(negedge clock)

begin

if(reset)

    begin
    
    //calcium_status<=1;
    
    calcium_level<=0;
    
    
 end
    

else
    
    begin
    if(spike==1 && (calcium_level<=960))
    
    calcium_level<= calcium_level -(calcium_level>>6)+ 10'b0001000000;  //Shift spike to left by 6 bits (For fractional calculation)
    
    else if (spike==0)
    
    calcium_level<= calcium_level -(calcium_level>>6);
    
    end
    
    end




always @(*)

begin

if (CT_and==1 && ST_and==0)  //Sparsification scale

    begin
    
     if (Potentiation_depression_status)
         begin
          if (calcium_level<(ctheta+delta))
            
            calcium_status=1;
            
          else
            
            calcium_status=0;
              
         end
    
     else 
         begin
        
          if (calcium_level>(ctheta-delta))
            
            calcium_status=1;
            
          else
            
            calcium_status=0;
        
         end
    
    end

else if (CT_and==0 && ST_and==1) //Classification stage
    
    begin
    
     if(Potentiation_depression_status)
         begin
         
          if((ctheta < calcium_level) && (calcium_level < (ctheta + delta)))
          
           calcium_status=1;
           
          else
           
           calcium_status=0;
           
         end  
        
     else
          begin
         
          if(((ctheta - delta) < calcium_level) && (calcium_level < ctheta))
        
           calcium_status=1;
           
          else
          
           calcium_status=0;
           
          end  
    
    end

end







endmodule
