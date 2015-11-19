module signExtendu(d, q); //sign extend unsigned
	input[4:0] d;
	input clock;
	output[31:0] q;
	wire[4:0] d;
	wire[31:0] q;
	always @(d && posedge) 
		q = d;
endmodule
