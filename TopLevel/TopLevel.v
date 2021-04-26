`timescale 10ns/10ns
module TopLevel(clk, rst); //aka datapath
	input clk, rst;
	
	wire [63:0] programCounterIn, programCounterOut, regAout, regBout, muxOut, ramwire, constantValue, regFileDataInput, ALUout, ramOut;
	wire [31:0] romOut, controlWord;
	wire [2:0] outputLength;
	wire setFlag;
	
	wire [3:0] signalBits;
	
	//control word indicators
	wire [1:0] programSelect;
	wire [4:0] regDataAddress, regAAddress, regBAddress, functionSelect;
	wire registerFileWrite, RAMwrite, enableRamData, enableAluData, enableRegAData, enablePcData, selAluValueInput, 
					programValueSelect, statusLineUse, enableAluCarry;

	assign muxOut = selAluValueInput ? regBout : constantValue;
	
	assign regFileDataInput = enableRamData ? ramOut : (enableAluData ? ALUout : (enableRegAData ? regAout : (enablePcData ? 
							programCounterOut : 64'b0)));
	
	//Assign meaning to Control-Word Bits
	assign programSelect = controlWord[31:30];
	assign regDataAddress = controlWord[29:25];
	assign regAAddress = controlWord[24:20];
	assign regBAddress = controlWord[19:15];
	assign functionSelect = controlWord[14:10];
	assign registerFileWrite = controlWord[9];
	assign RAMwrite = controlWord[8];
	assign enableRamData = controlWord[7];
	assign enableAluData = controlWord[6];
	assign enableRegAData = controlWord[5]; //Is B in list, we are using A
	assign enablePcData = controlWord[4];
	assign selAluValueInput = controlWord[3];
	assign programValueSelect = controlWord[2];
	assign statusLineUse = controlWord[1];
	assign enableAluCarry = controlWord[0];

	Program_Counter PC (clk, rst, programSelect, programCounterIn, programCounterOut);
	
	ROM rom (programCounterOut, romOut);
	
	ControlUnit controlUnit (clk, rst, romOut, signalBits, constantValue, controlWord, outputLength, setFlag);
	
	ALU alu (regAout, muxOut, functionSelect, enableAluCarry, ALUout, signalBits);
	
	RegisterFile32x64bit regFile (regAout, regBout, regFileDataInput, regAAddress, regBAddress, regDataAddress, registerFileWrite, rst, clk);
	
	RAM256x64 ram (ALUout, clk, regBout, RAMwrite, ramOut);	
endmodule
