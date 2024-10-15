module progmemory #(p = 6, i = 24)
					(input logic [p-1:0] address,
					output logic [i-1:0] instruction);

logic [i-1:0] mem [(1<<p) - 1: 0];

initial
$readmemh("prog.hex", mem);

always_comb
begin
	instruction = mem[address];
end

endmodule