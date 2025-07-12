module difference(clk,reset,datapre,datapost,out_time1,out_time2);
input clk;
input reset;
input [15:0]datapre;
input [15:0]datapost;
output reg signed [5:0]out_time1;
output reg signed [5:0]out_time2; 

reg [15:0]datapr;
reg [15:0]datapo;
reg signed [5:0]time2;

always@(*)
begin

if(datapost[15]==1)

begin
datapr<=datapre;
datapo<=datapost;
//else
//data<=0;

casex(datapr)
  
  16'b00001xxxxxxxxxxx:
  begin
  out_time1<=5'sd4;
  casex(datapo)
  16'b1xxxx1xxxxxxxxxx:out_time2<=5'sd5;
  16'b1xxxx01xxxxxxxxx:out_time2<=5'sd6;
  16'b1xxxx001xxxxxxxx:out_time2<=5'sd7;
  16'b1xxxx0001xxxxxxx:out_time2<=5'sd8;
  16'b1xxxx00001xxxxxx:out_time2<=5'sd9;
  16'b1xxxxxxxxxxxxxxx:out_time2<=5'd0;
  default:out_time2<=5'd0;
  endcase
  end
   
  16'b0001xxxxxxxxxxxx:
  begin
  out_time1<=5'sd3;
  casex(datapo)
  16'b1xxx1xxxxxxxxxxx:out_time2<=5'sd4;
  16'b1xxx01xxxxxxxxxx:out_time2<=5'sd5;
  16'b1xxx001xxxxxxxxx:out_time2<=5'sd6;
  16'b1xxx0001xxxxxxxx:out_time2<=5'sd7;
  16'b1xxx00001xxxxxxx:out_time2<=5'sd8;
  16'b1xxxxxxxxxxxxxxx:out_time2<=5'd0;
  default:out_time2<=5'd0;
  endcase
  end
  
  16'b001xxxxxxxxxxxxx:
  begin
  out_time1<=5'sd2;
  casex(datapo)
  16'b1xx1xxxxxxxxxxxx:out_time2<=5'sd3;
  16'b1xx01xxxxxxxxxxx:out_time2<=5'sd4;
  16'b1xx001xxxxxxxxxx:out_time2<=5'sd5;
  16'b1xx0001xxxxxxxxx:out_time2<=5'sd6;
  16'b1xx00001xxxxxxxx:out_time2<=5'sd7;
  16'b1xxxxxxxxxxxxxxx:out_time2<=5'd0;
  default:out_time2<=5'd0;
  endcase
  end
  
  
  
  16'b01xxxxxxxxxxxxxx:
  begin
  out_time1<=5'sd1;
  casex(datapo)
  16'b1x1xxxxxxxxxxxxx:out_time2<=5'sd2;
  16'b1x01xxxxxxxxxxxx:out_time2<=5'sd3;
  16'b1x001xxxxxxxxxxx:out_time2<=5'sd4;
  16'b1x0001xxxxxxxxxx:out_time2<=5'sd5;
  16'b1x00001xxxxxxxxx:out_time2<=5'sd6;
  16'b1xxxxxxxxxxxxxxx:out_time2<=5'd0;
  default:out_time2<=5'd0;
  endcase
  end
  
  16'b1xxxxxxxxxxxxxxx:
  begin
  out_time1<=5'sd0;
  out_time2<=5'd0;
  end
  
  default:out_time1<=5'd0;
  endcase 
  
  end
  
  else if (datapre[15]==1)
  begin
   datapr<=datapre;
   datapo<=datapost;
  
  
casex(datapo)

  16'b00001xxxxxxxxxxx:
  begin
  out_time1<=-5'sd4;
  casex(datapr)
  16'b1xxxx1xxxxxxxxxx:out_time2<=5'sd5;
  16'b1xxxx01xxxxxxxxx:out_time2<=5'sd6;
  16'b1xxxx001xxxxxxxx:out_time2<=5'sd7;
  16'b1xxxx0001xxxxxxx:out_time2<=5'sd8;
  16'b1xxxx00001xxxxxx:out_time2<=5'sd9;
  16'b1xxxxxxxxxxxxxxx:out_time2<=5'd0;
  default:out_time2<=5'd0;
  endcase
  end
  
  16'b0001xxxxxxxxxxxx:
  begin
  out_time1<=-5'sd3;
  casex(datapr)
  16'b1xxx1xxxxxxxxxxx:out_time2<=5'sd4;
  16'b1xxx01xxxxxxxxxx:out_time2<=5'sd5;
  16'b1xxx001xxxxxxxxx:out_time2<=5'sd6;
  16'b1xxx0001xxxxxxxx:out_time2<=5'sd7;
  16'b1xxx00001xxxxxxx:out_time2<=5'sd8;
  16'b1xxxxxxxxxxxxxxx:out_time2<=5'd0;
  default:out_time2<=5'd0;
  endcase
  end
  
  16'b001xxxxxxxxxxxxx:
  begin
  out_time1<=-5'sd2;
  casex(datapr)
  16'b1xx1xxxxxxxxxxxx:out_time2<=5'sd3;
  16'b1xx01xxxxxxxxxxx:out_time2<=5'sd4;
  16'b1xx001xxxxxxxxxx:out_time2<=5'sd5;
  16'b1xx0001xxxxxxxxx:out_time2<=5'sd6;
  16'b1xx00001xxxxxxxx:out_time2<=5'sd7;
  16'b1xxxxxxxxxxxxxxx:out_time2<=5'd0;
  default:out_time2<=5'd0;
  endcase
  end
  
  
  16'b01xxxxxxxxxxxxxx:
  begin
  out_time1<=-5'sd1;
  casex(datapr)
  16'b1x1xxxxxxxxxxxxx:out_time2<=5'sd2;
  16'b1x01xxxxxxxxxxxx:out_time2<=5'sd3;
  16'b1x001xxxxxxxxxxx:out_time2<=5'sd4;
  16'b1x0001xxxxxxxxxx:out_time2<=5'sd5;
  16'b1x00001xxxxxxxxx:out_time2<=5'sd6;
  16'b1xxxxxxxxxxxxxxx:out_time2<=5'd0;
  default:out_time2<=5'd0;
  endcase
  end
  
  
  
  16'b1xxxxxxxxxxxxxxx:
  begin
  out_time1<=5'sd0;
  out_time2<=5'd0;
  end
  
  
  default:out_time1<=5'd0;
  
 endcase 
   
end
    
 else begin
  out_time1<=5'sd0;
  out_time2<=5'd0;
 end
end  
  
endmodule