`include "alucodes.sv"

module testbench;

logic clk, reset, ready;
logic [7:0] sw;
logic [7:0] LED;

picomips p1 (.*);

initial
begin
	clk= '0;
	forever #1ns clk = ~clk;
end

initial
begin
	//sw [8] = 1'b0;
	ready = 1'b0;
	reset = 1'b0;
	#50ns reset = 1'b1;
	
	#50ns ready = 1'b0;
	sw [7:0] = 8'b00000100;
	#50ns ready = 1'b1;
	
	#50ns ready = 1'b0;
	sw[7:0] = 8'b00001000;
	#50ns ready = 1'b1;

	// wait 0, calculate and display x2
	#100ns ready = 1'b0;
	
	// wait 1 and display y2
	#100ns ready = 1'b1;
	
	#50ns ready = 1'b0;
	
		#50ns ready = 1'b0;
	sw [7:0] = 8'b00000101;
	#50ns ready = 1'b1;
	
	#50ns ready = 1'b0;
	sw[7:0] = 8'b00001010;
	#50ns ready = 1'b1;

	// wait 0, calculate and display x2
	#100ns ready = 1'b0;
	
	// wait 1 and display y2
	#100ns ready = 1'b1;
	
	#50ns ready = 1'b0;
	
end

endmodule
