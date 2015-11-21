module datamemory(clk, regWE, Addr, DataIn, DataOut);
  input clk, regWE;
  input[9:0] Addr;
  input[31:0] DataIn;
  output[31:0]  DataOut;

  reg [31:0] mem[16383:0];  
  always @(posedge clk) begin
    if (regWE) begin
      mem[Addr] <= DataIn;
    end
  end

  initial $readmemh(tests.dat”, mem);

  assign DataOut = mem[Addr];
endmodule
