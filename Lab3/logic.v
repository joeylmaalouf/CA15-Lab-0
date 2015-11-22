module bitwiseAND(
  output[31:0] out,
  input[31:0] a, b
);
  assign out = a & b;
endmodule 

module bitwiseOR(
  output[31:0] out,
  input[31:0] a, b
);
  assign out = a | b;
endmodule

module bitwiseXOR(
  output[31:0] out,
  input[31:0] a,
  input[31:0] b
);
  assign out = a ^ b;
endmodule

module bitwiseINV(
  output[31:0] out,
  input[31:0] a
);
  assign out = ~a;
endmodule
