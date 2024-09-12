$title CCR Model(Epsilon)
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
  i "Inputs"   /i1 "Doctors",i2 "Nurses"/
  r "Outputs"  /o1 "Outpatient",o2 "Inpatient"/
  j "Units"    /DMU01*DMU12/;

Alias (l,j);

Parameters
       xo(i)   "Inputs of under evaluation DMU"
       yo(r)   "Outputs of under evaluation DMU";

Table x(i,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
i1  20    19    25    27    22    55    33    31    30    50    53    38
i2  151   131   160   168   158   255   235   206   244   268   306   284;
Table y(r,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
o1  100   150   160   180   94    230   220   152   190   250   260   250
o2  90    50    55    72    66    90    88    80    100   100   147   120;

Variables
       v(i)  "Output weights"
       u(r)  "Input weights"
       z     "Efficiency"
       w
       epsilon;
    Positive Variables
                   v
                   u;

Equations
       Objective1
       Objective2
       Const1(j)
       Const2(j)
       Const3(r)
       Const4(i)
       Const5
       Const6(r)
       Const7(i);
Objective1.. w=e=epsilon;
Objective2.. z=e=Sum(r,yo(r)*u(r));
Const1(j)..  Sum(i,x(i,j)*v(i))=l=1;
Const2(j)..  Sum(r,y(r,j)*u(r))-Sum(i,x(i,j)*v(i))=l=0;
Const3(r)..  u(r)-epsilon=g=0;
Const4(i)..  v(i)-epsilon=g=0;
Const5..     Sum(i,xo(i)*v(i))=e=1;
Const6(r)..  u(r)=g=w.l;
Const7(i)..  v(i)=g=w.l;

Models e_Model /Objective1,Const1,Const2,Const3,Const4/
       CCR_Model /Objective2,Const2,Const5,Const6,Const7/;

File e_CCR_Model /Results.txt/;

Puttl e_CCR_Model 'Title ' System.title, @60 'Page ' System.page;

Put e_CCR_Model;

Solve e_Model Using LP Maximizing w;

Put #2 'Epsilon=' w.l:9:6//;

Put @20'Input-Weights', @44'Outputs-Weights'/;
Put @10'z', @19'v(i1)', @31'v(i2)', @43'u(o1)', @55'u(o2)'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve CCR_Model Using LP Maximizing z;

Put l.tl:6;

Put z.l:6;
Loop(i,Put v.l(i):12:4);
Loop(r,Put u.l(r):12:4);
Put /;

Option decimals=4;
Display w.l,z.l;
Display v.l,u.l;
Display v.m,u.m;
);







