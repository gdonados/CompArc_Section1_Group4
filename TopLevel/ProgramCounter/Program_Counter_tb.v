`timescale 10ns/10ns
module Program_Counter_tb();
	reg clk, rst;
	reg [1:0] PS;
	reg [63:0] PC_IN;
	
	wire [63:0] PC_OUT;
	
	Program_Counter dut (clk, rst, PS, PC_IN, PC_OUT);
	
	
	initial begin
		clk <= 1'b1;
		rst <= 1'b0;
		PS <= 2'b00;
		PC_IN <= 64'b0;
		
		#10 PS <= 2'b01; //increment by 1 instruction
	
		#10
		PS <= 2'b10;
		PC_IN <= 16; //jump to instruction 4
	
		#10
		PS <= 2'b10;
		PC_IN <= 4; //jump back to instruction 1
	
		#10
		PS <= 2'b11;
		PC_IN <= 32; //jump forward 8 instructions
		
		#10 rst <= 1'b1;
	
		#20 $stop;
	end
	
	always
	#5 clk <= ~clk;
	
endmodule
	