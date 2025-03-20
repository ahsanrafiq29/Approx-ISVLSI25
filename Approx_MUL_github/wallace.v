`timescale 1ns / 1ps

module top (a, b, r);
    input [7:0] a;
    input [7:0] b;
    output [15:0] r;
    
    (* keep = "true" *) wire [15:0] r_one;
    (* keep = "true" *) wire [15:0] r_two;
    (* keep = "true" *) wire [15:0] r_three;
    
    (* DONT_TOUCH = "yes" *) wallace w1(a, b, r_one);
    (* DONT_TOUCH = "yes" *) wallace w2(a, b, r_two);
    (* DONT_TOUCH = "yes" *) wallace w3(a, b, r_three);
    
    assign r = (r_one & r_two) | (r_one & r_three) | (r_two & r_three);
    
endmodule

module wallace(a,b,r);
input [7:0]a;//first input
input [7:0]b;//second input
output [15:0] r;//maximum 16 bits


wire [7:0] p1,p2,p3,p4,p5,p6,p7,p8; // all partial products
wire [15:0] c1p1,c1p2,c1p3,c1p4,c1p5,c1p6;//,c1p7,c1p8; //respective sum for each step
wire [15:0] s1p1,s1p2,s1p3,s1p4,s1p5,s1p6;//,s1p7,s1p8; //respective carry for each step
wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12;

// #generating parallel outputs
assign p1[0] = a[0]&b[0];
assign p1[1] = a[1]&b[0];
assign p1[2] = a[2]&b[0];
assign p1[3] = a[3]&b[0];
assign p1[4] = a[4]&b[0];
assign p1[5] = a[5]&b[0];
assign p1[6] = a[6]&b[0];
assign p1[7] = a[7]&b[0];
//first 8 bit product

assign p2[0] = a[0]&b[1];
assign p2[1] = a[1]&b[1];
assign p2[2] = a[2]&b[1];
assign p2[3] = a[3]&b[1];
assign p2[4] = a[4]&b[1];
assign p2[5] = a[5]&b[1];
assign p2[6] = a[6]&b[1];
assign p2[7] = a[7]&b[1];
//second 8 bit product

assign p3[0] = a[0]&b[2];
assign p3[1] = a[1]&b[2];
assign p3[2] = a[2]&b[2];
assign p3[3] = a[3]&b[2];
assign p3[4] = a[4]&b[2];
assign p3[5] = a[5]&b[2];
assign p3[6] = a[6]&b[2];
assign p3[7] = a[7]&b[2];

assign p4[0] = a[0]&b[3];
assign p4[1] = a[1]&b[3];
assign p4[2] = a[2]&b[3];
assign p4[3] = a[3]&b[3];
assign p4[4] = a[4]&b[3];
assign p4[5] = a[5]&b[3];
assign p4[6] = a[6]&b[3];
assign p4[7] = a[7]&b[3];
//fourth 8 bit product
assign p5[0] = a[0]&b[4];
assign p5[1] = a[1]&b[4];
assign p5[2] = a[2]&b[4];
assign p5[3] = a[3]&b[4];
assign p5[4] = a[4]&b[4];
assign p5[5] = a[5]&b[4];
assign p5[6] = a[6]&b[4];
assign p5[7] = a[7]&b[4];
//fifth 8 bit product
assign p6[0] = a[0]&b[5];
assign p6[1] = a[1]&b[5];
assign p6[2] = a[2]&b[5];
assign p6[3] = a[3]&b[5];
assign p6[4] = a[4]&b[5];
assign p6[5] = a[5]&b[5];
assign p6[6] = a[6]&b[5];
assign p6[7] = a[7]&b[5];

assign p7[0] = a[0]&b[6];
assign p7[1] = a[1]&b[6];
assign p7[2] = a[2]&b[6];
assign p7[3] = a[3]&b[6];
assign p7[4] = a[4]&b[6];
assign p7[5] = a[5]&b[6];
assign p7[6] = a[6]&b[6];
assign p7[7] = a[7]&b[6];
//seventh 8 bit product
assign p8[0] = a[0]&b[7];
assign p8[1] = a[1]&b[7];
assign p8[2] = a[2]&b[7];
assign p8[3] = a[3]&b[7];
assign p8[4] = a[4]&b[7];
assign p8[5] = a[5]&b[7];
assign p8[6] = a[6]&b[7];
assign p8[7] = a[7]&b[7];

assign s1p1[0] = p1[0];
HalfAdder h0( p1[1],p2[0],s1p1[1],c1p1[0] );
// c1p1[0] = c1
full_Adder h1(p1[2],p2[1],p3[0],s1p1[2],c1p1[1]);
full_Adder h2(p1[3],p2[2],p3[1],s1p1[3],c1p1[2]);
full_Adder h3(p1[4],p2[3],p3[2],s1p1[4],c1p1[3]);
full_Adder h4(p1[5],p2[4],p3[3],s1p1[5],c1p1[4]);
full_Adder h5(p1[6],p2[5],p3[4],s1p1[6],c1p1[5]);
full_Adder h6(p1[7],p2[6],p3[5],s1p1[7],c1p1[6]);
// full_Adde2(p1[8],p2[7],p3[6],s1p1[2],c1p1[1]);
HalfAdder h7(p2[7],p3[6],s1p1[8],c1p1[7]);
assign s1p1[9] = p3[7];

assign s1p2[0] = p4[0];
HalfAdder h9( p4[1],p5[0],s1p2[1],c1p2[0] );
// c1p1[0] = c1
full_Adder h10(p4[2],p5[1],p6[0],s1p2[2],c1p2[1]);
full_Adder h11(p4[3],p5[2],p6[1],s1p2[3],c1p2[2]);
full_Adder h12(p4[4],p5[3],p6[2],s1p2[4],c1p2[3]);
full_Adder h13(p4[5],p5[4],p6[3],s1p2[5],c1p2[4]);
full_Adder h14(p4[6],p5[5],p6[4],s1p2[6],c1p2[5]);
full_Adder h15(p4[7],p5[6],p6[5],s1p2[7],c1p2[6]);
// full_Adder(p1[8],p2[7],p3[6],s1p1[2],c1p1[1]);
HalfAdder h16(p5[7],p6[6],s1p2[8],c1p2[7]);
assign s1p2[9] = p6[7];

assign s1p3[0] = s1p1[0];
assign s1p3[1] = s1p1[1];
HalfAdder h17(s1p1[2],c1p1[0],s1p3[2],c1p3[0]);
full_Adder h18(s1p1[3],c1p1[1],s1p2[0],s1p3[3],c1p3[1]);
full_Adder h19(s1p1[4],c1p1[2],s1p2[1],s1p3[4],c1p3[2]);
full_Adder h20(s1p1[5],c1p1[3],s1p2[2],s1p3[5],c1p3[3]);
full_Adder h21(s1p1[6],c1p1[4],s1p2[3],s1p3[6],c1p3[4]);
full_Adder h22(s1p1[7],c1p1[5],s1p2[4],s1p3[7],c1p3[5]);
full_Adder h23(s1p1[8],c1p1[6],s1p2[5],s1p3[8],c1p3[6]);
full_Adder h24(s1p1[9],c1p1[7],s1p2[6],s1p3[9],c1p3[7]);

//firoz correction ?
assign s1p3[10] = s1p2[7];
assign s1p3[11] = s1p2[8];
assign s1p3[12] = s1p2[9];

assign s1p4[0] = c1p2[0];
HalfAdder h25(c1p2[1],p7[0],s1p4[1],c1p4[0]);
full_Adder h26(c1p2[2],p7[1],p8[0],s1p4[2],c1p4[1]);
full_Adder h27(c1p2[3],p7[2],p8[1],s1p4[3],c1p4[2]);
full_Adder h28(c1p2[4],p7[3],p8[2],s1p4[4],c1p4[3]);
full_Adder h29(c1p2[5],p7[4],p8[3],s1p4[5],c1p4[4]);
full_Adder h30(c1p2[6],p7[5],p8[4],s1p4[6],c1p4[5]);
full_Adder h31(c1p2[7],p7[6],p8[5],s1p4[7],c1p4[6]);
// full_Adder h32(c1p2[8],p7[7],p8[6],s1p4[8],c1p4[7]);
HalfAdder h32(p7[7],p8[6],s1p4[8],c1p4[7]);
assign s1p4[9] = p8[7];

assign s1p5[0] = s1p3[0];
assign s1p5[1] = s1p3[1];
assign s1p5[2] = s1p3[2];
HalfAdder h33(s1p3[3],c1p3[0],s1p5[3],c1p5[0]);
// full_Adder f1
HalfAdder h41(s1p3[4],c1p3[1],s1p5[4],c1p5[1]);
full_Adder h34(s1p3[5],c1p3[2],s1p4[0],s1p5[5],c1p5[2]);
full_Adder h35(s1p3[6],c1p3[3],s1p4[1],s1p5[6],c1p5[3]);
full_Adder h36(s1p3[7],c1p3[4],s1p4[2],s1p5[7],c1p5[4]);
full_Adder h37(s1p3[8],c1p3[5],s1p4[3],s1p5[8],c1p5[5]);
full_Adder h38(s1p3[9],c1p3[6],s1p4[4],s1p5[9],c1p5[6]);
full_Adder h39(s1p3[10],c1p3[7],s1p4[5],s1p5[10],c1p5[7]);

HalfAdder h40(s1p3[11],s1p4[6],s1p5[11],c1p5[8]);
HalfAdder h42(s1p3[12],s1p4[7],s1p5[12],c1p5[9]);
assign s1p5[13] = s1p4[8];
assign s1p5[14] = s1p4[9];

assign s1p6[0] = s1p5[0];
assign s1p6[1] = s1p5[1];
assign s1p6[2] = s1p5[2];
assign s1p6[3] = s1p5[3];
HalfAdder h43(s1p5[4],c1p5[0],s1p6[4],c1p6[0]);
HalfAdder h44(s1p5[5],c1p5[1],s1p6[5],c1p6[1]);
HalfAdder h45(s1p5[6],c1p5[2],s1p6[6],c1p6[2]);

full_Adder f1(s1p5[7],c1p5[3],c1p4[0],s1p6[7],c1p6[3]);
full_Adder f2(s1p5[8],c1p5[4],c1p4[1],s1p6[8],c1p6[4]);
full_Adder f3(s1p5[9],c1p5[5],c1p4[2],s1p6[9],c1p6[5]);
full_Adder f4(s1p5[10],c1p5[6],c1p4[3],s1p6[10],c1p6[6]);
full_Adder f5(s1p5[11],c1p5[7],c1p4[4],s1p6[11],c1p6[7]);
full_Adder f6(s1p5[12],c1p5[8],c1p4[5],s1p6[12],c1p6[8]);
full_Adder f7(s1p5[13],c1p5[9],c1p4[6],s1p6[13],c1p6[9]);

HalfAdder h46(s1p5[14],c1p4[7],s1p6[14],c1p6[10]);

assign r[0] = s1p6[0];
assign r[1] = s1p6[1];
assign r[2] = s1p6[2];
assign r[3] = s1p6[3];
assign r[4] = s1p6[4];
HalfAdder h47(s1p6[5],c1p6[0],r[5],c1);
full_Adder h48(s1p6[6],c1p6[1],c1,r[6],c2);
full_Adder h49(s1p6[7],c1p6[2],c2,r[7],c3);
full_Adder h50(s1p6[8],c1p6[3],c3,r[8],c4);
full_Adder h51(s1p6[9],c1p6[4],c4,r[9],c5);

full_Adder h52(s1p6[10],c1p6[5],c5,r[10],c6);
full_Adder h53(s1p6[11],c1p6[6],c6,r[11],c7);
full_Adder h54(s1p6[12],c1p6[7],c7,r[12],c8);
full_Adder h55(s1p6[13],c1p6[8],c8,r[13],c9);
full_Adder h56(s1p6[14],c1p6[9],c9,r[14],c10);
// assign asn[15] = c1p6[10];
HalfAdder h57(c1p6[10],c10,r[15],c11);

endmodule

module HalfAdder (a,b,sum, ca);
input a, b;
output sum, ca;
	assign sum = a ^ b;
	assign ca  = a&b;
endmodule

module full_Adder (a,b,cin,sum, ca);
input a, b,cin;
output sum, ca;
	wire x,y,z;
	xor x1(x,a,b);
	xor x2(sum,x,cin);
	and a1(y,a,b);
	and a2(z,x,cin);
	or o1(ca,y,z);
endmodule