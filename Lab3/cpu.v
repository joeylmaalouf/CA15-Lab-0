`include "alu.v"
`include "arithmatic.v"
`include "control_module.v"
`include "mux.v" //  contains all muxs
`include "doubleLeftShift.v" // shift left by 2
`include "signExtendu.v" //sign extend unsigned
`include "signExtens.v" //sign extend signed
`include "regfile.v" //register file
module mips_cpu
(
input Clk
);
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

	//Control Module
	cpu_control control_module(op, inst_funct, reg_dest, alu_src, mem_write_enable, mem_to_reg, pc_src, write_enable, mem_read_enable, alu_op, jump_enable, bne_pc_override, jal_reg_override);

	//2:1 mux
	//ties pc_chooser mux directly to zero flag of ALU for use in BNE operations
	// input 0, input 1, choice, output
	mux2 bne_pc_override_mux(pc_src, zero_flag, bne_pc_override, pc_choose); //checked

	//PC register
	//Checked for completeness
	register32 PC(next_instruction_addr, instruction_addr); //in progress

	//PC incrementer
	bitwiseAdd pc_incrementer(instruction_addr_plus4, overflow, instruction_addr, 32'd4, 1'b0);

	//PC adder
	bitwiseAdd pc_jumper(instruction_addr_plus_immediate, instruction_addr_plus4, shifted_extended_immediate);

	//PC chooser
	mux32 pc_chooser(instruction_addr_plus4, instruction_addr_plus_immediate, pc_choose, normal_pc);

	//PC Jumper
	mux32 jump_mux(normal_pc, pc_jump_addr, jump_enable, next_instruction_addr);

	//Take address from instruction and shift left by 2
	shift_by_two jump_shifter(jump_instruction_addr, jump_instruction_addr_shifted);

	//Concat shifted jump address with 4 most significant bits of PC+4
	//Stick the 4 most significant bits of PC+4 on to the shifted immediate from the instruction
	concatenator jump_add_concat(instruction_addr_plus4, jump_instruction_addr_shifted, pc_jump_addr);

	//instruction memory module
	instruction_mem instruction_memory(instruction_addr, op, inst_1, inst_2, inst_3_a, inst_3_b, inst_funct, jump_instruction_addr);

	//instruction register destination mux
    //output, choice 1, choice 2, selector
	mux5 reg_dest_mux(inst_2, inst_3_a, reg_dest, normal_write_addr); //included

	//mux to choose address to write to for jal op
	mux5 jal_reg_mux(normal_write_addr, 5'd31, jal_reg_override, write_addr);

	//memory register module
	reg32 memory_data_reg(mem_data, mem_data_out);

	//sign extending module
	sign_extender immediate_extender(inst_3, extended_immediate); //included

	//shift left by 2'er module
	shift_by_two immediate_shifter(extended_immediate, shifted_extended_immediate); //included

	//operational register module
	//async_register register(read_1_addr, read_2_addr, write_addr, write_data, write_enable, read_1, read_2);
	regfile register(inst_1, inst_2, write_addr, write_data, write_enable, read_1, read_2);

	//alu source mux
	mux32 alu_src_mux(b, read_2, extended_immediate, alu_src); //included

	//alu module
	//alu ALU(a, b, alu_res, zero_flag);
	alu ALU(read_1, b, alu_res, zero_flag, alu_op); //included 

	//data memory module
	//data_memory data_mem(clk, mem_read_addr, mem_write_addr, mem_read_enable, mem_write_enable, mem_write_data_in, mem_read_data_out);
	data_memory data_mem(clk, alu_res, alu_res, mem_read_enable, mem_write_enable, read_2, mem_read);

	//memory to register mux
	mux32 mem_to_reg_mux(alu_res, mem_read, mem_to_reg, normal_write_data); //included

	//Optionally forces register to write PC+4 to whatever address
	//useful for jal operations
	mux32 jal_data_mux(normal_write_data, instruction_addr_plus4, jal_reg_override, write_data);

endmodule
