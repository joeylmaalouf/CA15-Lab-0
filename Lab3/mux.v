module mux32(
	input[31:0] a,
	input[31:0] b,
	input selector,
	output[31:0] c
);
	
	always@(a or b or selector) begin
		if (selector == 0) begin
			c = a;
		end
		else if (selector == 1) begin
			c = b;
		end
	end
endmodule

module mux5(
	input[4:0] a,
	input[4:0] b,
	input selector,
	output[4:0] c
);
	
	always@(a or b or selector) begin
		if (selector == 0) begin
			c = a;
		end
		else if (selector == 1) begin
			c = b;
		end
	end
endmodule

module mux2(
	input a,
	input b,
	input selector,
	output c
);

	always@(a or b or selector) begin
		if (selector == 0) begin
			c = a;
		end
		else if (selector == 1) begin
			c = b;
		end
	end
endmodule