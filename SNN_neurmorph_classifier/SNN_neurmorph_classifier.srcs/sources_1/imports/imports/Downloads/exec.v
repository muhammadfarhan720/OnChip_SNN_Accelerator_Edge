module exec(xvar,
exvar);

//no sign bit needed because all inputs are negative
//keep 6 bits for integer and 10 bits for fractional bits

input wire signed [15:0]xvar;
output wire signed [15:0]exvar;
reg signed [15:0]x1;
reg signed [15:0]x4;
reg signed [5:0]xi;
reg signed [5:0]xi_comp;
reg signed [15:0]xf;
reg [2:0]true_bits;
reg signed [15:0]outvar;

always@(*) begin
x1 = xvar + (xvar >>> 1);
x4 = x1 - (xvar >>> 4);

xi = x4[15:10];

xf = {6'b000001,x4[9:0]};


xi_comp = ~xi + 1'b1;

outvar =(xf >> (true_bits));
end

always@(*) begin

//true_bits = (xi_comp[4] & 1'b1) + (xi_comp[3] & 1'b1) + (xi_comp[2] & 1'b1) + (xi_comp[1] & 1'b1) + (xi_comp[0] & 1'b1);
if(xi_comp[4] & 1'b1)
   true_bits = 3'd5;
else if(xi_comp[3] & 1'b1)
   true_bits = 3'd4;
else if(xi_comp[2] & 1'b1)
   true_bits = 3'd3;
else if(xi_comp[1] & 1'b1)
   true_bits = 3'd2;
else if(xi_comp[0] & 1'b1)
   true_bits = 3'd1;
else 
   true_bits = 3'd0;
end

assign exvar = outvar;

endmodule
