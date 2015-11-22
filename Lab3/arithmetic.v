`include "logic.v"

module bitwiseADD(
  output[31:0] out,
  output overflow,
  input[31:0] a, b,
  input carryin
);
  assign out = a + b + carryin;
  assign overflow = (a & (a[30] & b[30])) | (b & (a[30] & b[30])) | (a[31] & b[31]);
endmodule

module bitwiseSUB(
  output[31:0] out,
  output overflow,
  input[31:0] a, 
  input[31:0] b,
  input carryin
);
  bitwiseAdd myAdder(out, overflow, a, ~b, 1'b1);
  //wire[31:0] neg_b;
  //bitwiseINV myInverter(neg_b, b);
  //bitwiseADD myAdder(out, overflow, a, neg_b, 1'b1);
endmodule  

module lessThan(
  output[31:0] out,
  input[31:0] a,
  input[31:0] b
);
  assign out = (a >= b) + 32'b0;
endmodule 
