`timescale 10ns/10ns
module TopLevel_tb();
	reg [4:0] A, B, regSel, FS;
	reg clock, wrt, reset, RAMwrt, CO, muxSelect;
	reg[63:0] in;
	
	wire [63:0] RAMo, ALUo, aVal, bVal;
	wire [3:0] SIGNAL;
	
	TopLevel dut (A, B, wrt, regSel, in, CO, clock, reset, FS, SIGNAL, RAMwrt, RAMo, ALUo, muxSelect);
	
	assign aVal = dut.regAout;
	assign bVal = dut.regBout;

	//give all inputs initial values
	initial begin
		clock <= 1'b0;
		reset <= 1'b0;
		in <= 64'b0;
		wrt <= 1'b1;
		RAMwrt <= 1'b1;
		A <= 31;
		B <= 0;
		FS <= 0;
		CO <= 0;
		regSel <= 0;
		in <= 7364;
		muxSelect <= 0;
		#1800 reset <= 1'b1; //trigger reset 
		#2000 $stop;        
	end
	
	//simulates clock with a period of 10 ticks
	always
		#5 clock <= ~clock;
		
	always begin
		#500 muxSelect = ~muxSelect;
	end
	
	always begin
		#20;
		in <= {$random, $random}; //$random is a system command that generates a 32-bit random number, we need 64-bits
		regSel = regSel + 1;
		//#5; 									 //delay 5ns
	end
	
	always begin
		#20 FS = FS + 1;
	end
	
	always
		#20 A = A + 1;
	
	always
		#20 B = B + 1;
endmodule
