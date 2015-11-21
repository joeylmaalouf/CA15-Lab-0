`include "cpu.v"
module CPUTest();
  reg clk;
  wire[31:0] error_code;
  mips_cpu dut(
  .clk(clk),
  .error_code(error_code)
);
  initial clk = 0;
  always #10 clk = !clk;
  always @(error_code) begin
    $display("Error code: %d", error_code);
  end
endmodule
