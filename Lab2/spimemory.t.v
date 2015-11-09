`include "spimemory.v"

module fault_injection_test();
  reg       clk;
  reg       sclk_pin;
  reg       cs_pin;
  wire      miso_pin;
  reg       mosi_pin;
  reg       fault_pin;
  wire[3:0] leds;
  
  /*spiMemory control(
    .clk(clk),
    .sclk_pin(sclk_pin),
    .cs_pin(cs_pin),
    .miso_pin(miso_pin),
    .mosi_pin(mosi_pin),
    .fault_pin(fault_pin),
    .leds(leds)
  );*/
  spiMemory_breakable dut(
    .clk(clk),
    .sclk_pin(sclk_pin),
    .cs_pin(cs_pin),
    .miso_pin(miso_pin),
    .mosi_pin(mosi_pin),
    .fault_pin(fault_pin),
    .leds(leds)
  );
	initial clk = 0;
  always #10 clk = !clk;
  initial begin
		fault_pin = 1;
		cs_pin = 0;
		#60;

		sclk_pin = 1;
		mosi_pin = 1;
		#60;
		sclk_pin = 0;
    #60;

    sclk_pin = 1; #60; sclk_pin = 0; #60;
    sclk_pin = 1; #60; sclk_pin = 0; #60;
    sclk_pin = 1; #60; sclk_pin = 0; #60;
    sclk_pin = 1; #60; sclk_pin = 0; #60;
    sclk_pin = 1; #60; sclk_pin = 0; #60;
    sclk_pin = 1; #60; sclk_pin = 0; #60;
    sclk_pin = 1; #60; sclk_pin = 0; #60;
    sclk_pin = 1; #60; sclk_pin = 0;
  end
endmodule