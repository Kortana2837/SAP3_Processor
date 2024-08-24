module processor_core_tb();
integer i;

reg rst;
reg clk;

wire [15:0] address_bus;
wire [7:0] data_bus;

processor_core DUT(
	clk,
	rst,
	address_bus,
	data_bus
);



initial begin
	clk = 0;
	rst = 1'b1;
	
	#1;
	rst = 1'b0;
	#1;
	rst = 1'b1;
	
	
	for (i = 0; i < 3000; i = i + 1) begin
		#10 clk = ~clk;
	end
end



endmodule