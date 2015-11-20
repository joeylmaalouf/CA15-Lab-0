`include "concatenator.v"
module concatenatorTest();
  reg[27:0]    jmpinstruction;
  reg[31:28]   PC;
  reg          clk;
  wire[31:0]   out;

    concatenator dut(
        .clk(clk), 
    	.jmpinstruction(jmpinstruction),
    	.PC(PC),
	.out(out)
    );

    // Generate clock (50MHz)
    initial clk = 0;
    always #10 clk = !clk; // 50MHz Clock

    initial begin
        jmpinstruction = 28'b1100101010101010101111111111;
	PC = 4'b0011;
        #20
        $display("%b + %b = %b", PC, jmpinstruction, out);
    end

endmodule
