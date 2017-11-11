`timescale 1ns/100ps
`celldefine
module	AN2(A,B,Y);
	input A,B;
	output Y;
	and(Y,A,B);
	specify
	    (A => Y) = (2.4:2.4:2.4);
	    (B => Y) = (2.4:2.4:2.4);
	endspecify
endmodule
`endcelldefine
`celldefine
module	AN3(A,B,C,Y);
	input A,B,C;
	output Y;
	and(Y,A,B,C);
	specify
	    (A => Y) = (2.8:2.8:2.8);
	    (B => Y) = (2.8:2.8:2.8);
	    (C => Y) = (2.8:2.8:2.8);
	endspecify
endmodule
`endcelldefine
`celldefine
module	XOR(A,B,Y);
	input A,B;
	output Y;
	xor(Y,A,B);
	specify
	    (A => Y) = (2.9:2.9:2.9);
	    (B => Y) = (2.9:2.9:2.9);
	endspecify
endmodule
`endcelldefine
`celldefine
module	FA(A,B,CI,CO,SO);
	input A,B,CI;
	output CO,SO;
	xor(SO,A,B,CI);
	maj(CO,B,CI,A);
	specify
	    (A => CO) = (4:4:4);
	    (B => CO) = (4:4:4);
	    (CI => CO) = (4:4:4);
	    (A => SO) = (3.1:3.1:3.1);
	    (B => SO) = (3.1:3.1:3.1);
	    (CI => SO) = (3.1:3.1:3.1);
	endspecify
endmodule
`endcelldefine
`celldefine
module	ND2(A,B,Y);
	input A,B;
	output Y;
	nand(Y,A,B);
	specify
	    (A => Y) = (1.5:1.5:1.5);
	    (B => Y) = (1.5:1.5:1.5);
	endspecify
endmodule
`endcelldefine
`celldefine
module	ND3(A,B,C,Y);
	input A,B,C;
	output Y;
	nand(Y,A,B,C);
	specify
	    (A => Y) = (1.8:1.8:1.8);
	    (B => Y) = (1.8:1.8:1.8);
	    (C => Y) = (1.8:1.8:1.8);
	endspecify
endmodule
`endcelldefine
`celldefine
module	NR2(A,B,Y);
	input A,B;
	output Y;
	nor(Y,A,B);
	specify
	    (A => Y) = (1.6:1.6:1.6);
	    (B => Y) = (1.6:1.6:1.6);
	endspecify
endmodule
`endcelldefine
`celldefine
module	NR3(A,B,C,Y);
	input A,B,C;
	output Y;
	nor(Y,A,B,C);
	specify
	    (A => Y) = (2:2:2);
	    (B => Y) = (2:2:2);
	    (C => Y) = (2:2:2);
	endspecify
endmodule
`endcelldefine
`celldefine
module	INV(A,Y);
	input A;
	output Y;
	not(Y,A);
	specify
	    (A => Y) = (1.1:1.1:1.1);
	endspecify
endmodule
`endcelldefine
`celldefine
module	OR2(A,B,Y);
	input A,B;
	output Y;
	or(Y,A,B);
	specify
	    (A => Y) = (2.6:2.6:2.6);
	    (B => Y) = (2.6:2.6:2.6);
	endspecify
endmodule
`endcelldefine
`celldefine
module	OR3(A,B,C,Y);
	input A,B,C;
	output Y;
	or(Y,A,B,C);
	specify
	    (A => Y) = (3:3:3);
	    (B => Y) = (3:3:3);
	    (C => Y) = (3:3:3);
	endspecify
endmodule
`endcelldefine

primitive maj(Y, A, B, C);
	output	Y;
	input	A, B, C;
	table	1  1  ? : 1;
		1  ?  1 : 1;
		?  1  1 : 1;
		0  0  ? : 0;
		0  ?  0 : 0;
		?  0  0 : 0;
	endtable
endprimitive
