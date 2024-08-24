module leds(
	input CLK
);
	
reg [7:0] values [31:0];

reg st = 0;
reg [4:0] counter = 0;
	
	
always @(posedge CLK) begin
	if (st == 0 ) begin
		values[0] = 0;
		values[1] = 1;
		values[2] = 1;
		values[3] = 2;
		values[4] = 3;
		values[5] = 5;
		values[6] = 8;
		values[7] = 13;
		values[8] = 21;
		values[9] = 34;
		values[10] = 55;
		values[11] = 89;
		values[12] = 144;
		values[13] = 233;
		st = 1;
	end else begin
		counter <= counter + 1;
	end

end

endmodule