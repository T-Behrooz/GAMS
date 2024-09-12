$title A Envelopment BCC Model
$ontext
Input oriented Model
$offtext
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
   i "Inputs"   /i1 "Doctors",i2 "Nurses"/
   r "Outputs"  /o1 "Outpatients",o2 "Inpatients"/
   j "Units"    /DMU01*DMU12/;

Alias (j,l);

Table x(i,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
i1  20    19    25    27     22    55    33    31    30    50    53    38
i2  151   131   160   168   158   255   235   206   244   268   306   284;
Table y(r,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
o1 100   150   160   180   94    230   220   152   190   250   260   250
o2 90   50    55    72    66    90    88    80    100   100   147   120;

Variables
      z
      Teta
      w
      Lambda(j)
      s(i)  "Input excess"
      t(r)  "Output shortfall";
    Positive Variables
             Lambda
             s
             t;

Parameters
       xo(i)  "Inputs of under evaluation DMU"
       yo(r)  "Outputs of under evaluation DMU"
       xp(i)  "Inputs of projection point"
       yp(r)  "Output of projection point";

Equations
          Objective1
          Objective2
          Const1(i)
          Const2(r)
          Const3
          Const4(i)
          Const5(r);
Objective1..  z=e=Teta;
Objective2..  w=e=Sum(i,s(i))+Sum(r,t(r));
Const1(i)..   Sum(j,x(i,j)*Lambda(j))=l=teta*xo(i);
Const2(r)..   Sum(j,y(r,j)*Lambda(j))=g=yo(r);
Const3..      Sum(j,Lambda(j))=e=1;
Const4(i)..   Sum(j,x(i,j)*Lambda(j))+s(i)=e=Teta.l*xo(i);
Const5(r)..   Sum(j,y(r,j)*Lambda(j))-t(r)=e=yo(r);

File BCC_Model/Results.txt/ ;

Models BCC_Phase1 /Objective1,Const1,Const2,Const3/
       BCC_Phase2 /Objective2,Const3,Const4,Const5/;

Puttl BCC_Model 'Title ' System.title, @60 'Page ' System.page//;

Put BCC_Model;

Put 'Envelopment BCC Model'/;
Put @6'Efficiency', @19'Input-Excess', @35'Output-Shortfall' /;
Put @10'z', @18's(i1)', @27's(i2)', @36't(o1)', @45't(o2)', @52'Reference-set'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve BCC_Phase1 Using LP Minimizing z;
Solve BCC_Phase2 Using LP Maximizing w;

Put l.tl:6;
Put z.l:6;
Loop(i,Put s.l(i):9);
Loop(r,Put t.l(r):9);
Loop(j,
     If(Lambda.l(j)>0,
     Put j.tl:>8);
);
Put/;
);
Put//;
Put 'Projection points'/;
Put @13'Inputs', @28'Outputs'/;
Put @10'x(i1)', @18'x(i2)', @26'y(o1)', @34'y(o2)'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Put l.tl:6;

Solve BCC_Phase1 Using LP Minimizing z;
Solve BCC_Phase2 Using LP Maximizing w;

xp(i)=z.l*xo(i)-s.l(i);
yp(r)=yo(r)+t.l(r);

Loop (i,Put xp(i):8);
Loop (r,Put yp(r):8);
Put/;

Option decimals=4;
Display z.l,w.l;
Display s.l,t.l;
Display s.m,t.m;
);


