`define XOR xor #60
`define AND and #30
`define OR or #30
`define NOT not #10

module ander(
  output c,
  input a,
  input b
);
  `AND(c, a, b);
endmodule

module orrer(
  output c,
  input a,
  input b
);
  `OR(c, a, b);
endmodule

module inverter(
	output out,
	input a
);
	`NOT(out, a);
endmodule

module xorrer(
	output c,
	input a,
	input b
);
	`XOR(c, a, b);
endmodule

module bitwiseAND(
  output reg[31:0] out,
  input[31:0] a, b
);
  reg placeholder_1, placeholder_2;
  wire k;
  ander myAnder(k, placeholder_1, placeholder_2);
  integer i;
  always @ (a or b) begin
    #0; //Lel this has to be here or it won't work    getrekt/10
    for (i = 0; i < 32; i = i + 1) begin
      placeholder_1 = a[i];
      placeholder_2 = b[i];
      #30;
      out[i] = k;
    end
  end
endmodule 

module bitwiseOR(
  output reg[31:0] out,
  input[31:0] a, b
);
  reg p1, p2;
  wire k;
  orrer myOrrer(k, p1, p2);
  integer i;
  always @ (a or b) begin
    #0; //Lel this has to be here or it won't work    getrekt/10
    for (i = 0; i < 32; i = i + 1) begin
      p1 = a[i];
      p2 = b[i];
      #40;
      out[i] = k;
    end
  end
endmodule

module bitwiseINV(
	output reg[31:0] out,
	input[31:0] a
);
	reg p;
	wire k;
	inverter myInverter(k, p);
	integer i;
	always @ (a) begin
		#26; //25 WONT WORK NUH UH NO SIR
		for (i = 0; i < 32; i = i + 1) begin
			p = a[i];
			#20;
			out[i] = k;
		end
	end
endmodule

module bitwiseXOR(
	output reg[31:0] out,
	input[31:0] a,
	input[31:0] b
);
	reg p1;
	reg p2;
	wire k;
	integer i;
	xorrer myXorrer(k, p1, p2);
	always @ (a or b) begin
		#0; //Lel this has to be here or it won't work    getrekt/10
		for (i = 0; i < 32; i = i + 1) begin
			p1 = a[i];
			p2 = b[i];
			#60;
			out[i] = k;
		end
	end
endmodule
