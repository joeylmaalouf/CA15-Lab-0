`include "logic.v"
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
  output       carryout,
  output       zero,
  output       overflow,
  input[31:0]  operandA,
  input[31:0]  operandB,
  input[2:0]   command
);
  wire[31:0] results[0:7];
  bitwiseXOR bXOR (results[`XOR ], operandA, operandB);
  bitwiseAND bAND (results[`AND ], operandA, operandB);
  bitwiseOR  bOR  (results[`OR  ], operandA, operandB);
  bitwiseINV bNAND(results[`NAND], results[`AND]);
  bitwiseINV bNOR (results[`NOR ], results[`OR ]);
  always @(command) begin // re-assign when the command is changed
    case (command)
      `ADD:  begin /**/ end
      `SUB:  begin /**/ end
      `XOR:  begin result = results[`XOR ]; end
      `SLT:  begin /**/ end
      `AND:  begin result = results[`AND ]; end
      `NAND: begin result = results[`NAND]; end
      `NOR:  begin result = results[`NOR ]; end
      `OR:   begin result = results[`OR  ]; end
    endcase
  end
endmodule

module testALU();
  reg[31:0] a, b;
  reg[2:0] command;
  wire [31:0] result;
  wire carryout, zero, overflow;
  ALU alu(result, carryout, zero, overflow, a, b, command);
  initial begin
    a = 32'b01000000100001000001010001001100;
    b = 32'b00001000101001001001000000001100;
    #1000;
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
  end
endmodule
