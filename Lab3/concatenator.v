module concatenator(
  input[31:0]    jmpinstruction,
  input[27:0]   PC,
  input          clk,
  output reg[31:0]   out
);
  always @(posedge clk) begin
    out = {PC[27:24], jmpinstruction[27:0]};
  end

endmodule
