`define AND and #20
`define OR or #20
`define NOT not #20
`define XOR xor #20

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

module xorrer(
  output c,
  input a,
  input b
);
  `XOR(c, a, b);
endmodule

module inverter(
  output out,
  input a
);
  `NOT(out, a);
endmodule

module bitwiseAND(
  output reg[31:0] out,
  input[31:0] a, b
);
  reg placeholder_1, placeholder_2;
  wire k;
  ander myAnder(k, placeholder_1, placeholder_2);
  integer i;
  initial begin
    #200;
    for (i = 0; i < 32; i = i + 1) begin
      placeholder_1 = a[i];
      placeholder_2 = b[i];
      #200;
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
  initial begin
    #200;
    for (i = 0; i < 32; i = i + 1) begin
      p1 = a[i];
      p2 = b[i];
      #200;
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
  initial begin
    #200;
    for (i = 0; i < 32; i = i + 1) begin
      p1 = a[i];
      p2 = b[i];
      #200;
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
  initial begin
    #500;
    for (i = 0; i < 32; i = i + 1) begin
      p = a[i];
      #200;
      out[i] = k;
    end
  end
endmodule
