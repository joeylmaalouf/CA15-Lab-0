`define XOR xor #60
`define AND and #30
`define OR or #30
`define NOT not #10

module bitwiseAND(
  output[31:0] out,
  input[31:0] a, b
);
  `AND(out[0], a[0], b[0]);
  `AND(out[1], a[1], b[1]);
  `AND(out[2], a[2], b[2]);
  `AND(out[3], a[3], b[3]);
  `AND(out[4], a[4], b[4]);
  `AND(out[5], a[5], b[5]);
  `AND(out[6], a[6], b[6]);
  `AND(out[7], a[7], b[7]);
  `AND(out[8], a[8], b[8]);
  `AND(out[9], a[9], b[9]);
  `AND(out[10], a[10], b[10]);
  `AND(out[11], a[11], b[11]);
  `AND(out[12], a[12], b[12]);
  `AND(out[13], a[13], b[13]);
  `AND(out[14], a[14], b[14]);
  `AND(out[15], a[15], b[15]);
  `AND(out[16], a[16], b[16]);
  `AND(out[17], a[17], b[17]);
  `AND(out[18], a[18], b[18]);
  `AND(out[19], a[19], b[19]);
  `AND(out[20], a[20], b[20]);
  `AND(out[21], a[21], b[21]);
  `AND(out[22], a[22], b[22]);
  `AND(out[23], a[23], b[23]);
  `AND(out[24], a[24], b[24]);
  `AND(out[25], a[25], b[25]);
  `AND(out[26], a[26], b[26]);
  `AND(out[27], a[27], b[27]);
  `AND(out[28], a[28], b[28]);
  `AND(out[29], a[29], b[29]);
  `AND(out[30], a[30], b[30]);
  `AND(out[31], a[31], b[31]);
endmodule 

module bitwiseOR(
  output[31:0] out,
  input[31:0] a, b
);
  `OR(out[0], a[0], b[0]);
  `OR(out[1], a[1], b[1]);
  `OR(out[2], a[2], b[2]);
  `OR(out[3], a[3], b[3]);
  `OR(out[4], a[4], b[4]);
  `OR(out[5], a[5], b[5]);
  `OR(out[6], a[6], b[6]);
  `OR(out[7], a[7], b[7]);
  `OR(out[8], a[8], b[8]);
  `OR(out[9], a[9], b[9]);
  `OR(out[10], a[10], b[10]);
  `OR(out[11], a[11], b[11]);
  `OR(out[12], a[12], b[12]);
  `OR(out[13], a[13], b[13]);
  `OR(out[14], a[14], b[14]);
  `OR(out[15], a[15], b[15]);
  `OR(out[16], a[16], b[16]);
  `OR(out[17], a[17], b[17]);
  `OR(out[18], a[18], b[18]);
  `OR(out[19], a[19], b[19]);
  `OR(out[20], a[20], b[20]);
  `OR(out[21], a[21], b[21]);
  `OR(out[22], a[22], b[22]);
  `OR(out[23], a[23], b[23]);
  `OR(out[24], a[24], b[24]);
  `OR(out[25], a[25], b[25]);
  `OR(out[26], a[26], b[26]);
  `OR(out[27], a[27], b[27]);
  `OR(out[28], a[28], b[28]);
  `OR(out[29], a[29], b[29]);
  `OR(out[30], a[30], b[30]);
  `OR(out[31], a[31], b[31]);
endmodule

module bitwiseXOR(
  output[31:0] out,
  input[31:0] a,
  input[31:0] b
);
	`XOR(out[0], a[0], b[0]);
  `XOR(out[1], a[1], b[1]);
  `XOR(out[2], a[2], b[2]);
  `XOR(out[3], a[3], b[3]);
  `XOR(out[4], a[4], b[4]);
  `XOR(out[5], a[5], b[5]);
  `XOR(out[6], a[6], b[6]);
  `XOR(out[7], a[7], b[7]);
  `XOR(out[8], a[8], b[8]);
  `XOR(out[9], a[9], b[9]);
  `XOR(out[10], a[10], b[10]);
  `XOR(out[11], a[11], b[11]);
  `XOR(out[12], a[12], b[12]);
  `XOR(out[13], a[13], b[13]);
  `XOR(out[14], a[14], b[14]);
  `XOR(out[15], a[15], b[15]);
  `XOR(out[16], a[16], b[16]);
  `XOR(out[17], a[17], b[17]);
  `XOR(out[18], a[18], b[18]);
  `XOR(out[19], a[19], b[19]);
  `XOR(out[20], a[20], b[20]);
  `XOR(out[21], a[21], b[21]);
  `XOR(out[22], a[22], b[22]);
  `XOR(out[23], a[23], b[23]);
  `XOR(out[24], a[24], b[24]);
  `XOR(out[25], a[25], b[25]);
  `XOR(out[26], a[26], b[26]);
  `XOR(out[27], a[27], b[27]);
  `XOR(out[28], a[28], b[28]);
  `XOR(out[29], a[29], b[29]);
  `XOR(out[30], a[30], b[30]);
  `XOR(out[31], a[31], b[31]);
endmodule

module bitwiseINV(
  output[31:0] out,
  input[31:0] a
);
  `NOT(out[0], a[0]);
  `NOT(out[1], a[1]);
  `NOT(out[2], a[2]);
  `NOT(out[3], a[3]);
  `NOT(out[4], a[4]);
  `NOT(out[5], a[5]);
  `NOT(out[6], a[6]);
  `NOT(out[7], a[7]);
  `NOT(out[8], a[8]);
  `NOT(out[9], a[9]);
  `NOT(out[10], a[10]);
  `NOT(out[11], a[11]);
  `NOT(out[12], a[12]);
  `NOT(out[13], a[13]);
  `NOT(out[14], a[14]);
  `NOT(out[15], a[15]);
  `NOT(out[16], a[16]);
  `NOT(out[17], a[17]);
  `NOT(out[18], a[18]);
  `NOT(out[19], a[19]);
  `NOT(out[20], a[20]);
  `NOT(out[21], a[21]);
  `NOT(out[22], a[22]);
  `NOT(out[23], a[23]);
  `NOT(out[24], a[24]);
  `NOT(out[25], a[25]);
  `NOT(out[26], a[26]);
  `NOT(out[27], a[27]);
  `NOT(out[28], a[28]);
  `NOT(out[29], a[29]);
  `NOT(out[30], a[30]);
  `NOT(out[31], a[31]);
endmodule
