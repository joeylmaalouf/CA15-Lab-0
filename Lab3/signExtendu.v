module signExtendu( //sign extend unsigned
  input reg[4:0] d,
  input reg clk,
  output reg[31:0] q
);
  always @(posedge clk) begin
    q = d;
  end
endmodule
