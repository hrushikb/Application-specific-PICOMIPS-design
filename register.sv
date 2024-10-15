module register #(parameter N = 8) (input logic clk, we, reset,
									input logic [N-1:0] wdata,
									input logic [4:0] raddr1, raddr2,
									output logic [N-1:0] rdata1, rdata2);

logic [N-1:0] gpr [31:0];
logic [N-1:0] next_gpr [31:0];

always_ff @(posedge clk, negedge reset)
begin
	if(~reset)
		gpr <= '{32{'0}};
	else
		gpr <= next_gpr;
end

always_comb
begin
	next_gpr = gpr;
	if(raddr1 == 5'b0)
		rdata1 = {N{1'b0}};
	else
		rdata1 = gpr[raddr1];
	
	if(raddr2 == 5'b0)
		rdata2 = {N{1'b0}};
	else
		rdata2 = gpr[raddr2];
	if(we)
		next_gpr[raddr2] = wdata;	//destination address is raddr2.
end

endmodule