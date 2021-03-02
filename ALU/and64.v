module and64 (A, B, C);
input [63:0] A, B;  //data inputs
output reg [63:0] C; //data outputs

always @(*) begin
C=A&B;
end

endmodule
