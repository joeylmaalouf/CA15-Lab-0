`include "alu.v"
`include "mux.v" //  32:1 mux
`include "mux5.v" // 5:1 mux
`include "doubleLeftShift"
`include "signExtendu.v" //sign extend unsigned
`include "signExtens.v" //sign extend signed
`include "regfile.v" //register file
module mips_cpu();

	wire[31:0] mem_read, alu_res, next_instruction_addr, instruction_addr, instruction_addr_plus4, 
						 jumped_pc, mem_data_out, extended_immediate, shifted_extended_immediate, b;
	wire[31:26] op;
	wire[25:21] inst_1;
	wire[20:16] inst_2;
	wire[15:11] inst_3_a
	wire[15:0] inst_3_b;
	wire[4:0] write_addr;
	wire reg_dest, alu_src, zero_flag, alu_op, mem_write_enable, mem_read_enable, mem_to_reg, pc_src;

	//Control Module
	cpu_control controle_module(op, reg_dest, alu_src, alu_op, mem_write_enable, mem_to_reg, pc_src);

	//PC register
	reg32 PC(next_instruction_addr, instruction_addr);

	//PC incrementer
	adder32 pc_incrementer(instruction_addr_plus4, instruction_addr, 32'b00000000000000000000000000000100);

	//PC jump adder
	adder32 pc_jumper(jumped_pc, instruction_addr_plus4, shifted_extended_immediate);

	//PC chooser
	mux32 pc_chooser(next_instruction_addr, instruction_addr_plus4, jumped_pc, pc_src);

	//instruction memory module
	instruction_mem instruction_memory(instruction_addr, op, inst_1, inst_2, inst_3_a, inst_3_b);

	//instruction register destination mux
  //output, choice 1, choice 2, selector
	mux5 reg_dest_mux(write_addr, inst_2, inst_3_a, reg_dest); //included

	//memory register module
	reg32 memory_data_reg(mem_data, mem_data_out);

	//sign extending module
	sign_extender immediate_extender(inst_3, extended_immediate); //included

	//shift left by 2'er module
	shift_by_two immediate_shifter(extended_immediate, shifted_extended_immediate); //included

	//operational register module
	//async_register register(read_1_addr, read_2_addr, write_addr, write_data, write_enable, read_1, read_2);
	async_register register(inst_1, inst_2, write_addr, write_data, write_enable, read_1, read_2);

	//alu source mux
	mux32 alu_src_mux(b, read_2, extended_immediate, alu_src); //included

	//alu module
	//alu ALU(a, b, alu_res, zero_flag);
	alu ALU(read_1, b, alu_res, zero_flag, alu_op); //included 

	//data memory module
	//data_memory data_mem(mem_read_addr, mem_write_addr, mem_write_data, mem_read, mem_write_enable, mem_read_enable);
	data_memory data_mem(alu_res, alu_res, read_2, mem_read, mem_write_enable, mem_read_enable);

	//memory to register mux
	mux32 mem_to_reg_mux(write_data, mem_read, alu_res, mem_to_reg); //included

endmodule
