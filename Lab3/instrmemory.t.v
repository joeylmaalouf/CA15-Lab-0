`include "instrmemory.v"
module InstrMemoryTest();
  reg[6:0]      addr;
  output[31:26] op;
  output[25:21] rs;
  output[20:16] rt;
  output[15:11] rd;
  output[10:6]  shft;
  output[5:0]   func;
  output[15:0]  imm;
  output[25:0]  target;
  instrmemory dut(addr, op, rs, rt, rd, shft, func, imm, target);
  initial begin
    $display("Reading instruction memory:");
    for (addr = 7'd0; addr < 7'd100; addr = addr + 1) begin
      #1
      $display("instr%d:", addr);
      $display("  R: %b,%b,%b,%b,%b,%b", op, rs, rt, rd, shft, func);
      $display("  I: %b,%b,%b,%b", op, rs, rt, imm);
      $display("  J: %b,%b", op, target);
    end
  end
endmodule
