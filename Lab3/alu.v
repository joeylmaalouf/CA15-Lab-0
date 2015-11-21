`include "logic.v"
`include "arithmetic.v"

`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

module ALU(
  output reg[31:0] result,
  output           carryout,
  output           zero,
  output reg       overflow,
  input[31:0]      operandA,
  input[31:0]      operandB,
  input[3:0]       command
);
  wire[31:0] results[0:7];
  wire[1:0] overflows;
  bitwiseADD  bADD (results[`ADD ], overflows[`ADD], operandA, operandB, 0);
	bitwiseSUB  bSUB (results[`SUB ], overflows[`SUB], operandA, operandB, 0);
	lessThan    bSLT (results[`SLT ], operandA, operandB);
  bitwiseXOR  bXOR (results[`XOR ], operandA, operandB);
  bitwiseAND  bAND (results[`AND ], operandA, operandB);
  bitwiseOR   bOR  (results[`OR  ], operandA, operandB);
  bitwiseINV  bNAND(results[`NAND], results[`AND]);
  bitwiseINV  bNOR (results[`NOR ], results[`OR ]);
  always @(command or operandA or operandB) begin // re-calculate when the command or operands are changed
    case (command)
      `ADD:  begin result = results[`ADD ]; overflow = overflows[`ADD]; end
      `SUB:  begin result = results[`SUB ]; overflow = overflows[`SUB]; end
      `XOR:  begin result = results[`XOR ]; end
      `SLT:  begin result = results[`SLT ]; end
      `AND:  begin result = results[`AND ]; end
      `NAND: begin result = results[`NAND]; end
      `NOR:  begin result = results[`NOR ]; end
      `OR:   begin result = results[`OR  ]; end
    endcase
//  #1000;
  end
endmodule
