`include "alucodes.sv"
//------------------------------------------------
module alu_tb;

parameter n = 8; // data bus width

logic [n-1:0] in1, in2; // ALU input operands   
logic [2:0] alu_func; // ALU func code
logic [3:0] flags; // ALU flags N,Z,C,V
logic [n-1:0] out; // ALU result

// create alu object
alu #(.n(n)) alu1 (.*);
//------------------------------------------------
initial    
begin // for 30ns
	in1 = 8'h43;
	in2 = 8'h30; 
	alu_func = `RADD;   // result = a + b
	#10ns alu_func = `RSUB;   // result = a - b
	#10ns alu_func = `RMUL;   // result = a * b
	
	#40ns in1 = 8'h23;
	in2 = 8'h42;
	alu_func = `RADD;   // result = a + b
	#10ns alu_func = `RSUB;   // result = a - b
	#10ns alu_func = `RMUL;   // result = a * b
end
endmodule