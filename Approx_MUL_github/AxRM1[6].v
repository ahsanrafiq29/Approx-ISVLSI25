module AxRM1(c,d,s);

//******************************
// Inputs Declaration
//******************************

input [7:0]c;
input [7:0]d;

//******************************
// Ouputs Declaration
//******************************

output [15:0]s;

//******************************
// Wires Declaration
//******************************

wire [7:0]s1;
wire [7:0]s2;
wire [7:0]s3;
wire [7:0]s4;


wire s1_RCA;
wire s2_RCA;
wire s3_RCA;
wire s4_RCA;
wire s5_RCA;
wire s6_RCA;
wire s7_RCA;
wire s8_RCA;

wire c1_RCA;
wire c2_RCA;
wire c3_RCA;
wire c4_RCA;
wire c5_RCA;
wire c6_RCA;
wire c7_RCA;
wire c8_RCA;

wire c_HA1;
wire c_HA2;
wire c_HA3;

wire c_FA1;
wire c_FA2;
wire c_FA3;
wire c_FA4;
wire c_FA5;
wire c_FA6;
wire c_FA7;


//****************************************
// Least Significant Partial Product (PP1)
//****************************************

Oa_approx M1(
		.c(c[3:0]),
		.d(d[3:0]),

		.s(s1[7:0])
      );	


//****************************************
// Partial Product 2 (PP2)
//****************************************

Ob_exact A1(
		.c(c[7:4]),
		.d(d[3:0]),

		.s(s2[7:0])
      	   );	

//****************************************
// Partial Product 3 (PP3)
//****************************************

Oc_exact A2(
		.c(c[3:0]),
		.d(d[7:4]),

		.s(s3[7:0])
      	   );


//****************************************
// Partial Product 4 (PP4)
//****************************************
	
Od_exact A3(
		.c(c[7:4]),
		.d(d[7:4]),

		.s(s4[7:0])
      	   );	


//****************************************
// Partial Product Reduction Stage 
//****************************************

Exact_FA EF1(

		.a(s1[4]),
		.b(s2[0]),
		.cin(s3[0]),

		.s(s1_RCA),
		.cout(c1_RCA)
	    );

Exact_FA EF2(

		.a(s1[5]),
		.b(s2[1]),
		.cin(s3[1]),

		.s(s2_RCA),
		.cout(c2_RCA)
	    );

Exact_FA EF3(

		.a(s1[6]),
		.b(s2[2]),
		.cin(s3[2]),

		.s(s3_RCA),
		.cout(c3_RCA)
	    );


Exact_FA EF4(

		.a(s1[7]),
		.b(s2[3]),
		.cin(s3[3]),

		.s(s4_RCA),
		.cout(c4_RCA)
	    );


Exact_FA EF5(

		.a(s2[4]),
		.b(s3[4]),
		.cin(s4[0]),

		.s(s5_RCA),
		.cout(c5_RCA)
	    );


Exact_FA EF6(

		.a(s2[5]),
		.b(s3[5]),
		.cin(s4[1]),

		.s(s6_RCA),
		.cout(c6_RCA)
	    );


Exact_FA EF7(

		.a(s2[6]),
		.b(s3[6]),
		.cin(s4[2]),

		.s(s7_RCA),
		.cout(c7_RCA)
	    );


Exact_FA EF8(

		.a(s2[7]),
		.b(s3[7]),
		.cin(s4[3]),

		.s(s8_RCA),
		.cout(c8_RCA)
	    );

//********************************
// Final addition stage
//********************************

assign s[0] = s1[0];
assign s[1] = s1[1];
assign s[2] = s1[2];
assign s[3] = s1[3];
assign s[4] = s1_RCA;


Exact_HA EH1(

		.a(s2_RCA),
		.b(c1_RCA),

		.s(s[5]),
		.cout(c_HA1)
	    );

Exact_FA EF9(

		.a(s3_RCA),
		.b(c2_RCA),
		.cin(c_HA1),

		.s(s[6]),
		.cout(c_FA1)
	    );


Exact_FA EF10(

		.a(s4_RCA),
		.b(c3_RCA),
		.cin(c_FA1),

		.s(s[7]),
		.cout(c_FA2)
	    );

Exact_FA EF11(

		.a(s5_RCA),
		.b(c4_RCA),
		.cin(c_FA2),

		.s(s[8]),
		.cout(c_FA3)
	    );

