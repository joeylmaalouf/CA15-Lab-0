`include "datamemory.v"
`include "dflipflop.v"
`include "finitestatemachine.v"
`include "inputconditioner.v"
`include "shiftregister.v"

//module spiMemory
//(
//  input       clk,       // FPGA clock
//  input       sclk_pin,  // SPI clock
//  input       cs_pin,    // SPI chip select
//  output      miso_pin,  // SPI master in slave out
//  input       mosi_pin,  // SPI master out slave in
//  input       fault_pin, // For fault injection testing
//  output[3:0] leds       // LEDs for debugging
//);
//  wire[4:0] unused;
//  wire mosi_cond;
//  wire sclk_pos, sclk_neg;
//  wire cs_cond;
//  wire[7:0] sr_par_out;
//  wire sr_ser_out;
//  wire miso_buf, dm_we, addr_we, sr_we;
//  wire[7:0] dmem_out;
//  wire dff_out;
//  wire[7:0] address;
//  wire[2:0] state;
//  reg storage;
//  inputconditioner ic0(clk, mosi_pin, mosi_cond, unused[0], unused[1]);
//  inputconditioner ic1(clk, sclk_pin, unused[2], sclk_pos, sclk_neg);
//  inputconditioner ic2(clk, cs_pin, cs_cond, unused[3], unused[4]);
//  shiftregister sr0(clk, sclk_pos, sr_we, dmem_out, mosi_cond, sr_par_out, sr_ser_out);
//  finitestatemachine fsm0(sclk_pos, cs_cond, sr_par_out[0], miso_buf, dm_we, addr_we, sr_we, state);
//  dflipflop1 dff0(clk, sclk_neg, sr_ser_out, dff_out);
//  dflipflop8 dff1(clk, addr_we, sr_par_out, address);
//  datamemory dm0(clk, dmem_out, address[6:0], dm_we, sr_par_out);
//  always @(posedge clk) begin
//    if (miso_buf) begin
//      $display("SR Params %b %b %b %b %b", clk, sclk_pos, sr_we, dmem_out, mosi_cond);
//      $display("Parallel Out: %b", sr_par_out);
//      $display("Serial Out: %b", sr_ser_out);
//      storage <= dff_out;
//    end
//    else begin
//      storage = 1'bZ;
//    end
//  end
//  assign miso_pin = storage;
//  assign leds = state;
//endmodule

//module spiMemory_breakable
//(
//  input       clk,       // FPGA clock
//  input       sclk_pin,  // SPI clock
//  input       cs_pin,    // SPI chip select
//  output      miso_pin,  // SPI master in slave out
//  input       mosi_pin,  // SPI master out slave in
//  input       fault_pin, // For fault injection testing
//  output[3:0] leds       // LEDs for debugging
//);
//  wire[4:0] unused;
//  wire mosi_cond;
//  wire sclk_pos, sclk_neg;
//  wire cs_cond;
//  wire[7:0] sr_par_out;
//  wire sr_ser_out;
//  wire miso_buf, dm_we, addr_we, sr_we;
//  wire[7:0] dmem_out;
//  wire dff_out;
//  wire[7:0] address;
//  wire[2:0] state;
//  reg storage;
//  inputconditioner ic0(clk, mosi_pin, mosi_cond, unused[0], unused[1]);
//  inputconditioner ic1(clk, sclk_pin, unused[2], sclk_pos, sclk_neg);
//  inputconditioner ic2(clk, cs_pin, cs_cond, unused[3], unused[4]);
//  shiftregister sr0(clk, sclk_pos, sr_we, dmem_out, mosi_cond, sr_par_out, sr_ser_out);
//  finitestatemachine fsm0(sclk_pos, cs_cond, sr_par_out[0], miso_buf, dm_we, addr_we, sr_we, state);
//  dflipflop1 dff0(clk, sclk_neg, sr_ser_out, dff_out);
//  dflipflop8 dff1(clk, addr_we, sr_par_out, address);
//  datamemory dm0(clk, dmem_out, address[6:0], dm_we, sr_par_out);
//  always @(posedge clk) begin
//    if (miso_buf || fault_pin) begin
//      storage <= dff_out;
//    end
//    else begin
//      storage = 1'bZ;
//    end
//  end
//  assign miso_pin = storage;
//  assign leds = state;
//endmodule

module spimemory_wrapper(
  input[3:0] sw,
  input clk,
  output[3:0] led
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
  wire[2:0] state;
  reg storage;
  inputconditioner ic0(clk, sw[2], mosi_cond, unused[0], unused[1]);
  inputconditioner ic1(clk, sw[0], unused[2], sclk_pos, sclk_neg);
  inputconditioner ic2(clk, sw[1], cs_cond, unused[3], unused[4]);
  shiftregister sr0(clk, sclk_pos, sr_we, dmem_out, mosi_cond, sr_par_out, sr_ser_out);
  finitestatemachine fsm0(sclk_pos, cs_cond, sr_par_out[0], miso_buf, dm_we, addr_we, sr_we, state);
  dflipflop1 dff0(clk, sclk_neg, sr_ser_out, dff_out);
  dflipflop8 dff1(clk, addr_we, sr_par_out, address);
  datamemory dm0(clk, dmem_out, address[6:0], dm_we, sr_par_out);
  always @(posedge clk) begin
    if (miso_buf || sw[3]) begin
      storage <= dff_out;
    end
    else begin
      storage = 1'bZ;
    end
  end
  assign led[0] = storage;
  assign led[3:1] = state;
  //spiMemory_breakable dut(clk, sw[0], sw[1], led[0], sw[2], sw[3], led[3:1]);
endmodule
