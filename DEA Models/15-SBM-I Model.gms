$title A Input-Oriented Slack-based Measure(SBM) Model
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
   i "Inputs"   /i1 "Doctors",i2 "Nurses"/
   r "Outputs"  /o1 "Outpatient",o2 "Inpatient"/
   j "Units"    /DMU01*DMU12/;

Alias(j,l);

Table x(i,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
i1   20    19    25    27    22    55    33    31    30    50    53    38
i2  151   131   160   168   158    255  235    206   244   268   306   284;
Table y(r,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
o1  100   150   160  180    94    230   220   152   190   250   260   250
o2  90    50    55   72     66    90    88    80    100   100   147   120;

Variables
        w
        Lambda(j)
        s(i)     "Input excess";
      Positive Variables
                Lambda
                s;

Parameters
       xo(i) "Inputs of unit under evaluation"
       yo(r) "Outputs of unit under evaluation"
       m;
m=Card(i);

Equations
       Objective
       Const1(i)
       Const2(r);
Objective..  w=e=1-(1/m)*Sum(i,s(i)/xo(i));
Const1(i)..  Sum(j,x(i,j)*Lambda(j))+s(i)=e=xo(i);
Const2(r)..  Sum(j,y(r,j)*Lambda(j))=g=yo(r);

Model SBM_I_Model /All/;

File SBM_I /Results.txt/;

Puttl SBM_I 'Title ' System.title, @60 'Page ' System.page//;

Put SBM_I;

Put @21'Input-Excess'/;
Put @12'w', @20's(i1)', @29's(i2)', @36'Reference-set'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve SBM_I_Model Using NLP Minimizing w;

Put l.tl:6;
Put w.l:8:2;

Loop(i,Put s.l(i):9:2);
Loop(j,
     If(Lambda.l(j)>0,
        Put j.tl:>8);
);
Put/;

Display w.l,Lambda.l;
Display s.l,s.m;
);
