vlog -reportprogress 300 -work work cpu.t.v
vsim -voptargs="+acc" CPUTest

add wave -position insertpoint  \
sim:/CPUTest/mem_read \
sim:/CPUTest/alu_res \
sim:/CPUTest/next_instruction_addr \
sim:/CPUTest/instruction_addr \
sim:/CPUTest/jumped_pc \
sim:/CPUTest/mem_data \
sim:/CPUTest/mem_data_out \
sim:/CPUTest/extended_immediate \
sim:/CPUTest/shifted_extended_immediate \
sim:/CPUTest/b \
sim:/CPUTest/normal_pc \
sim:/CPUTest/pc_jump_addr \
sim:/CPUTest/instruction_addr_plus4 \
sim:/CPUTest/op \
sim:/CPUTest/inst_1 \
sim:/CPUTest/jump_instruction_addr \
sim:/CPUTest/jump_instruction_addr_shifted \
sim:/CPUTest/inst_2 \
sim:/CPUTest/inst_3_a \
sim:/CPUTest/inst_3_b \
sim:/CPUTest/inst_funct \
sim:/CPUTest/write_addr \
sim:/CPUTest/alu_op \
sim:/CPUTest/reg_dest \
sim:/CPUTest/alu_src \
sim:/CPUTest/zero_flag \
sim:/CPUTest/alu_op \
sim:/CPUTest/write_enable \
sim:/CPUTest/mem_write_enable \
sim:/CPUTest/mem_read_enable \
sim:/CPUTest/mem_to_reg \
sim:/CPUTest/pc_src \
sim:/CPUTest/jump_enable \
sim:/CPUTest/bne_pc_override \
sim:/CPUTest/pc_choose \
sim:/CPUTest/jal_reg_override \
sim:/CPUTest/normal_write_addr \
sim:/CPUTest/read_1 \
sim:/CPUTest/read_2 \
sim:/CPUTest/overflow \
sim:/CPUTest/normal_write_data 
run -all

wave zoom full