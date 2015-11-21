`include "instrmemory.v"
module InstrMemoryTest();
  reg[6:0] addr;
  wire[31:0] instr;
  instrmemory dut(addr, instr);
  initial begin
    $display("Reading instruction memory:");
    for (addr = 7'd0; addr < 7'd100; addr = addr + 1) begin
      $display("instr%d: 0x%x => 0b%b", addr, instr, instr);
    end
  end
endmodule
