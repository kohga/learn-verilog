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


module RCA_16(A,B,CI,SUM,CO);
	input[16:0]A;
	input[16:0]B;
	output[16:0]SUM;
	input CI;
	output CO;
	wire co1,co2,co3,co4;

	RCA_4 Adder4_1(.A(A[3:0]), .B(B[3:0]), .CI(CI), .SUM(SUM[3:0]), .CO(co1));
	RCA_4 Adder4_2(.A(A[7:4]), .B(B[7:4]), .CI(co1), .SUM(SUM[7:4]), .CO(co2));
	RCA_4 Adder4_3(.A(A[11:8]), .B(B[11:8]), .CI(co2), .SUM(SUM[11:8]), .CO(co3));
	RCA_4 Adder4_4(.A(A[15:12]), .B(B[15:12]), .CI(co3), .SUM(SUM[15:12]), .CO(CO));

endmodule



//Test fixture
module test_adder;

reg[16:0]A;
reg[16:0]B;
reg CI;
wire [16:0]S;
wire C4;

initial begin

$monitor ($time, "A = %b, B = %b, CI = %b, S = %b, C4 = %b",A,B,CI,S,C4);

A = 4'b0; B = 4'b0; CI = 0;

#10  A <= 16'hf;
#100 B <= 16'h1;
#100 B <= 16'h0;
#100 CI <= 1;
#200 $finish;
	end

initial
	begin
		$shm_open("waves.shm");
		$shm_probe("AS");
	end

//	instadder Adder4( .a(A), .b(B), .ci(CI), .s(S), .co(C4) );
	RCA_16 Adder4(.A(A), .B(B), .CI(CI), .SUM(S), .CO(C4));
endmodule
