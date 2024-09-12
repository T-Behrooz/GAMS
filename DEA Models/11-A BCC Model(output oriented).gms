$title A BCC Model(Output-oriented)
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
   i "Iputs"   /i1 "Doctors",i2 "Nurses"/
   r "Outputs"  /o1 "Outpatient",o2 "Inpatient"/
   j "Units"    /DMU01*DMU12/;

Alias (l,j);

Parameters
       xo(i)   "Inputs of under evaluation DMU"
       yo(r)   "Outputs of under evaluation DMU"
       xp(i)   "Inputs of projection point"
       yp(r)   "Output of projection point";

Table x(i,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
i1  20    19    25    27    22    55    33    31    30    50    53    38
i2  151   131   160   168   158   255   235   206   244   268   306   284;
Table y(r,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
o1 100   150   160   180   94    230   220   152   190   250   260   250
o2 90    50    55    72    66    90    88    80    100   100   147   120;

Variables
       v(i)  "Output weights"
       u(r)  "Input weights"
       vo    "Variable return to scale"
       z1    "Primal Efficiency"
       z2    "Dual Efficiency"
       Phi
       w
       Mu(j)
       s(i)  "Input excess"
       t(r)  "Output shortfall";
    Positive Variables
             v
             u
             Mu
             s
             t;

Equations
       Objective1
       Const1
       Const2(j)
       Objective2
       Objective3
       Const3(i)
       Const4(r)
       Const5
       Const6(i)
       Const7(r);
Objective1..  z1=e=Sum(i,xo(i)*v(i))-vo;
Const1..      Sum(r,yo(r)*u(r))=e=1 ;
Const2(j)..   Sum(i,x(i,j)*v(i))-Sum(r,y(r,j)*u(r))-vo=g=0;
Objective2..  z2=e=Phi;
Objective3..  w=e=Sum(i,s(i))+Sum(r,t(r));
Const3(i)..   Sum(j,x(i,j)*Mu(j))=l=xo(i);
Const4(r)..   Sum(j,y(r,j)*Mu(j))=g=Phi*yo(r);
Const5..      Sum(j,Mu(j))=e=1;
Const6(i)..   Sum(j,x(i,j)*Mu(j))+s(i)=e=xo(i);
Const7(r)..   Sum(j,y(r,j)*Mu(j))-t(r)=e=z2.l*yo(r);

Models Multiplier_BCC /Objective1,Const1,Const2/
       BCC_Phase1 /Objective2,Const3,Const4,Const5/
       BCC_Phase2 /Objective3,Const5,Const6,Const7/;

File BCC_Model /Results.txt/;

Puttl BCC_Model 'Title ' System.title, @60 'Page ' System.page//;

Put BCC_Model;

Put 'Multiplier BCC Model'/;
Put @7'Efficiency', @21'Input-weights', @40'Output-weights',
    @56 "variable-return-to-scale"/;
Put @12'z1', @20'v(i1)', @30'v(i2)', @40'u(o1)', @50'u(o2)', @62'vo'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve Multiplier_BCC Using LP Minimizing z1;

Put l.tl:6;
Put z1.l:8;
Loop(i,Put v.l(i):10:3);
Loop(r,Put u.l(r):10:3);
Put vo.l:10:3;
Put /;

Option decimals=4;
Display z1.l;
Display v.l,u.l,vo.l;
Display v.m,u.m,vo.m;
);

Put //;
Put 'Envelopment BCC Model'/;
Put @6'Efficiency',@19'Input-Excess', @35'Output-Shortfall'/;
Put @10'w', @18's(i1)', @27's(i2)', @36't(o1)', @45't(o2)', @52'Reference-set'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve BCC_Phase1 Using LP Maximizing z2;
Solve BCC_Phase2 Using LP Maximizing w;

Put l.tl:6;
Put z2.l:6;
Loop(i,Put s.l(i):9);
Loop(r,Put t.l(r):9);
Loop(j,
     If (Mu.l(j)>0,
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
Solve BCC_Phase1 Using LP Maximizing z2;
Solve BCC_Phase2 Using LP Maximizing w;

xp(i)=xo(i)-s.l(i);
yp(r)=z2.l*yo(r)+t.l(r);

Loop(i,Put xp(i):8);
Loop(r,Put yp(r):8);
Put/;

Option decimals=4;
Display z2.l,w.l;
Display s.l,t.l;
Display s.m,t.m;
);














