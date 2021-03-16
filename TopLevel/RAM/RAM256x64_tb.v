module RAM256x64_tb();
	reg [63:0] data_in, addr;
	reg clk, wrt;
	wire [63:0] data_out;
	
	RAM256x64 dut (addr, clk, data_in, wrt, data_out);
	
	initial begin
		data_in = 0;
		wrt = 1;
		clk = 0;
		addr[63:56] = 8'b00000000;
		#5120 wrt = 0;
		#5200 $stop;
	end
	always begin
	
		#5 clk = ~clk;
	end
	
	always begin
		#20;
		data_in = {$random, $random};
		addr[63:56] = addr[63:56] + 1;
	end
endmodule
