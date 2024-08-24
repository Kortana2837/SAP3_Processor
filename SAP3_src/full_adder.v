module full_adder(
	input a, b, cin, 
	output s, c);
	
  assign s = a ^ b ^ cin;
  assign c = (a & b) | (b & cin) | (a & cin);
  
endmodule