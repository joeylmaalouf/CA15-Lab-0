`include "datamemory.v"
module DataMemoryTest();
  reg clk;
  datamemory dut(clk);

  initial clk = 0;
  always #10 clk = !clk;
endmodule
