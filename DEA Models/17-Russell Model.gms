$title A Russell Model
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
   i "Inputs"   /i1 "Doctors",i2 "Nurses"/
   r "Outputs"  /o1 "Outpatients",o2 "Inpatients"/
   j "Units"    /DMU01*DMU12/;

Alias(j,l);

Table x(i,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
i1  20    19    25    27    22    55    33    31    30    50    53    38
i2  151   131   160   168   158   255   235   206   244   268   306   284;
Table y(r,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
o1  100   150   160   180    94    230   220   152   190   250   260   250
o2  90     50    55   72     66    90    88    80    100   100   147   120;

Variables
       z
       Teta(i)
       Phi(r)
       Lambda(j);
     Positive Variable
                Lambda;
Phi.lo(r)=0.2;

Parameters
       xo(i) "Inputs of unit under evaluation"
       yo(r) "Outputs of unit under evaluation"
       m
       s;
m=Card(i);
s=Card(r);

Equations
       Objective
       Const1(i)
       Const2(r)
       Const3(r)
       Const4(i)
       Const5(i);
Objective..  z=e=Sum(i,Teta(i)/m)/Sum(r,Phi(r)/s);
Const1(i)..  Sum(j,x(i,j)*Lambda(j))=l=Teta(i)*xo(i);
Const2(r)..  Sum(j,y(r,j)*Lambda(j))=g=Phi(r)*yo(r);
const3(r)..  Phi(r)=g=1;
const4(i)..  Teta(i)=l=1;
const5(i)..  Teta(i)=g=0;

Model Russell_Model /All/;

File Russell /Results.txt/;

Puttl Russell 'Title ' System.title, @60 'Page ' System.page;

Put Russell;

Put #2 @12'z', @18 'Teta(i1)', @28'Teta(i2)', @37'Phi(r1)', @46'Phi(r2)', @55'Reference-set'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve Russell_Model Using NLP Minimizing z;

Put l.tl:6;
Put z.l:8;

Loop(i,Put Teta.l(i):9);
Loop(r,Put Phi.l(r):9);
Loop(j,
     If(Lambda.l(j)>0,
        Put j.tl:>9);
);
Put/;

Display z.l,Lambda.l;
);
