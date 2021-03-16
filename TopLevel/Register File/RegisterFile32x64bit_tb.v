`timescale 10ns/10ns

module RegisterFile32x64bit_tb();
	//create registers for holding the simulated input values to the DUT
	reg [4:0] SA, SB, SI;   //use reg as the inputs for the register file
	reg [63:0]data;		   
	reg load, reset, clock;
	//create wires for the output of the DUT
	wire [63:0]A, B;
	
	RegisterFile32x64bit dut (A, B, data, SA, SB, SI, load, reset, clock); //instantiation of RegisterFile32x64bit
	
	//give all inputs initial values
	initial begin
		clock <= 1'b1;
		reset <= 1'b1;
		data <= 64'b0;
		load <= 1'b1;
		SI <= 5'd31;       //select Input, writes to register 0 first (since data is incremented before click)
		SA <= 5'd30;		 //read from register 31 first on A bus
		SB <= 5'd29;		 //read from register 30 first on B bus
		#5 reset <= 1'b0;  //delay 5 ticks then turn reset off
		#320 load <= 1'b0; //delay 320 ticks then turn write off
		#320 $stop;        //delay another 320 ticks then stop the simulation. Prevents crash!
	end
	
	//simulates clock with a period of 10 ticks
	always
		#5 clock <= ~clock;
		
	//every 10 ticks generate random data and increment SI, SA, and SB
	always begin
		#5 data <= {$random, $random}; //$random is a system command that generates a 32-bit random number, we need 64-bits
		SI <= SI + 5'b1;
		SA <= SA + 5'b1;
		SB <= SB + 5'b1;
		#5; 									 //delay 5ns
	end
	
	//wires act as output for registers, assign wire to each register. 
	wire [63:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16;
	wire [63:0] r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
	
	assign r0 = dut.registers[0]; //"dut." comes from the register file instantiation: "RegisterFile32x64bit dut (A, B, data, SA, SB, SI, load, reset, clock);"
	assign r1 = dut.registers[1];
	assign r2 = dut.registers[2];
	assign r3 = dut.registers[3];
	assign r4 = dut.registers[4];
	assign r5 = dut.registers[5];
	assign r6 = dut.registers[6];
	assign r7 = dut.registers[7];
	assign r8 = dut.registers[8];
	assign r9 = dut.registers[9];
	assign r10 = dut.registers[10];
	assign r11 = dut.registers[11];
	assign r12 = dut.registers[12];
	assign r13 = dut.registers[13];
	assign r14 = dut.registers[14];
	assign r15 = dut.registers[15];
	assign r16 = dut.registers[16];
	assign r17 = dut.registers[17];
	assign r18 = dut.registers[18];
	assign r19 = dut.registers[19];
	assign r20 = dut.registers[20];
	assign r21 = dut.registers[21];
	assign r22 = dut.registers[22];
	assign r23 = dut.registers[23];
	assign r24 = dut.registers[24];
	assign r25 = dut.registers[25];
	assign r26 = dut.registers[26];
	assign r27 = dut.registers[27];
	assign r28 = dut.registers[28];
	assign r29 = dut.registers[29];
	assign r30 = dut.registers[30];
	assign r31 = dut.registers[31];
endmodule
