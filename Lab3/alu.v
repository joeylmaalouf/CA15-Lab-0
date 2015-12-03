module ALU(
  output reg[31:0] result,
  output reg       zero,
  input[31:0]      a,
  input[31:0]      b,
  input[2:0]       command
);
  always @(command or a or b) begin
    case (command)
      3'd0: assign result = a + b;
      3'd1: assign result = a - b;
      3'd2: assign result = a ^ b;
      3'd3: assign result = a < b;
      3'd4: assign result = a & b;
      3'd5: assign result = ~(a & b);
      3'd6: assign result = ~(a | b);
      3'd7: assign result = a | b;
    endcase
    assign zero = result == 0;
  end
endmodule
