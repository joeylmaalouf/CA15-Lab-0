module datamemory(
  input        clk,
  input[31:0]  readAddr,
  input[31:0]  writeAddr,
  input        readEn,
  input        writeEn,
  input[31:0]  dIn,
  output reg[31:0] dOut
);
  reg[31:0] mem[16383:0];
  always @(posedge clk) begin
    if (writeEn) begin
      mem[writeAddr[13:0]] <= dIn;
    end
    if (readEn) begin
      dOut <= mem[readAddr[13:0]];
    end
  end
endmodule
