`define XOR xor #60
`define AND and #30
`define OR or #30
`define NOT not #10

module FullAdder(out, carryout, a, b, carryin);
  output out, carryout;
  input a, b, carryin;
  wire AxorB, carryout_condition1, carryout_condition2;
  `XOR xor1(AxorB, a, b);
  `AND and1(carryout_condition1, AxorB, carryin); // If only one of a and b is high, and carryin is high, then carryout is high
  `AND and2(carryout_condition2, a, b); // If both a and b are high, then carryout is high
  `OR or1(carryout, carryout_condition1, carryout_condition2);
  `XOR xor2(out, AxorB, carryin); // Sum is high only when only one of a or b is high or both are matching values and carryin is high
endmodule

module bitwiseADD(
  output reg[31:0] out,
  output reg overflow,
  input[31:0] a, b,
  input carryin
);
  wire carryout, outBit;
  reg aBit, bBit, carryBit;
  FullAdder adder(outBit, carryout, aBit, bBit, carryBit);
  integer i;
  always @ (a or b or carryin) begin
    #670;
    carryBit = carryin;
    for (i = 0; i < 32; i = i + 1) begin
      aBit = a[i];
      bBit = b[i];
      #120;
      out[i] = outBit;
      carryBit = carryout;
    end
    #0;
    overflow = carryout;
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
		#26;
		for (i = 0; i < 32; i = i + 1) begin
			p = a[i];
			#20;
			out[i] = k;
		end
	end
endmodule

module inverter(
	output out,
	input a
);
	`NOT(out, a);
endmodule 

module bitwiseSUB(
	output reg[31:0] out,
	output reg overflow,
	input[31:0] a, 
	input[31:0] b,
	input carryin
);
	wire[31:0] neg_b;
	wire[31:0] out_placeholder;
	wire[31:0] output_temp;
	//wire[31:0] another_temp;
	//reg[31:0] temp;
	//wire trash;
	wire overflow_placeholder;
	bitwiseINV asdawsd(neg_b, b);
	bitwiseADD adsadasda(output_temp, overflow_placeholder, neg_b, 1, 1);
	always @ (a or b or carryin) begin
		//#1311;
		//#641;
		#10000;
		overflow = overflow_placeholder;
		out = output_temp;
	end
endmodule  

module lessThan(
	output reg[31:0] out,
	input[31:0] a,
	input[31:0] b
);
	wire isLessThan;
	wire[31:0] output_temp;
	bitwiseSUB asdasd(output_temp, overflow, a, b, 0);
	`AND(isLessThan, output_temp[31], 1);
	always @ (a or b) begin
		out = 32'b00000000000000000000000000000000;
		//#2000;
		#11000;
		out[0] = isLessThan;
	end
endmodule 
