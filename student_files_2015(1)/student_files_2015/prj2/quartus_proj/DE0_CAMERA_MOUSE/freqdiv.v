module frediv(clk, clk_out);
input clk;

output reg clk_out;
reg [19:0] counter;

always @(posedge clk)
begin
if(counter==20'd500000)
	begin
	counter<=20'd0;
	clk_out <= ~clk_out;
	end
else
	begin
	counter<=counter+1;
	end
end

endmodule