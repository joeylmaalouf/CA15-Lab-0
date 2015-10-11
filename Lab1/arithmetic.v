`define XOR xor 
`define AND and 
`define OR or 
`define NOT not 

module fulladder(out, carryout, a, b, carryin);
  output out, carryout;
  input a, b, carryin;
  wire AxorB, carryout_condition1, carryout_condition2;
  `XOR xor1(AxorB, a, b);
  `AND and1(carryout_condition1, AxorB, carryin); // If only one of a and b is high, and carryin is high, then carryout is high
  `AND and2(carryout_condition2, a, b); // If both a and b are high, then carryout is high
  `OR or1(carryout, carryout_condition1, carryout_condition2);
  `XOR xor2(out, AxorB, carryin); // Sum is high only when only one of a or b is high or both are matching values and carryin is high
endmodule

module adder32(
  output reg[31:0] out,
  output reg overflow,
  input[31:0] a, b,
  input reg carryin
);
  reg aBit, bBit, carryBit;
  wire carryout, outBit;
  adder fulladder(outBit, carryout, aBit, bBit, carryBit);
  integer i;
  initial begin
    #0
    carryBit = carryin;
    for (i = 0; i < 32; i = i + 1) begin
	aBit = a[i];
	bBit = b[i];
	#1
	out[i] = outBit;
	$display(" %b %b %b %b",i[4:0],aBit,bBit,outBit);
	carryBit = carryout;
    end
    #0
    overflow = carryout;
  end
endmodule

module test();
  reg [31:0] a = 32'sb10000000100001000001000000001101;
  reg [31:0] b = 32'sb10010000100000000001000000001101;
  wire carryin, overflow;
  wire [31:0] out;
  adder32 myAdder(out, overflow, a, b, carryin);
  initial begin
    #100
    $display("sum %b", out);
    $display("carryout %b", overflow);
  end
endmodule
