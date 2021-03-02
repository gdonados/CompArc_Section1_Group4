`timescale 10ns/10ns
module ALU(A, B, fsec, carry, fout);
	input [63:0] A, B; //data inputs
	input [4:0] fsec;  //"opcode"
	input carry; 		 //
	output [63:0] fout;
	
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
 zero64 zeroAC (A, zeroC); //A -> 0
 pass64 passA (A, passC); //A -> A
 and64 andAB (A, B, andC); //A & B = C
 or64 orAB (A, B, orC); //A | B = C
 xor64 xorAB (A, B, xorC); //A ^ B = C
 
 
 //Shift (does not use 2:1 mux)
 shiftLeft1 shiftAl (A, Aleft);
 shiftRight1 shiftAr (A, Aright);
 
 endmodule
 
	