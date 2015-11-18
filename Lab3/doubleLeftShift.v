module doubleLeftShift(d, q, enable)
	
	input[31:0] d;
	input       enable;
	reg[31:0]   q;
	wire[31:0]  d;
	reg[31:0]   q;
	wire        enable;

	always@(enable) begin
		input << 2;				
	end
endmodule
