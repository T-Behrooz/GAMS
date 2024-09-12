$title A Profit Model
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
   i "Inputs"   /i1 ,i2/
   r "Outputs"  /o1/
   j "Units"    /DMU1*DMU3/;

Alias (j,l);

Table x(i,j)
    DMU1 DMU2 DMU3
i1   3    1     4
i2   2    3     6 ;
Table y(r,j)
    DMU1 DMU2 DMU3
o1    3   5    6;

Parameters
         c(i) /i1  4
               i2  2/
         p(r) /o1  6/
         yo(r)   "Outputs under evaluation DMU"
         xo(i)   "Inputs under evaluation DMU"
         ep      "Profit efficiency";

Variables
      t(r)
      s(i)
      w
      Lambda(j);
    Positive Variable
             Lambda;

Equations
       Objective
       Const1(i)
       Const2(r)
       Const3(i)
       Const4(r);
Objective..   w=e=Sum(r,p(r)*t(r))-Sum(i,c(i)*s(i));
Const1(i)..   Sum(j,x(i,j)*Lambda(j))=l=xo(i);
Const2(r)..   Sum(j,y(r,j)*Lambda(j))=g=yo(r);
Const3(i)..   s(i)=e=Sum(j,x(i,j)*Lambda(j));
Const4(r)..   t(r)=e=Sum(j,y(r,j)*Lambda(j));

Model Profit_Model /All/;

File Profit /Results.txt/ ;

Puttl Profit 'Title ' System.title, @60 'Page ' System.page//;

Put Profit;

Put @12'w', @20'Profit-efficiency'/;

Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));

Solve Profit_Model Using LP Maximizing w;

ep=(Sum(r,p(r)*yo(r))-Sum(i,c(i)*xo(i)))/(Sum(r,p(r)*t.l(r))-Sum(i,c(i)*s.l(i)));

Put l.tl:6;
Put w.l:8;
Put ep:16:3;

Put /;

Option decimals=4;
Display w.l,ep;
);


