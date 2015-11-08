module dflipflop
(
  input clk,   // clock
  input en,    // enable
  input d,     // input
  output reg q // output
);
  always @(posedge clk) begin
    if (en) begin
      q <= d;
    end
  end
endmodule
