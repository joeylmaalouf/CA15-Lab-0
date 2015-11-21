`include "cpu.v"
module CPUTest();
  reg clk;
  mips_cpu dut(clk);

  initial clk = 0;
  always #10 clk = !clk;
endmodule
