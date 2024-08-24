module iCAC_rows
#(parameter word_size = 8)(
	input 	[word_size-1:0] a,b,
	output 	[word_size-1:0] p,q
);
genvar i;
generate 
	for(i = 0; i < word_size; i = i + 1) begin : iCAC_row
		iCAC icac0(a[i],b[i],p[i],q[i]);
	end
endgenerate
endmodule