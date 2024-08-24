module Stage2(
	input		[14:0]		P7,
	input 	[14:0]		Q7,
	input 	[12:0]		V1,
	input 	[10:0]		V2,
	output [14:0] a,
	output [12:0] b,
	output [10:0] c
);

assign a = P7;
assign b[2:0] = V1[2:0];
assign b[9:3] = V1[9:3] | V2[8:2];
assign b[12:10] = V1[12:10];
assign c[1:0] = V2[1:0];
assign c[8:2] = Q7[10:4];
assign c[10:9] = V2[10:9];
endmodule