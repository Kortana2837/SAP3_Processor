module CMA_HA(
	input x,y,mask_x,
	output s,c_out
);

assign s = ~(x & y & mask_x) & (x | y);
assign c_out = x & y & mask_x;

endmodule