module wallace_tree_multiplier
#(parameter word_size = 8)
(
	input [word_size-1:0] a,b,
	output [(word_size * word_size) - 1:0] s
);

wire [word_size-1:0][word_size-1:0] PPs;

Partial_Product_Generator #(word_size) PPG	(a,b,PPs);


endmodule