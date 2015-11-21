`include "doubleLeftShift.v"
module doubleLeftShiftTest();
    reg		clk;
    reg[31:0]    d;
    wire[31:0]   q;
    reg          enable;

    doubleLeftShift32 #(32) dut(
        .clk(clk), 
    	.d(d),
    	.q(q),
	.enable(enable)
    );

    // Generate clock (50MHz)
    initial clk = 0;
    always #10 clk = !clk; // 50MHz Clock
    
    initial begin
	//d = 32'b00000000000000000000000001;
	enable = 1;
	#20
	$display("%b -> %b", d, q);
    end

endmodule
