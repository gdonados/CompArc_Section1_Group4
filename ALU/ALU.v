`timescale 10ns/10ns
module ALU(A, B, fsec, carry, fout);
	input [63:0] A, B; //data inputs
	input [4:0] fsec;  //"opcode"
	input carry; 		 //
	output [63:0] fout;
	
	reg [63:0] result; //chosen statement result
	
	assign fout = result;
	
	wire[63:0] Anot, Bnot, sum, sumC, sum1, differenceA, differenceB, difference1; //arithmetic wires
	wire[63:0] zeroC, passC, andC, orC, xorC;  //logic wires
	wire[63:0] Aleft, Aright; //shift wires
	integer i=0;
	integer j=1;
	
	//A and B 2:1 mux for A and A' 
	invert64 invertA (A, Anot);  //make sure that this is making A --> -A, and does not need +1
	invert64 invertB (B, Bnot);
	invert64 invertj (j, jnot);  //pay close attention here to if it works

	//Arithmetic
	addition64 add (A, B, i, sum); 					//A+B
	addition64 addCarry (A, B, carry, sumC); 	//A+B+Carry

	addition64 subA (Anot, B, i, differenceA);  //(-A)+B, aka B-A
	addition64 subB (A, Bnot, i, differenceB);  //A+(-B), aka A-B

	addition64 add1 (A, j, i, sum1);            //A+1
	addition64 sub1 (A, jnot, i, difference1);  //A-1

	//Logic
	//invert64 
	//zero64 zeroAC (A, zeroC); //A -> 0
	//pass64 passA (A, passC); //A -> A
	and64 andAB (A, B, andC); //A & B = C
	or64 orAB (A, B, orC); //A | B = C
	xor64 xorAB (A, B, xorC); //A ^ B = C


	//Shift (does not use 2:1 mux)
	shiftLeft1 shiftAl (A, Aleft);
	shiftRight1 shiftAr (A, Aright);

	always @(*) begin
		case(fsec)
			5'b00000:	begin //inverts A
				result = Anot;
			end
			
			5'b00001:	begin //inverts B
				result = Bnot;
			end
			
			5'b00010:	begin //A + B
				result = sum;
			end
			
			5'b00011:	begin //A + B + C
				result = A+B+carry;
			end
			
			5'b00100:	begin //A + 1
				result = A+1;
			end
			
			5'b00101:	begin
				result = differenceA + 1; //B-A
			end
			
			5'b00110:	begin
				result = differenceB + 1; //A-B
			end
			
			5'b00111:	begin	//A-1
				result = A-1; 
			end
			
			5'b01000:	begin //sets A to 0
				result = 64'b0;
			end
			
			5'b01001:	begin	//passes A through
				result = A;
			end
			
			5'b01010:	begin	//ands A and B
				result = andC;
			end
			
			5'b01011:	begin	//Ors A and B
				result = orC;
			end
			
			5'b01100:	begin	//Xors A and B
				result = xorC;
			end
			
			5'b01101:	begin	//Shifts A to the left 1
				result = Aleft;
			end	
			
			5'b01110:	begin	//Shifts A to the right 1
				result = Aright;
			end
			
			default:	result = 999;	//default case
		endcase
	end

endmodule
 
	