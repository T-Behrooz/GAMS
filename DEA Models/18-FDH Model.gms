$title A Free Disposal Hull (FDH) Model
$ontext
Deprins D., L. Simar and H. T ulkene (1984), "Measuring
Labor Efficiency in Post Offices," in M. Marchand, P.
Pestieau and H. Tulkene, eds. The Performance of
Public Enterprises: Concepts and Measurement (Amsterdam,
North Holland), pp.243-267
$offtext
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
   i "Inputs" /i1,i2/
   r  "Outputs"/o1,o2/
   j  "Decision making units"/DMU01*DMU12/;

Alias(j,l);

Table x(i,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
i1  20    19    25    27    22    55    33    31    30    50    53    38
i2  151   131   160   168   158   255   235   206   244   268   306   284;
Table y(r,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
o1  100   150   160   180   94    230   220   152   190   250   260   250
o2  90    50    55    72    66    90    88    80    100   100   147   120;

Variables
     z
     Teta
     Lambda(j)
    Binary Variable
              Lambda;

Parameters
       xo(i) "Inputs of unit under evaluation"
       yo(r) "Outputs of unit under evaluation";

Equations
       Objective
       Const1(i)
       Const2(r)
       Const3;
Objective..  z=e=Teta;
Const1(i)..  Sum(j,x(i,j)*Lambda(j))=l=z*xo(i);
Const2(r)..  Sum(j,y(r,j)*Lambda(j))=g=yo(r);
Const3..     Sum(j,Lambda(j))=e=1;

File Results /Results.txt/;

Model FDH_Model /All/;

Puttl Results 'Title ' System.title, @60 'Page '  System.page//;

Put Results;

Put @12'z', @18'Lambda'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve FDH_Model Using MIP Minimizing z;

Put l.tl:6;
Put z.l:8:2;
Loop(j,
     If(Lambda.l(j)>0,
        Put "   Lambda(", j.tl:5,")=", Lambda.l(j):1:0);
);
Put/;

Display z.l,Lambda.l;
);
