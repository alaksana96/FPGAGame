module BCD_Counter ( clk ,reset,dout, clkout );

output [3:0] dout ;
reg [3:0] dout ;

output clkout;
reg clkout;

input clk ;
wire clk ;

input reset ;
wire reset ;

initial dout = 0 ;

always @ (posedge (clk) or posedge reset) begin
	if(reset) begin
		dout <= 0;
		clkout <= 0;
	
	end else if(dout < 9) begin
		dout <= dout + 1;
		clkout <= 0;
	end else begin
		dout <= 0;
		clkout <= ~clkout;
	end
end
endmodule
