`include "alucodes.sv"

module picomips (input logic clk, reset, ready,
				input logic [7:0] sw,
				output logic [7:0] LED);

//Declaring variables

parameter n = 8;
parameter p = 6;
logic pc_incr, pc_rel, pc_abs;
logic [p-1:0] pcout, branch_addr;

parameter I = 24;
logic [I-1:0] instruction;

logic w;
logic [n-1:0] wdata, rdata1, rdata2;

logic [n-1:0]b;
logic [2:0] alu_func;
logic [3:0] flags;

logic imm, store, disp;

pc #(.p(p)) prog_counter(.clk(clk), .reset(reset),
			.pc_incr(pc_incr), .pc_rel(pc_rel), .pc_abs(pc_abs),
			.branch_addr(instruction[p-1:0]), .pcout(pcout));
			
progmemory #(.p(p), .i(I)) prog_memory(.address(pcout), .instruction(instruction));

register #(.N(n)) gpr1(.clk(clk), .we(w), .wdata(wdata), .raddr1(instruction[I-7:I-11]), .raddr2(instruction[I-12:I-16]),
					.rdata1(rdata1), .rdata2(rdata2), .reset(reset));

alu #(.n(n)) alu1(.in1(rdata1), .in2(b), .alu_func(alu_func), .flags(flags), .out(wdata));

decoder d1 (.opcode(instruction[I-1:I-6]), .flags(flags), .ready(ready), .branch_cond(instruction[n-1]), .pc_incr(pc_incr),
			.pc_rel(pc_rel), .pc_abs(pc_abs), .alu_func(alu_func), .w(w), .imm(imm), .store(store), .disp(disp));
			
assign b = (imm ? (store ? sw[7:0] : instruction[7:0]) : rdata2);

always_ff@(posedge clk, negedge reset)
begin
	if(~reset)
		LED <= 8'b0;
	else if(disp)
		LED <= wdata;
end

endmodule