`include "inputconditioner.v"
`include "shiftregister.v"
module midpoint(
  input button0,           // activates parallel load
  input switch0,           // manual control of serial input
  input switch1,           // manual control of serial input
  input clk,               // clock
  output[7:0] parallelout, // parallel output
  output serialout         // serial output
);
  wire button0smooth, button0posedge, button0negedge;
  wire switch0smooth, switch0posedge, switch0negedge;
  wire switch1smooth, switch1posedge, switch1negedge;
  inputconditioner icb0(clk, button0, button0smooth, button0posedge, button0negedge);
  inputconditioner ics0(clk, switch0, switch0smooth, switch0posedge, switch0negedge);
  inputconditioner ics1(clk, switch1, switch1smooth, switch1posedge, switch1negedge);
  shiftregister sr(clk, switch1posedge, button0negedge, 8`hA5, switch0smooth, parallelout, serialout);
endmodule
