module decoder1to32
(
  output[31:0] out,
  input        enable,
  input[4:0]   address
);
  assign out = enable << address; 
  always @(address) begin
    if (enable) begin
      $display("%b", out);
    end
  end
endmodule
