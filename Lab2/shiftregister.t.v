`include "shiftregister.v"
//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------

module testshiftregister();

    reg             clk;
    reg             peripheralClkEdge;
    reg             parallelLoad;
    wire[7:0]       parallelDataOut;
    wire            serialDataOut;
    reg[7:0]        parallelDataIn;
    reg             serialDataIn; 
    
    // Instantiate with parameter width = 8
    shiftregister #(8) dut(.clk(clk), 
    		           .peripheralClkEdge(peripheralClkEdge),
    		           .parallelLoad(parallelLoad), 
    		           .parallelDataIn(parallelDataIn), 
    		           .serialDataIn(serialDataIn), 
    		           .parallelDataOut(parallelDataOut), 
    		           .serialDataOut(serialDataOut));
    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock
   
    initial begin
    peripheralClkEdge = 1;
    parallelLoad = 0;
    parallelDataIn = 8'b00100001;
    serialDataIn = 1;
    end

    always @(posedge peripheralClkEdge) begin
//testing the broken case
	if (parallelDataOut == parallelDataIn) begin
	  $display("Parallel Load Flag Ignored; Value Propagated When Flag Was False");
	end
	if (serialDataOut != serialDataIn) begin
	  $display("Failed To Set Serial Data To Serial Out Effectively; Though Parallel Flag Was False, Serial Didn't Fire")	;
	end
// testing the normal case
	#1
	parallelLoad = 1;
	if (parallelDataOut != parallelDataIn) begin
	  $display("Normal Parallel Load Case Failed; Flag Failed To Propogate When Flag Was True");
	end
	if (serialDataOut == serialDataIn) begin
	  $display("Serial Data Propagated Incorrectly; Parallel Flag Failed To Prevent Serial Write");
	end
        #1
	peripheralClkEdge = 0;
    end
    always @(negedge peripheralClkEdge) begin
	parallelDataIn = 8'b11001001;
	serialDataIn = 0;
	if (parallelDataIn == parallelDataOut) begin
	  $display("Shift Register Working Off Peripheral Clock Edge (Parallel)");
	end
	parallelLoad = 0;
	if (serialDataIn == serialDataOut) begin
	  $display("Shift Register Working Off Peripheral Clock Edge (Serial)");
	end
    end
endmodule

