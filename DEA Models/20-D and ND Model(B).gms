$title A discretionary and non-discretionary inputs Model
$ontext
Multiplier Form
$offtext
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
   i     "Inputs"   /i1,i2/
   r     "Outputs"  /o1,o2/
   j     "Decision making units" /DMU01*DMU12/
   d(i)  "Discretionary inputs"  /i1/
   nd(i) "non-discretionary inputs" /i2/;

Alias(j,l);

Parameters
       xo(i) "Inputs of under evaluation DMU"
          /i1 20
           i2 151/
       yo(r) "Outputs of under evaluation DMU"
          /o1 100
           o2  90/;

Scalar Epsilon /0.005/;

Table x(i,j)
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
       z     "Efficiency";

Equation
       Objective
       Const1
       Const2(j)
       Const3(i)
       Const4(i)
       Const5(r);
Objective..        z=e=Sum(r,yo(r)*u(r))-Sum(i$nd(i),xo(i)*v(i));
Const1..           Sum(i$d(i),xo(i)*v(i))=e=1 ;
Const2(j)..        Sum(r,y(r,j)*u(r))-Sum(i$nd(i),x(i,j)*v(i))-Sum(i$d(i),x(i,j)*v(i))=l=0;
Const3(i)$d(i)..   v(i)=g=Epsilon;
Const4(i)$nd(i)..  v(i)=g=0;
Const5(r)..        u(r)=g=Epsilon;

Model m_Model /All/;

File Results /Result.dat/;

Puttl Results 'Title ' System.title, @60 'Page ' System.page;

Put Results;

Put @7'Efficiency', @25'Input-weights', @48'Output-weights'/;
Put @12'z', @24'v1', @36 'v2', @48'u1', @60'u2'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve m_Model Using LP Maximizing z;

Put l.tl:6;
Put z.l:8;
Loop(i,Put v.l(i));
Loop(r,Put u.l(r));
Put /;

Option decimals=4;
Display z.l;
Display v.l,u.l;
Display v.m,u.m;
);
