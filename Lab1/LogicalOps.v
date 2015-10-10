`define AND and #20
`define OR or #20

module ander(
output c,
input a,
input b
);
`AND a0(c, a, b);
endmodule

module orrer(
output c,
input a,
input b
);
`OR(c, a, b);
endmodule

module bitwiseAnder(
output reg[31:0] out,
input[31:0] a, b
);
reg placeholder_1, placeholder_2;
wire k;
ander myAnder(k, placeholder_1, placeholder_2);
integer i;
initial begin
#5;
for (i = 0; i < 32; i = i + 1) begin
placeholder_1 = a[i];
placeholder_2 = b[i];
#20;
out[i] = k;
end
end
endmodule 

module bitwiseOrrer(
output reg[31:0] out,
input[31:0] a, b
);
reg p1, p2;
wire k;
orrer myOrrer(k, p1, p2);
integer i;
initial begin
#5;
for (i = 0; i < 32; i = i + 1) begin
p1 = a[i];
p2 = b[i];
#20;
out[i] = k;
end
end

endmodule

module test();
reg [31:0] a = 32'sb00000000100001000001000000001100;
reg [31:0] b = 32'sb00010000100000000001000000001100;
wire [31:0] out;
wire [31:0] out2;
bitwiseAnder myAnder(out, a, b);
bitwiseOrrer myOrrer(out2, a, b);
initial begin
#660;
$display("and %b", out);
#660;
$display("or %b", out2);
end
endmodule 