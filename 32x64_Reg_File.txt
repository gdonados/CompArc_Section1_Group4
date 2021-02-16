`timescale 1ns / 1ns

module regfile32x64a (input1, sel_i1, op1, sel_op1, op2, sel_op2, RD, WR, rst, clk);
	
	input [63:0] input1;
	input [4:0] sel_i1, sel_op1, sel_op2;
	input RD, WR, rst, clk;
	
	output [63:0] op1, op2;
	
	reg[63:0] regFile [0:31];
	
	always @ (posedge clk)
	begin
		if(rst == 1)
		begin
			for(integer i = 0; i < 64, i = i + 1)
			begin
				regFile[i] = 64`h0;
			end
		end
		
		else if(rst == 0)
		begin
			