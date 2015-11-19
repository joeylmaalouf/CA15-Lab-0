//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------
`include "register32.v"
`include "mux32to1by32.v"
`include "register32zero.v"
`include "decoder1to32.v"

module regfile
(
output[31:0]	ReadData1,	// Contents of first register read
output[31:0]	ReadData2,	// Contents of second register read
input[31:0]	WriteData,	// Contents to write to register
input[4:0]	ReadRegister1,	// Address of first register to read
input[4:0]	ReadRegister2,	// Address of second register to read
input[4:0]	WriteRegister,	// Address of register to write
input		RegWrite,	// Enable writing of register when High
input		Clk		// Clock (Positive Edge Triggered)
);
  
  wire[31:0] registerwires[31:0];
  wire[31:0] enable;
  decoder1to32 decoder(enable, RegWrite, WriteRegister);
  
  //Attatch all of the wires to the registers
  register32zero reg0(registerwires[0], WriteData, enable[0], Clk);
  genvar i;
  generate
  for(i=1;i<32;i=i+1) begin: loop
    register32 register(registerwires[i], WriteData, enable[i], Clk);
  end
  endgenerate

  mux32to1by32 reader1(ReadData1, ReadRegister1, registerwires[0], registerwires[1], registerwires[2], registerwires[3], registerwires[4], registerwires[5], registerwires[6], registerwires[7], registerwires[8], registerwires[9], registerwires[10], registerwires[11], registerwires[12], registerwires[13], registerwires[14], registerwires[15], registerwires[16], registerwires[17], registerwires[18], registerwires[19], registerwires[20], registerwires[21], registerwires[22], registerwires[23], registerwires[24], registerwires[25], registerwires[26], registerwires[27], registerwires[28], registerwires[29], registerwires[30], registerwires[31]);
  mux32to1by32 reader2(ReadData2, ReadRegister1, registerwires[0], registerwires[1], registerwires[2], registerwires[3], registerwires[4], registerwires[5], registerwires[6], registerwires[7], registerwires[8], registerwires[9], registerwires[10], registerwires[11], registerwires[12], registerwires[13], registerwires[14], registerwires[15], registerwires[16], registerwires[17], registerwires[18], registerwires[19], registerwires[20], registerwires[21], registerwires[22], registerwires[23], registerwires[24], registerwires[25], registerwires[26], registerwires[27], registerwires[28], registerwires[29], registerwires[30], registerwires[31]);
endmodule


