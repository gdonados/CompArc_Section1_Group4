module RegisterFile32x64bit(outA, outB, in, selA, selB, selI, ld, rst, clk);
	output [63:0] outA, outB; //A and B output buses
	input [63:0] in; //input bus
	input [4:0] selA, selB, selI; //selector buses
	input ld, rst, clk; //load, reset, clock inputs
	
	reg [63:0] registers [31:0]; //32, 64 bit registers
	
	assign outA = registers[selA]; //sets output A to the register selected by selA
	assign outB = registers[selB]; //sets output B to the register selected by selB
	
	integer i = 0;
	
	always @(posedge clk or posedge rst) begin
		if(rst == 1) begin //if rst is high
			for(i = 0; i < 32; i = i + 1) begin
				registers[i] <= 64'b0; //goes through each register and sets all 64 bits to 0
			end
		end
		
		else if (ld == 1) begin
			registers[selI] <= in; //if ld is set, load the input data
		end
		
		else begin //else do nothing
		end
		//to add a read, make a swtich block with the read/write bits and perform the correct action accordingly
	end
endmodule