Exact_FA EF12(

		.a(s6_RCA),
		.b(c5_RCA),
		.cin(c_FA3),

		.s(s[9]),
		.cout(c_FA4)
	    );

Exact_FA EF13(

		.a(s7_RCA),
		.b(c6_RCA),
		.cin(c_FA4),

		.s(s[10]),
		.cout(c_FA5)
	    );

Exact_FA EF14(

		.a(s8_RCA),
		.b(c7_RCA),
		.cin(c_FA5),

		.s(s[11]),
		.cout(c_FA6)
	    );

Exact_FA EF15(

		.a(s4[4]),
		.b(c8_RCA),
		.cin(c_FA6),

		.s(s[12]),
		.cout(c_FA7)
	    );

Exact_HA EH2(

		.a(s4[5]),
		.b(c_FA7),

		.s(s[13]),
		.cout(c_HA2)
	    );

Exact_HA EH3(

		.a(s4[6]),
		.b(c_HA2),

		.s(s[14]),
		.cout(c_HA3)
	    );

Exact_HA EH4(

		.a(s4[7]),
		.b(c_HA3),

		.s(s[15]),
		.cout()
	    );

endmodule
module Exact_FA(a,b,cin,s,cout);

input a;
input b;
input cin;

output s;
output cout;

wire var1;
wire var2;
wire var3;

xor u1(var1,a,b);
xor u2(s,var1,cin);

and u3(var2,var1,cin);
and u4(var3,a,b);

or u5(cout,var2,var3);

endmodule
module Exact_HA(a,b,s,cout);

input a;
input b;

output s;
output cout;


xor x1(s,a,b);

and a3(cout,a,b);


endmodule
module Oa_approx(c,d,s);

//******************************
// Inputs Declaration
//******************************

input [3:0]c;
input [3:0]d;

//******************************
// Ouputs Declaration
//******************************

output [7:0]s;

//******************************
// Wires Declaration
//******************************

wire [3:0]s1;
wire [3:0]s2;
wire [3:0]s3;
wire [3:0]s4;


wire s1_RCA;
wire s2_RCA;
wire s3_RCA;
wire s4_RCA;

wire c1_RCA;
wire c2_RCA;
wire c3_RCA;
wire c4_RCA;

wire c_HA1;

wire c_FA1;
wire c_FA2;
wire c_FA3;



//****************************************
// Least Significant Partial Product (PP1)
//****************************************

Mul2_b M1(
		.c(c[1:0]),
		.d(d[1:0]),

		.s(s1[3:0])
      );	


//****************************************
// Partial Product 2 (PP2)
//****************************************

Mul2_b A1(
		.c(c[3:2]),
		.d(d[1:0]),

		.s(s2[3:0])
      	   );	

//****************************************
// Partial Product 3 (PP3)
//****************************************

Mul2_b A2(
		.c(c[1:0]),
		.d(d[3:2]),

		.s(s3[3:0])
      	   );


//****************************************
// Partial Product 4 (PP4)
//****************************************
	
Mul2_b A3(
		.c(c[3:2]),
		.d(d[3:2]),

		.s(s4[3:0])
      	   );	


//****************************************
// Partial Product Reduction Stage 
//****************************************

Exact_FA EF1(

		.a(s1[2]),
		.b(s2[0]),
		.cin(s3[0]),

		.s(s1_RCA),
		.cout(c1_RCA)
	    );

Exact_FA EF2(

		.a(s1[3]),
		.b(s2[1]),
		.cin(s3[1]),

		.s(s2_RCA),
		.cout(c2_RCA)
	    );

Exact_FA EF3(

		.a(s2[2]),
		.b(s3[2]),
		.cin(s4[0]),

		.s(s3_RCA),
		.cout(c3_RCA)
	    );


Exact_FA EF4(

		.a(s2[3]),
		.b(s3[3]),
		.cin(s4[1]),

		.s(s4_RCA),
		.cout(c4_RCA)
	    );


//********************************
// Final addition stage
//********************************

assign s[0] = s1[0];
assign s[1] = s1[1];
assign s[2] = s1_RCA;



Exact_HA EH1(

		.a(s2_RCA),
		.b(c1_RCA),

		.s(s[3]),
		.cout(c_HA1)
	    );

Exact_FA EF9(

		.a(s3_RCA),
		.b(c2_RCA),
		.cin(c_HA1),

		.s(s[4]),
		.cout(c_FA1)
	    );


