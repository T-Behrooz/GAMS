set
i /i1*i2/
j /j1*j3/;

Parameter
    x(i,j)  'Inputs';

* Reading data from the Excel file
$CALL GDXXRW.EXE C:\Users\DATA\Desktop\Gams-Bank\data.xlsx par=x rng=a1:d3 rdim=1 cdim=1
$GDXIN data.gdx
$load x
$GDXIN

display x;

execute_unload "data.gdx" 
execute 'gdxxrw.exe  data.gdx o=C:\Users\DATA\Desktop\Gams-Bank\data.xlsx par=x.l rng=output!k1:n3'
