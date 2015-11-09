`include "datamemory.v"
`include "dflipflop.v"
`include "finitestatemachine.v"
`include "inputconditioner.v"
`include "shiftregister.v"

module spiMemory
(
  input       clk,       // FPGA clock
  input       sclk_pin,  // SPI clock
  input       cs_pin,    // SPI chip select
  output      miso_pin,  // SPI master in slave out
  input       mosi_pin,  // SPI master out slave in
  input       fault_pin, // For fault injection testing
  output[3:0] leds       // LEDs for debugging
);
  wire[4:0] unused;
  wire mosi_cond;
  wire sclk_pos, sclk_neg;
  wire cs_cond;
  wire[7:0] sr_par_out;
  wire sr_ser_out;
  wire miso_buf, dm_we, addr_we, sr_we;
  wire[7:0] dmem_out;
  wire dff_out;
  wire[7:0] address;
  inputconditioner ic0(clk, mosi_pin, mosi_cond, unused[0], unused[1]);
  inputconditioner ic1(clk, sclk_pin, unused[2], sclk_pos, sclk_neg);
  inputconditioner ic2(clk, cs_pin, cs_cond, unused[3], unused[4]);
  shiftregister sr0(clk, sclk_pos, sr_we, dmem_out, mosi_cond, sr_par_out, sr_ser_out);
  finitestatemachine fsm0(sclk_pos, cs_cond, sr_par_out[0], miso_buf, dm_we, addr_we, sr_we);
  dflipflop dff0(clk, sclk_neg, sr_ser_out, dff_out);
  dflipflop dff1(clk, addr_we, sr_par_out, address);
  datamemory dm0(clk, dmem_out, address, dm_we, sr_par_out);
  if (miso_buf) begin
    miso_pin <= dff_out;
  end
  else begin
    miso_pin <= `Z;
  end
endmodule

module spiMemory_breakable
(
  input       clk,       // FPGA clock
  input       sclk_pin,  // SPI clock
  input       cs_pin,    // SPI chip select
  output      miso_pin,  // SPI master in slave out
  input       mosi_pin,  // SPI master out slave in
  input       fault_pin, // For fault injection testing
  output[3:0] leds       // LEDs for debugging
);
  wire[4:0] unused;
  wire mosi_cond;
  wire sclk_pos, sclk_neg;
  wire cs_cond;
  wire[7:0] sr_par_out;
  wire sr_ser_out;
  wire miso_buf, dm_we, addr_we, sr_we;
  wire[7:0] dmem_out;
  wire dff_out;
  wire[7:0] address;
  inputconditioner ic0(clk, mosi_pin, mosi_cond, unused[0], unused[1]);
  inputconditioner ic1(clk, sclk_pin, unused[2], sclk_pos, sclk_neg);
  inputconditioner ic2(clk, cs_pin, cs_cond, unused[3], unused[4]);
  shiftregister sr0(clk, sclk_pos, sr_we, dmem_out, mosi_cond, sr_par_out, sr_ser_out);
  finitestatemachine fsm0(sclk_pos, cs_cond, sr_par_out[0], miso_buf, dm_we, addr_we, sr_we);
  dflipflop dff0(clk, sclk_neg, sr_ser_out, dff_out);
  dflipflop dff1(clk, addr_we, sr_par_out, address);
  datamemory dm0(clk, dmem_out, address, dm_we, sr_par_out);
  if (miso_buf or fault_pin) begin
    miso_pin <= dff_out;
  end
  else begin
    miso_pin <= `Z;
  end
endmodule

module fault_injection_test();
  reg       clk;
  reg       sclk_pin;
  reg       cs_pin;
  wire      miso_pin;
  reg       mosi_pin;
  reg       fault_pin;
  wire[3:0] leds;
  
  spiMemory control(
    .clk(clk),
    .sclk_pin(sclk_pin),
    .cs_pin(cs_pin),
    .miso_pin(miso_pin),
    .mosi_pin(mosi_pin),
    .fault_pin(fault_pin),
    .leds(leds)
  );
  spiMemory_breakable dut(
    .clk(clk),
    .sclk_pin(sclk_pin),
    .cs_pin(cs_pin),
    .miso_pin(miso_pin),
    .mosi_pin(mosi_pin),
    .fault_pin(fault_pin),
    .leds(leds)
  );

  initial clk = 0;
  always #10 clk = !clk;
  initial begin
    // check if miso_pin is set, even if miso_buf isn't
  end
endmodule
