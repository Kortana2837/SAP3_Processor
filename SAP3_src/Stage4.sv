module Stage4(
	input [14:0] a,
	input [12:0] b,
	input [6:0] mask_x,
	output [15:0] out
);

wire [8:0] c_out;
// Truncated part
assign out[1:0] 	= a[1:0];
assign out[2] 		= a[2] | b[0];
assign out[3] 		= a[3] | b[1];
assign out[4] 		= a[4] | b[2];

// Controllable part
CMA_HA CMA_ha0(a[5],	b[3],				mask_x[0],out[5], c_out[0]);
CMA_FA CMA_fa0(a[6],	b[4],c_out[0],	mask_x[1],out[6], c_out[1]);
CMA_FA CMA_fa1(a[7],	b[5],c_out[1],	mask_x[2],out[7], c_out[2]);
CMA_FA CMA_fa2(a[8],	b[6],c_out[2],	mask_x[3],out[8], c_out[3]);
CMA_FA CMA_fa3(a[9],	b[7],c_out[3],	mask_x[4],out[9], c_out[4]);
CMA_FA CMA_fa4(a[10],b[8],c_out[4],	mask_x[5],out[10],c_out[5]);
CMA_FA CMA_fa5(a[11],b[9],c_out[5],	mask_x[6],out[11],c_out[6]);

// Accurate part
full_adder fa0(a[12], b[10], c_out[6], out[12], c_out[7]);
full_adder fa1(a[13], b[11], c_out[7], out[13], c_out[8]);
full_adder fa2(a[14], b[12], c_out[8], out[14], out[15]);

endmodule