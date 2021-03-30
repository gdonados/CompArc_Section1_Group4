module ControlUnit_tb();
	reg c, r;
	reg [31:0] in;
	reg [3:0] stat;
	
	wire [30:0] out;
	wire [63:0] con;
	
	initial begin
		c = 0;
		r = 0;
		in = 0;
		stat = 0;
		#20 in = 32'b1001000100_000001100100_11111_00100;
	end
	
	always
		#5 c = ~c;
endmodule
