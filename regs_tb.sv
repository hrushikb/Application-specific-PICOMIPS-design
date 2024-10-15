module regs_tb;

parameter n = 8;

logic clk, we, reset;
logic [n-1:0] wdata;
logic [4:0] raddr1, raddr2;
logic [n-1:0] rdata1, rdata2;

// create regs object
register #(.N(n)) u_reg (.*);
//------------------------------------------------
initial
begin // for 50ns
  clk = 1'b0;
  forever #5ns clk = ~clk;
end

initial
begin
	reset = 1'b0;
	#10ns reset = 1'b1;
  we = 1'b0;
  wdata = 8'b00000111;
  raddr1 = 5'b00001; raddr2 = 5'b00000;

  #10ns raddr1 = 5'b00000; raddr2 = 5'b00010;

  // test write 0 to dest reg (raddr2)
  #10ns we = 1'b1;
  @(posedge clk);
  #10ns we = 1'b1; wdata = 8'b00000110;
  @(posedge clk);
end

endmodule