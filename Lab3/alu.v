`include "logic.v"
`include "arithmetic.v"
`include "shift.v"

`define ADD  4'd0
`define SUB  4'd1
`define XOR  4'd2
`define SLT  4'd3
`define AND  4'd4
`define NAND 4'd5
`define NOR  4'd6
`define OR   4'd7
`define SHFT 4'd8 // our extra shift operation forces us to use 4 bits, not 3

module ALU(
  output reg[31:0] result,
  output           carryout,
  output           zero,
  output reg       overflow,
  input[31:0]      operandA,
  input[31:0]      operandB,
  input[3:0]       command // see bit note about extra operation above
);
  wire[31:0] results[0:8];
  wire[1:0] overflows;
  reg clock;
  bitwiseADD  bADD (results[`ADD ], overflows[`ADD], operandA, operandB, 0);
	bitwiseSUB  bSUB (results[`SUB ], overflows[`SUB], operandA, operandB, 0);
	lessThan    bSLT (results[`SLT ], operandA, operandB);
  bitwiseXOR  bXOR (results[`XOR ], operandA, operandB);
  bitwiseAND  bAND (results[`AND ], operandA, operandB);
  bitwiseOR   bOR  (results[`OR  ], operandA, operandB);
  bitwiseINV  bNAND(results[`NAND], results[`AND]);
  bitwiseINV  bNOR (results[`NOR ], results[`OR ]);
  bitwiseSHFT bSHFT(results[`SHFT], operandA, clock);
  always @(command or operandA or operandB) begin // re-calculate when the command or operands are changed
    clock = 0;
    #120;
    clock = 1;
    #1000;
    case (command)
      `ADD:  begin result = results[`ADD ]; overflow = overflows[`ADD]; end
      `SUB:  begin result = results[`SUB ]; overflow = overflows[`SUB]; end
      `XOR:  begin result = results[`XOR ]; end
      `SLT:  begin result = results[`SLT ]; end
      `AND:  begin result = results[`AND ]; end
      `NAND: begin result = results[`NAND]; end
      `NOR:  begin result = results[`NOR ]; end
      `OR:   begin result = results[`OR  ]; end
      `SHFT: begin result = results[`SHFT]; end
    endcase
    #1000;
  end
endmodule

module testALU();
  reg[31:0] a, b;
  reg[3:0] command;
  wire [31:0] result;
  wire carryout, zero, overflow;
  ALU alu(result, carryout, zero, overflow, a, b, command);
  reg[31:0] expected;
  reg expected_overflow;
  initial begin
    command = `ADD;  #100000;

    a = 32'b00000000000001000001000001001100;
    b = 32'b00001000101001001001000000001100;
    expected = 32'b00001000101010001010000001011000;
    expected_overflow = 0;
    #100000;
    $display("ADD \nA:          %b\nB:          %b\nOut:      %b %b\nExpected: %b %b\n", a, b, overflow, result, expected_overflow, expected);

    a = 32'b00000101000001000001000001001101;
    b = 32'b00001000101001001001000000001100;
    expected = 32'b00001101101010001010000001011001;
    expected_overflow = 0;
    #100000;
    $display("ADD \nA:          %b\nB:          %b\nOut:      %b %b\nExpected: %b %b\n", a, b, overflow, result, expected_overflow, expected);

    a = 32'b11000101000001000001000001001101;
    b = 32'b10001000101001001001000000001100;
    expected = 32'b01001101101010001010000001011001;
    expected_overflow = 1;
    #100000;
    $display("ADD \nA:          %b\nB:          %b\nOut:      %b %b\nExpected: %b %b\n", a, b, overflow, result, expected_overflow, expected);

    command = `SUB;

    a = 32'b00000101000001000001000001001101;
    b = 32'b00001000101001001001000000001100;
    expected = 32'b11111100010111111000000001000001;
    expected_overflow = 0;
    #100000;
    $display("SUB \nA:          %b\nB:          %b\nOut:      %b %b\nExpected: %b %b\n", a, b, overflow, result, expected_overflow, expected);

    a = 32'b01000100000101000001001001001001;
    b = 32'b00101000001001000001000010001110;
    expected = 32'b00011011111100000000000110111011;
    expected_overflow = 0;
    #100000;
    $display("SUB \nA:          %b\nB:          %b\nOut:      %b %b\nExpected: %b %b\n", a, b, overflow, result, expected_overflow, expected);

    a = 32'b01000100000101000001001001001001;
    b = 32'b10101000001001000001000010001110;
    expected = 32'b10011011111100000000000110111011;
    expected_overflow = 1;
    #100000;
    $display("SUB \nA:          %b\nB:          %b\nOut:      %b %b\nExpected: %b %b\n", a, b, overflow, result, expected_overflow, expected);

    command = `SLT;

    a = 32'b01000101100101000001001001001001;
    b = 32'b10101001001001000001000010001110;
    expected = 32'b00000000000000000000000000000000;
    #100000;
    $display("SLT \nA:        %b\nB:        %b\nOut:      %b\nExpected: %b\n", a, b, result, expected);

    a = 32'b11000101100101000001001001001001;
    b = 32'b10101001001001000001000010001110;
    expected = 32'b00000000000000000000000000000000;
    #100000;
    $display("SLT \nA:        %b\nB:        %b\nOut:      %b\nExpected: %b\n", a, b, result, expected);

    a = 32'b11101001001001000001000001001001;
    b = 32'b11101001001001000001000001001001;
    expected = 32'b00000000000000000000000000000000;
    #100000;
    $display("SLT \nA:        %b\nB:        %b\nOut:      %b\nExpected: %b\n", a, b, result, expected);

    a = 32'b11111111111111111111111111111111;
    b = 32'b00000000000000000000000000000000;
    expected = 32'b00000000000000000000000000000001;
    #100000;
    $display("SLT \nA:        %b\nB:        %b\nOut:      %b\nExpected: %b\n", a, b, result, expected);

    a = 32'b11111111111111111111111111111111;
    b = 32'b01111111111111111111111111111111;
    expected = 32'b00000000000000000000000000000001;
    #100000;
    $display("SLT \nA:        %b\nB:        %b\nOut:      %b\nExpected: %b\n", a, b, result, expected);

    command = `XOR;

    a = 32'b11111111111111111111111111111111;
    b = 32'b01111111111111111111111111111111;
    expected = 32'b10000000000000000000000000000000;
    #100000;
    $display("XOR \nA:        %b\nB:        %b\nOut:      %b\nExpected: %b\n", a, b, result, expected);

    a = 32'b11111110111111011111110011110111;
    b = 32'b01110111111011111110111111100111;
    expected = 32'b10001001000100100001001100010000;
    #100000;
    $display("XOR \nA:        %b\nB:        %b\nOut:      %b\nExpected: %b\n", a, b, result, expected);

    command = `AND;  

    a = 32'b10011110111111011101110011110111;
    b = 32'b01110111111011001110111000100111;
    expected = 32'b00010110111011001100110000100111;
    #10000;
    $display("AND \nA:        %b\nB:        %b\nOut:      %b\nExpected: %b\n", a, b, result, expected);

    a = 32'b10011000110011011101100011000111;
    b = 32'b00010011000011001100011000100111;
    expected = 32'b00010000000011001100000000000111;
    #10000;
    $display("AND \nA:        %b\nB:        %b\nOut:      %b\nExpected: %b\n", a, b, result, expected);

    command = `OR;

    a = 32'b10011010110011011101101011000111;
    b = 32'b01110011011011101100011001100111;
    expected = 32'b11111011111011111101111011100111;
    #100000;
    $display("OR \nA:        %b\nB:        %b\nOut:      %b\nExpected: %b\n", a, b, result, expected);

    a = 32'b00011010010001011001100000000100;
    b = 32'b11000011010000101100011001100011;
    expected = 32'b11011011010001111101111001100111;
    #100000;
    $display("OR \nA:        %b\nB:        %b\nOut:      %b\nExpected: %b\n", a, b, result, expected);

    command = `NAND;

    a = 32'b00011010011001011001101001001101;
    b = 32'b11010011010100101100011001100010;
    expected = 32'b11101101101111110111110110111111;
    #100000;
    $display("NAND \nA:        %b\nB:        %b\nOut:      %b\nExpected: %b\n", a, b, result, expected);

    a = 32'b00011010011001010001001001001101;
    b = 32'b00010010010100100100010001000010;
    expected = 32'b11101101101111111111111110111111;
    #100000;
    $display("NAND \nA:        %b\nB:        %b\nOut:      %b\nExpected: %b\n", a, b, result, expected);

    command = `NOR;

    a = 32'b11011010011001010001001001001101;
    b = 32'b10010010010100100100010001000010;
    expected = 32'b00100101100010001010100110110000;
    #100000;
    $display("NOR \nA:        %b\nB:        %b\nOut:      %b\nExpected: %b\n", a, b, result, expected);

    a = 32'b11011010011001010111001101001101;
    b = 32'b01010011110100100100110011001011;
    expected = 32'b00100100000010001000000000110000;
    #100000;
    $display("NOR \nA:        %b\nB:        %b\nOut:      %b\nExpected: %b\n", a, b, result, expected);

    command = `SHFT;

    a = 32'b11011010011001010111001101001101;
    expected = 32'b10110100110010101110011010011011;
    #100000;
    $display("SHFT \nA:        %b\nOut:      %b\nExpected: %b\n", a, result, expected);

    a = 32'b01111001001001100100000011100001;
    expected = 32'b11110010010011001000000111000010;
    #100000;
    $display("SHFT \nA:        %b\nOut:      %b\nExpected: %b\n", a, result, expected);
  end
endmodule
