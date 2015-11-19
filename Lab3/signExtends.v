module signExtends( //sign extend signed, for use with 2's compliment
  input reg[4:0] d,
  input reg clk,
  output reg[31:0] q
);
  always @(posedge clk) begin
    q <= {{27{d[4]}}, d};
  end
endmodule
