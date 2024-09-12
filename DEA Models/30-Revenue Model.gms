$title A Revenue Model
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
i1   3    1    4
i2   2    3    6 ;
Table y(r,j)
    DMU1 DMU2 DMU3
o1    3    5    6;

Parameters
         p(r) /o1  6/
         yo(r)   "Outputs under evaluation DMU"
         xo(i)   "Inputs under evaluation DMU"
         er      "Revenue efficiency";

Variables
      t(r)
      w
      Lambda(j);
    Positive Variable
             Lambda;

Equations
          Objective
          Const1(i)
          Const2(r);
Objective..   w=e=Sum(r,p(r)*t(r));
Const1(i)..   Sum(j,x(i,j)*Lambda(j))=l=xo(i);
Const2(r)..   Sum(j,y(r,j)*Lambda(j))=g=t(r);

Model Revenue_Model /All/;

File Revenue /Results.txt/;

Puttl Revenue 'Title ' System.title, @60 'Page ' System.page//;

Put Revenue;

Put @11't(o1)', @21'w', @26'Revenue-efficiency'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve Revenue_Model Using LP Maximizing w;

er=(Sum(r,p(r)*yo(r)))/(w.l);

Put l.tl:6;

Loop(r,Put t.l(r):8);
Put w.l:8;
Put er:12:3;
put /;

Option decimals=4;
Display w.l,er;
);


