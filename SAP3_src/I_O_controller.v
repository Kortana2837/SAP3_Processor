module I_O_controller(
	input 	wire 			clk,
	input 	wire 			rst,
	input 	wire 			reg_we,
	input 	wire [1:0]  reg_sel,
	input 	wire [7:0] 	bus,
	output 	wire [15:0]	out_address_bus,
	output 	wire [7:0]		out_data_bus
);

reg [15:0] out_address_reg;
reg [7:0]  out_data_reg;

localparam REG_ADDR_L = 2'd0;
localparam REG_ADDR_H = 2'd1;
localparam REG_DATA   = 2'd2;

assign out_data_bus 	  = 	 out_data_reg;
assign out_address_bus = out_address_reg;

always@(posedge clk or negedge rst) begin
	if (!rst) begin
		out_address_reg = 0;
		out_data_reg    = 0;
	end
	else if (reg_we) begin
		if			(reg_sel == REG_ADDR_L)	out_address_reg[7:0] 	<= bus;	
		else if	(reg_sel == REG_ADDR_H)	out_address_reg[15:8] 	<= bus;
		else if	(reg_sel == REG_DATA)		out_data_reg 			<= bus;
	end
end





endmodule