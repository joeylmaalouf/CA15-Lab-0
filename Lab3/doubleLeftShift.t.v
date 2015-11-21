`include "doubleLeftShift.v"
module doubleLeftShiftTest();
    reg		clk;
    reg[25:0]  d;
    wire[27:0]   q;
    reg        enable;

    doubleLeftShift dut(
        .clk(clk), 
    	.d(d),
    	.q(q),
	.enable(enable)
    );

    // Generate clock (50MHz)
    initial clk = 0;
    always #10 clk = !clk; // 50MHz Clock
    
    initial begin
	d = 32'b10000000000000000000000000;
	enable = 1;
	#20
	$display("%b -> %b", d, q);
    end

endmodule
