module RAM256x64(address, clock, in, write, out);
    parameter RAMAddress = 8'b00000010;
    
    input [63:0] address; //8b address
    input clock; //1b clock
    input [63:0] in; //64b input
    input write; //1b write enable
    
    output [63:0] out;
    reg [63:0] outReg; //64b output
    
    reg [63:0]mem[0:255]; //reserve memory
    wire correctAddress;
    
    assign correctAddress = (address[63:56] == RAMAddress) ? 1'b1 : 1'b0;
    assign out = correctAddress ? outReg : 64'bz;
    
    always @(posedge clock) begin
   	 if (write & correctAddress) begin
   		 mem[address[63:56]] <= in; //write to RAM when write is enabled
   	 end
    end
    
    always @(posedge clock) begin
   	 outReg <= mem[address[63:56]]; //access RAM
    end
endmodule
