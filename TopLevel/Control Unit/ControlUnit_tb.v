`timescale 10ns/10ns
module ControlUnit_tb();
	reg c, r;
	reg [31:0] in;
	reg [3:0] stat;
	
	wire [31:0] out;
	wire [63:0] con;
	
	ControlUnit dut (c, r, in, stat, con, out);
	
	initial begin
		c = 0;
		r = 0;
		in = 0;
		stat = 0;
		#20 in = 32'b1001000100_000001100100_11111_00100; // ADDI X4, XZR, 100
		#20 in = 32'b1001000100_000000001000_01000_01000; // ADDI X8, X8, 8
		#20 in = 32'b1001000100_000000001000_01001_01001; // ADDI X9, X9, 8
	end
	
	always
		#5 c = ~c;
endmodule
