

`timescale 1ns / 1ps
//Testbench for out square root calculator design.
module tb;  //testbench module is always empty. No input or output ports.
reg reset;
reg write;
reg postsynapSR0;

reg presynapSR1;
reg presynapSR2;

reg [3:0] select;

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

//wire [3:0] select;

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

wire [3:0]select_minus;

wire [3:0]dataArray [15:0];

wire [3:0]weight_new2;

wire signed [2:0] time_difference_new;
//wire [3:0] weight_old_final;
square_root module_sqrt ( reset,write,postsynapSR0, presynapSR1, presynapSR2,presynapSR3, presynapSR4, presynapSR5, presynapSR6, presynapSR7,presynapSR8, presynapSR9, presynapSR10, presynapSR11, presynapSR12,
                 presynapSR13, presynapSR14, presynapSR15, presynapSR16,select,clock, time_difference,mux_synapse,postreg,preonereg,pretworeg,prethreereg,weight_new, weight_old, dataArray,weight_new2,time_difference_new);


always 
begin
@(negedge clock);
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


initial 
begin
write<=0;
#10;
write<=1;
end




initial 
begin
reset<=0;
#10;
reset<=1;
#10;
reset<=0;
end





always@(negedge clock) 
begin

select=4'd0;

@(negedge clock);

select=4'd1;

@(negedge clock);


select=4'd2;

@(negedge clock);

select=4'd3;

@(negedge clock);

select=4'd4;


@(negedge clock);

select=4'd5;


@(negedge clock);

select=4'd6;


@(negedge clock);

select=4'd7;


@(negedge clock);

select=4'd8;


@(negedge clock);

select=4'd9;


@(negedge clock);

select=4'd10;


@(negedge clock);

select=4'd11;


@(negedge clock);

select=4'd12;


@(negedge clock);

select=4'd13;


@(negedge clock);

select=4'd14;


@(negedge clock);

select=4'd15;


@(negedge clock);

select=4'd0;


end


always  
begin
presynapSR3<=1;
#100;
presynapSR3<=0;
#200;
presynapSR3<=1;
#300;
presynapSR3<=0;
#400;
presynapSR3<=1;
end




always
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