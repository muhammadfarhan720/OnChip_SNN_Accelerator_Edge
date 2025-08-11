

`timescale 1ns / 1ps
//Testbench for out square root calculator design.
module tb;  //testbench module is always empty. No input or output ports.

//reg write;
reg postsynapSR0;

reg presynapSR1;
reg presynapSR2;


reg presynapSR3;
reg presynapSR4;
reg presynapSR5;
reg presynapSR6;
reg presynapSR7;
reg presynapSR8;
reg presynapSR9;
reg presynapSR10;
reg presynapSR11;
reg presynapSR12;
reg presynapSR13;
reg presynapSR14;
reg presynapSR15;
reg presynapSR16;

reg [3:0] select;

reg clock;

wire signed [2:0] time_difference;
wire [15:0]mux_synapse;
wire  [15:0]postreg;


wire [15:0]preonereg;
wire [15:0]pretworeg;

wire [15:0]prethreereg;
wire [28:0] stdp_val;
wire [3:0] weight_old;
wire [3:0] weight_new;
wire [3:0] weight_try;

//wire [3:0] weight_old_final;
square_root tb ( postsynapSR0, presynapSR1, presynapSR2,presynapSR3, presynapSR4, presynapSR5, presynapSR6, presynapSR7,presynapSR8, presynapSR9, presynapSR10, presynapSR11, presynapSR12,
                 presynapSR13, presynapSR14, presynapSR15, presynapSR16, select, clock, time_difference,mux_synapse,postreg,preonereg,pretworeg,prethreereg,weight_new, weight_old, weight_try);


initial 
begin
presynapSR1<=1;
#50;
presynapSR1<=0;
#100;
presynapSR1<=1;
#150;
presynapSR1<=0;
#200;
presynapSR1<=1;
end


//initial 
//begin
//write<=0;
//#50;
//write<=1;
//end






initial 
begin

select=4'd2;

#550;

select=4'd1;



end


initial 
begin
presynapSR3<=1;
#20;
presynapSR3<=0;
#40;
presynapSR3<=1;
#120;
presynapSR3<=0;
#150;
presynapSR3<=1;
end




initial 
begin
presynapSR2<=0;
#50;
presynapSR2<=1;
#50;

presynapSR2<=0;
#100;

presynapSR2<=1;
#50;


presynapSR2<=0;
#50;

presynapSR2<=1;
end

initial 
begin

postsynapSR0<=1;

forever begin #100 postsynapSR0=~postsynapSR0;
end
end




always
begin
clock = 1'b0;
forever begin #50 clock = ~clock;

end 
end
endmodule 