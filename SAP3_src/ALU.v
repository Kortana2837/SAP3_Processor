module ALU(
	input 	wire 			clk,
	input 	wire 			rst,
	input 	wire 			a_store,
	input 	wire 			a_restore,
	input 	wire 			a_we,
	input 	wire 			tmp_we,
	input 	wire 			flags_we,
	input    wire 			cs,
	input    wire [6:0]	accuracy,
	input 	wire [4:0]	op,
	inout 	wire [7:0]	bus,
	output 	reg  [7:0]	flags,
	output	wire [7:0]  out
);


reg [7:0] Acc;
reg [7:0] tmp;
reg [7:0] tmp2;

assign out = Acc;

reg carry;

localparam FLG_Z = 0;
localparam FLG_C = 1;
localparam FLG_P = 2;
localparam FLG_S = 3;


localparam OP_ADD = 5'b00000;
localparam OP_ADC = 5'b00001;
localparam OP_SUB = 5'b00010;
localparam OP_SBB = 5'b00011;
localparam OP_ANA = 5'b00100;
localparam OP_XRA = 5'b00101;
localparam OP_ORA = 5'b00110;
localparam OP_CMP = 5'b00111;
localparam OP_RLC = 5'b01000;
localparam OP_RRC = 5'b01001;
localparam OP_RAL = 5'b01010;
localparam OP_RAR = 5'b01011;
localparam OP_DAA = 5'b01100; // Unsupported
localparam OP_CMA = 5'b01101;
localparam OP_STC = 5'b01110;
localparam OP_CMC = 5'b01111;
localparam OP_INR = 5'b10000;
localparam OP_DCR = 5'b10001;
localparam OP_Approx = 5'b10010;

assign flg_c = (carry == 1'b1);
assign flg_z = (Acc[7:0] == 8'b0);
assign flg_s = Acc[7];
assign flg_p = ~^Acc[7:0];

always@(posedge clk or negedge rst) begin
	if(!rst) begin
		Acc 	<= 8'b0;
		tmp 	<= 8'b0;
		tmp2 	<= 8'b0;
	end
	else begin
	if (a_we) begin
			Acc <= bus;
		end else if (a_restore) begin
			Acc <= tmp2;
		end else if (cs) begin
		case(op) 
			OP_ADD : {carry,Acc} <= Acc + tmp;
			OP_ADC : {carry,Acc} <= Acc + tmp + flags[FLG_C];
			OP_SUB : {carry,Acc} <= Acc - tmp;
			OP_SBB : {carry,Acc} <= Acc - tmp - flags[FLG_C];
			OP_ANA : {carry,Acc} <= Acc & tmp;
			OP_XRA : {carry,Acc} <= Acc ^ tmp;
			OP_ORA : {carry,Acc} <= Acc | tmp;
			OP_CMP : 		 tmp2 <= Acc - tmp;
			OP_RLC : begin
								carry <= Acc[7];
								  Acc <= Acc << 1;
						end
			OP_RRC : begin
								carry <= Acc[0];
								  Acc <= Acc >> 1;
						end
			OP_RAL : begin
								carry <= Acc[7];
								  Acc <= (Acc << 1 | {7'b0, flags[FLG_C]});
						end
			OP_RAR : begin
								carry <= Acc[0];
								  Acc <= (Acc >> 1 | {flags[FLG_C], 7'b0});
						end
			//OP_DAA : {carry,Acc} <= Acc + tmp; // Unsupported
			OP_CMA : begin
								  Acc <= ~Acc;
						end
			OP_STC : begin
								carry <= 1;
						end
			OP_CMC : begin
								carry <= ~flags[FLG_C];
						end
			OP_INR : begin
								  Acc <= Acc + 1;
						end
			OP_DCR : begin
								  Acc <= Acc - 1;
						end
			OP_Approx : begin
									Acc <= Acc_approx;
			end
		endcase	
		end
		if(a_store) tmp2 <= Acc;
	if(tmp_we)  tmp <= bus;
	end
	
	
end

reg [7:0] Acc_approx;
yang_multiplier approx0(Acc,tmp,accuracy,Acc_approx);

always @(negedge clk or negedge rst) begin

	if(!rst) 				flags <= 8'b0;
	else if (flags_we)   flags <= bus;
	else begin
		if (cs) begin
			case (op)
				OP_ADD, OP_ADC, OP_SUB, OP_SBB, OP_ANA, OP_XRA, OP_ORA: begin
					flags[FLG_C] <= flg_c;
					flags[FLG_Z] <= flg_z;
					flags[FLG_S] <= flg_s;
					flags[FLG_P] <= flg_p;
				end

				OP_CMP: begin
					flags[FLG_Z] <= (tmp2 == 8'b0);
				end

				OP_INR, OP_DCR: begin
					flags[FLG_Z] <= flg_z;
					flags[FLG_S] <= flg_s;
					flags[FLG_P] <= flg_p;
				end

				OP_RLC, OP_RRC, OP_RAL, OP_RAR, OP_STC, OP_CMC: begin
					flags[FLG_C] <= flg_c;
				end
			endcase
		end
	end
end
endmodule