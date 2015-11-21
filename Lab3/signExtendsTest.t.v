`include "signExtends.v"
module signExtendsTest();
    reg clk;
    reg[15:0] d;
    wire[25:0] q;

    signExtends dut(
        .clk(clk), 
    	.q(q),
    	.d(d)
    );

    // Generate clock (50MHz)
    initial clk = 0;
    always #10 clk = !clk; // 50MHz Clock

    initial begin
        d <= 15'd37;
        #20
        $display("%b -> %b", d, q);
    end

endmodule
