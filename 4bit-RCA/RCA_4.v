`include "arch.v"

module RCA_4(A,B,CI,SUM,CO);
	input[3:0]A;
	input[3:0]B;
	output[3:0]SUM;
	input CI;
	output CO;
	wire c3,c2,c1;

	FA U1_0 (.A(A[0]), .B(B[0]), .CI(CI), .CO(c1), .SO(SUM[0]) );
	FA U1_1 (.A(A[1]), .B(B[1]), .CI(c1), .CO(c2), .SO(SUM[1]) );
	FA U1_2 (.A(A[2]), .B(B[2]), .CI(c2), .CO(c3), .SO(SUM[2]) );
	FA U1_3 (.A(A[3]), .B(B[3]), .CI(c3), .CO(CO), .SO(SUM[3]) );
endmodule

//Test fixture
module test_adder;

reg[3:0]A;
reg[3:0]B;
reg CI;
wire [3:0]S;
wire C4;

initial begin

$monitor ($time, "A = %b, B = %b, CI = %b, S = %b, C4 = %b",A,B,CI,S,C4);

A = 4'b0; B = 4'b0; CI = 0;

#10  A <= 4'hf;
#100 B <= 4'h1;
#100 B <= 4'h0;
#100 CI <= 1;
#200 $finish;
	end

initial
	begin
		$shm_open("waves.shm");
		$shm_probe("AS");
	end

//	instadder Adder4( .a(A), .b(B), .ci(CI), .s(S), .co(C4) );
	RCA_4 Adder4(.A(A), .B(B), .CI(CI), .SUM(S), .CO(C4));
endmodule
