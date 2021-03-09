`timescale 10ns/10ns
module carry_look_ahead64bit (a,b,cin, sum, cout);
input [63:0] a,b;
input cin;
output [63:0] sum;
output cout;

wire c1, c2, c3;

carry_look_ahead4bit cla1(.a(a[15:0]), .b(b[15:0]), .cin(cin), .sum(sum[15:0]), .cout(c1));
carry_look_ahead4bit cla2(.a(a[31:16]), .b(b[31:16]), .cin(cin), .sum(sum[31:16]), .cout(c2));
carry_look_ahead4bit cla3(.a(a[47:32]), .b(b[47:32]), .cin(cin), .sum(sum[47:32]), .cout(c3));
carry_look_ahead4bit cla4(.a(a[63:48]), .b(b[63:48]), .cin(cin), .sum(sum[63:48]), .cout(cout));

endmodule
