`timescale 10ns/10ns
module ROM(address, out);
    output reg [31:0] out;
    input [15:0] address; // address - 16 deep memory
    always @(address) begin
   	 case (address)
   		 // n = 100;
   		 // a = &array1[0];
   		 // b = &array2[0];
   		 // while(n--) {
   		 //     *b++ = *a++;
   		 // }
   		 // where n -> X4, a -> X8, b -> X9, X10 is temp value
			 16'h0000: out = 32'b110100101_00_0000000000000001_00001;  // MOVZ X1, 1
   		 16'h0001: out = 32'b110100101_00_0000000000000010_00010;  // MOVZ X2, 2
   		 16'h0002: out = 32'b1001000100_000001100100_00001_00100;  // ADDI X4, X1, 100
   		 16'h0003: out = 32'b10001011000_00001_000000_00010_00001; // ADD X1, X1, X2
   		 16'h0004: out = 32'b1101000100_000000000001_00100_00100;  // SUBI X4, X4, 1
   		 16'h0005: out = 32'b11111000010_000000000_00_01000_01010; // LDUR X10, [X8, 0]
   		 16'h0006: out = 32'b1001000100_000000001000_01000_01000;  // ADDI X8, X8, 8
   		 16'h0007: out = 32'b11111000000_000000000_00_01001_01010; // STUR X10, [X9, 0]
   		 16'h0008: out = 32'b1001000100_000000001000_01001_01001;  // ADDI X9, X9, 8
   		 16'h0009: out = 32'b000101_11111111111111111111111001;	// B -7
   		 default:  out = 32'hD60003E0; // BR XZR
   	 endcase
    end
endmodule
