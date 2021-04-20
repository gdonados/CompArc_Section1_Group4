`timescale 10ns/10ns
module TopLevel_tb();
	reg clock, reset;
	
	wire [63:0] RAMout, ALUout, aVal, bVal, PC_OUT, K;
	wire [31:0] instruction, CW;
	wire [3:0] STATUS;
	
	TopLevel dut (clock, reset);
	
	assign aVal = dut.regAout;
	assign bVal = dut.regBout;
	assign instruction = dut.romOut;
	assign CW = dut.controlWord;
	assign ALUout = dut.ALUout;
	assign RAMout = dut.ramOut;
	assign STATUS = dut.signalBits;
	assign PC_OUT = dut.programCounterOut;
	assign K = dut.constantVal;

	//give all inputs initial values
	initial begin
		clock <= 1'b0;
		reset <= 1'b0;
		#1800 reset <= 1'b1; //trigger reset 
		#2000 $stop;        
	end
	
	//simulates clock with a period of 10 ticks
	always
		#5 clock <= ~clock;
endmodule
