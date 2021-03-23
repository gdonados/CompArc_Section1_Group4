`timescale 10ns/10ns
module ROM_tb ();
	reg [15:0] addressROM;
	wire [31:0] outROM;
	
	ROM dut (outROM, addressROM);
	
	//give input initial value	
	initial begin
		addressROM <= 16'b0; //initialize at zero
		#150 $stop;	//stop tb after Address increments 150/10 = 15 times (allows to see default case)
	end

	always begin
		#10 addressROM = addressROM + 1; //delay 10, then add 1'b to increment ROM Address
	end
endmodule
	