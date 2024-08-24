module Partial_Product_Generator
#(parameter	word_size = 8)
(
	input [word_size-1:0] a,b,
	output [word_size-1:0][word_size-1:0] PPs
);

genvar i;
genvar j;

generate
for(i = 0; i < word_size; i = i + 1) begin : multiplier
	for(j = 0; j < word_size; j = j + 1) begin : multiplicant
		and a0(PPs[i][j],a[j],b[i]);
	end
end
endgenerate

endmodule