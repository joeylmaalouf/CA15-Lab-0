`include "signExtendu.v"
module signExtenduTest();
    reg clk;
    reg[4:0] d;
    wire[31:0] q;

    signExtendu dut(
        .clk(clk), 
    	.q(q),
    	.d(d)
    );

    // Generate clock (50MHz)
    initial clk = 0;
    always #10 clk = !clk; // 50MHz Clock

    initial begin
        d <= 5'b10100;
        #20
        $display("%b -> %b", d, q);
    end

endmodule
