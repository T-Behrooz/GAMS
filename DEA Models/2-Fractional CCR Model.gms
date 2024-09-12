$title A Fractional CCR model
$ontext
This fractional programming problem finds input weights and
output weights as maximize objective function value.
The optimal value of objective function is at most 1 because
of the constraints of the model.
Charnes, A., Cooper, W.W., Rhodes, E.L., 1978. Measuring the
efficiency of decision making units. European Journal of
Operational Research 2, 429–444.
$offtext
$onsymxref
$onsymlist
$onuellist
$onuelxref

Sets
   i "Inputs"   /i1 "Doctors",i2 "Nurses"/
   r "Outputs"  /o1 "Outpatients",o2 "Inpatients"/
   j "Units"    /DMU01*DMU12/;

Scalar Epsilon  "non-archimedian value"  /0.005/;

Parameters
* Let DMU1 be under evaluation

       xo(i)   "Inputs of under evaluation DMU"
          /i1  20
           i2  151/
       yo(r)   "Outputs of under evaluation DMU"
          /o1  100
           o2  90/;

Table x(i,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
i1  20    19    25    27    22    55    33    31    30    50    53    38
i2  151   131   160   168   158   255   235   206   244   268   306   284;
Table y(r,j)
   DMU01 DMU02 DMU03 DMU04 DMU05 DMU06 DMU07 DMU08 DMU09 DMU10 DMU11 DMU12
o1 100   150   160   180   94    230   220   152   190   250   260   250
o2  90   50    55    72    66    90    88    80    100   100   147   120;

Variables
       v(i)  "Output weights"
       u(r)  "Input weights"
       z     "Efficiency";
     Positive Variables
                     v
                     u;
v.lo(i)=Epsilon;
u.lo(r)=Epsilon;

Equations
        Objective
        Const(j);
Objective.. z=e=(Sum(r,u(r)*yo(r)))/Sum(i,v(i)*xo(i));
Const(j)..  Sum(r,u(r)*y(r,j))/Sum(i,v(i)*x(i,j))=l=1;

Model FractionalCCR_Model /All/;

Solve FractionalCCR_Model Using NLP Maximizing z;

File CCR_Model /Results.txt/;

Puttl CCR_Model 'Title ' System.title, @60 'Page ' System.page;

Put CCR_Model;

Put #2 'Efficiency= ', z.l:5//;
Put 'Input weights'/;
Loop(i,Put @3 'v(' i.tl,@7 ')=', v.l(i):8:4/);
Put /'Output weights'/;
Loop(r,Put @3 'u(' r.tl,@7 ')=' u.l(r):8:4/);

Option decimals=4;
Display z.l;
Display v.l,u.l;
Display v.m,u.m;
