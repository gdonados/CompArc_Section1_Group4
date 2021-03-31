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
		
		//hard values based off lab sheet, idk if actual opcodes exist for the rest of the instructions somewhere
		case(instruction/*[31:21]*/)
			32'b1001000100_000001100100_11111_00100 : begin
				controlWord <= 32'b010010011111xxxxx000101001001010;
				constant <= instruction[21:10];			//Constant, should be 100 in this case
			end
			
			/*11'b1001000100x :	begin //addi, 3 in rom
				controlWord[31:30] <= 01;
				controlWord[29:25] <= instruction[4:0]; //should be reg 4 in this case
				controlWord[24:20] <= instruction[9:5]; //whatever xzr is
				controlWord[19:15] <= 5'bxxxxx;			//constant is set 
				controlWord[14:10] <= 5'b00010;			//FS for adding
				controlWord[9] <= 1'b1;						//regW is true
				controlWord[8] <= 1'b0;						//ramW is false
				controlWord[7] <= 1'b0;						//EN_MEM false
				controlWord[6] <= 1'b1;						//EN_ALU true
				controlWord[5] <= 1'b0;						//Dont use regB
				controlWord[4] <= 1'b0;						//we dont want PC in the reg file
				controlWord[3] <= 1'b1;						//We want the constant
				controlWord[2] <= 1'b0;						//idk we'll use A
				controlWord[1] <= 1'b1;						//use status lines
				controlWord[0] <= 1'b0;						//No carry
				constant <= instruction[21:10];			//Constant, should be 100 in this case
																	//expected control word: 010010011111xxxxx000101001001010
			end
			
			11'b110100101xx :	begin	//MOVZ, 2 in rom
			
			end
			
			11'b10110100xxx :	begin //CBZ
			
			end
			
			11'b1101000100x : begin //subI, different code from addi
			
			end
			
			11'b11111000010 : begin //LDUR
			
			end
			
			11'b11111000000 :	begin //STUR
			
			end
			
			11'b000101xxxxx : begin //b -7?
			
			end*/
			
		endcase
			
	end
endmodule