Exact_FA EF10(

		.a(s4_RCA),
		.b(c3_RCA),
		.cin(c_FA1),

		.s(s[5]),
		.cout(c_FA2)
	    );

Exact_FA EF11(

		.a(s4[2]),
		.b(c4_RCA),
		.cin(c_FA2),

		.s(s[6]),
		.cout(c_FA3)
	    );

Exact_HA EH4(

		.a(s4[3]),
		.b(c_FA3),

		.s(s[7]),
		.cout()
	    );

endmodule
module Oa_exact(c,d,s);

//******************************
// Inputs Declaration
//******************************

input [3:0]c;
input [3:0]d;

//******************************
// Ouputs Declaration
//******************************

output [7:0]s;

//******************************
// Wires Declaration
//******************************

wire [3:0]s1;
wire [3:0]s2;
wire [3:0]s3;
wire [3:0]s4;


wire s1_RCA;
wire s2_RCA;
wire s3_RCA;
wire s4_RCA;

wire c1_RCA;
wire c2_RCA;
wire c3_RCA;
wire c4_RCA;

wire c_HA1;

wire c_FA1;
wire c_FA2;
wire c_FA3;



//****************************************
// Least Significant Partial Product (PP1)
//****************************************

Exact_Mul2 M1(
		.c(c[1:0]),
		.d(d[1:0]),

		.s(s1[3:0])
      );	


//****************************************
// Partial Product 2 (PP2)
//****************************************

Exact_Mul2 A1(
		.c(c[3:2]),
		.d(d[1:0]),

		.s(s2[3:0])
      	   );	

//****************************************
// Partial Product 3 (PP3)
//****************************************

Exact_Mul2 A2(
		.c(c[1:0]),
		.d(d[3:2]),

		.s(s3[3:0])
      	   );


//****************************************
// Partial Product 4 (PP4)
//****************************************
	
Exact_Mul2 A3(
		.c(c[3:2]),
		.d(d[3:2]),

		.s(s4[3:0])
      	   );	


//****************************************
// Partial Product Reduction Stage 
//****************************************

Exact_FA EF1(

		.a(s1[2]),
		.b(s2[0]),
		.cin(s3[0]),

		.s(s1_RCA),
		.cout(c1_RCA)
	    );

Exact_FA EF2(

		.a(s1[3]),
		.b(s2[1]),
		.cin(s3[1]),

		.s(s2_RCA),
		.cout(c2_RCA)
	    );

Exact_FA EF3(

		.a(s2[2]),
		.b(s3[2]),
		.cin(s4[0]),

		.s(s3_RCA),
		.cout(c3_RCA)
	    );


Exact_FA EF4(

		.a(s2[3]),
		.b(s3[3]),
		.cin(s4[1]),

		.s(s4_RCA),
		.cout(c4_RCA)
	    );


//********************************
// Final addition stage
//********************************

assign s[0] = s1[0];
assign s[1] = s1[1];
assign s[2] = s1_RCA;



Exact_HA EH1(

		.a(s2_RCA),
		.b(c1_RCA),

		.s(s[3]),
		.cout(c_HA1)
	    );

Exact_FA EF9(

		.a(s3_RCA),
		.b(c2_RCA),
		.cin(c_HA1),

		.s(s[4]),
		.cout(c_FA1)
	    );


Exact_FA EF10(

		.a(s4_RCA),
		.b(c3_RCA),
		.cin(c_FA1),

		.s(s[5]),
		.cout(c_FA2)
	    );

Exact_FA EF11(

		.a(s4[2]),
		.b(c4_RCA),
		.cin(c_FA2),

		.s(s[6]),
		.cout(c_FA3)
	    );

Exact_HA EH4(

		.a(s4[3]),
		.b(c_FA3),

		.s(s[7]),
		.cout()
	    );

endmodule
module Ob_approx(c,d,s);

//******************************
// Inputs Declaration
//******************************

input [3:0]c;
input [3:0]d;

//******************************
// Ouputs Declaration
//******************************

output [7:0]s;

//******************************
// Wires Declaration
//******************************

wire [3:0]s1;
wire [3:0]s2;
wire [3:0]s3;
wire [3:0]s4;


wire s1_RCA;
wire s2_RCA;
wire s3_RCA;
wire s4_RCA;

wire c1_RCA;
wire c2_RCA;
wire c3_RCA;
wire c4_RCA;

wire c_HA1;

