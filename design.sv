/* Code your design here*/
module dff(
  input clk,
  input rst,
  input [15:0] din,
  output reg [15:0] dout);
  
  always @(posedge clk)
    begin
      if(rst) begin
        dout <= 16'd0;
      end
      else begin
        dout <= din;
      end
    end
endmodule
