//Potentiation weight change
// TSTDP Module
// Model Parameters:
// ---------------------------------------------
// tauX = 2^(10)     = 1024
// tauY = 2^(5)      = 32
// tauPlus 2^(4)     = 16
// tauMinus = 2^(7)  = 128
// A2Plus = 2^(-12)  = 0.00024414062
// A2Minus = 2^(-9)  = 0.001953125
// A3Plus = 2^(-7)   = 0.0078125
// A3Minus = 2^(-10) = 0.0009765625

module weight_change(
deltat1,
deltat2,
weight_initial,
weight_final);

parameter tau_plus = 4;
parameter tau_y = 5;
parameter a2_plus =  12;
parameter a3_plus =  7;
parameter a2_minus =  9;
parameter a3_minus =  10;


input wire signed [5:0]deltat1;
input wire signed [5:0]deltat2;
input wire  [15:0]weight_initial; //initial weight is also a fixed point;
output reg  [15:0]weight_final; //]fixed point number with 6 integer and 10 fractional digits

reg signed [15:0]xvar1;
reg signed [15:0]xvar2;
reg signed [15:0]xvar4;
reg signed [15:0]xvar5;
wire signed [15:0]exvar4;
wire signed [15:0]exvar5;
reg signed [15:0]delta_weight;
reg signed [15:0]delta_weight1;
reg signed [15:0]delta_weight2;
reg signed [5:0]deltat3;
reg signed [5:0]deltat4;

always@(*)
begin
   deltat3 = ~(deltat1);
   deltat4 = ~(deltat2);
end

always@(*)
begin
   if(deltat1 >= 0) begin    //Potentiation Case
   xvar1 = {deltat1,10'b0000000000} >>> 4;
   xvar2 = ({deltat2,10'b0000000000} >>> 5) + ({deltat1,10'b0000000000} >>> 4);
   end
   else begin          //Depression case
   xvar1 = {(deltat3),10'b000000000} >>> 7;
   xvar2 = ({(deltat4),10'b000000000} >>> 10) + ({deltat3,10'b0000000000} >>> 7);
   end
end

always@(*)
begin
              //since delta t1/tau+ is pos and t1/tau+ + t2/tauy  is pos 
   xvar4 = ~xvar1;
   xvar5 = ~xvar2;
end
  

exec exec01 (.xvar(xvar4),.exvar(exvar4));
exec exec02 (.xvar(xvar5),.exvar(exvar5));

always@(*)
begin
   if(deltat1 > 0 & deltat2 >0) begin
   delta_weight1 = exvar4 >>> a2_plus;
   delta_weight2 = exvar5 >>> a3_plus;
   delta_weight = delta_weight1 + delta_weight2 ;
   weight_final = weight_initial + delta_weight ;
   end
   else if(deltat1 <0 & deltat2 >0)begin
   delta_weight1 = exvar4 >>> a2_minus;
   delta_weight2 = exvar5 >>> a3_minus;
   delta_weight = delta_weight2 - delta_weight1 ;
   weight_final = weight_initial + delta_weight ;
   end
   else begin
   delta_weight = 16'd0;
   weight_final = weight_initial + delta_weight;
   end
   
end
endmodule

