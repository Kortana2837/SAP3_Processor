module io_prephiral
#(parameter address_word_size = 16,
				data_word_size 	= 8,
				module_address		= 16'h02)
(
	input 	wire rst,
	input 	wire [address_word_size-1:0] address_bus,
	input 	wire [data_word_size-1:0] data_bus,
	output 	reg  [data_word_size-1:0]data
);

always@(*) begin
	if(!rst)											data <= 0;
	else if(address_bus == module_address) data <= data_bus;
end

endmodule