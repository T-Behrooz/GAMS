$title A Fractional BCC Model
$ontext
This fractional programming problem finds input weights and
output weights as maximize objective function value.
The optimal value of objective function is at most 1 because
of the constraints of the model. This model is built on the
assumption of variable return to scale.
Banker RD, Charnes A, Cooper WW. Some models for estimating
technical and scale inefficiencies in data envelopment analysis.
Management Science 1984; 30(9):1078-92.
$offtext
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
   i "Inputs"   /i1 "Doctors",i2 "Nurses"/
   r "Outputs"  /o1 "Outpatients",o2 "Inpatients"/
   j "Units"    /DMU01*DMU12/;

Alias (j,l);

Scalar Epsilon  "non-archimedian value" /0.005/;

Parameters
       xo(i) "Inputs of under evaluation DMU"
       yo(r) "Outputs of under evaluation DMU";

Table  x(i,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
i1  20    19    25    27    22    55    33    31    30    50    53    38
i2  151   131   160   168   158   255   235   206   244   268   306   284;
Table y(r,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
o1  100   150   160   180   94    230   220   152   190   250   260   250
o2  90    50    55    72    66    90    88    80    100   100   147   120;

Variables
       v(i)  "Output weights"
       u(r)  "Input weights"
       z     "Efficiency"
       uo    "Variable return to scale";
     Positive Variables
                    v
                    u;
v.lo(i)=Epsilon;
u.lo(r)=Epsilon;

Equations
        Objective
        Const(j);
Objective..  z=e=(Sum(r,u(r)*yo(r))-uo)/(Sum(i,v(i)*xo(i)));
Const(j)..   (Sum(r,u(r)*y(r,j))-uo)/(Sum(i,v(i)*x(i,j)))=l=1;

Model Fractional_BCC_Model /All/;

File BCC_Model/Results.txt/;

Puttl BCC_Model 'Title ' System.title,@60 'Page ' System.page;

Put BCC_Model;

Put #2 @7'Efficiency', @20'Input-weights', @40'Output-weights',
    @58 'variable-return-to-scale'/;
Put @12'z', @22'v1', @31'v2', @42'u1', @51'u2', @62'uo'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve Fractional_BCC_Model Using NLP Maximizing z;

Put l.tl:6;
Put z.l:8;
Loop(i,Put v.l(i):10:3);
Loop(r,Put u.l(r):10:3);
Put uo.l;
Put /;

Option decimals=4;
Display z.l;
Display v.l,u.l,uo.l;
Display v.m,u.m,uo.l;
);
