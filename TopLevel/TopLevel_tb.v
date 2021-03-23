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
		reset <= 1'b1;
		in <= 64'b0;
		wrt <= 1'b1;
		RAMwrt <= 1'b1;
		A <= 0;
		B <= 0;
		FS <= 0;
		CO <= 0;
		regSel <= 0;
		in <= 7364;
		muxSelect <= 0;
		#5 reset <= 1'b0;  //delay 5 ticks then turn reset off
		#3200 $stop;        
	end
	
	//simulates clock with a period of 10 ticks
	always
		#5 clock <= ~clock;
		
	always begin
		#500 muxSelect = ~muxSelect;
	end
	
	always begin
		#5 in <= {$random, $random}; //$random is a system command that generates a 32-bit random number, we need 64-bits
		regSel = regSel + 1;
		#5; 									 //delay 5ns
	end
	
	always begin
		#25 FS = FS + 1;
	end
	
	always
		#10 A = A + 1;
	
	always
		#30 B = B + 1;
endmodule
