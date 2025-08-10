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


module Synaptic_Input_Processor_OE(clock,reset,write,ST_and, CT_and,ST, CT,parallel_spike_in,parallel_Ein,
flush_weight,flush_Ein,flush_spike,spike,select
);
input clock;  

input reset;  

input write;

input ST_and; //new added for OE_STDP

input CT_and;

input ST;

input CT;
//input [15:0]Er; //For selecting inhibitory or exhibitory presynaptic neuron

//input [15:0]Sin; //For incoming spikes from presynapses (Either internal or external)

//input  [3:0] weight;

//output reg [15:0] EP, EN, IP, IN;

//input [3:0] parallel_in_weight[0:15];

input [15:0] parallel_spike_in;

input [15:0] parallel_Ein;

output reg flush_weight;

output reg flush_Ein;

output reg flush_spike;

output spike;

output [3:0] select;

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



wire [15:0] weight_sum; //ruizhe_added 4/28/2024
reg [15:0] ES_plus_reg;
wire [15:0] ES_plus;

reg [15:0] ES_minus_reg;
wire [15:0] ES_minus;  
  
wire [15:0] IS_plus_reg;
  
wire [15:0] IS_minus_reg;
  
wire    [15:0] ES_add; //   



wire    [15:0] ES_add_divided; //  
//reg    [15:0] ES_add_divided_reg;//  


wire    [15:0] IS_add; //   

wire    [15:0] IS_add_divided;//  
//reg    [15:0] operand3=0;

//reg [15:0] operand4=0;

wire    [15:0] sum;

wire spike;

//reg load=1;

//wire [3:0] parallel_in_weight [0:15];  //used in only SIP design without STDP for testing 

wire [15:0] parallel_spike_in;

//wire spike_out;

wire [15:0] parallel_Ein;

wire Ein_out;

wire    [15:0] weight;//[3:0]


//reg [3:0] weight_old;

wire    [15:0] weight_old; //[3:0]

wire    [15:0] weight_new; //[3:0]

wire [3:0]select;


//wire [3:0] dataArray [0:15]; 
wire    [15:0] dataArray [0:15]; //new added

reg    [15:0] sum_reg=0;
//always @(posedge clock)
//begin

//PISO piso_weight (.clk(clock),.load(load),.parallel_in(parallel_in_weight),.serial_out(weight),.flush(flush_weight)); // parallel_in_weight has to be brought out from STDP

PISO_OE piso_weight (.clk(clock),.reset(reset),.parallel_in(dataArray),.serial_out(weight),.flush(flush_weight),.shift_count(select)); // parallel_in_weight has to be brought out from STDP


PISO_spike_OE piso_spike (.clk(clock),.reset(reset),.d(parallel_spike_in), .flush(flush_spike),.Qout(Sin));

PISO_spike_OE Ein_PISO (.clk(clock),.reset(reset), .d(parallel_Ein), .flush(flush_Ein),.Qout(Ein_out));

//load<=0;

//end





//Mux mux_weight (.mux_in_1(4'b0),.mux_in_2(weight),.sel(Sin),.mux_out(mux_weight_out));


//Mux mux_Ein (.mux_in_1(4'b0),.mux_in_2(mux_weight_out),.sel(Ein_out),.mux_out(mux_Ein_out));
reg write_d1;
  always @(negedge clock) begin
//  if(reset)begin
////  ES_plus_reg<=0;
////  ES_minus_reg <= 0;
//  end else begin
  write_d1 <= write;
//  ES_plus_reg <= ES_plus;
//  ES_minus_reg <= ES_minus;
//  end
  end

//new_SRU_simplified new_SRU(.clk(clock),.reset(reset),.w_old(weight), .input_spike(Sin), .weight_sum(weight_sum));

SRU_EP_EN_IP_IN_OE SRU (.clk(clock),.reset(reset), .spike(spike),.wi(weight),.E_plus(Sin),.Ein(Ein_out),.ES_plus_reg(ES_plus),.ES_minus_reg(ES_minus),.IS_plus_reg(IS_plus_reg),.IS_minus_reg(IS_minus_reg));

SimpleAdder_OE ES_adder (.operand1(ES_minus_reg),.operand2(ES_plus_reg),.result(ES_add)); //Here the denominator is minus so the operators had to be switched

SimpleAdder_OE ISadder (.operand1(IS_plus_reg),.operand2(IS_minus_reg),.result(IS_add));

RightShifterEP_OE ES_divider (.operand(ES_add),.output_shifter(ES_add_divided));

