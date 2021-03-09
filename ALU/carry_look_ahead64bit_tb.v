module carry_look_ahead64bit_tb;
reg[63:0] a,b;
reg cin;
wire [63:0] sum;
wire cout;

carry_look_ahead64bit dut(a, b, cin, sum, cout);

initial begin
	a=0; b=0; cin=0;
	#10 a=16'd0; b=16'd0; cin=1'd1;
	#10 a=16'd14; b=16'd1; cin=1'd1;
	#10 a=16'd5; b=16'd0; cin=1'd0;
	#10 a=16'd999; b=16'd0; cin=1'd1;
end

initial 
	$monitor( "A=%d, B=%d, Cin=%d, Sum=%d, Cout=%d", a,b,cin,sum,cout);
endmodule
