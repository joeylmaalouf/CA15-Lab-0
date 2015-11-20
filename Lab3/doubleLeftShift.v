module doubleLeftShift(d, q, enable)
    input[31:0] d;
    reg[31:0]   q;
    input       enable;
    wire[31:0]  d;
    reg[31:0]   q;
    wire        enable;
    always @(d) begin
	if (enable) begin
	    q = d << 2;
        end
    end
endmodule
