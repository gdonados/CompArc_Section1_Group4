module ControlUnit(clk, rst, instruction, status, constant, controlWord);
	input [31:0] instruction;
	input [3:0] status;
	input clk, rst;
	
	output reg [30:0] controlWord; //[30:0] in instructions, do we change?
											/*[30:29] PS
												[28:24] DA
												[23:19] SA
												[18:14] SB
												[13:9] FS
												[8] regW
												[7] ramW
												[6] EN_MEM
												[5] EN_ALU
												[4] EN_B
												[3] EN_PC
												[2] selB/constant
												[1] PCsel
												[0] SL
												*/
											
	output reg [63:0] constant;
	
	always @(posedge clk)begin
		if(rst == 1)begin
			controlWord = 31'b0;
			constant = 64'b0;
		end
		
		case(instruction)
			32'b1001000100_000001100100_11111_00100:	begin //ADDI X4, XZR, 100
				controlWord[30:29] = 2'b01;		//PS
				controlWord[28:24] = 5'b00100;	//DA
				controlWord[23:19] = 5'b11111;	//SA
				controlWord[18:14] = 5'b00000;	//SB
				controlWord[13:9] = 5'b00010;		//FS
				controlWord[8] = 1'b1;				//regW
				controlWord[7] = 1'b0;				//ramW
				controlWord[6] = 1'b0;				//EN_MEM
				controlWord[5] = 1'b1;				//EN_ALU
				controlWord[4] = 1'b0;				//EN_B
				controlWord[3] = 1'b0;				//EN_PC
				controlWord[2] = 1'b1;				//selB
				controlWord[1] = 1'b0;				//PCsel
				controlWord[0] = 1'b1;				//SL
				constant = 5'b11111;					//constant
			end
			
		endcase
			
	end
endmodule