RightShifterIP_OE IS_divider (.operand(IS_add),.output_shifter(IS_add_divided));

 // Instantiate the ThreeOperandAdder module
//ThreeOperandAdder adder_inst(.clk(clock),.reset(reset),.operand1(ES_add_divided),.operand2(IS_add_divided),.operand3(operand3),.result(sum));

always @(negedge clock)
begin
if(spike | reset)
sum_reg<=0;
else begin
    sum_reg<=sum;
end
end

assign sum=sum_reg-(sum_reg>>5)+ES_add_divided+IS_add_divided;
//assign sum = sum- (sum>>5) + weight_sum;
Comparator_OE spike_comparator (.Vmem(sum_reg),.spike(spike));

LSM_OE_STDP OE_STDP(.write(write_d1),.clock(clock),.rst(reset), .postsynapSR0(spike), 
.presynapSR1(parallel_spike_in[0]), .presynapSR2(parallel_spike_in[1]),
.presynapSR3(parallel_spike_in[2]), .presynapSR4(parallel_spike_in[3]), 
.presynapSR5(parallel_spike_in[4]), .presynapSR6(parallel_spike_in[5]), 
.presynapSR7(parallel_spike_in[6]),.presynapSR8(parallel_spike_in[7]), 
.presynapSR9(parallel_spike_in[8]), .presynapSR10(parallel_spike_in[9]), 
.presynapSR11(parallel_spike_in[10]), .presynapSR12(parallel_spike_in[11]),
.presynapSR13(parallel_spike_in[12]), .presynapSR14(parallel_spike_in[13]), 
.presynapSR15(parallel_spike_in[14]),.presynapSR16(parallel_spike_in[15]),
.ST_and(ST_and),.CT_and(CT_and), .ST(ST), .CT(CT),.select(select),.spike(spike), 
.weight_new(weight_new),.weight_old(weight_old),.dataArray(dataArray));





endmodule


    




module SimpleAdder_OE (
  input  [15:0] operand1,
  input  [15:0] operand2,
  output [15:0] result
);

  assign result = operand1 - operand2;

endmodule



module RightShifterEP_OE (operand,output_shifter);

  input    [15:0] operand;
//  input [1:0] shiftAmount;
  output    [15:0] output_shifter;



  assign output_shifter = operand >> 2;

endmodule



module RightShifterIP_OE (operand,output_shifter);

  input    [15:0] operand;
//  input [1:0] shiftAmount;
  output    [15:0] output_shifter;



  assign output_shifter = operand >> 1;

endmodule




module Comparator_OE(Vmem,spike);

input    [15:0] Vmem;

integer Vth=640; // shift 20 left for 5 times

output  spike;


assign spike = (Vmem>Vth) ? 1'b1: 1'b0;

endmodule





module PISO_spike_OE(
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
 
else if(flush==0&&reset==0)
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






module PISO_OE (
  input wire clk,
  input reset,
 // input wire load,
 // input wire reset,
  input wire    [15:0] parallel_in[0:15], //[3:0]
//  output reg [3:0] shift_reg [0:15],
  output reg    [15:0] serial_out, // [3:0]
  output reg flush,
  output reg [3:0] shift_count
);

 reg [15:0] shift_reg [0:15];//[3:0]
 //reg [3:0] shift_count;
  
  initial
  
  begin
   serial_out<=16'd2;
   shift_reg <= '{2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2};
   flush<=0;  
   shift_count <= 4'b0000;
   
   end
  

  always @(negedge clk) begin

  if(reset)
    begin
   
         shift_reg <= '{2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2}; // sob value by default 2 save korba parallelwise 
         flush<=0;  
         shift_count <= 4'b0000;
         serial_out<=16'd2;
    end
   
   else if (flush==1&&reset==0) begin
        shift_reg <= '{parallel_in[0], parallel_in[1], parallel_in[2], parallel_in[3],parallel_in[4],parallel_in[5],parallel_in[6],parallel_in[7],parallel_in[8],parallel_in[9],parallel_in[10],parallel_in[11],parallel_in[12],parallel_in[13],parallel_in[14],parallel_in[15]};
        
  //      serial_out<=0; //jehetu first cycle ei serial_out e load korte hoy so non blocking use korle load to shift_reg are load er ager shift_reg er value serial_out e entry eksathe parallel vabe hobe. So, blocking statement use kore ei jhamela erano jai 
        shift_count <= 4'b0000; //jodi pore jhamela kore taile sobgula non-blocking kore diyo, shudhu ekta data first time na dhuke zero ase erpore fix
        
        flush<=0;
      end 
      else if(flush==0&&reset==0)
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

endmodule