`timescale 10ns/10ns
module ControlUnit_tb();
	reg c, r;
	reg [31:0] in;
	reg [3:0] stat;
	
	wire [31:0] out;
	wire [63:0] con;
	
	wire [2:0] len;
	wire flg;
	
	ControlUnit dut (c, r, in, stat, con, out, len, flg);
	
	initial begin
		c = 0;
		r = 0;
		in = 0;
		stat = 0;
		#5 in = 32'b1001000100_000001100100_11111_00100; // ADDI X4, XZR, 100
		#10 in = 32'b10001011000_00010_000000_10010_00110; //ADD X2, X18, X6 
		#10 in = 32'b11001011000_00101_000000_00110_00001; //SUB X5, X6, X1 
		#10 in = 32'b110100101_00_0000000110010000_01000; //MOVZ X8, 400
		#10 in = 32'b110100101_00_0000010010110000_01001; //MOVZ X9, 1200
		#10 in = 32'b10110100_0000000000000000110_00100; //CBZ X4, 6
		#10 in = 32'b1101000100_000000000001_00100_00100; //SUBI X4, X4, 1
		#10 in = 32'b11111000010_000000000_00_01000_01010; //LDUR X10, [X8, 0]
		#10 in = 32'b1001000100_000000001000_01000_01000;	//ADDI X8, X8, 8
		#10 in = 32'b11111000000_000000000_00_01001_01010;	//STUR X10, [X9, 0]
		#10 in = 32'b1001000100_000000001000_01001_01001; 	//ADDI X9, X9, 8
		#120 $stop;
	end
	
	always
		#5 c = ~c;
endmodule
