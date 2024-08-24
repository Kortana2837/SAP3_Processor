module CMA_FA(
	input x,y,c_in,mask_x,
	output s,c_out
);

assign s = c_in ^ ((x | y) & ~(x & y & mask_x));
assign c_out = ~(~(x & y & mask_x) & ~(c_in & ((x | y) & ~(x & y & mask_x))));

endmodule