`timescale 10ns/10ns
module ControlUnit(clk, rst, instruction, status, constant, controlWord);
	input [31:0] instruction;
	input [3:0] status;
	input clk, rst;
	
	output reg [31:0] controlWord; //[31:0] in instructions, added 1 for carry
											/*[31:30] PS
												[29:25] DA
												[24:20] SA
												[19:15] SB
												[14:10] FS
												[9] regW
												[8] ramW
												[7] EN_MEM
												[6] EN_ALU
												[5] EN_B
												[4] EN_PC
												[3] selB/constant
												[2] PCsel
												[1] SL
												[0] carry
												*/
											
	output reg [63:0] constant;
	
	always @(posedge clk)begin
		if(rst == 1)begin
			controlWord <= 32'b0;
			constant <= 64'b0;
		end
		
		//Goes through each opcode and assigns control word accordingly
		casex(instruction[31:21])
			/////////////////////////////
			///Arithmetic Instructions///
			/////////////////////////////
			11'b10001011000 :	begin //add, i think [15:10] are shamt bits
				controlWord <= {2'b01, instruction[4:0], instruction[9:5], instruction[20:16], 5'b00010, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 
										1'b1, 1'b0};
				//FS for adding
				//regW is true
				//ramW is false
				//EN_MEM false
				//EN_ALU true
				//Use regB
				//we dont want PC in the reg file
				//We want the constant
				//idk we'll use A
				//use status lines
				//No carry
			end
			
			11'b11001011000 :	begin	//sub
				controlWord <= {2'b01, instruction[4:0], instruction[9:5], instruction[20:16], 5'b00110, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 
										1'b1, 1'b0};
				//FS for subbing
				//regW is true
				//ramW is false
				//EN_MEM false
				//EN_ALU true
				//Use regB
				//we dont want PC in the reg file
				//We want the constant
				//idk we'll use A
				//use status lines
				//No carry
			end
			
			11'b1001000100? :	begin //addi, 3 in current rom
				controlWord <= {2'b01, instruction[4:0], instruction[9:5], 5'bxxxxx, 5'b00010, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 
										1'b1, 1'b0};

				//should be reg 4 in this case
				//whatever xzr is
				//constant is set 
				//FS for adding
				//regW is true
				//ramW is false
				//EN_MEM false
				//EN_ALU true
				//Dont use regB
				//we dont want PC in the reg file
				//We want the constant
				//idk we'll use A
				//use status lines
				//No carry
				constant <= instruction[21:10];			//Constant, should be 100 in this case
																	//expected control word: 010010011111xxxxx000101001001010
			end
			
			11'b1101000100x : begin //subI, different code from addi
			
			end
			
			11'b10101011000 :	begin //ADDS, add with flag set
			
			end
			
			11'b11101011000 :	begin	//SUBS, sub with flag
			
			end
			
			11'b1011000100? :	begin //ADDIS
			
			end
			
			11'b1111000100? :	begin //SUBIS
			
			end
			
			/////////////////////////////
			////////Data Transfer////////
			/////////////////////////////
			
			11'b11111000000 :	begin //STUR, store register 64-Bit
			
			end
			
			11'b11111000010 :	begin //LDUR, load register 64-Bit
			
			end
			
			11'b10111000000 :	begin	//STUR, 32-Bit
			
			end
			
			11'b10111000010 :	begin	//LDUR 32-Bit
			
			end
			
			11'b01111000000 : begin //STURH, store half word, 16-Bit
			
			end
			
			11'b01111000010 : begin	//LDURH, load half word, 16-Bit
			
			end
			
			11'b00111000000 : begin	//STURB, store byte
			
			end
			
			11'b00111000010 : begin	//LDURB
			
			end
			
			11'b110100101?? :	begin	//MOVZ, 2 in rom, move wide with zero
			
			end
			
			11'b111100101?? : begin	//MOVK, move wide with keep
			
			end
			
			11'b10110100??? :	begin //CBZ
			
			end
			
			////////////////////////////
			/////Logic Instructions/////
			////////////////////////////
		
			11'b10001010000 : begin	//AND
			
			end
			
			11'b10101010000 : begin //ORR, Inclusive Or
			
			end
			
			11'b11001010000 : begin	//EOR, exclusive Or
			
			end
			
			11'b1001001000? : begin //ANDI, and immediate
			
			end
			
			11'b1011001000? : begin //ORRI, or immediate
			
			end
			
			11'b1101001000? : begin	//EORI
			
			end
			
			11'b11101010000 : begin //ANDS, and set flag
			
			end
			
			11'b1111001000? : begin	//ANDIS, and immediate and set flag
			
			end
			
			11'b11010011010 : begin //LSR
			
			end
			
			11'b11010011011 : begin //LSL
			
			end
			
			////////////////////////////
			/////Conditional Branch/////
			////////////////////////////
			
			11'b10110100??? : begin	//CBZ, compare and branch = 0
			
			end
			
			11'b10110101??? : begin //CBNZ, compare and branch ~= 0
			
			end
			
			11'b01010100??? : begin //B.cond, branch conditionally
			
			end
			
			////////////////////////////
			/////Unconditional Jump/////
			////////////////////////////
			11'b000101????? : begin	//B, branch
			
			end
			
			11'b11010110000 : begin	//BR, branch to register
			
			end
			
			11'b100101????? : begin //BL, branch with link
			
			end
		endcase
			
	end
endmodule
