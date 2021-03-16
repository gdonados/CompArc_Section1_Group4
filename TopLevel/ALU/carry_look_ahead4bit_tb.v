`timescale 10ns/10ns
module carry_look_ahead4bit_tb;
reg [3:0] A,B;
reg Cin;
wire [3:0] Sum;
wire Cout;
integer i,j;
	
carry_look_ahead4bit dut(A, B, Cin, Sum, Cout);

initial begin
	A=4'd0; B=4'd0; Cin=0;
	
	//for carry = 0;
	for(i=0; i<16; i=i+1) begin
		for(j=0; j<16; j=j+1) begin
			A = i;
			B = j;
			#10;
		end
	end
	
	//for carry = 1;
	Cin=1;
	for(i=0; i<16; i=i+1) begin
		for(j=0; j<16; j=j+1) begin
			A = i;
			B = j;
			#10;
		end
	end
end
endmodule
