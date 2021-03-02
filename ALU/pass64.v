module pass64(A, C);
input [63:0] A; //data inputs
output reg [63:0] C; //data outputs

assign C[63:0] = A;

endmodule
