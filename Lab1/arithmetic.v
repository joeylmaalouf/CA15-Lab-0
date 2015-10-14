`define XOR xor
`define AND and
`define OR or
`define NOT not

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
  initial begin
    #20
    carryBit = carryin;
    for (i = 0; i < 32; i = i + 1) begin
      aBit = a[i];
      bBit = b[i];
      #20
      out[i] = outBit;
      carryBit = carryout;
    end
    overflow = carryout;
  end
endmodule
