$title A Multiplier BCC Model(B)
$ontext
This Linear programming problem finds input weights and
output weights as maximize objective function value.The
optimal value of objective function is at most 1 because
of the constraints of the model. This model is built on
the assumption of variable return to scale.
Banker RD, Charnes A, Cooper WW. Some models for estimating
technical and scale inefficiencies in data envelopment
analysis. Management Science 1984; 30(9):1078-92.
$offtext
$offlisting
$onlisting
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
   i "Inputs"   /i1 "Doctors",i2 "Nurses"/
   r "Outputs"  /o1 "Outpatients",o2 "Inpatients"/
   j "Units"    /DMU01*DMU12/;

Alias (l,j);

Parameters
        xo(i)  "Inputs of under evaluation DMU"
        yo(r)  "Outputs of under evaluation DMU"

Variables
        z    "Efficiency"
        v(i) "Input weights"
        u(r) "Output weights"
        uo   "variable return to scale";
     Positive variables
                    v
                    u;

Table x(i,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
i1  20    19    25    27    22    55    33    31    30    50    53    38
i2 151   131   160   168   158   255   235   206   244   268   306   284;
Table y(r,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
O1  100   150   160   180   94    230   220   152   190   250   260   250
O2  90    50    55    72    66    90    88    80    100   100   147   120;

Equations
        Objective
        Const1
        Const2(j);
Objective..  z=e=Sum(r,yo(r)*u(r))-uo;
Const1..     Sum(i,xo(i)*v(i))=e=1 ;
Const2(j)..  Sum(r,y(r,j)*u(r))-Sum(i,x(i,j)*v(i))-uo=l=0;

Model Multiplier_BCC /All/;

File BCC_Model /Results.txt/;

Puttl BCC_Model 'Title ' System.title, @60 'Page ' System.page//;

Put BCC_Model;

Put @7'Efficiency', @21'Input-weights', @40'Output-weights',
    @56 'variable-return-to-scale'/;
Put @12'z', @20'v(i1)', @30'v(i2)', @40'u(o1)', @50'u(o2)', @62'uo'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve Multiplier_BCC Using LP Maximizing z;

Put l.tl:6;
Put z.l:8;
Loop(i,Put v.l(i):10:3);
Loop(r,Put u.l(r):10:3);
Put uo.l:10:3;
Put /;

Option decimals=4;
Display z.l;
Display v.l,u.l,uo.l;
Display v.m,u.m,uo.m;
);
