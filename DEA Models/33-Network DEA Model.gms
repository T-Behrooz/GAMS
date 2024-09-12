$title A Network DEA Model
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
  i "Iputs"    /i1/
  r "Outputs"  /o1/
  j "Units"    /DMU1*DMU3/
  d            /d1/;

Alias (l,j);

Parameters
       xo(i)   "Inputs of under evaluation DMU"
       yo(r)   "Outputs of under evaluation DMU"
       zo(d)
       e1      "Efficiency of sub process1"
       e2      "Efficiency of sub process2";

Scalar Epsilon /0.005/;

Table x(i,j)
    DMU1 DMU2 DMU3
i1   2    4    5;
Table z(d,j)
    DMU1 DMU2 DMU3
d1  1.5   4    4;
Table y(r,j)
    DMU1 DMU2 DMU3
o1  1.5   5    6;

Variables
       v(i)  "Output weights"
       u(r)  "Input weights"
       w(d)
       e     "Efficiency";
     Positive Variables
                   v
                   u
                   w;

Equations
       Objective1
       Const1
       Const2(j)
       Const3(j)
       Const4(j)
       Const5(d)
       Const6(i)
       Const7(r);
Objective1..  e=e=Sum(r,yo(r)*u(r));
Const1..      Sum(i,xo(i)*v(i))=e=1 ;
Const2(j)..   Sum(r,y(r,j)*u(r))-Sum(i,x(i,j)*v(i))=l=0;
Const3(j)..   Sum(d,z(d,j)*w(d))-Sum(i,x(i,j)*v(i))=l=0;
Const4(j)..   Sum(r,y(r,j)*u(r))-Sum(d,z(d,j)*w(d))=l=0;
Const5(d)..   w(d)=g=Epsilon;
Const6(i)..   v(i)=g=Epsilon;
Const7(r)..   u(r)=g=Epsilon;

Model Network_DEA_Model /All/;

File Network /Results.txt/;

Puttl Network 'Title ' System.title, @60 'Page' System.page//;

Put Network ;

Put @12'e', @19'v(i1)', @27'u(o1)', @35'w(d1)', @44'e1', @52'e2'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));
     Loop(d,zo(d)=z(d,l));

Solve Network_DEA_Model Using LP Maximizing e;

Put l.tl:6;
Put e.l:8;
Loop(i,Put v.l(i):8);
Loop(r,Put u.l(r):8);
Loop(d,Put w.l(d):8);

e1=(w.l('d1')*zo('d1'))/(v.l('i1')*xo('i1'));
Put e1:8;

e2=(u.l('o1')*yo('o1'))/(w.l('d1')*zo('d1'));
Put e2:8;

Put /;

Option decimals=4;
Display e.l,e.m;
Display v.l,u.l;
Display v.m,u.m;
);
