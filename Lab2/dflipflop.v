module dflipflop
(
  input d,     // input
  input clk,   // clock
  input en,    // enable
  output reg q // output
);
  always @(posedge clk) begin
    if (en) begin
      q <= d;
    end
  end
endmodule
