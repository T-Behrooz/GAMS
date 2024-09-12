$title A Return To Scale Model
$onsymxref
$onsymlist
$onuellist
$onuelxref
Sets
   i     "Inputs" /i1,i2/
   r     "Outputs"/o1,o2/
   j     "Decision making units"/DMU01*DMU12/
   k(j)
   p(j);

Alias(j,l);

Table x(i,j)
    DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
i1   20    19    25    27    22    55    33    31    30    50    53    38
i2  151   131   160   168   158    255  235    206   244   268   306   284;
Table y(r,j)
    DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
o1  100   150   160   180    94    230   220   152   190   250   260   250
o2  90     50    55   72     66    90    88    80    100   100   147   120;

Variables
       z
       Teta
       w
       Lambda(j)
       s(i)
       t(r)
       v(i)
       u(r)
       uo1
       uo2
       uo3
       q1
       q2;
      Positive Variables
                Lambda
                s
                t
                v
                u
                uo2;
      Negative Variable
                uo3;

Parameters
       xo(i)   "Inputs of unit under evaluation"
       yo(r)   "Outputs of unit under evaluation"
       xp(i)   "input of projection point"
       yp(r)   "output of projection point";

Equations
       Objective1
       Const1(i)
       Const2(r)
       Const3
       Objective2
       Const4(i)
       Const5(r)
       Const6
       Objective3
       Const7(j)
       Const8(j)
       Const9
       Const10
       Objective4
       Const11(j)
       Const12(j)
       Const13
       Const14;

Objective1..      z=e=Teta;
Const1(i) ..      Sum(j,x(i,j)*Lambda(j))=l=Teta*xo(i);
Const2(r)..       Sum(j,y(r,j)*Lambda(j))=g=yo(r);
Const3..          Sum(j,Lambda(j))=e=1;
Objective2 ..     w=e=Sum(i,s(i))+Sum(r,t(r));
Const4(i)..       Sum(j,x(i,j)*Lambda(j))+s(i)=e=z.l*xo(i);
Const5(r)..       Sum(j,y(r,j)*Lambda(j))-t(r)=e=yo(r);
Const6..          Sum(j,Lambda(j))=e=1;
Objective3..      q1=e=uo2;
Const7(j)$k(j)..  Sum(r,u(r)*y(r,j))-Sum(i,v(i)*x(i,j))-uo2=l=0;
Const8(j)$p(j)..  Sum(r,u(r)*yp(r))-Sum(i,v(i)*xp(i))-uo2=l=0;
Const9..          Sum(i,v(i)*xp(i))=e=1;
Const10..         Sum(r,u(r)*yp(r))-uo2=e=1;
Objective4..      q2=e=uo3;
Const11(j)$k(j).. Sum(r,u(r)*y(r,j))-Sum(i,v(i)*x(i,j))-uo3=l=0;
Const12(j)$p(j).. Sum(r,u(r)*yp(r))-Sum(i,v(i)*xp(i))-uo3=l=0;
Const13..         Sum(i,v(i)*xp(i))=e=1;
Const14..         Sum(r,u(r)*yp(r))-uo3=e=1;


Models BCC_Phase1 /Objective1,Const1,Const2,Const3/
       BCC_Phase2 /Objective2,Const4,Const5,Const6/
       IRTS /objective3,Const7,Const8,Const9,Const10/
       DRTS /objective4,Const11,Const12,Const13,Const14/;

File RTS_Model /Results.txt/;

Puttl RTS_Model 'Title ' System.title, @60 'Page '  System.page//;

Put RTS_Model;

Put 'Return To Scale:'//;
Put @10 '-uo1'/;
Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Put l.tl:6;
Solve BCC_Phase1 Using LP Minimizing z;
Solve BCC_Phase2 Using LP Maximizing w;

xp(i)=z.l*xo(i)-s.l(i);
yp(r)=yo(r)+t.l(r);

Put const3.m:8:3 ',';
If(const3.m<0,
   Loop(j,
        k(j)=Yes;
        k(l)=No);
   Loop(j,
        p(j)=No;
        p(l)=Yes);
   Solve IRTS Using LP Minimizing q1;
   Put '   uo2=', uo2.l:>8:3;
   If(uo2.l=0,
      Put @35"Constant return to scale"/;
   Elseif uo2.l>0,
      Put @35"Decreasing return to scale"/;
   );
Elseif const3.m>0,
    Loop(j,
         k(j)=Yes;
         k(l)=No);
    Loop(j,
         p(j)=No;
         p(l)=Yes);
    Solve DRTS Using LP Maximizing q2;
    Put '   uo3=', uo3.l:>8:3;
    If(uo3.l=0,
       Put @35, "Constant return to scale"/;
    Elseif uo3.l<0,
       Put @35, "Increasing return to scale"/;
    );
Else const3.m=0
    Put @35, "Constant return to scale"/);

Option decimals=4;
Display z.l,w.l;
Display Const3.m;
);

