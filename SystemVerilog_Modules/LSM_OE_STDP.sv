`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/15/2023 11:07:03 PM
// Design Name: 
// Module Name: LSM_OE_STDP
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


module LSM_OE_STDP(

input write,

input clock,

input rst, //new added

input postsynapSR0,

input presynapSR1,

input presynapSR2,

input presynapSR3,
input presynapSR4,
input presynapSR5,
input presynapSR6,
input presynapSR7,
input presynapSR8,
input presynapSR9,
input presynapSR10,
input presynapSR11,
input presynapSR12,
input presynapSR13,
input presynapSR14,
input presynapSR15,
input presynapSR16,
input ST_and,

input CT_and,
input spike,
input ST,

input CT,

input [3:0] select,

//output postreg,preonereg,pretworeg,mux_synapse,time_difference,mux_out_LTP,mux_out_LTD,weight_change,rnd_num,ENA,weight_old, weight_new, adder_control,mux_out_probability);
 output wire   [15:0] weight_old, 
 output wire   [15:0] weight_new,
 output reg   [15:0] dataArray[0:15]) ;
  
wire signed [15:0]  weight_change;  ///The output weight_delta_mux_OE is saved here but the output of the module inside the module is delcared as reg 
reg   [15:0]  weight_change_d1; 
reg   [15:0] weight_new_pos_2;   
reg   [15:0] weight_old_pos_2;
wire [15:0] postreg;

wire [15:0] preonereg;

wire [15:0] pretworeg,prethreereg,prefourreg, prefivereg, presixreg, presevenreg, preeightreg, 
preninereg, pretenreg, preelevenreg, pretwelvereg, prethirteenreg, prefourteenreg, prefifteenreg,presixteenreg ;

wire [7:0] rnd_num;

//wire [7:0] rand_dumm;

wire [15:0]mux_synapse;
wire select_mux_LTP;
wire   [4:0] mux_out_LTP;

wire ENA;
wire select_mux_LTD;
wire   [4:0] mux_out_LTD;

//wire [3:0] select;
reg [3:0] select_read=0;
reg [3:0] select_read_d1;
reg [3:0] select_write;
wire   [4:0] time_difference;
//reg   [4:0] time_difference_d1;

wire [7:0] probability_output_LTP;


wire [7:0] probability_output_LTD;

wire [7:0] mux_out_probability;

//reg   [9:0] dataArray[0:15];

integer i;

//reg   [9:0] weight_old;

//reg   [9:0] weight_new;


wire adder_control;
reg adder_control_d1;

//new added
wire select_mux_weight_change;
wire calcium_status;


Shiftright_OE zero(.rst(rst),.write(write), .Serial_in(postsynapSR0),.Clock(clock),.Q(postreg));
Shiftright_OE one(.rst(rst),.write(write),.Serial_in(presynapSR1),.Clock(clock),.Q(preonereg));
Shiftright_OE two(.rst(rst),.write(write),.Serial_in(presynapSR2),.Clock(clock),.Q(pretworeg)); 
//new added
Shiftright_OE three(.rst(rst),.write(write),.Serial_in(presynapSR3),.Clock(clock),.Q(prethreereg)); 
Shiftright_OE four(.rst(rst),.write(write),.Serial_in(presynapSR4),.Clock(clock),.Q(prefourreg)); 
Shiftright_OE five(.rst(rst),.write(write),.Serial_in(presynapSR5),.Clock(clock),.Q(prefivereg)); 
Shiftright_OE six(.rst(rst),.write(write),.Serial_in(presynapSR6),.Clock(clock),.Q(presixreg)); 
Shiftright_OE seven(.rst(rst),.write(write),.Serial_in(presynapSR7),.Clock(clock),.Q(presevenreg)); 
Shiftright_OE eight(.rst(rst),.write(write),.Serial_in(presynapSR8),.Clock(clock),.Q(preeightreg)); 
Shiftright_OE nine(.rst(rst),.write(write),.Serial_in(presynapSR9),.Clock(clock),.Q(preninereg)); 
Shiftright_OE ten(.rst(rst),.write(write),.Serial_in(presynapSR10),.Clock(clock),.Q(pretenreg)); 
Shiftright_OE eleven(.rst(rst),.write(write),.Serial_in(presynapSR11),.Clock(clock),.Q(preelevenreg)); 
Shiftright_OE twelve(.rst(rst),.write(write),.Serial_in(presynapSR12),.Clock(clock),.Q(pretwelvereg)); 
Shiftright_OE thirteen(.rst(rst),.write(write),.Serial_in(presynapSR13),.Clock(clock),.Q(prethirteenreg)); 
Shiftright_OE fourteen(.rst(rst),.write(write),.Serial_in(presynapSR14),.Clock(clock),.Q(prefourteenreg)); 
Shiftright_OE fifteen(.rst(rst),.write(write),.Serial_in(presynapSR15),.Clock(clock),.Q(prefifteenreg)); 
Shiftright_OE sixteen(.rst(rst),.write(write),.Serial_in(presynapSR16),.Clock(clock),.Q(presixteenreg)); 


MUX_OE mux_one(.mux_in_1(preonereg),
.mux_in_2(pretworeg),
.mux_in_3(prethreereg),
.mux_in_4(prefourreg),
.mux_in_5(prefivereg),
.mux_in_6(presixreg),
.mux_in_7(presevenreg),
.mux_in_8(preeightreg),
.mux_in_9(preninereg),
.mux_in_10(pretenreg),
.mux_in_11(preelevenreg),
.mux_in_12(pretwelvereg),
.mux_in_13(prethirteenreg),
.mux_in_14(prefourteenreg),
.mux_in_15(prefifteenreg),
.mux_in_16(presixteenreg),
.sel(select),
.mux_out(mux_synapse));

difference_OE comparator1 (.datapre(mux_synapse),.datapost(postreg),.out(time_difference));


MUX_time_difference_OE Mux_LTP (.mux_in_1(0),.mux_in_2(time_difference),.sel(select_mux_LTP),.mux_out(mux_out_LTP));

MUX_time_difference_OE Mux_LTD (.mux_in_1(0),.mux_in_2(time_difference),.sel(select_mux_LTD),.mux_out(mux_out_LTD));



/////////////////////////////////////////////////////////////////////////////////////////////////////////
assign select_mux_LTD= (ST & time_difference[4]);


assign select_mux_LTP= (ST & !(time_difference[4]));


assign select_mux_weight_change= (CT & (time_difference[4]));


//instantiate calcium concentration
Updated_calcium_concentration calcium(.clock(clock), .reset(rst),.spike(spike), .ST_and(ST_and),.CT_and(CT_and),.time_difference(time_difference), .calcium_status(calcium_status));

/////////////////////////////////////////////////////////////////////////////////////////////////////////

weight_delta_mux_OE delta (.sel(select_mux_weight_change),.output_weight_change(weight_change));


LTP_LUT_OE dummy_LTP (.time_difference(mux_out_LTP), .weight_update_probability (probability_output_LTP));   


LTD_LUT_OE dummy_LTD (.time_difference(mux_out_LTD), .weight_update_probability (probability_output_LTD));   

MUX_probability_OE prob_mux (.mux_in_1(probability_output_LTP),.mux_in_2(probability_output_LTD),.sel(time_difference[4]),.mux_out(mux_out_probability));

Random_OE rng (.clk(clock),.random_number(rnd_num));

//assign rand_dumm=rnd_num;

difference_RNG_OE comparator2 (.mux_input(mux_out_probability), .RNG_input(rnd_num), .compared_output(ENA));

assign adder_control= (ENA & calcium_status); //new modified (ENA & Calcium);

always@(negedge clock)
  
 begin
     
     if(rst)
   begin
   for (i = 0; i < 16; i = i + 1)
    begin
         dataArray[i] <= 16'd2; // sob value by default 2 save korba
    end
    end
  
//  if(select!=0)
   
 //  select_minus<=select+1;
  select_read<=select+1;
  //select_read_d1 <= select_read;
//  select_write<=select_read;
  //weight_change_d1 <= weight_change;
  //adder_control_d1 <= adder_control;
   if(write==1&rst==0  )
  // //if(adder_control_d1)
   dataArray[select_read]<=weight_new_pos_2;
   
   
  end   




//Newly added from STDP design 

always @(posedge clock)
begin
    weight_new_pos_2<=weight_new;

end
//Newly added from STDP design 

//always @(negedge clock) 
// begin
//       //if(!write)
//if(rst)
//   begin
//   for (i = 0; i < 16; i = i + 1)
//    begin
//         dataArray[i] <= 16'd2; // sob value by default 2 save korba
//    end
//    end
   
//   //weight_old<=dataArray[select];
         
//end
  assign weight_old=dataArray[select]; 
//ControlledAdder ALU (.operand1(weight_old),.operand2(weight_change),.control_bit(adder_control),.new_result(weight_new));
ControlledAdder_OE ALU (.operand1(weight_old),.operand2(weight_change),.control_bit(adder_control),.new_result(weight_new));
    


endmodule       




module Shiftright_OE( 
input Serial_in, 
input Clock, 
input write,
input rst,

output reg [15:0]Q );

 
always @ (negedge Clock) 
begin 
if (rst)
	Q<= 16'b0;
else begin
	if(write)
		Q<={Serial_in, Q[15:1]}; 
end //end else
end // always 
endmodule 





module MUX_OE(mux_in_1,mux_in_2,mux_in_3, mux_in_4, mux_in_5, mux_in_6, mux_in_7, mux_in_8, mux_in_9
,mux_in_10,mux_in_11, mux_in_12, mux_in_13, mux_in_14, mux_in_15,mux_in_16
,sel,mux_out);
input [15:0] mux_in_1,mux_in_2,mux_in_3, mux_in_4, mux_in_5, mux_in_6, mux_in_7, mux_in_8, mux_in_9;
input [15:0] mux_in_10,mux_in_11, mux_in_12, mux_in_13, mux_in_14, mux_in_15,mux_in_16;


input [3:0]sel;
output reg [15:0] mux_out;

always @(*)
/*if(sel==1'b0)
begin
mux_out<=mux_in_1;  //eikhane case statement use kore 16 ta mux_in use korte hobe
end
else
begin
mux_out<=mux_in_2;
end*/
begin
 case (sel)
      4'b0000: mux_out = mux_in_1;
      4'b0001: mux_out = mux_in_2;
	  4'b0010: mux_out = mux_in_3;
	  4'b0011: mux_out = mux_in_4;
	  4'b0100: mux_out = mux_in_5;
	  4'b0101: mux_out = mux_in_6;
	  4'b0110: mux_out = mux_in_7;
	  4'b0111: mux_out = mux_in_8;
	  4'b1000: mux_out = mux_in_9;
	  4'b1001: mux_out = mux_in_10;
	  4'b1010: mux_out = mux_in_11;
	  4'b1011: mux_out = mux_in_12;
	  4'b1100: mux_out = mux_in_13;
	  4'b1101: mux_out = mux_in_14;
	  4'b1110: mux_out = mux_in_15;
	  4'b1111: mux_out = mux_in_16;
	  default:mux_out = 16'bx;

      
   endcase
   
   end   

 
endmodule
    


module MUX_time_difference_OE(mux_in_1,mux_in_2,sel,mux_out);
input   [4:0] mux_in_1;
input   [4:0] mux_in_2;


input sel;
output reg   [4:0] mux_out;

always @(*)
/*if(sel==1'b0)
begin
mux_out<=mux_in_1;  //eikhane case statement use kore 16 ta mux_in use korte hobe
end
else
begin
mux_out<=mux_in_2;
end*/
begin
 case (sel)
      1'b0: mux_out = mux_in_1;
      1'b1: mux_out = mux_in_2;

      
 endcase
   
end   

 
endmodule



module MUX_probability_OE(mux_in_1,mux_in_2,sel,mux_out);
input [7:0] mux_in_1;
input [7:0] mux_in_2;


input sel;
output reg [7:0] mux_out;

always @(*)

/*if(sel==1'b0)
begin
mux_out<=mux_in_1;  //eikhane case statement use kore 16 ta mux_in use korte hobe
end
else
begin
mux_out<=mux_in_2;
end*/
begin
 case (sel)
      1'b0: mux_out = mux_in_1;
      1'b1: mux_out = mux_in_2;

      
   endcase
   
   end   

 
endmodule





module difference_OE(datapre,datapost,out);

input [15:0]datapre;
input [15:0]datapost;
reg [15:0]data;
output reg   [4:0]out;  // Changed 3 --> 5 bit for   and for up until to 12 


always@(*)
begin


if(datapost[15]==1)

begin
data<=datapre;
//else
//data<=0;

casex(data)

  
  16'b0000000000001xxx:out<=5'b01100;
  
  16'b000000000001xxxx:out<=5'b01011;
  
  16'b00000000001xxxxx:out<=5'b01010;
  
  16'b0000000001xxxxxx:out<=5'b01001;
  
  16'b000000001xxxxxxx:out<=5'b01000;
  
  16'b00000001xxxxxxxx:out<=5'b00111;
  
  16'b0000001xxxxxxxxx:out<=5'b00110;
  
  16'b000001xxxxxxxxxx:out<=5'b00101;
  
  16'b00001xxxxxxxxxxx:out<=5'b00100; 
   
  16'b0001xxxxxxxxxxxx:out<=5'b00011;
  
  
  16'b001xxxxxxxxxxxxx:out<=5'b00010;
  
  
  16'b01xxxxxxxxxxxxxx:out<=5'b00001;
  
  
  16'b1xxxxxxxxxxxxxxx:out<=5'b00000;
  
  default:out<=5'b00000;
 endcase 
  
  end
  
  else if (datapre[15]==1)
  begin
  data<=datapost;
  
  
casex(data)
    
  16'b0000000000001xxx:out<=-5'sd12;
  
  16'b000000000001xxxx:out<=-5'sd11;
  
  16'b00000000001xxxxx:out<=-5'sd10;
  
  16'b0000000001xxxxxx:out<=-5'sd9;
  
  16'b000000001xxxxxxx:out<=-5'sd8;
  
  16'b00000001xxxxxxxx:out<=-5'sd7;
  
  16'b0000001xxxxxxxxx:out<=-5'sd6;
  
  16'b000001xxxxxxxxxx:out<=-5'sd5;
 
  16'b00001xxxxxxxxxxx:out<=-5'sd4; 
  
 
  16'b0001xxxxxxxxxxxx:out<=-5'sd3;
  
  
  16'b001xxxxxxxxxxxxx:out<=-5'sd2;
  
  
  16'b01xxxxxxxxxxxxxx:out<=-5'sd1;
  
  
  16'b1xxxxxxxxxxxxxxx:out<=5'sd0;
  
  default:out<=5'b00000;
 endcase 
 
  
  
  end
  
  
 else
 out<=5'b00000;
 
end  
  
endmodule


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Random_OE (
    input wire clk,
    output wire [7:0] random_number
);
    reg [7:0] lfsr;
    initial
    begin
        lfsr = 8'hFF; // Initial seed value
    end
    always @(negedge clk) begin
        lfsr <= {lfsr[6:0], lfsr[0] ^ lfsr[2] ^ lfsr[3] ^ lfsr[5]};
    end

    assign random_number = lfsr;

endmodule



module difference_RNG_OE (mux_input,RNG_input,compared_output);

input [7:0] mux_input;

input [7:0] RNG_input;

output compared_output;

 assign compared_output = (mux_input > RNG_input) ? 1'b1 : 1'b0;

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module ControlledAdder_OE (
    input  [15:0]  operand1,
    input signed  [15:0]  operand2,
    input control_bit,
    output   [15:0] new_result
);
    reg   [15:0] result;

    always @(*)
    begin
        if (control_bit && (operand1 > 0))
            result = operand1 + operand2;
            
        else if (control_bit && (operand1==0) && (operand2>0))
           result = operand1 + operand2;
        else
            result = operand1; // No addition, result is zero
    end
    
    assign new_result=result;

endmodule






module weight_delta_mux_OE (sel,output_weight_change);

input sel;

output reg  signed [15:0] output_weight_change; 

always@(*)

begin
 case (sel)
      1'b0: output_weight_change = -16'd1;
      1'b1: output_weight_change = 16'd1;

      
   endcase
   
   end   

endmodule







module LTP_LUT_OE(
  input   [4:0] time_difference,
  output reg [7:0] weight_update_probability
);
  
  always @(*)
  begin
  case (time_difference)
      5'b00000: weight_update_probability = 8'b00000000;  // Probability = 1.0
      5'b00001: weight_update_probability = 8'b11111111 ;  // Probability = 0.875
      5'b00010: weight_update_probability = 8'b11000111 ;  // Probability = 0.75
      5'b00011: weight_update_probability = 8'b10011011 ;  // Probability = 0.625
      5'b00100: weight_update_probability = 8'b01111000 ;  // Probability = 0.5
      5'b00101: weight_update_probability = 8'b01011110 ;  // Probability = 0.375
      5'b00110: weight_update_probability = 8'b01001001 ;  // Probability = 0.25
      5'b00111: weight_update_probability = 8'b00111001 ;  // Probability = 0.125
      5'b01000: weight_update_probability = 8'b00101100 ;  // Probability = 0.0
      5'b01001: weight_update_probability = 8'b00100011 ;  // Probability = 0.0
      5'b01010: weight_update_probability = 8'b00011011 ;  // Probability = 0.0
      5'b01011: weight_update_probability = 8'b00010101 ;  // Probability = 0.0
      5'b01100: weight_update_probability = 8'b00010000;  // Probability = 0.0
    //  5'b01101: weight_update_probability = 8'b00010000;  // Probability = 0.0
    //  5'b01110: weight_update_probability = 8'b11110001;  // Probability = 0.0
    //  5'b01111: weight_update_probability = 8'b11110000;  // Probability = 0.0
      default: weight_update_probability = 8'b00000000;  // Default value
    endcase
  end

endmodule

module LTD_LUT_OE(
  input   [4:0] time_difference,
  output reg [7:0] weight_update_probability
);
  
  always @(*)
  begin
  case (time_difference)
      5'sd0: weight_update_probability = 8'b00000000;  // Probability = 1.0
     -5'sd1: weight_update_probability = 8'b11111111 ;  // Probability = 0.875
     -5'sd2: weight_update_probability = 8'b11100001 ;  // Probability = 0.75
     -5'sd3: weight_update_probability = 8'b11000111 ;  // Probability = 0.625
     -5'sd4: weight_update_probability = 8'b10101111 ;  // Probability = 0.5
     -5'sd5: weight_update_probability = 8'b10011011 ;  // Probability = 0.375
     -5'sd6: weight_update_probability = 8'b10001000 ;  // Probability = 0.25
     -5'sd7: weight_update_probability = 8'b01111000 ;  // Probability = 0.125
     -5'sd8: weight_update_probability = 8'b01101010 ;  // Probability = 0.0
     -5'sd9: weight_update_probability = 8'b01011110 ;  // Probability = 0.0
     -5'sd10: weight_update_probability = 8'b01010011 ;  // Probability = 0.0
     -5'sd11: weight_update_probability = 8'b01001001 ;  // Probability = 0.0
     -5'sd12: weight_update_probability = 8'b01000000;  // Probability = 0.0
    //  5'b01101: weight_update_probability = 8'b00010000;  // Probability = 0.0
    //  5'b01110: weight_update_probability = 8'b11110001;  // Probability = 0.0
    //  5'b01111: weight_update_probability = 8'b11110000;  // Probability = 0.0
      default: weight_update_probability = 8'b00000000;  // Default value
    endcase
  end

endmodule


