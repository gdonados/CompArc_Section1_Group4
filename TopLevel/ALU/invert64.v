`timescale 10ns/10ns
module invert64 (A, C);
	input [63:0] A;
	output reg [63:0] C;
	
	always @(*) begin
	 C=~A;
	end
endmodule 