wire c_FA1;
wire c_FA2;
wire c_FA3;



//****************************************
// Least Significant Partial Product (PP1)
//****************************************

Mul2_b M1(
		.c(c[1:0]),
		.d(d[1:0]),

		.s(s1[3:0])
      );	


//****************************************
// Partial Product 2 (PP2)
//****************************************

Mul2_b A1(
		.c(c[3:2]),
		.d(d[1:0]),

		.s(s2[3:0])
      	   );	

//****************************************
// Partial Product 3 (PP3)
//****************************************

Mul2_b A2(
		.c(c[1:0]),
		.d(d[3:2]),

		.s(s3[3:0])
      	   );


//****************************************
// Partial Product 4 (PP4)
//****************************************
	
Mul2_b A3(
		.c(c[3:2]),
		.d(d[3:2]),

		.s(s4[3:0])
      	   );	


//****************************************
// Partial Product Reduction Stage 
//****************************************

Exact_FA EF1(

		.a(s1[2]),
		.b(s2[0]),
		.cin(s3[0]),

		.s(s1_RCA),
		.cout(c1_RCA)
	    );

Exact_FA EF2(

		.a(s1[3]),
		.b(s2[1]),
		.cin(s3[1]),

		.s(s2_RCA),
		.cout(c2_RCA)
	    );

Exact_FA EF3(

		.a(s2[2]),
		.b(s3[2]),
		.cin(s4[0]),

		.s(s3_RCA),
		.cout(c3_RCA)
	    );


Exact_FA EF4(

		.a(s2[3]),
		.b(s3[3]),
		.cin(s4[1]),

		.s(s4_RCA),
		.cout(c4_RCA)
	    );


//********************************
// Final addition stage
//********************************

assign s[0] = s1[0];
assign s[1] = s1[1];
assign s[2] = s1_RCA;



Exact_HA EH1(

		.a(s2_RCA),
		.b(c1_RCA),

		.s(s[3]),
		.cout(c_HA1)
	    );

Exact_FA EF9(

		.a(s3_RCA),
		.b(c2_RCA),
		.cin(c_HA1),

		.s(s[4]),
		.cout(c_FA1)
	    );


Exact_FA EF10(

		.a(s4_RCA),
		.b(c3_RCA),
		.cin(c_FA1),

		.s(s[5]),
		.cout(c_FA2)
	    );

Exact_FA EF11(

		.a(s4[2]),
		.b(c4_RCA),
		.cin(c_FA2),

		.s(s[6]),
		.cout(c_FA3)
	    );

Exact_HA EH4(

		.a(s4[3]),
		.b(c_FA3),

		.s(s[7]),
		.cout()
	    );

endmodule
module Ob_exact(c,d,s);

//******************************
// Inputs Declaration
//******************************

input [3:0]c;
input [3:0]d;

//******************************
// Ouputs Declaration
//******************************

output [7:0]s;

//******************************
// Wires Declaration
//******************************

wire [3:0]s1;
wire [3:0]s2;
wire [3:0]s3;
wire [3:0]s4;


wire s1_RCA;
wire s2_RCA;
wire s3_RCA;
wire s4_RCA;

wire c1_RCA;
wire c2_RCA;
wire c3_RCA;
wire c4_RCA;

wire c_HA1;

wire c_FA1;
wire c_FA2;
wire c_FA3;



//****************************************
// Least Significant Partial Product (PP1)
//****************************************

Exact_Mul2 M1(
		.c(c[1:0]),
		.d(d[1:0]),

		.s(s1[3:0])
      );	


//****************************************
// Partial Product 2 (PP2)
//****************************************

Exact_Mul2 A1(
		.c(c[3:2]),
		.d(d[1:0]),

		.s(s2[3:0])
      	   );	

//****************************************
// Partial Product 3 (PP3)
//****************************************

Exact_Mul2 A2(
		.c(c[1:0]),
		.d(d[3:2]),

		.s(s3[3:0])
      	   );


//****************************************
// Partial Product 4 (PP4)
//****************************************
	
Exact_Mul2 A3(
		.c(c[3:2]),
		.d(d[3:2]),

		.s(s4[3:0])
      	   );	


//****************************************
// Partial Product Reduction Stage 
//****************************************

Exact_FA EF1(

		.a(s1[2]),
		.b(s2[0]),
		.cin(s3[0]),

		.s(s1_RCA),
		.cout(c1_RCA)
	    );

