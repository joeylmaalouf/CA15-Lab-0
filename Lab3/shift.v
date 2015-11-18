// This is a left shifter. It uses D flip flops to capture data and update it with the clock cycle. The 
// D flip flops use only NAND gates. 
`define NAND nand #30

module bitwiseSHFT(Q, D, clock);
  output[31:0] Q;
  input[31:0] D;
  input clock;
  Dflipflop dff00(Q[ 1], D[ 0], clock); // Shifts everything to the left by moving the output to the new location
  Dflipflop dff01(Q[ 2], D[ 1], clock);
  Dflipflop dff02(Q[ 3], D[ 2], clock);
  Dflipflop dff03(Q[ 4], D[ 3], clock);
  Dflipflop dff04(Q[ 5], D[ 4], clock);
  Dflipflop dff05(Q[ 6], D[ 5], clock);
  Dflipflop dff06(Q[ 7], D[ 6], clock);
  Dflipflop dff07(Q[ 8], D[ 7], clock);
  Dflipflop dff08(Q[ 9], D[ 8], clock);
  Dflipflop dff09(Q[10], D[ 9], clock);
  Dflipflop dff10(Q[11], D[10], clock);
  Dflipflop dff11(Q[12], D[11], clock);
  Dflipflop dff12(Q[13], D[12], clock);
  Dflipflop dff13(Q[14], D[13], clock);
  Dflipflop dff14(Q[15], D[14], clock);
  Dflipflop dff15(Q[16], D[15], clock);
  Dflipflop dff16(Q[17], D[16], clock);
  Dflipflop dff17(Q[18], D[17], clock);
  Dflipflop dff18(Q[19], D[18], clock);
  Dflipflop dff19(Q[20], D[19], clock);
  Dflipflop dff20(Q[21], D[20], clock);
  Dflipflop dff21(Q[22], D[21], clock);
  Dflipflop dff22(Q[23], D[22], clock);
  Dflipflop dff23(Q[24], D[23], clock);
  Dflipflop dff24(Q[25], D[24], clock);
  Dflipflop dff25(Q[26], D[25], clock);
  Dflipflop dff26(Q[27], D[26], clock);
  Dflipflop dff27(Q[28], D[27], clock);
  Dflipflop dff28(Q[29], D[28], clock);
  Dflipflop dff29(Q[30], D[29], clock);
  Dflipflop dff30(Q[31], D[30], clock);
  Dflipflop dff31(Q[ 0], D[31], clock);
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
  `NAND nand6(dflip6, dflip2, Q1); // total delay of 120
endmodule
