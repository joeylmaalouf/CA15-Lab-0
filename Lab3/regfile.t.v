`include "regfile.v"
module regfiletest();
  wire[31:0] ReadData1;    // Data from first register read
  wire[31:0] ReadData2;    // Data from second register read
  reg[31:0] WriteData;     // Data to write to register
  reg[4:0] ReadRegister1; // Address of first register to read
  reg[4:0] ReadRegister2; // Address of second register to read
  reg[4:0] WriteRegister; // Address of register to write
  reg RegWrite;           // Enable writing of register when High
  reg Clk;                // Clock (Positive Edge Triggered)
  regfile DUT(
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .WriteData(WriteData),
    .ReadRegister1(ReadRegister1),
    .ReadRegister2(ReadRegister2),
    .WriteRegister(WriteRegister),
    .RegWrite(RegWrite),
    .Clk(Clk)
  );
  initial Clk = 0;
  always #10 Clk = !Clk;
  initial begin
    RegWrite = 1'b1;
    WriteRegister = 5'b01111;
    WriteData = 5'b10101;
    #20
    $display("Wrote %b to %b.", WriteData, WriteRegister);
    ReadRegister1 = 5'b01111;
    #20
    $display("Read %b from %b.", ReadData1, ReadRegister1);
  end
endmodule
