`include "arch.v"

module CLA_4 ( A, B, CI, SUM, CO );
  input [3:0] A;
  input [3:0] B;
  output [3:0] SUM;
  input CI;
  output CO;
  wire   c3 , c2 , c1 ;

  FA U1_0 ( .A(A[0]), .B(B[0]), .CI(CI), .CO(), .SO(SUM[0]) );
  FA U1_1 ( .A(A[1]), .B(B[1]), .CI(c1), .CO(), .SO(SUM[1]) );
  FA U1_2 ( .A(A[2]), .B(B[2]), .CI(c2), .CO(), .SO(SUM[2]) );
  FA U1_3 ( .A(A[3]), .B(B[3]), .CI(c3), .CO(), .SO(SUM[3]) );

 // Bit[0]: Carry Lookahead Logic

  OR2 U2_1 ( .A(A[0]), .B(B[0]), .Y(p0) );
  AN2 U2_2 ( .A(A[0]), .B(B[0]), .Y(g0) );
  AN2 U2_3 ( .A(p0), .B(CI), .Y(n100) );
  OR2 U2_4 ( .A(g0), .B(n100), .Y(c1) );

 // Bit[1]: Carry Lookahead Logic

  OR2 U3_1 ( .A(A[1]), .B(B[1]), .Y(p1) );
  AN2 U3_2 ( .A(A[1]), .B(B[1]), .Y(g1) );
  AN3 U3_3 ( .A(p1), .B(p0), .C(CI), .Y(n200) );
  AN2 U3_4 ( .A(g0), .B(p1), .Y(n201) );
  OR3 U3_5 ( .A(g1), .B(n201), .C(n200), .Y(c2) );

 // Bit[2]: Carry Lookahead Logic

  OR2 U4_1 ( .A(A[2]), .B(B[2]), .Y(p2) );
  AN2 U4_2 ( .A(A[2]), .B(B[2]), .Y(g2) );
  AN2 U4_3 ( .A(p0), .B(CI), .Y(n351) );
  AN2 U4_4 ( .A(p2), .B(p1), .Y(n352) );
  AN2 U4_5 ( .A(n351), .B(n352), .Y(n300) );
  AN3 U4_6 ( .A(g0), .B(p1), .C(p2), .Y(n301) );
  AN2 U4_7 ( .A(g1), .B(p2), .Y(n302) );
  OR2 U4_8 ( .A(n301), .B(n300), .Y(n353) );
  OR2 U4_9 ( .A(g2), .B(n302), .Y(n354) );
  OR2 U4_10 ( .A(n354), .B(n353), .Y(c3) );

// Bit[3]: Carry Lookahead Logic

  OR2 U5_1 ( .A(A[3]), .B(B[3]), .Y(p3) );
  AN2 U5_2 ( .A(A[3]), .B(B[3]), .Y(g3) );
  AN2 U5_3 ( .A(p0), .B(CI), .Y(n451) );
  AN3 U5_4 ( .A(p3), .B(p2), .C(p1), .Y(n452) );
  AN2 U5_5 ( .A(n451), .B(n452), .Y(n400) );
  AN2 U5_6 ( .A(p2), .B(p3), .Y(n453) );
  AN2 U5_7 ( .A(g0), .B(p1), .Y(n454) );
  AN2 U5_8 ( .A(n454), .B(n453), .Y(n401) );
  AN3 U5_9 ( .A(g1), .B(p2), .C(p3), .Y(n402) );
  AN2 U5_10 ( .A(g2), .B(p3), .Y(n403) );
  OR2 U5_11 ( .A(n401), .B(n400), .Y(n455) );
  OR3 U5_12 ( .A(g3), .B(n403), .C(n402), .Y(n456) );
  OR2 U5_13 ( .A(n456), .B(n455), .Y(CO) );

endmodule

// Test fixture
module test_adder2;

reg [3:0] A;
reg [3:0] B;
reg CI;
wire [3:0] S;
wire C4;

initial begin

$monitor($time, "  A = %b, B = %b, CI = %b, S = %b, C4 = %b", A, B, CI, S, C4);

A = 4'b0; B = 4'b0; CI = 0;

#10 A <= 4'hf;
// #10 A[0] <= 1;
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


//      instadder Adder_4 ( .a(A), .b(B), .ci(CI), .s(S), .co(C4) ); 
      CLA_4 Adder_4 ( .A(A), .B(B), .CI(CI), .SUM(S), .CO(C4) ); 
endmodule
