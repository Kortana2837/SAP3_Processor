module Stage3(
	input [14:0] a,
	input [12:0] b,
	input [10:0] c,
	output [14:0] out1,
	output [12:0] out2
);


assign out1[0] = a[0];
half_adder ha0(a[1], b[0], out1[1], out1[2]);
full_adder fa1(a[2], b[1], c[0], out2[0], out1[3]);
full_adder fa2(a[3], b[2], c[1], out2[1], out1[4]);
full_adder fa3(a[4], b[3], c[2], out2[2], out1[5]);
full_adder fa4(a[5], b[4], c[3], out2[3], out1[6]);
full_adder fa5(a[6], b[5], c[4], out2[4], out1[7]);
full_adder fa6(a[7], b[6], c[5], out2[5], out1[8]);
full_adder fa7(a[8], b[7], c[6], out2[6], out1[9]);
full_adder fa8(a[9], b[8], c[7], out2[7], out1[10]);
full_adder fa9(a[10], b[9], c[8], out2[8], out1[11]);
full_adder fa10(a[11], b[10], c[9], out2[9], out1[12]);
full_adder fa11(a[12], b[11], c[10], out2[10], out1[13]);
half_adder ha1(a[13], b[12], out2[11], out1[14]);
assign out2[12] = a[14];

endmodule