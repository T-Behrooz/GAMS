$title A Multiplier CCR Model(A)
$ontext
This Linear programming problem finds input weights and
output weights as maximize objective function value.
The optimal value of objective function is at most 1
because of the constraints of the model.
Charnes, A., Cooper, W.W., 1962. Programming with linear
fractional functionals. Naval Research Logistics Quarterly
9, 67–88.
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
* Let DMU01 be under evaluation
       xo(i) "Inputs of under evaluation DMU"
          /i1  20
           i2  151/
       yo(r) "Outputs of under evaluation DMU"
          /o1  100
           o2   90/;

Table x(i,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
i1  20    19    25    27    22    55    33    31    30    50    53    38
i2  151   131   160   168   158   255   235   206   244   268   306   284;
Table y(r,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
o1 100   150   160   180   94    230   220   152   190   250   260   250
o2  90   50    55    72    66    90    88    80    100   100   147   120;

Variables
       v(i)  "Input weights"
       u(r)  "Output weights"
       z     "Efficiency";
     Positive Variables
                    v
                    u;
Equations
       Objective
       Const1
       Const2(j);
Objective..  z=e=Sum(r,yo(r)*u(r));
Const1..     Sum(i,xo(i)*v(i))=e=1;
Const2(j)..  Sum(r,y(r,j)*u(r))-Sum(i,x(i,j)*v(i))=l=0;

Model MultiplierCCR_Model /All/;

Solve MultiplierCCR_Model Using LP Maximizing z;

File CCR_Model /Results.txt/;

Puttl CCR_Model 'Title ' System.title, @60 'Page ' System.page;

Put CCR_Model ;

Put #2 'Efficiency= ', z.l:4//;
Put 'Input weights'/;
Loop(i,Put @3 'v(' i.tl,@7')=', v.l(i):5/);
Put /'Output weights'/;
Loop(r,put @3 'u('r.tl,@7')=', u.l(r):5/);

Option decimals=4;
Display z.l;
Display v.l,u.l;
Display v.m,u.m;