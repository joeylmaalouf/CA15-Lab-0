module datamemory(
  input        clk,
  input[13:0]  readAddr,
  input[13:0]  writeAddr,
  input        readEn,
  input        writeEn,
  input[31:0]  dIn,
  output reg[31:0] dOut
);
  reg[31:0] mem[16383:0];
  always @(posedge clk) begin
    if (writeEn) begin
      mem[writeAddr] <= dIn;
    end
    if (readEn) begin
      dOut <= mem[readAddr];
    end
  end
endmodule
