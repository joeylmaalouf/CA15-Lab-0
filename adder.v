`define XOR xor #50
`define AND and #50
`define OR or #50

module behavioralFullAdder(sum, carryout, a, b, carryin);
output sum, carryout;
input a, b, carryin;
assign {carryout, sum}=a+b+carryin;
endmodule

module structuralFullAdder(out, carryout, a, b, carryin);
output out, carryout;
input a, b, carryin;
wire AxorB, carryout_condition1, carryout_condition2;
`XOR xor1(AxorB, a, b);
`AND and1(carryout_condition1, AxorB, carryin); // If only one of a and b is high, and carryin is high, then carryout is high
`AND and2(carryout_condition2, a, b); // If both a and b are high, then carryout is high
`OR or1(carryout, carryout_condition1, carryout_condition2);
`XOR xor2(out, AxorB, carryin); // Sum is high only when only one of a or b is high or both are matching values and carryin is high
endmodule

module FullAdder4bit (
  output[3:0] sum,  // 2's complement sum of a and b
  output carryout,  // Carry out of the summation of a and b
  output overflow,  // True if the calculation resulted in an overflow
  input[3:0] a,     // First operand in 2's complement format
  input[3:0] b      // Second operand in 2's complement format
);
wire carryover1, carryover2, carryover3;
structuralFullAdder adder1(sum[0], carryover1, a[0], b[0], 1'b0);
structuralFullAdder adder2(sum[1], carryover2, a[1], b[1], carryover1);
structuralFullAdder adder3(sum[2], carryover3, a[2], b[2], carryover2);
structuralFullAdder adder4(sum[3], carryout, a[3], b[3], carryover3);
`XOR overflow_check(overflow, carryout, carryover3);
endmodule

module test4bitAdder;
reg [3:0] a = 4'sb0000; // Init to signed 4 bit numbers
reg [3:0] b = 4'sb0000; // Init to 0
wire [3:0] sum;
wire carryout, overflow;
FullAdder4bit adder(sum, carryout, overflow, a, b);

initial begin
a = 4'sb0101; // Set values to test
b = 4'sb1010;
$display(" Sum  | Cout | Overflow?");
#500 // It takes a long time to changes to propogate, unsure how to reduce this
$display(" %b | %b    | %b", sum, carryout, overflow);
end
endmodule

module testFullAdder;
reg a, b, carryin;
wire sum, carryout, test_sum, test_carryout;
behavioralFullAdder model (sum, carryout, a, b, carryin);
structuralFullAdder test (test_sum, test_carryout, a, b, carryin);

initial begin
$display("Cin A B | Sum Cout | Expected");
carryin=0; a=0; b=0; #1000
$display(" %b  %b %b |  %b    %b  | %b  %b ", carryin, a, b, test_sum, test_carryout, sum, carryout);
carryin=0; a=1; b=0; #1000
$display(" %b  %b %b |  %b    %b  | %b  %b ", carryin, a, b, test_sum, test_carryout, sum, carryout);
carryin=0; a=0; b=1; #1000
$display(" %b  %b %b |  %b    %b  | %b  %b ", carryin, a, b, test_sum, test_carryout, sum, carryout);
carryin=0; a=1; b=1; #1000
$display(" %b  %b %b |  %b    %b  | %b  %b ", carryin, a, b, test_sum, test_carryout, sum, carryout);
carryin=1; a=0; b=0; #1000
$display(" %b  %b %b |  %b    %b  | %b  %b ", carryin, a, b, test_sum, test_carryout, sum, carryout);
carryin=1; a=1; b=0; #1000
$display(" %b  %b %b |  %b    %b  | %b  %b ", carryin, a, b, test_sum, test_carryout, sum, carryout);
carryin=1; a=0; b=1; #1000
$display(" %b  %b %b |  %b    %b  | %b  %b ", carryin, a, b, test_sum, test_carryout, sum, carryout);
carryin=1; a=1; b=1; #1000
$display(" %b  %b %b |  %b    %b  | %b  %b ", carryin, a, b, test_sum, test_carryout, sum, carryout);
end
endmodule
