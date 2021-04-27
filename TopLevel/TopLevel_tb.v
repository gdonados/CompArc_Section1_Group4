`timescale 10ns/10ns
module TopLevel_tb();
	reg clock, reset;
	
	wire [63:0] dataInput, RAMout, ALUout, aVal, bVal, PC_OUT, K, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, 
						r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
	wire [31:0] instruction, CW;
	wire [3:0] STATUS;
	wire aluData, regData, ramData, PCData;
	
	TopLevel dut (clock, reset);
	
	assign aVal = dut.regAout;
	assign bVal = dut.regBout;
	assign instruction = dut.romOut;
	assign CW = dut.controlWord;
	assign ALUout = dut.ALUout;
	assign RAMout = dut.ramOut;
	assign STATUS = dut.signalBits;
	assign PC_OUT = dut.programCounterOut;
	assign K = dut.constantValue;
	assign dataInput = dut.regFileDataInput;
	
	assign aluData = dut.enableAluData;
	assign regData = dut.enableRegAData;
	assign ramData = dut.enableRamData;
	assign PCData = dut.enablePcData;

	//give all inputs initial values
	initial begin
		clock <= 1'b0;
		reset <= 1'b0;
		
		//#800 reset <= 1'b1; //trigger reset 
	   #50 $stop;
	end
	
	//simulates clock with a period of 10 ticks
	always
		#5 clock <= ~clock;
		
	assign r0 = dut.regFile.registers[0]; //"dut." comes from the register file instantiation: "RegisterFile32x64bit dut (A, B, data, SA, SB, SI, load, reset, clock);"
	assign r1 = dut.regFile.registers[1];
	assign r2 = dut.regFile.registers[2];
	assign r3 = dut.regFile.registers[3];
	assign r4 = dut.regFile.registers[4];
	assign r5 = dut.regFile.registers[5];
	assign r6 = dut.regFile.registers[6];
	assign r7 = dut.regFile.registers[7];
	assign r8 = dut.regFile.registers[8];
	assign r9 = dut.regFile.registers[9];
	assign r10 = dut.regFile.registers[10];
	assign r11 = dut.regFile.registers[11];
	assign r12 = dut.regFile.registers[12];
	assign r13 = dut.regFile.registers[13];
	assign r14 = dut.regFile.registers[14];
	assign r15 = dut.regFile.registers[15];
	assign r16 = dut.regFile.registers[16];
	assign r17 = dut.regFile.registers[17];
	assign r18 = dut.regFile.registers[18];
	assign r19 = dut.regFile.registers[19];
	assign r20 = dut.regFile.registers[20];
	assign r21 = dut.regFile.registers[21];
	assign r22 = dut.regFile.registers[22];
	assign r23 = dut.regFile.registers[23];
	assign r24 = dut.regFile.registers[24];
	assign r25 = dut.regFile.registers[25];
	assign r26 = dut.regFile.registers[26];
	assign r27 = dut.regFile.registers[27];
	assign r28 = dut.regFile.registers[28];
	assign r29 = dut.regFile.registers[29];
	assign r30 = dut.regFile.registers[30];
	assign r31 = dut.regFile.registers[31];
	
endmodule
