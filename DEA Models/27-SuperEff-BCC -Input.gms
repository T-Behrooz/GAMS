$title A input-Oriented Super-efficiency Model
$ontext
Variable return to scale.
$offtext
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
   i "Inputs"   /i1 "Doctors",i2 "Nurses"/
   r "Outputs"  /o1 "Outpatients",o2 "Inpatients"/
   j "Units"    /DMU1*DMU6/
   k(j);

Alias (j,l);

Table x(i,j)
    DMU1 DMU2 DMU3 DMU4 DMU5 DMU6
i1   2    2    5    10   10  3.5
i2   12   8    5    4    6   6.5;
Table y(r,j)
    DMU1 DMU2 DMU3 DMU4 DMU5 DMU6
o1   4    3    2    2    1    1
o2   1    1    1    1    1    1;

Variables
      z
      Teta
      Lambda(j);
    Positive Variables
             Lambda;

Parameters
       xo(i)   "Inputs of under evaluation DMU"
       yo(r)   "Outputs of under evaluation DMU";

Equations
       Objective
       Const1
       Const2
       Const3;
Objective..   z=e=Teta;
Const1(i)..   Sum(j$k(j),x(i,j)*Lambda(j))=l=Teta*xo(i);
Const2(r)..   Sum(j$k(j),y(r,j)*Lambda(j))=g=yo(r);
Const3..      Sum(j$k(j),Lambda(j))=e=1;

Model Super_BCC_I_Model /All/;

File Super_BCC_I /Results.txt/;

Puttl Super_BCC_I 'Title ' System.title, @60 'Page ' System.page//;

Put Super_BCC_I ;

Put @12'Efficiency', @30'Reference-Set'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));
     Loop(j,
          k(j)=Yes;
          k(l)=No);

Solve Super_BCC_I_Model Using LP Minimizing z;

Put l.tl:6;

If(Super_BCC_I_Model.modelstat=4,
   Put @12 'Infeasible';
   Put/;
Else
   Put z.l;
Loop(j,
     If(Lambda.l(j)>0,
     Put j.tl:>11);
     );
Put/;
);
Option decimals=4;
Display z.l,Lambda.l;
);



