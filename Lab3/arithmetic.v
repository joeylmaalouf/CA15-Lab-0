`include "logic.v"

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
  output[31:0] out,
  output overflow,
  input[31:0] a, b,
  input carryin
);
  wire[31:0] carryout;
  FullAdder adder0(out[0], carryout[0], a[0], b[0], carryin);
  FullAdder adder1(out[1], carryout[1], a[1], b[1], carryout[0]);
  FullAdder adder2(out[2], carryout[2], a[2], b[2], carryout[1]);
  FullAdder adder3(out[3], carryout[3], a[3], b[3], carryout[2]);
  FullAdder adder4(out[4], carryout[4], a[4], b[4], carryout[3]);
  FullAdder adder5(out[5], carryout[5], a[5], b[5], carryout[4]);
  FullAdder adder6(out[6], carryout[6], a[6], b[6], carryout[5]);
  FullAdder adder7(out[7], carryout[7], a[7], b[7], carryout[6]);
  FullAdder adder8(out[8], carryout[8], a[8], b[8], carryout[7]);
  FullAdder adder9(out[9], carryout[9], a[9], b[9], carryout[8]);
  FullAdder adder10(out[10], carryout[10], a[10], b[10], carryout[9]);
  FullAdder adder11(out[11], carryout[11], a[11], b[11], carryout[10]);
  FullAdder adder12(out[12], carryout[12], a[12], b[12], carryout[11]);
  FullAdder adder13(out[13], carryout[13], a[13], b[13], carryout[12]);
  FullAdder adder14(out[14], carryout[14], a[14], b[14], carryout[13]);
  FullAdder adder15(out[15], carryout[15], a[15], b[15], carryout[14]);
  FullAdder adder16(out[16], carryout[16], a[16], b[16], carryout[15]);
  FullAdder adder17(out[17], carryout[17], a[17], b[17], carryout[16]);
  FullAdder adder18(out[18], carryout[18], a[18], b[18], carryout[17]);
  FullAdder adder19(out[19], carryout[19], a[19], b[19], carryout[18]);
  FullAdder adder20(out[20], carryout[20], a[20], b[20], carryout[19]);
  FullAdder adder21(out[21], carryout[21], a[21], b[21], carryout[20]);
  FullAdder adder22(out[22], carryout[22], a[22], b[22], carryout[21]);
  FullAdder adder23(out[23], carryout[23], a[23], b[23], carryout[22]);
  FullAdder adder24(out[24], carryout[24], a[24], b[24], carryout[23]);
  FullAdder adder25(out[25], carryout[25], a[25], b[25], carryout[24]);
  FullAdder adder26(out[26], carryout[26], a[26], b[26], carryout[25]);
  FullAdder adder27(out[27], carryout[27], a[27], b[27], carryout[26]);
  FullAdder adder28(out[28], carryout[28], a[28], b[28], carryout[27]);
  FullAdder adder29(out[29], carryout[29], a[29], b[29], carryout[28]);
  FullAdder adder30(out[30], carryout[30], a[30], b[30], carryout[29]);
  FullAdder adder31(out[31], carryout[31], a[31], b[31], carryout[30]);
  `XOR(overflow, carryout[31], carryout[30]);
endmodule

module bitwiseSUB(
  output[31:0] out,
  output overflow,
  input[31:0] a, 
  input[31:0] b,
  input carryin
);
  wire[31:0] neg_b;
  bitwiseINV myInverter(neg_b, b);
  bitwiseADD myAdder(out, overflow, a, neg_b, 1'b1);
endmodule  

module lessThan(
  output[31:0] out,
  input[31:0] a,
  input[31:0] b
);
  wire isNotGreaterThan;
  wire condition0, condition1, condition2;
  wire disqualifier0;
  wire nota, notb;
  wire[31:0] output_temp;
  bitwiseSUB mySubber(output_temp, overflow, a, b, 1'b0);
  `AND(condition0, output_temp[31], 1'b1);
  `NOT(nota, a[31]);
  `AND(disqualifier0, nota, b[31]);
  `NOT(isNotGreaterThan, disqualifier0);
  `NOT(notb, b[31]);
  `AND(condition1, a[31], notb);
  `OR(condition2, condition0, condition1);
  `AND(out[0], isNotGreaterThan, condition2);
  `AND(out[1], 0, 0);
  `AND(out[2], 0, 0);
  `AND(out[3], 0, 0);
  `AND(out[4], 0, 0);
  `AND(out[5], 0, 0);
  `AND(out[6], 0, 0);
  `AND(out[7], 0, 0);
  `AND(out[8], 0, 0);
  `AND(out[9], 0, 0);
  `AND(out[10], 0, 0);
  `AND(out[11], 0, 0);
  `AND(out[12], 0, 0);
  `AND(out[13], 0, 0);
  `AND(out[14], 0, 0);
  `AND(out[15], 0, 0);
  `AND(out[16], 0, 0);
  `AND(out[17], 0, 0);
  `AND(out[18], 0, 0);
  `AND(out[19], 0, 0);
  `AND(out[20], 0, 0);
  `AND(out[21], 0, 0);
  `AND(out[22], 0, 0);
  `AND(out[23], 0, 0);
  `AND(out[24], 0, 0);
  `AND(out[25], 0, 0);
  `AND(out[26], 0, 0);
  `AND(out[27], 0, 0);
  `AND(out[28], 0, 0);
  `AND(out[29], 0, 0);
  `AND(out[30], 0, 0);
  `AND(out[31], 0, 0);
endmodule 
