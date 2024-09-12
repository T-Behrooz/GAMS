$title A discretionary and non-discretionary inputs Model
$ontext
Envelopment Form
$offtext
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
   i     "Inputs" /i1,i2/
   r     "Outputs"/o1,o2/
   j     "Decision making units"/DMU01*DMU12/
   d(i)  "Discretionary inputs"  /i1/
   nd(i) "non-discretionary inputs" /i2/;

Alias(j,l);

Table x(i,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
i1  20    19    25    27    22    55    33    31    30    50    53    38
i2  151   131   160   168   158   255   235   206   244   268   306   284;

Table y(r,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
o1  100   150   160   180   94    230   220   152   190   250   260   250
o2  90     50    55   72    66    90    88    80    100   100   147   120;

Variables
        z
        Teta
        Lambda(j)
        s(i)
        t(r)
      Positive Variables
                Lambda
                s
                t;

Parameters
       xo(i)   "Inputs of unit under evaluation"
       yo(r)   "Outputs of unit under evaluation";

Scalar Epsilon /0.005/;

Equations
       Objective
       Const1(i)
       Const2(i)
       Const3(r);
Objective..        z=e=Teta-(Epsilon*(Sum(i$d(i),s(i))+Sum(r,t(r))));
Const1(i)$d(i)..   Sum(j,x(i,j)*Lambda(j))+s(i)=e=Teta*xo(i);
Const2(i)$nd(i)..  Sum(j,x(i,j)*Lambda(j))+s(i)=e=xo(i);
Const3(r)..        Sum(j,y(r,j)*Lambda(j))-t(r)=e=yo(r);

File Results /Results.txt/;

Model e_Model /All/;

Puttl Results 'Title ' System.title, @60 'Page ' System.page;

Put Results;

Put @12'z', @20'Lambda'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve e_Model Using MIP Minimizing z;

Put l.tl:6;
Put z.l:8:2;
Loop(j,
     If(Lambda.l(j)>0,
        Put "   Lambda(", j.tl:5,")=", Lambda.l(j):4);
     );
Put/;

Display z.l,Lambda.l;
);
