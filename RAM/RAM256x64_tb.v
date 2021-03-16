module RAM256x64_tb();
	reg [63:0] data_in, addr;
	reg clk, wrt;
	wire [63:0] data_out;
	
	RAM256x64 dut (addr, clk, data_in, wrt, data_out);
	
	initial begin
		data_in = 0;
		wrt = 1;
		clk = 0;
		addr = 8'b00000000;
		#1280 wrt = 0;
		#1300 $stop;
	end
	
	always begin
		clk = ~clk;
	end
	
	always begin
		data_in = {$random, $random};
		addr = addr + 1;
		#5;
	end
endmodule
