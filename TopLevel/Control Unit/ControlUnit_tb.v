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
		#20 in = 32'b10001011000_00010_000000_10010_00110; //ADD X2, X18, X6 
		#20 in = 32'b11001011000_00101_000000_00110_00001; //SUB X5, X6, X1 
	end
	
	always
		#5 c = ~c;
endmodule
