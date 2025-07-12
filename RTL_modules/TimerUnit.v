module TimerUnit(

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
output reg  [15:0]weight_old,
output wire  [15:0]weight_final,
output reg [15:0] dataArray[15:0]);


wire signed [5:0] time_difference_t1;
wire signed [5:0] time_difference_t2;


wire [15:0]mux_synapse;
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
reg signed [15:0]weight_new2;

reg [3:0] select_read=0;
reg [3:0] select_write=0; 
integer i;


//CREATE A SHIFT REGISTER FOR EACH PRE SYNAPTIC UNIT TO OUR POST NEURON
Shiftright zero(.Serial_in(postsynapSR0),.Clock(clock),.reset(reset),.Q(postreg));
Shiftright one(.Serial_in(presynapSR1),.Clock(clock),.reset(reset),.Q(preonereg));
Shiftright two(.Serial_in(presynapSR2),.Clock(clock),.reset(reset),.Q(pretworeg));
Shiftright three(.Serial_in(presynapSR3),.Clock(clock),.reset(reset),.Q(prethreereg));
Shiftright four(.Serial_in(presynapSR4),.Clock(clock),.reset(reset),.Q(prefourreg));
Shiftright five(.Serial_in(presynapSR5),.Clock(clock),.reset(reset),.Q(prefivereg));
Shiftright six(.Serial_in(presynapSR6),.Clock(clock),.reset(reset),.Q(presixreg));
Shiftright seven(.Serial_in(presynapSR7),.Clock(clock),.reset(reset),.Q(presevenreg));
Shiftright eight(.Serial_in(presynapSR8),.Clock(clock),.reset(reset),.Q(preeightreg));
Shiftright nine(.Serial_in(presynapSR9),.Clock(clock),.reset(reset),.Q(preninereg));
Shiftright ten(.Serial_in(presynapSR10),.Clock(clock),.reset(reset),.Q(pretenreg));
Shiftright eleven(.Serial_in(presynapSR11),.Clock(clock),.reset(reset),.Q(preelevenreg));
Shiftright twelve(.Serial_in(presynapSR12),.Clock(clock),.reset(reset),.Q(pretwelvereg));
Shiftright thirteen(.Serial_in(presynapSR13),.Clock(clock),.reset(reset),.Q(prethirteenreg));
Shiftright fourteen(.Serial_in(presynapSR14),.Clock(clock),.reset(reset),.Q(prefourteenreg));
Shiftright fifteen(.Serial_in(presynapSR15),.Clock(clock),.reset(reset),.Q(prefifteenreg));
Shiftright sixteen(.Serial_in(presynapSR16),.Clock(clock),.reset(reset),.Q(presixteenreg));

//SELECT WHICH PRENEURON YOU WANT TO UPDATE THE WEIGHT FOR
MUX_logic mux_one(.mux_in_1(preonereg),.mux_in_2(pretworeg),.mux_in_3(prethreereg),.mux_in_4(prefourreg),.mux_in_5(prefivereg),.mux_in_6(presixreg),.mux_in_7(presevenreg),.mux_in_8(preeightreg),.mux_in_9(preninereg),.mux_in_10(pretenreg),.mux_in_11(preelevenreg),.mux_in_12(pretwelvereg),.mux_in_13(prethirteenreg),.mux_in_14(prefourteenreg),.mux_in_15(prefifteenreg),.mux_in_16(presixteenreg),.sel(select_read),.mux_out(mux_synapse));
//comparator comp (.postsynap(postreg),.presynap(mux_synapse),.time_difference(time_difference));
difference differone(.clk(clock),.reset(reset),.datapre(mux_synapse),
.datapost(postreg),.out_time1(time_difference_t1),.out_time2(time_difference_t2));


weight_change weight_dut(.deltat1(time_difference_t1),.deltat2(time_difference_t2),
.weight_initial(weight_old),.weight_final(weight_final));

//always@(*) begin
//if (reset)begin
//for (i = 0; i < 16; i = i + 1)
//   begin
//      dataArray[i] <= 17'b0000010000000000; // sob value by default 2 save korba
//   end
//end
//end

always@(negedge clock)
   begin
   if(reset) begin
   select_read<=4'd0;
   select_write<=4'd0;
   for (i = 0; i < 16; i = i + 1)
   begin
      dataArray[i] <= 16'b0100000000000000; // sob value by default 2 save korba
   end
   end 
   else begin
   select_read<=select+1;
   select_write<=select_read;
   if(write==1&reset==0)
   dataArray[select_write]<=weight_new2;
  end 
  end
  
  always @(posedge clock)
  begin
  if(reset) begin
   weight_new2 <= 0;
  end
  else begin
   weight_new2<=weight_final;
  end
  end
  
  //TO GENERATE OUTPUT OF WEIGHT OLD FROM DATA ARRAY
 always @(negedge clock) 
   begin
      weight_old<=dataArray[select_read];
          
   end
  
 endmodule 

//SHIFT RIGHT

module Shiftright( 
input Serial_in, 
input Clock,
input reset, 

output reg [15:0]Q);

initial
begin
Q<=0;
end
  
always @ (negedge Clock) 
begin 
if(reset) begin
Q<= 16'b0;
end
else begin
Q<={Serial_in, Q[15:1]}; 
end // always 
end
endmodule 


