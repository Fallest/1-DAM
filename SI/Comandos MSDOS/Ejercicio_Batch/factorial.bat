@echo on
setlocal enabledelayedexpansion
prompt $G
:intro_datos
rem Pedir un numero positivo y calcular su factorial
set /P x="Introduzca un numero positivo natural: "

rem Comprobar que el numero introducido es positivo
if %x% LEQ 0 (echo Ha ocurrido un error. Introduzca un numero positivo. && goto :intro_datos)

rem Calculo del factorial de x
set result=1
set cont=0

rem Bucle para hacer el factorial
:bucle
set /A resta=%x%-%cont%
if %cont% lss %x% (
	set /A resta=%x%-%cont%
	set /A result=%result%*%resta%
	set /A cont=%cont%+1
	goto :bucle
)

:fin
rem Mostrar por pantalla el factorial de x
echo El factorial de %x% es %result%
pause
exit /b