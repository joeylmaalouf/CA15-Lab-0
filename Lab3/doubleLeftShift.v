module doubleLeftShift26(    
    input reg[25:0]    d,
    output reg[27:0]   q,
    input              enable,
    input	       clk
);
    always @(posedge clk) begin
	if (enable) begin
	    q = d << 2;
        end
    end
endmodule

module leftShift32
#(parameter shift = 2)
(
    input reg[31:0]    d,
    output reg[31:0]   q,
    input              enable,
    input	       clk
);
    always @(posedge clk) begin
	if (enable) begin
	    q = d << shift;
            $display("%b << %d = %b", d, shift, q);
        end
    end
endmodule