Exact_FA EF2(

		.a(s1[3]),
		.b(s2[1]),
		.cin(s3[1]),

		.s(s2_RCA),
		.cout(c2_RCA)
	    );

Exact_FA EF3(

		.a(s2[2]),
		.b(s3[2]),
		.cin(s4[0]),

		.s(s3_RCA),
		.cout(c3_RCA)
	    );


Exact_FA EF4(

		.a(s2[3]),
		.b(s3[3]),
		.cin(s4[1]),

		.s(s4_RCA),
		.cout(c4_RCA)
	    );


//********************************
// Final addition stage
//********************************

assign s[0] = s1[0];
assign s[1] = s1[1];
assign s[2] = s1_RCA;



Exact_HA EH1(

		.a(s2_RCA),
		.b(c1_RCA),

		.s(s[3]),
		.cout(c_HA1)
	    );

Exact_FA EF9(

		.a(s3_RCA),
		.b(c2_RCA),
		.cin(c_HA1),

		.s(s[4]),
		.cout(c_FA1)
	    );


Exact_FA EF10(

		.a(s4_RCA),
		.b(c3_RCA),
		.cin(c_FA1),

		.s(s[5]),
		.cout(c_FA2)
	    );

Exact_FA EF11(

		.a(s4[2]),
		.b(c4_RCA),
		.cin(c_FA2),

		.s(s[6]),
		.cout(c_FA3)
	    );

Exact_HA EH4(

		.a(s4[3]),
		.b(c_FA3),

		.s(s[7]),
		.cout()
	    );

endmodule
module Oc_approx(c,d,s);

//******************************
// Inputs Declaration
//******************************

input [3:0]c;
input [3:0]d;

//******************************
// Ouputs Declaration
//******************************

output [7:0]s;

//******************************
// Wires Declaration
//******************************

wire [3:0]s1;
wire [3:0]s2;
wire [3:0]s3;
wire [3:0]s4;


wire s1_RCA;
wire s2_RCA;
wire s3_RCA;
wire s4_RCA;

wire c1_RCA;
wire c2_RCA;
wire c3_RCA;
wire c4_RCA;

wire c_HA1;

wire c_FA1;
wire c_FA2;
wire c_FA3;



//****************************************
// Least Significant Partial Product (PP1)
//****************************************

Mul2_a M1(
		.c(c[1:0]),
		.d(d[1:0]),

		.s(s1[3:0])
      );	


//****************************************
// Partial Product 2 (PP2)
//****************************************

Mul2_a A1(
		.c(c[3:2]),
		.d(d[1:0]),

		.s(s2[3:0])
      	   );	

//****************************************
// Partial Product 3 (PP3)
//****************************************

Mul2_a A2(
		.c(c[1:0]),
		.d(d[3:2]),

		.s(s3[3:0])
      	   );


//****************************************
// Partial Product 4 (PP4)
//****************************************
	
Mul2_a A3(
		.c(c[3:2]),
		.d(d[3:2]),

		.s(s4[3:0])
      	   );	


//****************************************
// Partial Product Reduction Stage 
//****************************************

Exact_FA EF1(

		.a(s1[2]),
		.b(s2[0]),
		.cin(s3[0]),

		.s(s1_RCA),
		.cout(c1_RCA)
	    );

Exact_FA EF2(

		.a(s1[3]),
		.b(s2[1]),
		.cin(s3[1]),

		.s(s2_RCA),
		.cout(c2_RCA)
	    );

Exact_FA EF3(

		.a(s2[2]),
		.b(s3[2]),
		.cin(s4[0]),

		.s(s3_RCA),
		.cout(c3_RCA)
	    );


Exact_FA EF4(

		.a(s2[3]),
		.b(s3[3]),
		.cin(s4[1]),

		.s(s4_RCA),
		.cout(c4_RCA)
	    );


//********************************
// Final addition stage
//********************************

assign s[0] = s1[0];
assign s[1] = s1[1];
assign s[2] = s1_RCA;



Exact_HA EH1(

		.a(s2_RCA),
		.b(c1_RCA),

		.s(s[3]),
		.cout(c_HA1)
	    );

Exact_FA EF9(

		.a(s3_RCA),
		.b(c2_RCA),
		.cin(c_HA1),

		.s(s[4]),
		.cout(c_FA1)
	    );


Exact_FA EF10(

		.a(s4_RCA),
		.b(c3_RCA),
		.cin(c_FA1),

		.s(s[5]),
		.cout(c_FA2)
	    );

