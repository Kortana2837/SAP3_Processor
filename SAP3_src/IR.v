module IR(
	input clk,
	input rst,
	input we,
	input[7:0] bus,
	output[7:0] out
);

reg[7:0] ir;

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		ir <= 8'b0;
	end else if (we) begin
		ir <= bus;
	end
end

assign out = ir;

endmodule