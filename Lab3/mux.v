module mux
#(parameter depth = 2)
(
  input[depth-1:0]      a,
  input[depth-1:0]      b,
  input                 selector,
  output reg[depth-1:0] c
);
  always @(a or b or selector) begin
    if (selector) begin
      c = b;
    end
    else begin
      c = a;
    end
  end
endmodule