Exact_FA EF11(

		.a(s4[2]),
		.b(c4_RCA),
		.cin(c_FA2),

		.s(s[6]),
		.cout(c_FA3)
	    );

Exact_HA EH4(

		.a(s4[3]),
		.b(c_FA3),

		.s(s[7]),
		.cout()
	    );

endmodule
module Oc_exact(c,d,s);

//******************************
// Inputs Declaration
//******************************

input [3:0]c;
input [3:0]d;

//******************************
// Ouputs Declaration
//******************************

output [7:0]s;

//******************************
// Wires Declaration
//******************************

wire [3:0]s1;
wire [3:0]s2;
wire [3:0]s3;
wire [3:0]s4;


wire s1_RCA;
wire s2_RCA;
wire s3_RCA;
wire s4_RCA;

wire c1_RCA;
wire c2_RCA;
wire c3_RCA;
wire c4_RCA;

wire c_HA1;

wire c_FA1;
wire c_FA2;
wire c_FA3;



//****************************************
// Least Significant Partial Product (PP1)
//****************************************

Exact_Mul2 M1(
		.c(c[1:0]),
		.d(d[1:0]),

		.s(s1[3:0])
      );	


//****************************************
// Partial Product 2 (PP2)
//****************************************

Exact_Mul2 A1(
		.c(c[3:2]),
		.d(d[1:0]),

		.s(s2[3:0])
      	   );	

//****************************************
// Partial Product 3 (PP3)
//****************************************

Exact_Mul2 A2(
		.c(c[1:0]),
		.d(d[3:2]),

		.s(s3[3:0])
      	   );


//****************************************
// Partial Product 4 (PP4)
//****************************************
	
Exact_Mul2 A3(
		.c(c[3:2]),
		.d(d[3:2]),

		.s(s4[3:0])
      	   );	


//****************************************
// Partial Product Reduction Stage 
//****************************************

Exact_FA EF1(

		.a(s1[2]),
		.b(s2[0]),
		.cin(s3[0]),

		.s(s1_RCA),
		.cout(c1_RCA)
	    );

Exact_FA EF2(

		.a(s1[3]),
		.b(s2[1]),
		.cin(s3[1]),

		.s(s2_RCA),
		.cout(c2_RCA)
	    );

Exact_FA EF3(

		.a(s2[2]),
		.b(s3[2]),
		.cin(s4[0]),

		.s(s3_RCA),
		.cout(c3_RCA)
	    );


Exact_FA EF4(

		.a(s2[3]),
		.b(s3[3]),
		.cin(s4[1]),

		.s(s4_RCA),
		.cout(c4_RCA)
	    );


//********************************
// Final addition stage
//********************************

assign s[0] = s1[0];
assign s[1] = s1[1];
assign s[2] = s1_RCA;



Exact_HA EH1(

		.a(s2_RCA),
		.b(c1_RCA),

		.s(s[3]),
		.cout(c_HA1)
	    );

Exact_FA EF9(

		.a(s3_RCA),
		.b(c2_RCA),
		.cin(c_HA1),

		.s(s[4]),
		.cout(c_FA1)
	    );


Exact_FA EF10(

		.a(s4_RCA),
		.b(c3_RCA),
		.cin(c_FA1),

		.s(s[5]),
		.cout(c_FA2)
	    );

Exact_FA EF11(

		.a(s4[2]),
		.b(c4_RCA),
		.cin(c_FA2),

		.s(s[6]),
		.cout(c_FA3)
	    );

Exact_HA EH4(

		.a(s4[3]),
		.b(c_FA3),

		.s(s[7]),
		.cout()
	    );

endmodule
module Od_exact(c,d,s);

//******************************
// Inputs Declaration
//******************************

input [3:0]c;
input [3:0]d;

//******************************
// Ouputs Declaration
//******************************

output [7:0]s;

//******************************
// Wires Declaration
//******************************

wire [3:0]s1;
wire [3:0]s2;
wire [3:0]s3;
wire [3:0]s4;


wire s1_RCA;
wire s2_RCA;
wire s3_RCA;
wire s4_RCA;

wire c1_RCA;
wire c2_RCA;
wire c3_RCA;
wire c4_RCA;

wire c_HA1;

wire c_FA1;
wire c_FA2;
wire c_FA3;



//****************************************
// Least Significant Partial Product (PP1)
//****************************************

