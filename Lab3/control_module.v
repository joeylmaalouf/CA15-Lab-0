module control_module(
	input[5:0] op,
	input[5:0] func,
	output reg reg_dest,
	output reg alu_src,
	output reg mem_write_enable, 
	output reg mem_to_reg, 
	output reg pc_src,
	output reg write_enable,
	output reg mem_read_enable,
	output reg[2:0] alu_op,
	output reg jump_enable,
	output reg bne_pc_override,
	output reg jal_reg_override
);

	always @(op or func) begin
		reg_dest = 0;
		alu_src = 0;
		mem_write_enable = 0;
		mem_read_enable = 0;
		mem_to_reg = 0;
		pc_src = 0;
		write_enable = 0;
		alu_op = 3'b0;
		jump_enable = 0;
		bne_pc_override = 0;
		jal_reg_override = 0;

		if (op == 6'b0) begin
			reg_dest = 1;
			write_enable = 1;
			if (func == 6'b010000) begin //add
				alu_op = 3'b010;
			end
			else if (func == 6'b100010) begin //sub
				alu_op = 3'b110;
			end
			else if (func == 6'b101010) begin //slt
				alu_op = 3'b111;
			end
			else if (func == 6'b001000) begin //jr
				pc_src = 1;
			end
		end
		else if (op == 6'b100011) begin //LW
			alu_src = 1;
			mem_to_reg = 1;
			write_enable = 1;
			mem_read_enable = 1;
			alu_op = 3'b010;
		end
		else if (op == 6'b101011) begin //SW
			alu_src = 1;
			mem_write_enable = 1;
			alu_op = 3'b010;
		end
		else if (op == 6'b000011) begin //jal
			jump_enable = 1;
			write_enable = 1;
			jal_reg_override = 1;
		end
		else if (op == 6'b000010) begin //j
			jump_enable = 1;
		end
		else if (op == 6'b000101) begin //bne
			alu_op = 3'b110;
			bne_pc_override = 1;
		end
		else if (op == 6'b001110) begin //xori
			alu_src = 1;
			write_enable = 1;
		end
	end
endmodule
