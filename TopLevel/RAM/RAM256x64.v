`timescale 10ns/10ns
module RAM256x64(address, clock, in, write, out);
    input [7:0] address; //8b address
    input clock; //1b clock
    input [63:0] in; //64b input
    input write; //1b write enable
    
    output [63:0] out;
    reg [63:0] outReg; //64b output
    
	 assign out = outReg;
	 
    reg [63:0]mem[0:255]; //reserve memory
    
    always @(posedge clock) begin
   	 if (write) begin
   		 mem[address] <= in; //write to RAM when write is enabled
   	 end
    end
    
    always @(posedge clock) begin
   	 outReg <= mem[address]; //access RAM
    end
endmodule
