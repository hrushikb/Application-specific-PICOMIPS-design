`include "opcodes.sv"
`include "alucodes.sv"

//------------------------------------------------
module decoder_tb;

logic [5:0] opcode; // top 6 bits of instruction
logic [3:0] flags; // ALU flags V,N,Z,C
logic ready, branch_cond; // // Branch status, connected to specified switch
// PC control, imm MUX control, register file control & Branch condition
logic pc_incr, pc_abs, pc_rel;
logic [2:0] ALUfunc; // ALU function
logic imm;
logic w;
logic store, disp;

// create dec object
decoder dec (
        .opcode(opcode),
        .flags(flags),
		.ready(ready),  // Branch status
        .branch_cond(branch_cond), // Branch condition
        .pc_incr(pc_incr),
        .pc_abs(pc_abs),
        .pc_rel(pc_rel),
        .alu_func(ALUfunc),
        .imm(imm),
		.w(w),
        .store(store),
		.disp(disp));
//------------------------------------------------
initial 
	begin // for 100ns
    branch_cond = 1'b0; ready = 1'b1; // if Bstus == Bcond, hold status.
    flags = 4'b0;

		opcode = `NOP;  //opcode: NOP  -> 6'b111111
    #10ns opcode = `ADD;  //opcode: ADD  -> 6'b000000
		#10ns opcode = `ADDI; //opcode: ADDI -> 6'b000001
    #10ns opcode = `ADDS; //opcode: ADDF -> 6'b000110
    #10ns opcode = `SUB;  //opcode: SUB  -> 6'b000010
    #10ns opcode = `SUBI; //opcode: SUBI -> 6'b000011
    #10ns opcode = `MUL;  //opcode: MUL  -> 6'b000100
		#10ns opcode = `MULI; //opcode: MULI -> 6'b000101
		#10ns opcode = `BREL;
			#10ns opcode = `BABS;//opcode: BAT  -> 6'b000111
    #10ns ready = 1'b0; opcode = `BREL;
	#10ns opcode = `SHOW;
	end 

endmodule // end of module decoder_tb