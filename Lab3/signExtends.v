module signExtends( //sign extend signed, for use with 2's compliment
  input[4:0] d,
  input clock,
  output[31:0] q
);
  always @(d && posedge) begin
    q <= {{27{d[4]}}, d};
  end
endmodule
