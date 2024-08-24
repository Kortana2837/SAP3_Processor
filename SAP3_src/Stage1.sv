module Stage1(
	input 	[7:0][7:0] 	PPs,
	output 	[14:0] 		P7,
	output 	[14:0]		Q7,
	output 	[12:0]		V1,
	output 	[10:0]		V2
	
);

wire [7:0][8:0] 	PPs_modified_1;
wire [3:0][10:0] 	PPs_modified_2;
wire [1:0][14:0] 	PPs_modified_3;
wire [3:0][8:0]	P1234;
wire [1:0][10:0]	P56;

assign PPs_modified_1[0] = {PPs[0],1'b0};
assign PPs_modified_1[1] = {1'b0,PPs[1]};
assign PPs_modified_1[2] = {PPs[2],1'b0};
assign PPs_modified_1[3] = {1'b0,PPs[3]};
assign PPs_modified_1[4] = {PPs[4],1'b0};
assign PPs_modified_1[5] = {1'b0,PPs[5]};
assign PPs_modified_1[6] = {PPs[6],1'b0};
assign PPs_modified_1[7] = {1'b0,PPs[7]};

assign PPs_modified_2[0] = {P1234[0],1'b0,1'b0};
assign PPs_modified_2[1] = {1'b0,1'b0,P1234[1]};
assign PPs_modified_2[2] = {P1234[2],1'b0,1'b0};
assign PPs_modified_2[3] = {1'b0,1'b0,P1234[3]};

assign PPs_modified_3[0] = {P56[0],1'b0,1'b0,1'b0,1'b0};
assign PPs_modified_3[1] = {1'b0,1'b0,1'b0,1'b0,P56[1]};



ATC8	ATC8_0(PPs_modified_1,P1234,V1);
ATC4	ATC4_0(PPs_modified_2,P56,V2);
iCAC_rows #(.word_size(15)) iCAC_row0(PPs_modified_3[0],PPs_modified_3[1],P7,Q7);

endmodule