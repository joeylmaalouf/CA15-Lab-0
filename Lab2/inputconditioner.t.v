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
    
    always @(conditioned) begin
      if (clk != 1 && $time > 100) begin
        $display ("Conditioned not synchronized with clock");
      end
    end

    initial begin
      pin = 1;
      #240;

      pin = 0;
      #60;
      pin = 1;
      #31;
      if (conditioned == 1) begin
        $display("Conditioned not set properly");
      end
      #120;

      pin = 0;
      #58;
      pin = 1;
      #41;
      if (conditioned == 0) begin
        $display("Glitch suppression failed");
      end
    end 

    always @(posedge rising) begin
      if (conditioned != 1 && $time > 100) begin
        $display ("Rising edge failed to set conditioned to 1");
      end
    end
    
    always @(posedge falling) begin
      if (conditioned != 0 && $time > 100) begin
        $display ("Falling edge failed to set conditioned to 0");
      end
    end
endmodule 