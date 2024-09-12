$title A Cost Model
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
   i "Inputs"   /i1,i2/
   r "Outputs"  /o1/
   j "Units"    /DMU1*DMU3/;

Alias (j,l);

Table x(i,j)
    DMU1 DMU2 DMU3
i1   3   1     4
i2   2   3     6;
Table y(r,j)
    DMU1 DMU2 DMU3
o1    3   5     6;

Parameters
         c(i) /i1  4
               i2  2/
         yo(r) "Outputs under evaluation DMU"
         xo(i) "Inputs under evaluation DMU"
         ec    "Cost efficiency";

Variables
      s(i)
      w
      Lambda(j);
    Positive Variable
            Lambda;

Equations
       Objective
       Const1(i)
       Const2(r);
Objective..   w=e=Sum(i,c(i)*s(i));
Const1(i)..   Sum(j,x(i,j)*Lambda(j))=l=s(i);
Const2(r)..   Sum(j,y(r,j)*Lambda(j))=g=yo(r);

Model Cost_Model /All/;

File Cost /Results.txt/ ;

Puttl Cost 'Title ' System.title, @60 'Page ' System.page//;

Put Cost;

Put @11's(i1)', @19's(i2)', @29'w', @35'Cost-efficiency'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve Cost_Model Using LP Minimizing w;

ec=(w.l)/(Sum(i,c(i)*xo(i)));

Put l.tl:6;

Loop(i,Put s.l(i):8);
Put  w.l:8;
Put  ec:12:3;
put /;

Option decimals = 4;
Display w.l,ec;
);


