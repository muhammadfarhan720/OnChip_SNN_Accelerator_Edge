module MUX_logic(mux_in_1,mux_in_2,mux_in_3,mux_in_4,mux_in_5,mux_in_6,mux_in_7,mux_in_8,mux_in_9,mux_in_10,mux_in_11,mux_in_12,mux_in_13,mux_in_14,mux_in_15,mux_in_16,sel,mux_out);
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
