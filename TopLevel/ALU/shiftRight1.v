`timescale 10ns/10ns
module shiftRight1 (A, C);
	input [63:0] A;
	output reg [63:0] C;
	
	always @(*) begin
	C= A >> 1; 
	end
endmodule
