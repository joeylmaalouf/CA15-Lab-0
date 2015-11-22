`include "alu.v"
`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7
module ALUtest();
  wire [31:0] result;
  wire zero;
  reg[31:0] a, b;
  reg[2:0] command;
  ALU dut(result, zero, a, b, command);
  initial begin
    command = `ADD; a = 32'd9; b = 32'd17; #1
    $display("  %b\n+ %b\n= %b\n", a, b, result);
    command = `SUB; a = 32'd20; b = 32'd15; #1
    $display("  %b\n- %b\n= %b\n", a, b, result);
    command = `XOR; a = 32'd3; b = 32'd5; #1
    $display("  %b\n^ %b\n= %b\n", a, b, result); 
    command = `SLT; a = 32'd4; b = 32'd8; #1
    $display("  %b\n< %b\n= %b\n", a, b, result);
    command = `AND; a = 32'd6; b = 32'd7; #1
    $display("  %b\n& %b\n= %b\n", a, b, result);
    command = `OR; a = 32'd12; b = 32'd180; #1
    $display("  %b\n| %b\n= %b\n", a, b, result);
    command = `NAND; a = 32'd12; b = 32'd180; #1
    $display("~ %b\n& %b\n= %b\n", a, b, result);
    command = `NOR; a = 32'd12; b = 32'd180; #1
    $display("~ %b\n| %b\n= %b\n", a, b, result);
  end
endmodule
