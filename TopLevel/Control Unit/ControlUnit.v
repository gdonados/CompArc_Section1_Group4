`timescale 10ns/10ns
module ControlUnit(clk, rst, instruction, status, constant, controlWord, length, flag);
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
	output reg [2:0] length; //000 for 1 byte, 001 for 16-bits, 010 for 32-bits, 100 for-64 bits
	output reg flag;
	
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
			11'b10001011000 :	begin //add	
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5], instruction[20:16], 5'b00010, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
				flag <= 0;
				length <= 3'b010;
			end
			
			11'b11001011000 :	begin	//sub
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5], instruction[20:16], 5'b00110, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
				flag <= 0;
				length <= 3'b010;
			end
			
			11'b1001000100? :	begin //addi, 3 in current rom
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5],     5'bxxxxx,       5'b00010, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[21:10];	//constant generation		
				flag <= 0;		
				length <= 3'b010;				
			end
			
			11'b1101000100? : begin //subI
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5],     5'bxxxxx,       5'b00110, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[21:10];	//constant generation		
				flag <= 0;
				length <= 3'b010;
			end
			
			11'b10101011000 :	begin //ADDS, add with flag set
						
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5], instruction[20:16], 5'b00010, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
				flag <= 1;
				length <= 3'b010;
			end
			
			11'b11101011000 :	begin	//SUBS, sub with flag
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5], instruction[20:16], 5'b00110, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
				flag <= 1;
				length <= 3'b010;
			end
			
			11'b1011000100? :	begin //ADDIS
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5],     5'bxxxxx,       5'b00010, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[21:10];	//constant generation	
				flag <= 1;	
				length <= 3'b010;
			end
			
			11'b1111000100? :	begin //SUBIS
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5],     5'bxxxxx,       5'b00110, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0,  1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[21:10];	//constant generation		
				flag <= 1;
				length <= 3'b010;
			end
			
			/////////////////////////////
			////////Data Transfer////////
			/////////////////////////////
			
			11'b11111000000 :	begin //STUR, store register 64-Bit
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b00, instruction[4:0], instruction[9:5],     5'bxxxxx      , 5'b00010, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0,  1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[20:12]; //9 bit constant
				length <= 3'b100;
				flag <= 0;
			end
			
			11'b11111000010 :	begin //LDUR, load register 64-Bit
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b00, instruction[4:0], instruction[9:5],     5'bxxxxx      , 5'b00010, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0,  1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[20:12]; //9 bit constant
				length <= 3'b100;
				flag <= 0;
			end
			
			11'b10111000000 :	begin	//STUR, 32-Bit
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5],     5'bxxxxx      , 5'b00010, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0,  1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[20:12]; //9 bit constant
				length <= 3'b010;
				flag <= 0;
			end
			
			11'b10111000010 :	begin	//LDUR 32-Bit
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5],     5'bxxxxx      , 5'b00010, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0,  1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[20:12]; //9 bit constant
				length <= 3'b010;
				flag <= 0;
			end
			
			11'b01111000000 : begin //STURH, store half word, 16-Bit
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5],     5'bxxxxx      , 5'b00010, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0,  1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[20:12]; //9 bit constant
				length <= 3'b001;
				flag <= 0;
			end
			
			11'b01111000010 : begin	//LDURH, load half word, 16-Bit
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5],     5'bxxxxx      , 5'b00010, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0,  1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[20:12]; //9 bit constant
				length <= 3'b001;
				flag <= 0;
			end
			
			11'b00111000000 : begin	//STURB, store byte
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5],     5'bxxxxx      , 5'b00010, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0,  1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[20:12]; //9 bit constant
				length <= 3'b000;
				flag <= 0;
			end
			
			11'b00111000010 : begin	//LDURB
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5],     5'bxxxxx      , 5'b00010, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0,  1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[20:12]; //9 bit constant
				length <= 3'b000;
				flag <= 0;
			end
			
			11'b110100101?? :	begin	//MOVZ, move wide with zero
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0],      5'bxxxxx,        5'bxxxxx      , 5'b00010, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0,  1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[20:5]; //16 bit constant
				flag <= 0;
				length <= 3'b010;
			end
			
			11'b111100101?? : begin	//MOVK, move wide with keep
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0],      5'bxxxxx,        5'bxxxxx      , 5'b00010, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0,  1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[20:5]; //16 bit constant
				flag <= 0;
				length <= 3'b010;
			end
			
			////////////////////////////
			/////Logic Instructions/////
			////////////////////////////
		
			11'b10001010000 : begin	//AND
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5], instruction[20:16], 5'b01100, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
				flag <= 0;
				length <= 3'b010;
			end
			
			11'b10101010000 : begin //ORR, Inclusive Or
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5], instruction[20:16], 5'b01101, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
				flag <= 0;
				length <= 3'b010;
			end
			
			11'b11001010000 : begin	//EOR, exclusive Or
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5], instruction[20:16], 5'b01110, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
				flag <= 0;
				length <= 3'b010;
			end
			
			11'b1001001000? : begin //ANDI, and immediate
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5],     5'bxxxxx      , 5'b01100, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[21:10];	//constant generation 
				flag <= 0;
				length <= 3'b010;
			end
			
			11'b1011001000? : begin //ORRI, or immediate
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5],     5'bxxxxx      , 5'b01101, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[21:10];	//constant generation 
				flag <= 0;
				length <= 3'b010;
			end
			
			11'b1101001000? : begin	//EORI
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5],     5'bxxxxx      , 5'b01110, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[21:10];	//constant generation 
				flag <= 0;
				length <= 3'b010;
			end
			
			11'b11101010000 : begin //ANDS, and set flag
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5], instruction[20:16], 5'b01100, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
				flag <= 1;
				length <= 3'b010;
			end
			
			11'b1111001000? : begin	//ANDIS, and immediate and set flag
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5],     5'bxxxxx      , 5'b01100, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0};
				constant <= instruction[21:10];	//constant generation 
				flag <= 1;
				length <= 3'b010;
			end
			
			11'b11010011010 : begin //LSR
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5], instruction[20:16], 5'b10000, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
				flag <= 0;
				length <= 3'b010;
			end
			
			11'b11010011011 : begin //LSL
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5], instruction[20:16], 5'b01111, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
				flag <= 0;
				length <= 3'b010;
			end
			
			////////////////////////////
			/////Conditional Branch/////
			////////////////////////////
			
			11'b10110100??? : begin	//CBZ, compare and branch = 0
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 			 		  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0],      5'b00000,        5'b00000      , 5'b01100, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0};
				flag <= 0;
				length <= 3'b010;
				constant <= instruction[24:5]*4;
			end
			
			11'b10110101??? : begin //CBNZ, compare and branch ~= 0
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 			 		  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0],      5'b00000,        5'b00000      , 5'b01100, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0};
				flag <= 0;
				length <= 3'b010;
				constant <= instruction[24:5]*4;
			end
			
			11'b01010100??? : begin //B.cond, branch conditionally
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 			 		  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0],      5'b00000,        5'b00000      , 5'b01100, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0};
				flag <= 0;
				length <= 3'b010;
				constant <= instruction[24:5]*4;
			end
			
			////////////////////////////
			/////Unconditional Jump/////
			////////////////////////////
			11'b000101????? : begin	//B, branch
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 			 		  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01,      5'b00000,         5'b00000,        5'b00000      , 5'b01100, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0};
				flag <= 0;
				length <= 3'b010;
				constant <= instruction[25:0]*4;
			end
			
			11'b11010110000 : begin	//BR, branch to register
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01, instruction[4:0], instruction[9:5], instruction[20:16], 5'b01001, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
				flag <= 0;
				length <= 3'b010;
			end
			
			11'b100101????? : begin //BL, branch with link
				//						PC				DataReg				RegA					RegB				  FS		RegW ramW  ENMEM ENALU  ENB  EN_PC  selB  PCsel SL 	CO  
				//						|				  |					  |					 |  				  |		 |		|		 |		 |		 |     |		  |     |    |		 |
				//						|				  |					  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				//						|				  | 			 		  |					 |					  |		 |		|		 |     |		 |     |		  |     |    |     |
				controlWord <= {2'b01,      5'b00000,         5'b00000,        5'b00000      , 5'b01100, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0};
				flag <= 0;
				length <= 3'b010;
				constant <= instruction[25:0]*4;
			end
		endcase
			
	end
endmodule
