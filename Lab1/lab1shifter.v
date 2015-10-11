`define NAND nand #50

module Shifter(Q, D, clock);
  output[3:0] Q;
  input[3:0] D;
  input clock;
  Dflipflop sh0(Q[0], D[3], clock);
  Dflipflop sh1(Q[1], D[0], clock);
  Dflipflop sh2(Q[2], D[1], clock);
  Dflipflop sh3(Q[3], D[2], clock);
endmodule

module Dflipflop(Q1, data, clock);
  output Q1;
  input data, clock;
  wire dflip1, dflip2, dflip3, dflip4, dflip5, dflip6;
  `NAND nand1(dflip1, data, dflip2);
  `NAND nand2(dflip2, clock, dflip1, dflip3);
  `NAND nand3(dflip3, clock, dflip4);
  `NAND nand4(dflip4, dflip1, dflip3);
  `NAND nand5(Q1, dflip6, dflip3);
  `NAND nand6(dflip6, dflip2, Q1);
endmodule

module testDflipflop();
  wire res;
  reg val;
  reg clock;
  Dflipflop flip(res, val, clock);
  initial begin
    val = 1;
    $display("%b", val);
    clock = 0;
    #10000;
    clock = 1;
    #10000;
    $display("%b", res);
  end
endmodule

module testShifter();
  wire[3:0] res;
  reg[3:0] val;
  reg clock;
  Shifter shifter(res, val, clock);
  initial begin
    val = 4'b1101;
    $display("%b", val);
    clock = 0;
    #10000;
    clock = 1;
    #10000;
    $display("%b", res);
  end
endmodule
