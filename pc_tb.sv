module pc_tb;

parameter p = 6;

logic clk;
logic reset;
logic pc_incr, pc_abs, pc_rel;
logic [p-1:0] branch_addr;
//logic [p-1:0] r_branch;
logic [p-1:0] pcout;

// create pc object 
pc #(.p(p)) pc (
	.clk(clk), 
	.reset(reset), 
	.pc_incr(pc_incr), 
	.pc_abs(pc_abs),
    .pc_rel(pc_rel),
	.branch_addr(branch_addr),
	.pcout(pcout));
//------------------------------------------------
initial 
begin 
	clk = 1'b0;
	forever #5ns clk = ~clk;
end

initial 
begin // for 50ns
	reset = 1'b0; 
	pc_incr = 1'b0; pc_abs = 1'b0; pc_rel = 1'b0;
	branch_addr = 5'b00000;

	// test pc increment
	#10ns reset = 1'b1; 
	pc_incr = 1'b1;
	
	// test pc relative branch
	#10ns pc_incr = 1'b0; 
	pc_rel = 1'b1; 
	branch_addr = 5'b00011;

	// test pc absolute branch
	#10ns pc_rel = 1'b0;
	pc_abs = 1'b1; 
	branch_addr = 5'b00010;

	// reset
	#10ns reset = 1'b0; 
end 
endmodule