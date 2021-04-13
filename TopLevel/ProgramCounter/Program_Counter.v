`timescale 10ns/10ns
module Program_Counter (clk, reset, PS, PC_IN, PC_OUT);
	input clk, reset; 
	input [1:0] PS;
	input[63:0] PC_IN;
	output [63:0] PC_OUT;

	reg[63:0] PC;
	
	assign PC_OUT = PC;
	
	initial begin
		PC <= 0;
	end
	
	always @(posedge clk) begin		
		if(reset == 1) PC <= 0;
		else begin	
			case (PS)
			2'b00: begin
				PC <= PC;//Stall PC
				end
				
			2'b01: begin //increment PC
				PC <= PC + 16'h1;
				end
			2'b10: begin //load input value to set PC to jump to a spot in the code
				PC <= PC_IN; 
				end
			2'b11: begin //offset PC by input value
				PC <= PC + PC_IN; 
				end
			default begin
				PC <= 0;
				end
			endcase
		end
	end
endmodule
			
	