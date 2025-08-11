
`timescale 1ns / 1ps

module new_square_root ( 

input reset,
input write,
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

input [3:0]select,

input clock,

output  reg [3:0] weight_new, 
output reg [3:0] weight_old,

output reg [15:0] dataArray[0:15]);


wire signed [2:0] time_difference;
//wire [15:0]mux;
reg signed [2:0] time_difference_new;

wire [15:0]mux_synapse;

//reg [3:0] select=0;
reg [3:0] select_reg;

wire [15:0]postreg;
wire [15:0]preonereg;
wire [15:0]pretworeg;
wire [15:0]prethreereg;
wire [15:0]prefourreg;
wire [15:0]prefivereg;
wire [15:0]presixreg;
wire [15:0]presevenreg;
wire [15:0]preeightreg;
wire [15:0]preninereg;
wire [15:0]pretenreg;
wire [15:0]preelevenreg;
wire [15:0]pretwelvereg;
wire [15:0]prethirteenreg;
wire [15:0]prefourteenreg;
wire [15:0]prefifteenreg;
wire [15:0]presixteenreg;
//wire  [28:0]stdp_val;
//integer address2=0;
//wire [3:0] address;
//reg [3:0] weight_old;
//wire [3:0] weight_new;

reg [3:0] weight_new2;


wire [3:0] weight_old_final;
reg [3:0]weight_try;
integer i;
//reg [3:0] dataArray[15:0];


reg [3:0] select_minus=0; 


Shiftright zero(.Serial_in(postsynapSR0),.Clock(clock),.Q(postreg));
Shiftright one(.Serial_in(presynapSR1),.Clock(clock),.Q(preonereg));
Shiftright two(.Serial_in(presynapSR2),.Clock(clock),.Q(pretworeg));
Shiftright three(.Serial_in(presynapSR3),.Clock(clock),.Q(prethreereg));
Shiftright four(.Serial_in(presynapSR4),.Clock(clock),.Q(prefourreg));
Shiftright five(.Serial_in(presynapSR5),.Clock(clock),.Q(prefivereg));
Shiftright six(.Serial_in(presynapSR6),.Clock(clock),.Q(presixreg));
Shiftright seven(.Serial_in(presynapSR7),.Clock(clock),.Q(presevenreg));
Shiftright eight(.Serial_in(presynapSR8),.Clock(clock),.Q(preeightreg));
Shiftright nine(.Serial_in(presynapSR9),.Clock(clock),.Q(preninereg));
Shiftright ten(.Serial_in(presynapSR10),.Clock(clock),.Q(pretenreg));
Shiftright eleven(.Serial_in(presynapSR11),.Clock(clock),.Q(preelevenreg));
Shiftright twelve(.Serial_in(presynapSR12),.Clock(clock),.Q(pretwelvereg));
Shiftright thirteen(.Serial_in(presynapSR13),.Clock(clock),.Q(prethirteenreg));
Shiftright fourteen(.Serial_in(presynapSR14),.Clock(clock),.Q(prefourteenreg));
Shiftright fifteen(.Serial_in(presynapSR15),.Clock(clock),.Q(prefifteenreg));
Shiftright sixteen(.Serial_in(presynapSR16),.Clock(clock),.Q(presixteenreg));

MUX mux_one(.mux_in_1(preonereg),.mux_in_2(pretworeg),.mux_in_3(prethreereg),.mux_in_4(prefourreg),.mux_in_5(prefivereg),.mux_in_6(presixreg),.mux_in_7(presevenreg),.mux_in_8(preeightreg),.mux_in_9(preninereg),.mux_in_10(pretenreg),.mux_in_11(preelevenreg),.mux_in_12(pretwelvereg),.mux_in_13(prethirteenreg),.mux_in_14(prefourteenreg),.mux_in_15(prefifteenreg),.mux_in_16(presixteenreg),.sel(select),.mux_out(mux_synapse));
//comparator comp (.postsynap(postreg),.presynap(mux_synapse),.time_difference(time_difference));
difference differone(.datapre(mux_synapse), .datapost(postreg),.out(time_difference));
//Multiplier exponential(.a(time_difference),.z(stdp_val));
//CacheDataMemory mymemory(.clock(clock),.address(select),.wr(write), .weight_new2(weight_try),.weight_old2(weight_old));
//Multiplier mymultiplier (.time_difference2(time_difference), .address(select), .weight_old3(weight_old),.weight_new3(weight_new));  
//CacheDataMemory mymemory2(.address(select),.wr(1), .weight_new2(weight_new),.weight_old2(weight_old_final));
  /*
always@(*)
begin
weight_try<=weight_new;
end
*/

initial 

begin
for (i = 0; i < 16; i = i + 1)
    begin
         dataArray[i] <= 4'd2; // sob value by default 2 save korba
end
end


always@(negedge clock)
 begin
 if(reset)
  begin
  
  for (i = 0; i < 16; i = i + 1)
  begin
       dataArray[i] <= 16'd2; // sob value by default 2 save korba
  end
//  select<=0;
//  select_minus<=0;
  end
   
   
   weight_old<=dataArray[select_reg];
          
  
//  if(select!=0)
   
 //  select_minus<=select+1;
   select_reg<=select+1;
   select_minus<=select_reg;
   if(write==1&reset==0)
   dataArray[select_minus]<=weight_new2;
   
   
  end   
  
  always @(posedge clock)
  begin
  weight_new2<=weight_new;
  time_difference_new<=time_difference;
  end
  
//assign select_minus=select-1;   
 //   Multiplier myslave_multiplier (time_difference, weight_old,weight_new3);
   /*
    initial begin
    bypass = 1'b1;
    end
    */
    
    
Multiplier mymultiplier (.time_difference2(time_difference_new),  .weight_old3(weight_old),.weight_new3(weight_new));  
  

    
  

//reg toggle=0;  // Toggling signal



//always @(posedge clock) begin
//    // Toggle the enable signal every positive edge of the clock
//    toggle <= ~toggle;
    
//    // Increment the counter when toggle is high
//    if (toggle) begin
//        if (select == 4'b0010) begin
//            select <= 4'b0000; // Reset to 0 when it reaches 15
//        end else begin
//            select <= select+1; // Increment the counter
//        end
//    end
//end


//reg [3:0] count;  // 4-bit counter output

//reg [3:0] next_count; // Next counter value

//always @(posedge clock) begin
//    if (reset) begin
//        // Reset the counter
//        select <= 4'b0000;
//    end else begin
//        // Increment the counter on every second positive clock edge
//        if (select == 4'b0010) begin
//            // Reset to 0 when it reaches 15
//            select <= 4'b0000;
//        end else if (clock) begin
//            select <= next_count;
//        end
//    end
//end

//always @(posedge clock) begin
//    // Calculate the next counter value
//    if (select == 4'b0010) begin
//        next_count <= 4'b0000;
//    end else begin
//        next_count <= select + 1;
//    end
//end





//wire [3:0] select2;
//assign select2=select;
    
    
  
//  always@(posedge clock)
//  begin
//   select_minus<=select;
  // dataArray[select_minus]<=weight_new;
     
  //end  
      
  // assign weight_old_final = dataArray[select];    
    



endmodule




//// Simple Dual-Port Block RAM with One Clock
//// File: simple_dual_one_clock.v
//module simple_dual_one_clock (clk,ena,enb,wea,addra,addrb,dia,dob);
//input clk,ena,enb,wea;
//input [3:0] addra,addrb;
//input [3:0] dia;
//output [3:0] dob;
//reg [3:0] ram [16:0];
//reg [3:0] doa,dob;


//always @(posedge clk) begin
// if (ena) begin
// if (wea)
// ram[addra] <= dia;
// end
 
//end

//always @(posedge clk) begin
// if (enb)
// dob <= ram[addrb];
//end
//endmodule






module Shiftright( 
input Serial_in, 
input Clock, 

output reg [15:0]Q);

initial
begin
Q<=0;
end
  
always @ (negedge Clock) 
begin 
Q<={Serial_in, Q[15:1]}; 
end // always 
endmodule 




module MUX(mux_in_1,mux_in_2,mux_in_3,mux_in_4,mux_in_5,mux_in_6,mux_in_7,mux_in_8,mux_in_9,mux_in_10,mux_in_11,mux_in_12,mux_in_13,mux_in_14,mux_in_15,mux_in_16,sel,mux_out);
input [15:0] mux_in_1;
input [15:0] mux_in_2;
input [15:0] mux_in_3;
input [15:0] mux_in_4;
input [15:0] mux_in_5;
input [15:0] mux_in_6;
input [15:0] mux_in_7;
input [15:0] mux_in_8;
input [15:0] mux_in_9;
input [15:0] mux_in_10;
input [15:0] mux_in_11;
input [15:0] mux_in_12;
input [15:0] mux_in_13;
input [15:0] mux_in_14;
input [15:0] mux_in_15;
input [15:0] mux_in_16;


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
      
   endcase
   
   end   

endmodule



module difference(datapre,datapost,out);

input [15:0]datapre;
input [15:0]datapost;
reg [15:0]data;
output reg signed [2:0]out; 


always@(*)
begin


if(datapost[15]==1)

begin
data<=datapre;
//else
//data<=0;

casex(data)
  
   
  16'b0001xxxxxxxxxxxx:out<=3'b011;
  
  
  16'b001xxxxxxxxxxxxx:out<=3'b010;
  
  
  16'b01xxxxxxxxxxxxxx:out<=3'b001;
  
  
  16'b1xxxxxxxxxxxxxxx:out<=3'b000;
  
  default:out<=3'b000;
 endcase 
  
  end
  
  else if (datapre[15]==1)
  begin
  data<=datapost;
  
  
casex(data)
 
  16'b0001xxxxxxxxxxxx:out<=-3'sd3;
  
  
  16'b001xxxxxxxxxxxxx:out<=-3'sd2;
  
  
  16'b01xxxxxxxxxxxxxx:out<=-3'sd1;
  
  
  16'b1xxxxxxxxxxxxxxx:out<=3'd0;
  
  default:out<=3'b000;
 endcase 
   
end
    
else begin
 out<=3'b000;
 data <= 0;
 end
end  
  
endmodule


/*
module Multiplier(a, z);
    input [3:0] a;
    
    output reg [28:0] z;

    always @(a) begin
        case (a)
          //  4'b0000: z <= 8'd1; // 0 * 0 = 0
            4'b0001: z <= 29'd367800000; // 0 * 1 = 0
            4'b0010: z <= 29'd135300000; // 0 * 2 = 0
            4'b0011: z <= 29'd49700000; // 0 * 3 = 0
            4'b0100: z <= 29'd18300000; // 0 * 4 = 0
            4'b0101: z <= 29'd674000000; // 0 * 5 = 0
            4'b0110: z <= 29'd2500000; // 0 * 6 = 0
            4'b0111: z <= 29'd910000; // 0 * 7 = 0
            4'b1000: z <= 29'd340000; // 0 * 8 = 0
            4'b1001: z <= 29'd120000; // 0 * 9 = 0
            4'b1010: z <= 29'd50000; // 0 * 10 = 0
            4'b1011: z <= 29'd17000; // 0 * 11 = 0
            4'b1100: z <= 29'd6100; // 0 * 12 = 0
            4'b1101: z <= 29'd2300; // 0 * 13 = 0
            4'b1110: z <= 29'd831; // 0 * 14 = 0
            4'b1111: z <= 29'd305; // 0 * 15 = 0
           default:z<=50'd0;
          endcase
     end
endmodule
*/



module Multiplier(time_difference2,  weight_old3,weight_new3);
//reg [7:0] result;
input signed [2:0] time_difference2;
input [3:0] weight_old3;
//input [3:0]address;
output reg [3:0]weight_new3;

always @(*) 
begin
  case ( {time_difference2, weight_old3} )
   {-3'd3,4'd0}: weight_new3 = 4'd0;
    {-3'd3,4'd2}: weight_new3 = 4'd2;
    {-3'd3,4'd6}: weight_new3 = 4'd6;
    {-3'd3,4'd8}: weight_new3 = 4'd8;
    {-3'd2,4'd0}: weight_new3 = 4'd0;
    {-3'd2,4'd2}: weight_new3 = 4'd0;
    {-3'd2,4'd6}: weight_new3 = 4'd2;
    {-3'd2,4'd8}: weight_new3 = 4'd6;
    {-3'd1,4'd0}: weight_new3 = 4'd0;
    {-3'd1,4'd2}: weight_new3 = 4'd0;
    {-3'd1,4'd6}: weight_new3 = 4'd0;
    {-3'd1,4'd8}: weight_new3 = 4'd2;
    {3'd0,4'd0}: weight_new3 = 4'd0;
    {3'd0,4'd2}: weight_new3 = 4'd2;
    {3'd0,4'd6}: weight_new3 = 4'd6;
    {3'd0,4'd8}: weight_new3 = 4'd8;
    {3'd1,4'd0}: weight_new3 = 4'd6;
    {3'd1,4'd2}: weight_new3 = 4'd8;
    {3'd1,4'd6}: weight_new3 = 4'd8;
    {3'd1,4'd8}: weight_new3 = 4'd8;
    {3'd2,4'd0}: weight_new3 = 4'd2;
    {3'd2,4'd2}: weight_new3 = 4'd6;
    {3'd2,4'd6}: weight_new3 = 4'd8;
    {3'd2,4'd8}: weight_new3 = 4'd8;
    {3'd3,4'd0}: weight_new3 = 4'd0;
    {3'd3,4'd2}: weight_new3 = 4'd2;
    {3'd3,4'd6}: weight_new3 = 4'd6;
    {3'd3,4'd8}: weight_new3 = 4'd8;
    default: weight_new3=4'd2;
  endcase
    
end
endmodule