Exact_Mul2 M1(
		.c(c[1:0]),
		.d(d[1:0]),

		.s(s1[3:0])
      );	


//****************************************
// Partial Product 2 (PP2)
//****************************************

Exact_Mul2 A1(
		.c(c[3:2]),
		.d(d[1:0]),

		.s(s2[3:0])
      	   );	

//****************************************
// Partial Product 3 (PP3)
//****************************************

Exact_Mul2 A2(
		.c(c[1:0]),
		.d(d[3:2]),

		.s(s3[3:0])
      	   );


//****************************************
// Partial Product 4 (PP4)
//****************************************
	
Exact_Mul2 A3(
		.c(c[3:2]),
		.d(d[3:2]),

		.s(s4[3:0])
      	   );	


//****************************************
// Partial Product Reduction Stage 
//****************************************

Exact_FA EF1(

		.a(s1[2]),
		.b(s2[0]),
		.cin(s3[0]),

		.s(s1_RCA),
		.cout(c1_RCA)
	    );

Exact_FA EF2(

		.a(s1[3]),
		.b(s2[1]),
		.cin(s3[1]),

		.s(s2_RCA),
		.cout(c2_RCA)
	    );

Exact_FA EF3(

		.a(s2[2]),
		.b(s3[2]),
		.cin(s4[0]),

		.s(s3_RCA),
		.cout(c3_RCA)
	    );


Exact_FA EF4(

		.a(s2[3]),
		.b(s3[3]),
		.cin(s4[1]),

		.s(s4_RCA),
		.cout(c4_RCA)
	    );


//********************************
// Final addition stage
//********************************

assign s[0] = s1[0];
assign s[1] = s1[1];
assign s[2] = s1_RCA;



Exact_HA EH1(

		.a(s2_RCA),
		.b(c1_RCA),

		.s(s[3]),
		.cout(c_HA1)
	    );

Exact_FA EF9(

		.a(s3_RCA),
		.b(c2_RCA),
		.cin(c_HA1),

		.s(s[4]),
		.cout(c_FA1)
	    );


Exact_FA EF10(

		.a(s4_RCA),
		.b(c3_RCA),
		.cin(c_FA1),

		.s(s[5]),
		.cout(c_FA2)
	    );

Exact_FA EF11(

		.a(s4[2]),
		.b(c4_RCA),
		.cin(c_FA2),

		.s(s[6]),
		.cout(c_FA3)
	    );

Exact_HA EH4(

		.a(s4[3]),
		.b(c_FA3),

		.s(s[7]),
		.cout()
	    );

endmodule
module Exact_Mul2(c,d,s);

input [1:0]c;
input [1:0]d;

output [3:0]s;

wire num1;
wire num2;
wire num3;
wire num4;


//*********************************************
// s0 calculation
//*********************************************

and a1(s[0],c[0],d[0]);

//*********************************************
// s1 calculation
//*********************************************

and a2(num1,c[0],d[1]);
and a3(num2,c[1],d[0]);

xor x1(s[1],num1,num2);

//*********************************************
// s2 calculation
//*********************************************

and a4(num3,c[1],d[1]);
and a5(num4,num1,num2);

xor x2(s[2],num3,num4);

//*********************************************
// s3 calculation
//*********************************************

and a6(s[3],num3,num4);



endmodule
module Mul2_a(c,d,s);

input [1:0]c;
input [1:0]d;

output [3:0]s;

wire num1;
wire num2;



//*********************************************
// s0 calculation
//*********************************************

assign s[0] = c[0];

//*********************************************
// s1 calculation
//*********************************************

and a1(num1,c[0],d[1]);
and a2(num2,c[1],d[0]);

or o1(s[1],num1,num2);


//*********************************************
// s2 calculation
//*********************************************

and a3(s[2],c[1],d[1]);

//*********************************************
// s3 calculation
//*********************************************

assign s[3] = 0;



endmodule
module Mul2_b(c,d,s);

input [1:0]c;
input [1:0]d;

output [3:0]s;


//*********************************************
// s0 calculation
//*********************************************

and a1(s[0],c[0],d[0]);

//*********************************************
// s1 calculation
//*********************************************
assign s[1] = d[1];

//*********************************************
// s2 calculation
//*********************************************

and a2(s[2],c[1],d[1]);

//*********************************************
// s3 calculation
//*********************************************

assign s[3] = 0;



endmodule