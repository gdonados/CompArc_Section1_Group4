module addition64 (A, B, carry, out);
	input [63:0] A, B;
	input carry;
	output reg [63:0] out;
	 
	reg carry_out;
	
	always @(*) begin
	{carry_out, out[63:0]}=A+B+carry;
	end
	
endmodule


	