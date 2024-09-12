$title A Super Efficiency Input_Constant Model
$ontext
Input oriented Model, Multiplier Form, Constant return to scale.
Andersen, Per; Petersen, Niels Christian, A procedure for ranking
efficient units in data envelopment. Management Science; Oct 1993;
39, 10; ABI/INFORM Global, pg. 1261
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

Parameters
    xo(i) "Inputs of under evaluation DMU"
    yo(r) "Outputs of under evaluation DMU";


Table x(i,j)
    DMU1 DMU2 DMU3 DMU4 DMU5 DMU6
i1   2    2    5   10    10  3.5
i2   12   8    5   4     6   6.5;
Table y(r,j)
    DMU1 DMU2 DMU3 DMU4 DMU5 DMU6
o1   4    3    2    2    1    1
o2   1    1    1    1    1    1;

Variables
      z    "Efficiency"
      v(i) "Input weights"
      u(r) "Output weights";
    positive variables
            v
            u;

Equation
     Objective
     Const1
     Const2;
Objective..      z=e=Sum(r,u(r)*yo(r));
Const1(j)$k(j).. Sum(r,u(r)*y(r,j))-Sum(i,v(i)*x(i,j))=l=0;
Const2..         Sum(i,v(i)*xo(i))=e=1;

Model Super_CCR_I_Model /All/;

File  Super_CCR_I /Results.txt/;

Puttl Super_CCR_I 'Title ' System.title, @60 'Page ' System.page//;

Put Super_CCR_I;

Put @6'Efficiency', @19'Input-weights', @39'Output-weights'/;
Put @10'z', @19'v1', @29'v2', @39 'u1', @49'u2'/;
Loop(l,
     Loop(i,xo(i)=x(i,l));
     Loop(r,yo(r)=y(r,l));
     loop(j,
          k(j)=Yes;
          k(l)=No);
Solve Super_CCR_I_Model using LP Maximizing z ;

Put l.tl:6;
Put z.l:6;
Loop(i,Put v.l(i):10:3);
Loop(r,Put u.l(r):10:3);
Put/;
);
