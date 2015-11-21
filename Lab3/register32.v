module register32
(
  output reg[0:31] q,
  input[0:31]      d,
  input            wrenable,
  input            clk
);
  always @(posedge clk) begin
    if (wrenable) begin
      q = d;
    end
  end
endmodule
