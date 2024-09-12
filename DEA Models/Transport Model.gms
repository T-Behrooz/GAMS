$Title A Transportation Problem
$onsymxref
$onsymlist

Sets
   i  'canning plants' /Zanjan, Tehran/
   j  'markets'        /Ghazvin, Hamedan, Arak/;

Parameters
       a(i)  'capacity of plant i in cases'
             /Zanjan     400
              Tehran     650/
       b(j)  'demand at market j in cases'
            /Ghazvin    375
             Hamedan    300
             Arak       325/;

Table d(i,j)  'distance in hundred kilometers'
         Ghazvin     Hamedan       Arak
Zanjan    3.29         1.60        5.05
Tehran    3.37         1.60        2.39;

Scalar f 'freight in toman per case per hundred kilometers' /25/;

Parameter c(i,j)  'transport cost in hundred of toman per case';

          c(i,j) = f * d(i,j)/100;

Variables
       x(i,j)  'shipment quantities in cases'
       z       'total transportation costs in hundred of toman';
     Positive Variable
                     x;

Equations
       Cost        'define objective function'
       Supply(i)   'observe supply limit at plant i'
       Demand(j)   'satisfy demand at market j';
Cost..        z=e=Sum((i,j),c(i,j)*x(i,j));
Supply(i)..   Sum(j,x(i,j))=l=a(i);
Demand(j)..   Sum(i,x(i,j))=g=b(j);

Model transport /All/;

Solve Transport using LP Minimizing z;

Display z.l,x.l,x.m;