$title A Additive Model
$ontext
Variable-return-to-scale Additive model
$offtext
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
i1  20    19    25    27    22    55    33    31    30    50    53    38
i2  151   131   160   168   158   255   235   206   244   268   306   284;
Table y(r,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
o1  100   150   160   180   94    230   220   152   190   250   260   250
o2  90    50    55    72    66    90    88    80    100   100   147   120;

Variables
       zp
       zd
       s(i)
       t(r)
       v(i)
       u(r)
       Lambda(j)
       uo;
     Positive Variables
                Lambda
                s
                t
                u
                v;

Parameters
       xo(i)   "Inputs of unit under evaluation"
       yo(r)   "Outputs of unit under evaluation"
       xp(i)   "Inputs of projection point"
       yp(r)   "Output of projection point";

Equations
       PObjective  "Primal Objective"
       Const1(i)
       Const2(r)
       DObjective  "Dual Objective"
       Const3
       Const4(j)
       Const5(i)
       Const6(r);
PObjective..   zp=e=Sum(i,s(i))+Sum(r,t(r));
Const1(i)..    Sum(j,x(i,j)*Lambda(j))+s(i)=e=xo(i);
Const2(r)..    Sum(j,y(r,j)*Lambda(j))-t(r)=e=yo(r);
Const3..       Sum(j,Lambda(j))=e=1;
DObjective..   zd=e=Sum(i,v(i)*xo(i))-Sum(r,yo(r)*u(r))+uo;
Const4(j)..    Sum(i,x(i,j)*v(i))-Sum(r,y(r,j)*u(r))+uo=g=0;
Const5(i)..    v(i)=g=1;
Const6(r)..    u(r)=g=1;

Models P_Additive_Model /PObjective,Const1,Const2,Const3/
       D_Additive_Model /DObjective,Const4,Const5,Const6/;

File Additive /Results.txt/;

Puttl Additive 'Title ' System.title, @60 'Page ' System.page//;

Put Additive;

Put 'Primal Additive model'/;
Put @20'Input-Excess', @36'Output-Shortfall' /;
Put @12'zp', @19's(i1)', @28's(i2)', @37't(o1)', @46't(o2)', @54'Reference-Set'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve P_Additive_Model Using LP Maxmizing zp;

Put l.tl:6;
Put zp.l:8:2;
Loop(i,Put s.l(i):9:2);
Loop(r,Put t.l(r):9:2);
Loop(j,
     If(Lambda.l(j)>0,
     Put j.tl:>8);
);
Put/;
);
Put//;
Put 'Dual Additive model'/;
Put @21'Input-weights', @40'Output-weights', @56'variable-return-to-scale'/;
Put @12'zd', @19'v(i1)', @29'v(i2)', @39'u(o1)', @49'u(o2)', @59'uo'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve D_Additive_Model Using LP Minimizing zd;

Put l.tl:6;
Put zd.l:8;
Loop(i,Put v.l(i):10:4);
Loop(r,Put u.l(r):10:4);
Put uo.l:10:4;
Put /;
);

put/;
Put 'Projection points'/;
Put @13'Inputs', @28'Outputs'/;
Put @10'x(i1)', @18'x(i2)', @26'y(o1)', @34'y(o2)'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Put l.tl:6;
Solve P_Additive_Model Using LP Maxmizing zp;

xp(i)=xo(i)-s.l(i);
yp(r)=yo(r)+t.l(r);

Loop(i,Put xp(i):8);
Loop(r,Put yp(r):8);
Put/;

Option decimals=4;
Display zp.l,zd.l;
Display s.l,t.l;
Display s.m,t.m;
Display v.l,u.l,uo.l;
Display v.m,u.m,uo.m;
);


