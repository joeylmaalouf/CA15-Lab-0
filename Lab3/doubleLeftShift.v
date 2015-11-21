module doubleLeftShift26(
    input[25:0]      d,
    output reg[27:0] q,
    input            enable,
    input            clk
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
    input[31:0]      d,
    output reg[31:0] q,
    input            enable,
    input            clk
);
    always @(posedge clk) begin
        if (enable) begin
            q = d << shift;
        end
    end
endmodule
