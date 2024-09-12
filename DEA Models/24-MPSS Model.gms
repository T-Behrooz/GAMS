$title A Most Productive Scale Size Model
$ontext
R.D. Banker (1984), "Estimating Most Productive Scale Size Using Data
Envelopment Analysis," European Journal of Operational Reserch 17, pp.35-44
$offtext
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
i2  151   131  160   168   158    255  235    206   244   268   306   284;
Table y(r,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
o1  100   150   160   180    94    230   220   152   190   250   260   250
o2  90    50    55    72     66    90    88    80    100   100   147   120;

Variables
     z
     Alpha
     Beta
     Lambda(j);
   Positive Variables
                Alpha
                Beta
                Lambda;
Alpha.lo=0.005;

Parameters
       xo(i)  "Inputs of unit under evaluation"
       yo(r)  "Outputs of unit under evaluation";

Equations
       Objective
       Const1(i)
       Const2(r)
       Const3;
Objective..  z=e=Beta/Alpha;
Const1(i)..  Sum(j,x(i,j)*Lambda(j))=l=Alpha*xo(i);
Const2(r)..  Sum(j,y(r,j)*Lambda(j))=g=Beta*yo(r);
Const3..     Sum(j,Lambda(j))=e=1;

Model MPSS_Model /All/;

File MPSS /Results.txt/;

Puttl MPSS 'Title ' system.title, @60 'Page ' system.page//;

Put MPSS;

Put @10'z', @15'Result'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve MPSS_Model Using NLP Maximizing z;

Put l.tl:8;

Put z.l:<6;

z.l=round(z.l,2);

If(z.l=1,
   Put "MPSS";
);

Put/;

Display z.l,Lambda.l;
);
