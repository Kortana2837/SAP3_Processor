module iCAC(
	input a,b,
	output p,q
);

assign p = a & b;
assign q = a | b;

endmodule