`timescale 10ns/10ns
module Program_Counter (clk, reset, PC_IN, PS, PC_OUT, PC4);
	input clk, reset;
	input [1:0] PS;
	input[63:0] PC_IN;
	output [63:0] PC_OUT;
	output [63:0] PC4;
	
	reg [63:0] PC;
	
	assign PC_OUT = PC_IN + 1;
	assign PC4 = PC_IN + 4;

    always @(*) begin
		case (PS)
		2'b00: begin
			PC = PC;
			end
			
		2'b01: begin
			PC = PC + 1;
			end
			
		2'b10: begin
			PC = PC_IN;
			end
			
		2'b11: begin
			PC = PC + PC_IN;
			end
			
			endcase
			
			end
			
			endmodule
			
	