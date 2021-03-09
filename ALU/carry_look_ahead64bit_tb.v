module carry_look_ahead64bit_tb;
reg[63:0] A,B;
reg Cin;
wire [63:0] Sum;
wire Cout;

carry_look_ahead64bit dut(A, A, Cin, Sum, Cout);

initial begin
A=64'd0; B=64'd0; Cin=0;
#10
A=64'd1000; B=64'd2945; Cin=0;
#10
A=64'd1000; B=64'd2945; Cin=1;
	/*//for carry = 0;
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
	end*/
end
endmodule
