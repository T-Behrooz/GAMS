$title A CCR Assurance Region Model
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
   i "Iputs"    /i1 "Doctors",i2 "Nurses"/
   r "Outputs"  /o1 "Outpatient",o2 "Inpatient"/
   j "Units"    /DMU01*DMU12/;

Alias(l,j);
Alias(i,ii);
Alias(r,rr);

Parameters
       xo(i) "Inputs of under evaluation DMU"
       yo(r) "Outputs of under evaluation DMU";

Table  x(i,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
i1  20    19    25    27    22    55    33    31    30    50    53    38
i2  151   131   160   168   158   255   235   206   244   268   306   284;
Table  y(r,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
o1  100   150   160   180   94    230   220   152   190   250   260   250
o2   90   50    55    72    66    90    88    80    100   100   147   120;
Table  p(i,ii)
    i1    i2
i1  0.2   -1
i2  -1    1;
Table  q(r,rr)
    o1    o2
o1  2    -5
o2  -1    1;

Variables
       v(i)  "Output weights"
       u(r)  "Input weights"
       z     "Efficiency";
     Positive Variables
                   v
                   u;

Equations
       Objective
       Const1
       Const2(j)
       Const3(ii)
       Const4(rr);
Objective..   z=e=Sum(r,yo(r)*u(r));
Const1..      Sum(i,xo(i)*v(i))=e=1 ;
Const2(j)..   Sum(r,y(r,j)*u(r))-Sum(i,x(i,j)*v(i))=l=0;
Const3(ii)..  Sum(i,v(i)*p(i,ii))=l=0;
Const4(rr)..  Sum(r,u(r)*q(r,rr))=l=0;

Model CCR_AR_Model /All/;

File CCR_AR /Results.txt/;

Puttl CCR_AR  'Title ' System.title, @60'Page ' System.page//;

Put CCR_AR;

Put @7'Efficiency', @21'Input-weights', @40'Output-weights'/;
Put @12'z', @20'v(i1)', @30'v(i2)', @40'u(o1)', @50'u(o2)'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve CCR_AR_Model Using LP Maximizing z;

Put l.tl:6;
Put z.l:8;
Loop(i,Put v.l(i):10:3);
Loop(r,Put u.l(r):10:3);
Put /;

Option decimals=4;
Display z.l,z.m;
Display v.l,u.l;
Display v.m,u.m;
);
