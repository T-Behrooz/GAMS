SET
      J      DMU    No.    / 1 * n/
      O    Output  No.    / O1 * Os/
      I      Input  No.      / I1 * Im/

ALIAS(J,L);

PARAMETERS
      XX(I), YY(O), EPSS;

TABLE Y(J,O)
$include "OUT.TXT"

TABLE X(J,I)
$include "IN.TXT"

FREE VARIABLE
      Z, TETA ;

POSITIVE VARIABLE
      LAN(J), SI(I), SO(O) ;

FILE  EFCCR/EFFCCR/;
FILE  EFBCC/EFFBCC/;
FILE  EFCCRBCC/EFFCCRBCC/;
FILE  EFBCCCCR/EFFBCCCCR/;

EQUATIONS
      OBJ, CON1, CON2, CON3, CON4, CON5;

OBJ..                Z =E= TETA - EPSS*(SUM(O, SO(O)) + SUM(I, SI(I)));
CON1(I)..        SUM(J, LAN(J)*X(J,I)) + SI(I) =E= TETA * XX(I);
CON2(O)..       SUM(J, LAN(J)*Y(J,O)) - SO(O) =E= YY(O);
CON3..             SUM(J, LAN(J)) =E= 1;
CON4..             SUM(J, LAN(J)) =L= 1;
CON5..             SUM(J, LAN(J)) =G= 1;

MODEL       CCR            / OBJ, CON1, CON2 /;
MODEL       BCC            / OBJ, CON1, CON2, CON3/;
MODEL       CCRBCC    / OBJ, CON1, CON2, CON4 /;
MODEL       BCCCCR    / OBJ, CON1, CON2, CON5 /;

EPSS = 0.000001;
********************CCR MODEL**********
LOOP(L,
      LOOP(O, YY(O) = Y(L,O));
      LOOP(I, XX(I) = X(L,I));

      SOLVE CCR USING LP MINIMIZING Z;

       PUT EFCCR;
       PUT L.TL:5:0;
       PUT $(CCR.MODELSTAT NE 1) "UN.":10:5'  ';
       PUT $(CCR.MODELSTAT EQ 1) TETA.L:10:5'  ';
       LOOP(O, PUT SO.L(O):10:5'  ');
       LOOP(I, PUT SI.L(I):10:5'  ');
       PUT /;
       );

 *******************BCC MODEL***********
LOOP(L,
      LOOP(O, YY(O) = Y(L,O));
      LOOP(I, XX(I) = X(L,I));

      SOLVE BCC USING LP MINIMIZING z;

       PUT EFBCC;
       PUT L.TL:5:0;
       PUT TETA.L:10:5'  ';
       LOOP(O, PUT SO.L(O):10:5'  ');
       LOOP(I, PUT SI.L(I):10:5'  ');
       PUT /;
       );

*******************CCRBCC MODEL******
LOOP(L,
      LOOP(O, YY(O) = Y(L,O));
      LOOP(I, XX(I) = X(L,I));

      SOLVE CCRBCC USING LP MINIMIZING z;

       PUT EFCCRBCC;
       PUT L.TL:5:0;
       PUT TETA.L:10:5'  ';
       LOOP(O, PUT SO.L(O):10:5'  ');
       LOOP(I, PUT SI.L(I):10:5'  ');
       PUT /;
       );

******************BCCCCR MODEL*******
LOOP(L,
      LOOP(O, YY(O) = Y(L,O));
      LOOP(I, XX(I) = X(L,I));

      SOLVE BCCCCR USING LP MINIMIZING z;

       PUT EFBCCCCR;
       PUT L.TL:5:0;
       PUT TETA.L:10:5'  ';
       LOOP(O, PUT SO.L(O):10:5'  ');
       LOOP(I, PUT SI.L(I):10:5'  ');
       PUT /;
       );
