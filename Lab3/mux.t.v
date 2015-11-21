`include "mux.v"
module MuxTest();
  reg sel2, sel5, sel32;
  reg[1:0] a2, b2;
  wire[1:0] c2;
  reg[4:0] a5, b5;
  wire[4:0] c5;
  reg[31:0] a32, b32;
  wire[31:0] c32;
  mux #(2) m2(a2, b2, sel2, c2);
  mux #(5) m5(a5, b5, sel5, c5);
  mux #(32) m32(a32, b32, sel32, c32);
  initial begin
    a2 = 2'd1;
    b2 = 2'd2;
    a5 = 5'd10;
    b5 = 5'd20;
    a32 = 32'd100;
    b32 = 32'd200;
    sel2 = 0;
    sel5 = 0;
    sel32 = 0;
    #1
    $display("%d, %d, %d", c2, c5, c32);
    sel2 = 1;
    sel5 = 1;
    sel32 = 1;
    #1
    $display("%d, %d, %d", c2, c5, c32);
  end
endmodule
