module yang_multiplier
#(parameter word_size = 8)(
	input [word_size - 1:0] a,b,
	input [6:0] accuracy,
	output [(word_size * 2) - 1:0] out
);


wire [word_size-1:0][word_size-1:0] PPs;
wire 	[14:0] 		P7;
wire 	[14:0]		Q7;
wire 	[12:0]		V1;
wire 	[10:0]		V2;
wire [14:0] stage3_out1;
wire [12:0] stage3_out2;
wire [14:0] stage2_out1;
wire [12:0] stage2_out2;
wire [10:0] stage2_out3;

Partial_Product_Generator #(word_size) PPG (a,b,PPs);
Stage1(PPs,P7,Q7,V1,V2);
Stage2(Q7,V1,V2,stage2_out1,stage2_out2,stage2_out3);
Stage3(stage2_out1,stage2_out2,stage2_out3,stage3_out1,stage3_out2);
Stage4(stage3_out1,stage3_out2,accuracy,out);

endmodule




