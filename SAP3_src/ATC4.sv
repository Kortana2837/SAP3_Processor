module ATC4
#(parameter word_size = 11,pp_num = 4)(
	input 	[pp_num-1:0][word_size-1:0] 		D,
	output 	[(pp_num/2)-1:0][word_size-1:0] 	P,
	output 	[word_size-1:0] 						V
);

wire [(pp_num/2)-1:0][word_size-1:0] Q;

// Generate the Vector
assign V = Q[0] | Q[1];

// Approximate tree compressor
genvar i;
generate 
	for(i = 0; i < pp_num/2; i = i + 1) begin : iCAC_tree
		iCAC_rows #(word_size) icac_row0(D[i*2],D[(i*2)+1],P[i],Q[i]);
	end
endgenerate

endmodule

