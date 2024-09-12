sets
i 'inputs' /i1*i3/
r 'outputs' /o1*o5/
j 'dmus' /j1*j1867/;

Parameter
    x(j,i)  'Inputs'
    y(j,r)  'Outputs';
* Reading data from the Excel file
$CALL GDXXRW.EXE C:\Users\DATA\Desktop\Gams-Bank\data1.xlsx par=x rng=input!A1:D1867 rdim=1 cdim=1
$GDXIN data1.gdx
$load x
$GDXIN


$CALL GDXXRW.EXE C:\Users\DATA\Desktop\Gams-Bank\data1.xlsx par=y rng=output!A1:F1866 rdim=1 cdim=1
$GDXIN data1.gdx
$load y
$GDXIN


display y,x;

execute_unload "data1.gdx" x y 
execute 'gdxxrw.exe  data1.gdx o=C:\Users\DATA\Desktop\Gams-Bank\data1.xlsx par=x.l rng=Ixput1!A1:D1867'
execute 'gdxxrw.exe  data1.gdx o=C:\Users\DATA\Desktop\Gams-Bank\data1.xlsx par=y.l rng=Oxput2!A1:F1867'


