$title A Multiplier BCC Model(A)
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
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
   i "Inputs"   /i1 "Doctors",i2 "Nurses"/
   r "Outputs"  /o1 "Outpatients",o2 "Inpatients"/
   j "Units"    /DMU01*DMU12/;

Parameters
       xo(i)   "Inputs of under evaluation DMU"
          /i1 20
           i2 151/
       yo(r)   "Outputs of under evaluation DMU"
          /o1 100
           o2  90/;

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
i1 20    19    25    27    22    55    33    31    30    50    53    38
i2 151   131   160   168   158   255   235   206   244   268   306   284;
Table y(r,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
O1 100   150   160   180   94    230   220   152   190   250   260   250
O2 90    50    55    72    66    90    88    80    100   100   147   120;

Equations
        Objective
        Const1
        Const2(j);
Objective..  z=e=Sum(r,yo(r)*u(r))-uo;
Const1..     Sum(i,xo(i)*v(i))=e=1 ;
Const2(j)..  Sum(r,y(r,j)*u(r))-Sum(i,x(i,j)*v(i))-uo=l=0;

Model Multiplier_BCC /All/;

Solve Multiplier_BCC Using LP Maxzimizing z;

File BCC_Model /Results.txt/;

Puttl BCC_Model 'Title ' System.title, @60 'Page ' System.page;

Put BCC_Model;

Put #2,'Efficiency=', z.l:5//;
Put 'Input weights'/;
Loop(i, Put @3 'v(' i.tl,@7')=', v.l(i):6:3/);
Put /;
Put  'Output weights'/;
Loop(r, Put @3 'u('r.tl,@7')=', u.l(r):6:3/);
Put /;
Put 'variable return to scale'/;
Put @3 'uo=' uo.l:6;

Option decimals=4;
Display z.l;
Display v.l,u.l,uo.l;
Display v.m,u.m,uo.m;
