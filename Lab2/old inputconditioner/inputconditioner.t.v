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
    #1
    // Your Test Code
    // Be sure to test each of the three conditioner functions:
    // Synchronize, Clean, Preprocess (edge finding)
    // Synchronize:
    // Give two inputs out of sync and see if it reads one before the other off clock cycle
    pin = 1;
    end
    always @(conditioned) begin
	if (clk != 1) begin
	$display ("Conditioned not synchronized with clock");
	end
    end

    // Input Stabilized:

    always @(pin) begin
      #10
      pin = 1;
      #1
      pin = 0;
      #1
      pin = 1;
      #100
      if (rising == 1) begin
      	if (conditioned != 1) begin
          $display ("Debouncing Input Signal Ineffective");
      	end
      end
    end
    //Clock Edge:
    
    always @(rising) begin
	if (conditioned != 1) begin
	  $display ("Rising edge failed to set conditioned to 1");
	end
    end
    
    always @(falling) begin
	
	if (conditioned != 0) begin
	  $display ("Falling edge failed to set conditioned to 0");
	  $display ("%b", conditioned);
	end
    end


endmodule
