module microcontroller
#(parameter i_o_pins 			= 8,
				address_word_size = 16,
				data_word_size		= 8)
(
	input clk,
	input rst,
	inout [i_o_pins-1:0]i_o_bank0
);

wire [address_word_size-1:0]address_bus;
wire [data_word_size-1:0]data_bus;

processor_core core0(
	clk,
	rst,
	address_bus,
	data_bus
);

io_prephiral #(address_word_size,data_word_size,16'h02) i_o_bank0_prephiral
(
	rst,
	address_bus,
	data_bus,
	i_o_bank0
);
endmodule