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
  output           overflow,
  input[31:0]      operandA,
  input[31:0]      operandB,
  input[3:0]       command // see bit note about extra operation above
);
  wire[31:0] results[0:8];
  reg clock;
  bitwiseADD  bADD (results[`ADD ], carryout, operandA, operandB, 0);
	bitwiseSUB  bSUB (results[`SUB ], carryout, operandA, operandB, 0);
	lessThan    bSLT (results[`SLT ], operandA, operandB);
  bitwiseXOR  bXOR (results[`XOR ], operandA, operandB);
  bitwiseAND  bAND (results[`AND ], operandA, operandB);
  bitwiseOR   bOR  (results[`OR  ], operandA, operandB);
  bitwiseINV  bNAND(results[`NAND], results[`AND]);
  bitwiseINV  bNOR (results[`NOR ], results[`OR ]);
  bitwiseSHFT bSHFT(results[`SHFT], operandA, clock);
  initial begin
    clock = 0;
  end
  always @(command) begin // re-assign when the command is changed
    clock = 1;
    case (command)
      `ADD:  begin result = results[`ADD ]; end
      `SUB:  begin result = results[`SUB ]; end
      `XOR:  begin result = results[`XOR ]; end
      `SLT:  begin result = results[`SLT ]; end
      `AND:  begin result = results[`AND ]; end
      `NAND: begin result = results[`NAND]; end
      `NOR:  begin result = results[`NOR ]; end
      `OR:   begin result = results[`OR  ]; end
      `SHFT: begin result = results[`SHFT]; end
    endcase
    #2000;
    clock = 0;
  end
endmodule

module testALU();
  reg[31:0] a, b;
  reg[3:0] command;
  wire [31:0] result;
  wire carryout, zero, overflow;
  ALU alu(result, carryout, zero, overflow, a, b, command);
  initial begin
    a = 32'b00000000000001000001000001001101;
    b = 32'b00001000101001001001000000001100;
    #100000;
    command = `ADD;  #1000;
    $display("ADD \n%b\n%b\n%b\n", a, b, result);
		command = `SUB;  #1000;
		$display("SUB \n%b\n%b\n%b\n", a, b, result);
		command = `SLT;  #1000;
		$display("SLT \n%b\n%b\n%b\n", a, b, result);
    command = `XOR;  #1000;
    $display("XOR \n%b\n%b\n%b\n", a, b, result);
    command = `AND;  #1000;
    $display("AND \n%b\n%b\n%b\n", a, b, result);
    command = `OR;   #1000;
    $display("OR  \n%b\n%b\n%b\n", a, b, result);
    command = `NAND; #1000;
    $display("NAND\n%b\n%b\n%b\n", a, b, result);
    command = `NOR;  #1000;
    $display("NOR \n%b\n%b\n%b\n", a, b, result);
    command = `SHFT; #1000;
    $display("SHFT\n%b\n%b\n",     a,    result);
  end
endmodule
