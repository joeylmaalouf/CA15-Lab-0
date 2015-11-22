module PCreg
(
  output reg[0:31] q,
  input[0:31]      d,
  input            clk
);
  initial begin
    q <= 0;
  end
  always @(posedge clk) begin
    q <= d;
  end
endmodule
