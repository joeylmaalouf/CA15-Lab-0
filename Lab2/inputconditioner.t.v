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
			 .negativeedge(falling))


    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock
    
    initial begin
    // Your Test Code
    // Be sure to test each of the three conditioner functions:
    // Synchronize, Clean, Preprocess (edge finding)
    // Synchronize:
    // Give two inputs out of sync and see if it reads one before the other off clock cycle
    always @(conditioned) begin
	if clk != 1 begin
	$display ("Conditioned not synchronized with clock")
	end
    end

    // Input Stabilized:
    always @(pin) begin
      #100
	if (pin == 1) begin
          $display ("Debouncing Input Signal Ineffective")
      end
    end
    //Clock Edge:
    always @(rising) begin
	if conditioned != 1 begin
	  $display ("Rising edge failed to set conditioned to 1")
	end
    end
    always @(falling) begin
	if conditioned != 0 begin
	  $display ("Falling edge failed to set conditioned to 0")
	end
    end
    
	
endmodule
