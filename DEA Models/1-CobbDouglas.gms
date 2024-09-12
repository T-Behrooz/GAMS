$title A Cobb-Douglas Model
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
   i "Inputs"  /i1,i2,i3/
   j "Units"   /DMU1*DMU5/;

Alias (j,l);

Table input(i,j)
    DMU1 DMU2 DMU3 DMU4 DMU5
i1   1    2     3    4    5
i2   6    8     3    7    4
i3   3    4     5    2    7;

Parameters
     output(j) /DMU1   12
                DMU2   10
                DMU3   15
                DMU4   16
                DMU5   11/
     y(j)
     x(i,j)
     a0
     v0  /1/
     k(j)
     Kmax
     e(j);
y(j)=log(output(j));
x(i,j)=log(input(i,j));
a0=log(v0);

Variables
      z
      v(i);

Equations
      Objective
      Const(j);
Objective.. z=e=Sum(j,Sum(i,x(i,j)*v(i))+a0-y(j));
Const(j)..  y(j)=l=a0+Sum(i,x(i,j)*v(i));

Model CobbDouglas_Model /All/;

Solve CobbDouglas_Model Using LP Minimizing z;

File CobbDouglas /Results.txt/;

Puttl CobbDouglas 'Title ' System.title, @60 'Page ' System.page//;

Put CobbDouglas;

Put 'Input weights'/;
Loop(i,Put 'v(' i.tl:2 ')= ' ,v.l(i):4/);
Put/;

Loop(j,
     k(j)=(Output(j)/v0*Prod(i,input(i,j)**v.l(i)));
);

Kmax=Smax(j,k(j));
Put 'Kmax=' Kmax:7//;

Put 'Efficiency'/;
Loop(j,
     e(j)=output(j)/v0*Prod(i,input(i,j)**v.l(i))/Kmax;
     Put 'e(' j.tl:4 ')= ' e(j):4/;
);

Put /;
Put 'Reaturn to scale= '
If(Sum(i,v.l(i))=1,
    Put 'Constant return to scale';
Elseif Sum(i,v.l(i))>1,
    Put 'Increasing return to scale';
Else
    Put 'Decreasing return to scale'
    );

Display z.l,v.l;
