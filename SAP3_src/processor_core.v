module processor_core(
	input clk,
	input rst,
	output [15:0] address_bus,
	output [7:0] data_bus
);





reg[15:0] bus;

wire hlt;


wire[4:0] reg_rd_sel;
wire[4:0] reg_wr_sel;
wire[1:0] reg_ext;
wire reg_oe;
wire reg_we;
wire[15:0] reg_out;
reg_file reg_file(
	.clk(clk),
	.rst(rst),
	.rd_sel(reg_rd_sel),
	.wr_sel(reg_wr_sel),
	.ext(reg_ext),
	.we(reg_we),
	.data_in(bus),
	.data_out(reg_out)
);

wire mem_mar_we;
wire mem_ram_we;
wire mem_oe;
wire[7:0] mem_out;
memory memory(
	.clk(clk),
	.rst(rst),
	.mar_we(mem_mar_we),
	.ram_we(mem_ram_we),
	.bus(bus),
	.out(mem_out)
);

wire ir_we;
wire[7:0] ir_out;
IR ir(
	.clk(clk),
	.rst(rst),
	.we(ir_we),
	.bus(bus[7:0]),
	.out(ir_out)
);

wire alu_cs;
wire alu_flags_we;
wire alu_a_we;
wire alu_a_store;
wire alu_a_restore;
wire alu_tmp_we;
wire alu_oe;
wire alu_flags_oe;
wire[4:0] alu_op;
wire[7:0] alu_flags;
wire[7:0] alu_out;
wire [7:0]alu_bus;
assign alu_bus = bus[7:0];
ALU alu(
	.clk(clk),
	.rst(rst),
	.cs(alu_cs),
	.flags_we(alu_flags_we),
	.a_we(alu_a_we),
	.a_store(alu_a_store),
	.a_restore(alu_a_restore),
	.tmp_we(alu_tmp_we),
	.op(alu_op),
	.bus(alu_bus),
	.flags(alu_flags),
	.out(alu_out)
);

wire out_we ;
wire [1:0] out_wr_sel;
controller controller(
	.clk(clk),
	.rst(rst),
	.opcode(ir_out),
	.flags(alu_flags),
	.ctrl_word({
		out_we,
		out_wr_sel,
		hlt,
		alu_cs,
		alu_flags_we,
		alu_a_we,
		alu_a_store,
		alu_a_restore,
		alu_tmp_we,
		alu_op,
		alu_oe,
		alu_flags_oe,
		reg_rd_sel,
		reg_wr_sel,
		reg_ext,
		reg_oe,
		reg_we,
		mem_ram_we,
		mem_mar_we,
		mem_oe,
		ir_we
		})
);


I_O_controller i_o_ctrl(
	.clk(clk),
	.rst(rst),
	.reg_we(out_we),
	.reg_sel(out_wr_sel),
	.bus(bus[7:0]),
	.out_address_bus(address_bus),
	.out_data_bus(data_bus)
);


always @(*) begin
	bus = 16'b0;

	if (reg_oe)
		bus = reg_out;
	else if (mem_oe)
		bus = {8'b0, mem_out};
	else if (alu_oe)
		bus = {8'b0, alu_out};
	else if (alu_flags_oe)
		bus = {8'b0, alu_flags};
end


endmodule