`timescale 10ns/10ns
module ALU(A, B, fsec, carry, fout, signal);
	input [63:0] A, B;   //data inputs
	input [4:0] fsec;    //"opcode"
	input carry; 		   //carry input
	output [63:0] fout;  //function output
	output [3:0] signal; //signal bit outputs
	
	reg [63:0] result;   //chosen statement result
	reg [3:0] signalCheck; //chosen signal check
	
	assign fout = result;//set output equal to case result
	assign signal = signalCheck; //set signal equal to signal check
	
	wire[63:0] Anot, Bnot, sum, sumC, differenceBA, differenceAB, difference1; //arithmetic wires
	wire[63:0] zeroC, passC, andC, orC, xorC;  //logic wires
	wire[63:0] Aleft, Aright; //shift wires
	wire cout; //carry out
	
	//A and B 2:1 mux for A and A' 
	invert64 invertA (A, Anot);  //Bitwise Inverts A
	invert64 invertB (B, Bnot);  //Bitwise Inverts B
	
	integer i=1;
	integer j=0;
	
	//Arithmetic
	carry_look_ahead64bit addAB (A,B,j, sum, cout); //adds A + B
	carry_look_ahead64bit addABcarry (A,B,carry, sumC, cout); //adds A + B + Carry_in
	
	
	carry_look_ahead64bit subBA (Anot+1, B, j, differenceBA);  //(-A)+B, aka B-A
	carry_look_ahead64bit subAB (A, Bnot+1, j, differenceAB);  //A+(-B), aka A-B

	//Logic
	and64 andAB (A, B, andC); //A & B = C
	or64 orAB (A, B, orC); //A | B = C
	xor64 xorAB (A, B, xorC); //A ^ B = C


	//Shift (does not use 2:1 mux)
	shiftLeft1 shiftAl (A, Aleft);
	shiftRight1 shiftAr (A, Aright);

	
	//5:1 Mux for Selecting Output of ALU
	always @(*) begin
		case(fsec)
			5'b00000:	begin //Bitwise inverts A
				result = Anot+1;
			end
			
			5'b00001:	begin //Arithmetic Negative B
				result = Bnot+1;
			end
			
			5'b00010:	begin //A + B
				result = sum;
			end
			
			5'b00011:	begin //A + B + C
				result = sumC;
			end
			
			5'b00100:	begin //A + 1
				result = A+1;
			end
			
			5'b00101:	begin
				result = differenceBA; //B-A
			end
			
			5'b00110:	begin
				result = differenceAB; //A-B
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
			 
			5'b01010:	begin //Bitwise inverts A
				result = Anot;
			end
			
			5'b01011:	begin //Bitwise Invert B
				result = Bnot;
			end
			
			5'b01100:	begin	//ands A and B
				result = andC;
			end
			
			5'b01101:	begin	//Ors A and B
				result = orC;
			end
			
			5'b01110:	begin	//Xors A and B
				result = xorC;
			end
			
			5'b01111:	begin	//Shifts A to the left 1
				result = Aleft;
			end	
			
			5'b10000:	begin	//Shifts A to the right 1
				result = Aright;
			end
			
			default:	result = 0;	//default case
		endcase
	end

	always @(*) begin
			//if output is zero
			if(result == 0)	begin
				signalCheck[0] = 1;
			end
			//if output is signed
			if(result[63] == 1) begin
				signalCheck[1] = 1;
			end
			//if A + B unsigned 65th bit arithmetic overflow error 
			if(cout == 1 && (fsec == 5'b00010 || fsec == 5'b00011)) begin
				signalCheck[2] = 1;
			end
			//if A + B signed 64th bit == 1, arithmetic overflow error
			if((fsec == 5'b00010 && sum[63] == 1) || (fsec == 5'b00011 && sumC[63] == 1)) begin
				signalCheck[3] = 1;
			end
	end
endmodule
 
	