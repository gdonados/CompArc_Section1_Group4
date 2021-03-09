`timescale 10ns/10ns

module ALU_tb();
	reg [63:0] Ain, Bin;
	reg[4:0] sel;
	reg c;
	
	wire[3:0] sig;
	wire [63:0] o;
	
	ALU dut (Ain, Bin, sel, c, o, sig);
	
	initial begin
		Ain <= 64'b1011101011110001110100101001010100100100111111010001111010111101; //sets A to 205
		Bin <= 64'b1111111111111111111111111111111111111111111111111111111111111111; //sets B to 512
		sel <= 0;	//sets select to 0
		c <= 0;	//carry is initially 0
		
		#80 c <= 1;	//after 80 ticks set carry to 1
		#80 sel <= 0;	//after 80 ticks reset select
		
		#160 $stop;	//stops simulation after 180 ticks
	end
	
	always begin
		#5 sel = sel + 5'b00001;	//increments select by 1 every 5 ticks
	end
endmodule
