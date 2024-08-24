module MAR(
	input 	wire 			clk,
	input 	wire 			rst,
	input 	wire 			we,
	input 	wire [15:0] bus,
	output 	wire 			address
);

reg [15:0] mar;


assign address = mar;

always@(posedge clk or negedge rst) begin

	if(!rst) mar <= 16'b0;
	else if (we) mar <= bus;
	
end
endmodule