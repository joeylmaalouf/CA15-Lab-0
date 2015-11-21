`include "datamemory.v"
module DataMemoryTest();
  reg        clk;
  reg[13:0]  readAddr;
  reg[13:0]  writeAddr;
  reg        readEn;
  reg        writeEn;
  reg[31:0]  dIn;
  wire[31:0] dOut;
  datamemory dut(clk, readAddr, writeAddr, readEn, writeEn, dIn, dOut);
  initial clk = 0;
  always #10 clk = !clk;
  initial begin
    dIn = 5;
    writeEn = 1;
    readEn = 1;
    writeAddr = 0;
    readAddr = 0;
    #31
    $display("%d", dOut);
  end
endmodule
