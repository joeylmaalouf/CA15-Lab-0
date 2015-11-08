`include "inputconditioner.v"
//------------------------------------------------------------------------
// Input Conditioner test bench
//------------------------------------------------------------------------

module testConditioner();

    reg clk;
    reg pin;
    wire conditioned;
    wire rising;
    wire falling;
    
    inputconditioner dut(.clk(clk),
    			 .noisysignal(pin),
			 .conditioned(conditioned),
			 .positiveedge(rising),
			 .negativeedge(falling));


    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock
    
    initial begin
    pin = 0;
    #100;

		pin = 1;
		#28;
		pin = 0;
		#2;
		pin = 1;
		#29;
		pin = 0;
		#2;
		pin = 1;
		#30;
		pin = 0;
		#2;
		pin = 1;
		#31;
		pin = 0;
		#100;
    end 
endmodule 