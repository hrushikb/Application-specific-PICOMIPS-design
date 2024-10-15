`include "opcodes.sv"
`include "alucodes.sv"

module decoder (input logic [5:0] opcode,
				input logic [3:0] flags,
				//Hand shaking functinality assigned to SW8 => ready
				//Branch conditioning logic for pc
				input logic ready, branch_cond,
				//Control of Program Counter
				output logic pc_incr, pc_rel, pc_abs,
				//Control of ALU
				output logic [2:0] alu_func,
				output logic w, imm, store,
				output logic disp);		

logic branching;

always_comb
begin
	pc_abs = 1'b0;
	pc_rel = 1'b0;
	pc_incr = 1'b1;
	w = 1'b0;
	imm = 1'b0;
	store = 1'b0;
	disp = 1'b0;
	alu_func = `RNOP;
	branching = '0;
	
	case(opcode)
		`NOP	:	;
		`ADD	:	begin
					w = 1'b1;
					imm = 1'b0;
					alu_func = `RADD;
				end
		`ADDI:	begin
					w = 1'b1;
					imm = 1'b1;
					store = 1'b0;
					alu_func = `RADD;
				end
		`SUB	:	begin
					w = 1'b1;
					imm = 1'b0;
					alu_func = `RSUB;
				end
		`SUBI:	begin
					w = 1'b1;
					imm = 1'b1;
					store = 1'b0;
					alu_func = `RSUB;
				end
		`MUL	:	begin
					w = 1'b1;
					imm = 1'b0;
					alu_func = `RMUL;
				end
		`MULI:	begin
					w = 1'b1;
					imm = 1'b1;
					store = 1'b0;
					alu_func = `RMUL;
				end
		`SHOW:	begin
					disp = 1'b1;
					imm = 1'b0;
					alu_func = `RADD;
				end
		`ADDS:	begin
					w = 1'b1;
					imm = 1'b1;
					store = 1'b1;
					alu_func = `RADD;
				end
		`BREL:	begin
					if(ready == branch_cond)
						branching = 1'b1;
				end
		`BABS:	begin
					pc_abs = 1'b0;
					pc_incr = 1'b0;
				end
	endcase
	
	if(branching)
	begin
		pc_rel = 1'b1;
		pc_incr = 1'b0;
	end
end

endmodule