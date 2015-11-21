module instrmemory(
  input[6:0]   addr,
  output[31:0] instr
);
  reg[31:0] mem[99:0];
  initial $readmemh("tests.dat", mem);
  assign instr = mem[addr];
endmodule
