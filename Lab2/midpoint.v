`include "inputconditioner.v"
`include "shiftregister.v"
//module midpoint(
//  input parallelIn,
//  input button0,           // activates parallel load
//  input switch0,           // manual control of serial input
//  input switch1,           // manual control of serial input
//  input clk,               // clock
//  output[7:0] parallelout,
//  output serialout
//);
//  wire button0smooth, button0posedge, button0negedge;
//  wire switch0smooth, switch0posedge, switch0negedge;
//  wire switch1smooth, switch1posedge, switch1negedge;
//  inputconditioner icb0(clk, button0, button0smooth, button0posedge, button0negedge);
//  inputconditioner ics0(clk, switch0, switch0smooth, switch0posedge, switch0negedge);
//  inputconditioner ics1(clk, switch1, switch1smooth, switch1posedge, switch1negedge);
//  shiftregister sr(clk, switch1posedge, button0negedge, parallelIn, switch0smooth, parallelout, serialout);
//endmodule

module midpoint_wrapper (
    input[1:0] sw,
    input clk,
    input[0:0] btn,
    output[3:0] led
);
    wire button0smooth, button0posedge, button0negedge;
    wire switch0smooth, switch0posedge, switch0negedge;
    wire switch1smooth, switch1posedge, switch1negedge;
    inputconditioner icb0(clk, btn[0], button0smooth, button0posedge, button0negedge);
    inputconditioner ics0(clk, sw[0], switch0smooth, switch0posedge, switch0negedge);
    inputconditioner ics1(clk, sw[1], switch1smooth, switch1posedge, switch1negedge);
    shiftregister sr(clk, switch1posedge, button0negedge, 8'hA5, switch0smooth, led, serialout);
   // midpoint device(8'hA5, btn[0], sw[0], sw[1], clk, led);
endmodule 