`timescale 10ns/10ns
module TopLevel(readA, readB, write, writeReg, data, ALUcarry, clk, rst, functionsel, signalBits, RAMwrite, RAMout, ALUout, muxSelect);
	input [4:0] readA, readB, writeReg, functionsel; //selA, selB, selI
	input clk, write, rst, RAMwrite, ALUcarry, muxSelect;
	input [63:0] data; //data being put in
	output [63:0] RAMout,ALUout; //outputs
	output [3:0] signalBits;
	
	wire[63:0] regAout, regBout, muxOut, ramwire, aluwire;
	
	assign RAMout = ramwire;
	assign ALUout = aluwire;
	
	RegisterFile32x64bit regFile (regAout, regBout, data, readA, readB, regSel, write, rst, clk);
	
	/*always @(*) begin
		case(muxSelect) begin
			0:	begin
				muxOut <= regAout;
			end
			1:	begin
				muxout <= 
			end
		endcase
	end*/
	
	ALU alu (regAout, regBout, functionsel, ALUcarry, aluwire, signalBits);
	
	RAM256x64 ram (ALUout, clk, regBout, RAMwrite, ramwire);
	
	
endmodule
