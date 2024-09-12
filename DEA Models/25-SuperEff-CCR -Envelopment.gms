$title A Super Efficiency Input_Constant Model
$ontext
Input oriented Model, Envelopment Form, Constant return to scale.
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
    Positive Variable
             Lambda;

Parameters
       xo(i) "Inputs of under evaluation DMU"
       yo(r) "Outputs of under evaluation DMU";

Equations
          Objective
          Const1
          Const2;
Objective..   z=e=Teta;
Const1(i)..   Sum(j$k(j),x(i,j)*Lambda(j))=l=Teta*xo(i);
Const2(r)..   Sum(j$k(j),y(r,j)*Lambda(j))=g=yo(r);

Model  Super_CCR_I_Model /All/;

File Super_CCR_I /Results.txt/ ;

Puttl Super_CCR_I 'Title ' System.title, @60 'Page '  System.page//;

Put Super_CCR_I ;

Put @7'Efficiency', @19'Reference-Set'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));
     Loop(j,
          k(j)=Yes;
          k(l)=No);

Solve Super_CCR_I_Model Using LP Minimizing z;

Put l.tl:6;
Put z.l:6;
Loop(j,
     If(Lambda.l(j)>0,
        Put j.tl:>10);
     );
Put/;

Option decimals=4;
Display z.l, Lambda.l;
);


