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
  output reg       zero,
  input[31:0]      operandA,
  input[31:0]      operandB,
  input[2:0]       command
);
  always @(command or operandA or operandB) begin
    case (command)
      `ADD:  assign result = operandA + operandB;
      `SUB:  assign result = operandA - operandB;
      `XOR:  assign result = operandA ^ operandB;
      `SLT:  assign result = operandA < operandB;
      `AND:  assign result = operandA & operandB;
      `NAND: assign result = operandA ~& operandB;
      `NOR:  assign result = operandA ~| operandB;
      `OR:   assign result = operandA | operandB;
    endcase
    assign zero = (result == 0);
  end
endmodule
