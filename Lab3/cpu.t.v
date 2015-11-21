`include "cpu.v"
module CPUTest();
  wire[31:0] mem_read, alu_res, next_instruction_addr, instruction_addr, instruction_addr_plus4, 
  		jumped_pc, mem_data, mem_data_out, extended_immediate, shifted_extended_immediate, b,
  		normal_pc, pc_jump_addr, read_1, read_2, normal_write_data;
  wire[31:26] op;
  wire[25:21] inst_1;
  wire[25:0] jump_instruction_addr;
  wire[27:0] jump_instruction_addr_shifted;
  wire[20:16] inst_2;
  wire[15:11] inst_3_a;
  wire[15:0] inst_3_b;
  wire[5:0] inst_funct;
  wire[4:0] write_addr;
  wire[2:0] alu_op;
  wire reg_dest, alu_src, zero_flag, alu_op, write_enable, mem_write_enable, mem_read_enable, mem_to_reg, 
		 pc_src, jump_enable, bne_pc_override, pc_choose, jal_reg_override, normal_write_addr, overflow;  
  reg clk;
  mips_cpu dut(
	.clk(clk),
	.overflow(overflow),
	.mem_read(mem_read),
	.reg_dest(reg_dest),
	.alu_src(alu_src),
	.zero_flag(zero_flag),
	.alu_op(alu_op),
	.write_enable(write_enable),
	.mem_write_enable(mem_write_enable),
	.mem_read_enable(mem_read_enable),
	.mem_to_reg(mem_to_reg),
	.pc_src(pc_src),
	.jump_enable(jump_enable),
	.bne_pc_override(bne_pc_override),
	.pc_choose(pc_choose),
	.jal_reg_override(jal_reg_override),
	.normal_write_addr(normal_write_addr),
	.mem_read_enable(mem_read_enable),
	.alu_res(alu_res),
	.next_instruction_addr(next_instruction_addr),
	.instruction_addr(instruction_addr),
	.instruction_addr_plus4(instruction_addr_plus4),
	.jumped_pc(jumped_pc),
	.mem_data(mem_data),
	.mem_data_out(mem_data_out),
	.extended_immediate(extended_immediate),
	.shifted_extended_immediate(shifted_extended_immediate),
	.b(b),
	.normal_pc(normal_pc),
	.pc_jump_addr(pc_jump_addr),
	.read_1(read_1),
	.read_2(read_2),
	.normal_write_data(normal_write_data),
	.op(op),
	.inst_1(inst_1),
	.jump_instruction_addr(jump_instruction_addr),
	.jump_instruction_addr_shifted(jump_instruction_addr_shifted),
	.inst_2(inst_2),
	.inst_3_a(inst_3_a),
	.inst_3_b(inst_3_b),
	.inst_funct(inst_funct),
	.write_addr(write_addr),
	.alu_op(alu_op),
);
  

  initial clk = 0;
  always #10 clk = !clk;
endmodule
