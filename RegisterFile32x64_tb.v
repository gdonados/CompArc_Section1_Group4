`timescale 1ns/1ns

module RegisterFile32x64_tb();
	reg clk;
	reg write;
	reg [4:0] wrAddr;    
	reg [63:0] wrData;   
	reg [4:0] rdAddrA;   
	wire [63:0] rdDataA; 
	reg [4:0] rdAddrB;   
	wire [63:0] rdDataB;
	
	RegisterFile32x64a(clk, write, wrAddr, wrData, rdAddrA, rdDataA, rdAddrB, rdDataB);
	
	initial begin
		clk = 0;
		write = 1;
		wrAddr = 0;
		wrData = 0;
		rdAddrA = 0;
		//rdDataA = 0;
		rdAddrB = 0;
		//rdDataB = 0;
		
		#40 write = 1;
		wrData = 7;
		wrAddr = 3;
	end
	
	always begin
		#10
		clk = ~clk;
	end
endmodule
