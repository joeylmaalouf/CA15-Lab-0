module concatenator(
  input[27:0]    jmpinstruction,
  input[31:28]   PC,
  input          clk,
  output reg[31:0]   out
);
  always @(posedge clk) begin
    out = {PC, jmpinstruction};
  end

endmodule
