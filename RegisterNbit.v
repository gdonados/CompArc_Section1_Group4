module RegisterNbit(Q, D, L, R, clock);

	parameter N = 64; // number of bits
	
	output reg [N-1:0]Q; // registered output
	input [N-1:0]D; // data input
	input L; // load enable
	input R; // positive logic asynchronous reset
	input clock; // positive edge clock
	
	always @(posedge clock or posedge R) begin
		if(R)      //if reset, register output set to 0
			Q <= 0;
		else if(L) //if load enabled, register output set to data input
			Q <= D;
		else
			Q <= Q; //if nothing, register values = register values
	end
endmodule
