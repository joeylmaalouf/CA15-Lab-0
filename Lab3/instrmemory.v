module instrmemory
#(parameter n_instr = 100)
(
  input[31:0]       address,
  output reg[31:26] op,
  output reg[25:21] rs,
  output reg[20:16] rt,
  output reg[15:11] rd,
  output reg[10:6]  shft,
  output reg[5:0]   func,
  output reg[15:0]  imm,
  output reg[25:0]  target
);
  reg[31:0] mem[n_instr-1:0];
  reg[31:0] instr;
  reg[31:0] index;
  initial $readmemh("tests.dat", mem);
  always @(address) begin
    index = address / 4;
    if (index > n_instr-1) $stop;
    instr = mem[index[6:0]];
    op = instr[31:26];
    rs = instr[25:21];
    rt = instr[20:16];
    rd = instr[15:11];
    shft = instr[10:6];
    func = instr[5:0];
    imm = instr[15:0];
    target = instr[25:0];
    $display("New instruction at %d: %x", address, instr);
  end
endmodule
