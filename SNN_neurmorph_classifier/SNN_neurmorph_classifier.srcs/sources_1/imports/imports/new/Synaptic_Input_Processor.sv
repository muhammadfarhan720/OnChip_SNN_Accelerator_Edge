`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2023 05:47:15 AM
// Design Name: 
// Module Name: Synaptic_Input_Processor
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


module Synaptic_Input_Processor (clock,reset,write,parallel_spike_in,parallel_Ein,flush_weight,spike

);
input clock;  

input reset;  

input write;


//input [15:0]Er; //For selecting inhibitory or exhibitory presynaptic neuron

//input [15:0]Sin; //For incoming spikes from presynapses (Either internal or external)

//input  [3:0] weight;

//output reg [15:0] EP, EN, IP, IN;

//input [3:0] parallel_in_weight[0:15];


input [15:0] parallel_spike_in;

input [15:0] parallel_Ein;

output reg flush_weight;

reg flush_Ein;

reg flush_spike;

output spike;

//output [3:0] select;

//output toggle;

//output wire [3:0] weight_new2;
//input load;

// input  clk,
//  input  reset,
////  input [4:0] count,
//  input  [3:0] wi,
//  input  E_plus,
//  input  Ein,
////  output reg [15:0] ES_plus,
//  output reg [15:0] ES_plus_reg,
  
//  output reg [15:0] ES_minus_reg,
  
//  output reg [15:0] IS_plus_reg,
  
//  output reg [15:0] IS_minus_reg
  

wire Sin;
//wire [3:0] mux_weight_out; 
//wire [3:0] mux_Ein_out;



wire [15:0] weight_sum;
wire [15:0] ES_plus_reg;
  

wire [15:0] ES_minus_reg;
  
wire [15:0] IS_plus_reg;
  
wire [15:0] IS_minus_reg;
  
wire [15:0] ES_add;



wire [15:0] ES_add_divided;



wire [15:0] IS_add;

wire [15:0] IS_add_divided;

reg [15:0] operand3=0;

//reg [15:0] operand4=0;

wire [15:0] sum;

reg [15:0] sum_reg=0;
//wire spike;

//reg load=1;

//wire [3:0] parallel_in_weight [0:15];  //used in only SIP design without STDP for testing 

wire [15:0] parallel_spike_in;

//wire spike_out;

wire [15:0] parallel_Ein;

wire Ein_out;

wire [15:0] weight;


//reg [3:0] weight_old;

wire [15:0] weight_old;

wire [15:0] weight_new;

wire [3:0]select;


wire [15:0] dataArray [0:15];

//always @(posedge clock)
//begin

//PISO piso_weight (.clk(clock),.load(load),.parallel_in(parallel_in_weight),.serial_out(weight),.flush(flush_weight)); // parallel_in_weight has to be brought out from STDP

PISO piso_weight (.clk(clock),.reset(reset),.parallel_in(dataArray),.serial_out(weight),.flush(flush_weight),.shift_count(select)); // parallel_in_weight has to be brought out from STDP


PISO_spike piso_spike (.clk(clock),.reset(reset),.d(parallel_spike_in), .flush(flush_spike),.Qout(Sin));

PISO_spike Ein_PISO (.clk(clock),.reset(reset), .d(parallel_Ein), .flush(flush_Ein),.Qout(Ein_out));

//load<=0;

//end





//Mux mux_weight (.mux_in_1(4'b0),.mux_in_2(weight),.sel(Sin),.mux_out(mux_weight_out));


//Mux mux_Ein (.mux_in_1(4'b0),.mux_in_2(mux_weight_out),.sel(Ein_out),.mux_out(mux_Ein_out));


//new_SRU_simplified new_SRU(.clk(clock),.reset(reset),.w_old(weight), .input_spike(Sin), .weight_sum(weight_sum));
SRU_EP_EN_IP_IN SRU (.clk(clock),.reset(reset), .wi(weight),.E_plus(Sin),.Ein(Ein_out),.ES_plus_reg(ES_plus_reg),.ES_minus_reg(ES_minus_reg),.IS_plus_reg(IS_plus_reg),.IS_minus_reg(IS_minus_reg));

SimpleAdder ES_adder (.operand1(ES_minus_reg),.operand2(ES_plus_reg),.result(ES_add)); //Here the denominator is minus so the operators had to be switched

SimpleAdder ISadder (.operand1(IS_plus_reg),.operand2(IS_minus_reg),.result(IS_add));

RightShifterEP ES_divider (.operand(ES_add),.output_shifter(ES_add_divided));

RightShifterIP IS_divider (.operand(IS_add),.output_shifter(IS_add_divided));

 // Instantiate the ThreeOperandAdder module
//ThreeOperandAdder adder_inst(.clk(clock),.reset(reset),.operand1(ES_add_divided),.operand2(IS_add_divided),.operand3(operand3),.result(sum));


assign sum=ES_add_divided-IS_add_divided+sum_reg-(sum_reg>>2);
//assign sum = sum- (sum>>5) + weight_sum;
Comparator spike_comparator (.Vmem(sum_reg),.spike(spike));



new_square_root new_square (.reset(reset),.write(write), .postsynapSR0(spike), .presynapSR1(parallel_spike_in[0]), .presynapSR2(parallel_spike_in[1]),.presynapSR3(parallel_spike_in[2]), .presynapSR4(parallel_spike_in[3]), .presynapSR5(parallel_spike_in[4]), .presynapSR6(parallel_spike_in[5]), .presynapSR7(parallel_spike_in[6]),.presynapSR8(parallel_spike_in[7]), .presynapSR9(parallel_spike_in[8]), .presynapSR10(parallel_spike_in[9]), .presynapSR11(parallel_spike_in[10]), .presynapSR12(parallel_spike_in[11]),
                 .presynapSR13(parallel_spike_in[12]), .presynapSR14(parallel_spike_in[13]), .presynapSR15(parallel_spike_in[14]), .presynapSR16(parallel_spike_in[15]),.select(select), .clock(clock),.weight_new(weight_new),.weight_old(weight_old),.dataArray(dataArray));



//TimerUnit STDP (.reset(reset),.write(write), .postsynapSR0(spike), .presynapSR1(parallel_spike_in[0]), .presynapSR2(parallel_spike_in[1]),.presynapSR3(parallel_spike_in[2]), .presynapSR4(parallel_spike_in[3]), .presynapSR5(parallel_spike_in[4]), .presynapSR6(parallel_spike_in[5]), .presynapSR7(parallel_spike_in[6]),.presynapSR8(parallel_spike_in[7]), .presynapSR9(parallel_spike_in[8]), .presynapSR10(parallel_spike_in[9]), .presynapSR11(parallel_spike_in[10]), .presynapSR12(parallel_spike_in[11]),
//                 .presynapSR13(parallel_spike_in[12]), .presynapSR14(parallel_spike_in[13]), .presynapSR15(parallel_spike_in[14]), .presynapSR16(parallel_spike_in[15]),.select(select), .clock(clock),.weight_final(weight_new),.weight_old(weight_old),.dataArray(dataArray));


always @(posedge clock)
begin
if(spike | reset)
sum_reg<=0;
else
sum_reg<=sum;

end

  // Use the output of the adder as one of the operands in the next clock cycles
//  always @(posedge clock) begin
//  //  if (!reset) begin
//  if(spike==1)
      
//      operand3<=0;
      
//  else    
//      operand3 <= sum-(sum>>5);
      
//  //  end
  
// // load<=0;
//  end


endmodule





//module MUX (mux_in_1,mux_in_2,sel,mux_out);

//input [3:0] mux_in_1;
//input [3:0] mux_in_2;


//input sel;
//output reg [3:0] mux_out;

//always @(*)
///*if(sel==1'b0)
//begin
//mux_out<=mux_in_1;  //eikhane case statement use kore 16 ta mux_in use korte hobe
//end
//else
//begin
//mux_out<=mux_in_2;
//end*/

//begin
// case (sel)
//      1'b0: mux_out = mux_in_1;
//      1'b1: mux_out = mux_in_2;

      
//   endcase
   
//   end   

 
//endmodule
    




module SimpleAdder (
  input  [15:0] operand1,
  input  [15:0] operand2,
  output [15:0] result
);

  assign result = operand1 - operand2;

endmodule



//module ThreeOperandAdder(
//  input wire clk,
//  input wire reset,
//  input wire [15:0] operand1,
//  input wire [15:0] operand2,
//  input wire [15:0] operand3,
//  output reg [15:0] result
//);


  
//  always @(posedge clk) begin
//    if (reset) begin
//      result <= 16'b0;
//    end else begin
//      result <= operand1 + operand2 + operand3;
//    end
//  end

//endmodule




module RightShifterEP (operand,output_shifter);

  input [15:0] operand;
//  input [1:0] shiftAmount;
  output [15:0] output_shifter;



  assign output_shifter = operand >> 2;

endmodule



module RightShifterIP (operand,output_shifter);

  input [15:0] operand;
//  input [1:0] shiftAmount;
  output [15:0] output_shifter;



  assign output_shifter = operand >> 1;

endmodule




module Comparator(Vmem,spike);

input [15:0] Vmem;

integer Vth=20;

output spike;
assign spike = (Vmem>Vth) ? 1'b1: 1'b0;

endmodule





module PISO_spike(
    input clk,
  //  input load, 
    input reset,
    input [15:0] d,
    output reg flush,
 //   output reg [3:0] shift_count;
    output reg Qout);  

reg [15:0]Q;  
reg [3:0] shift_count;



  initial
  
  begin
   Qout<=0;
   Q <= 16'b0;
   flush<=0;  
   shift_count <= 4'b0000;
   
   end
  




always @ (negedge clk)
begin

if(reset)
  begin
   //serial_out<=0;
   Q <= 16'b0;
   flush<=0;  
   shift_count <= 4'b0000;
   Qout<=0;
   end
   
else if ( flush==1 && reset==0 ) 

begin
  Q <= d;
  flush<=0;
  shift_count<=0;
//  Qout<=0;
 end
 
else if (flush==0&&reset==0)
begin 
  Qout <= Q[15];
  Q<={Q[14:0],1'b0};
  
  shift_count <= shift_count + 1'b1;
  if (shift_count==4'b1111)
  flush<=1;
  
  
  end
 
  
  
  
 end  
 
//always@(negedge clk)

//begin

//if(flush==0&&reset==0)
//begin 
//  Qout <= Q[15];
//  Q<={Q[14:0],1'b0};
  
//  shift_count <= shift_count + 1'b1;
//  if (shift_count==4'b1111)
//  flush<=1;
  
  
//  end
//end
endmodule






module PISO (
  input wire clk,
  input reset,
 // input wire load,
 // input wire reset,
  input wire    [15:0] parallel_in[15:0], //[3:0]
//  output reg [3:0] shift_reg [0:15],
  output reg    [15:0] serial_out, // [3:0]
  output reg flush,
  output reg [3:0] shift_count
);

 reg [15:0] shift_reg [0:15];//[3:0]
 //reg [3:0] shift_count;
  
  initial
  
  begin
   serial_out<= 16'b0100000000000000;
   shift_reg <= '{16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000};
   flush<=0;  
   shift_count <= 4'b0000;
   
   end
  

  always @(negedge clk) begin

    if(reset)
    begin
   
         shift_reg <= '{16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000,16'b0100000000000000}; // sob value by default 2 save korba parallelwise 
         flush<=0;  
         shift_count <= 4'b0000;
         serial_out<=16'b0100000000000000;
    end
   
      if (flush==1&&reset==0) begin
        shift_reg <= '{parallel_in[0], parallel_in[1], parallel_in[2], parallel_in[3],parallel_in[4],parallel_in[5],parallel_in[6],parallel_in[7],parallel_in[8],parallel_in[9],parallel_in[10],parallel_in[11],parallel_in[12],parallel_in[13],parallel_in[14],parallel_in[15]};
        
  //      serial_out<=0; //jehetu first cycle ei serial_out e load korte hoy so non blocking use korle load to shift_reg are load er ager shift_reg er value serial_out e entry eksathe parallel vabe hobe. So, blocking statement use kore ei jhamela erano jai 
        shift_count <= 4'b0000; //jodi pore jhamela kore taile sobgula non-blocking kore diyo, shudhu ekta data first time na dhuke zero ase erpore fix
        
        flush<=0;
      end 
       if(flush==0&&reset==0)
        begin
        serial_out<={shift_reg[shift_count]};
        shift_count <= shift_count + 1'b1;
        if (shift_count==4'b1111)
        flush<=1;

      end
      end 
//      always@(negedge clk)
//       begin
//        if(flush==0&&reset==0)
//        begin
//        serial_out<={shift_reg[shift_count]};
//        shift_count <= shift_count + 1'b1;
//        if (shift_count==4'b1111)
//        flush<=1;

//      end
//    end
//  end
  
//  assign serial_out = {shift_reg[3], shift_reg[2], shift_reg[1], shift_reg[0]};

endmodule



//module PISO (
//  input wire clk,
//  input wire load,
// // input wire reset,
//  input wire [3:0] parallel_in[0:15],
////  output reg [7:0] shift_reg [0:15],
//  output reg [3:0] serial_out,
//  output reg flush
////  output reg [3:0] shift_count
//);

// reg [3:0] shift_reg [0:15];
// reg [3:0] shift_count;
  
//  initial
  
//  begin
//   serial_out<=0;
//   shift_reg <= '{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
//   flush<=0;  
//   shift_count <= 4'b0000;
   
//   end
  

//  always @(negedge clk) begin
////    if (reset) begin
////      shift_reg <= '{0,0,0,0};
////      shift_count <= 2'b0;
////    end else begin
   
//      if (load || flush) begin
//        shift_reg <= '{parallel_in[0], parallel_in[1], parallel_in[2], parallel_in[3],parallel_in[4],parallel_in[5],parallel_in[6],parallel_in[7],parallel_in[8],parallel_in[9],parallel_in[10],parallel_in[11],parallel_in[12],parallel_in[13],parallel_in[14],parallel_in[15]};
        
//        serial_out<=0; //jehetu first cycle ei serial_out e load korte hoy so non blocking use korle load to shift_reg are load er ager shift_reg er value serial_out e entry eksathe parallel vabe hobe. So, blocking statement use kore ei jhamela erano jai 
//        shift_count <= 4'b0000; //jodi pore jhamela kore taile sobgula non-blocking kore diyo, shudhu ekta data first time na dhuke zero ase erpore fix
        
//        flush<=0;
//      end else begin
//    //    {shift_reg[3], shift_reg[2], shift_reg[1], shift_reg[0]} <= {shift_reg[3], shift_reg[2], shift_reg[1], shift_reg[0]};
        
        
//        serial_out<={shift_reg[shift_count]};
//        shift_count <= shift_count + 1'b1;
//        if (shift_count==4'b1111)
//        flush<=1;
////        else if (flush==1)
////        flush<=0;
//      end
//    end
////  end
  
////  assign serial_out = {shift_reg[3], shift_reg[2], shift_reg[1], shift_reg[0]};

//endmodule


