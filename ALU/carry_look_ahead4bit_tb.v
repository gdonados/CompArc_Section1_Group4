`timescale 10ns/10ns
module carry_look_ahead4bit_tb;
reg[3:0] a,b;
reg cin;
wire [3:0] sum;
wire cout;
integer i,j;
	
carry_look_ahead4bit dut(a, b, cin, sum, cout);

initial begin
	a=0; b=0; cin=0;
	
	
	//for carry = 0;
	for(i=0; i<16; i=i+1) begin
		for(j=0; j<16; j=j+1) begin
			a = i;
			b = j;
			#10;
		end
	end
	
	//for carry = 1;
	cin=1;
	for(i=0; i<16; i=i+1) begin
		for(j=0; j<16; j=j+1) begin
			a = i;
			b = j;
			#10;
		end
	end
end
endmodule
