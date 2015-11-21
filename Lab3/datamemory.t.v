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
    readEn = 1;
    writeEn = 1;
    readAddr = 0;
    writeAddr = 0;
    dIn = 5;
    #40
    $display("Stored %d at   %x", dIn, writeAddr);
    $display("Read   %d from %x", dOut, readAddr);
    readAddr = 1;
    writeAddr = 1;
    dIn = 8;
    #40
    $display("Stored %d at   %x", dIn, writeAddr);
    $display("Read   %d from %x", dOut, readAddr);
    readAddr = 0;
    writeEn = 0;
    #40
    $display("Read   %d from %x", dOut, readAddr);
  end
endmodule
