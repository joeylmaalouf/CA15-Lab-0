module regfileTest();
  wire[31:0] ReadData1;   // Contents of first register read
  wire[31:0] ReadData2;   // Contents of second register read
  reg[31:0] WriteData;    // Contents to write to register
  reg[4:0] ReadRegister1; // Address of first register to read
  reg[4:0] ReadRegister2; // Address of second register to read
  reg[4:0] WriteRegister; // Address of register to write
  reg RegWrite;           // Enable writing of register when High
  reg Clk;                 // Clock (Positive Edge Triggered)
  
  regfile dut(
      .Clk(Clk), 
      .ReadData1(ReadData1),
      .ReadData2(ReadData2),
      .WriteData(WriteData),
      .ReadRegister1(ReadRegister1),
      .ReadRegister2(ReadRegister2),
      .WriteRegister(WriteRegister),
      .RegWrite(RegWrite)
    );
    // Generate clock (50MHz)
    initial Clk = 0;
    always #10 Clk = !Clk; // 50MHz Clock

    initial begin
        RegWrite = 1'b1;
        WriteRegister = 5'b01111;
        WriteData = 5'b11011;
        #20
        $display("Wrote %b to %b.", WriteData, WriteRegister);
        ReadRegister1 = 5'b01111;
        #20
        $display("Read %b from %b.", ReadData1, ReadRegister1);  
    end
endmodule
