module memory(
	input clk,
	input rst,
	input mar_we,
	input ram_we,
	input[15:0] bus,
	output[7:0] out
);

initial begin
	$readmemh("E\:addition_program.txt", ram);
end

reg[15:0] mar;
reg[7:0]  ram[0:65535];

always @(posedge clk or negedge rst) begin
	if (!rst)
		mar <= 16'b0;
	else if (mar_we)
		mar <= bus;
end

always @(posedge clk) begin
	if (ram_we)
		ram[mar] <= bus[7:0];
end

assign out = ram[mar];

endmodule