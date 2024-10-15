module pc #(parameter p = 6)
			(input logic clk, reset, pc_incr, pc_rel, pc_abs,
			input logic [p-1:0] branch_addr,
			output logic [p-1:0] pcout);
			
logic [p-1:0] r_branch;
logic [p-1:0] pcout_next;
always_comb
begin
	pcout_next = '0;
	r_branch = '0;
	if(pc_incr)
		r_branch = {{(p-1){1'b0}}, 1'b1};
	else
		r_branch = branch_addr;
	if(pc_incr | pc_rel)
		pcout_next = pcout + r_branch;
	else if(pc_abs)
		pcout_next = branch_addr;
end

always_ff @(posedge clk, negedge reset)
begin
	if(~reset)
		pcout <= {(p){1'b0}};
	else 
		pcout <= pcout_next;
end

endmodule