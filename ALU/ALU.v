`timescale 10ns/10ns
module ALU(A, B, fsec, carry, fout);
	input [63:0] A, B; //data inputs
	input [4:0] fsec;  //"opcode"
	input carry; 		 //
	output [63:0] fout;
	
	wire[63:0] Anot, Bnot, sum, sumC, sum1, differenceA, differenceB, difference1;
	integer i=0;
	integer j=1;
	
 //A and B 2:1 mux for A and A' 
 invert64 invertA (A, Anot);
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
 
 
 
 //Shift (does not use 2:1 mux)
 
 endmodule
 
	