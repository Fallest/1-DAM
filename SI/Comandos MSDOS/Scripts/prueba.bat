@echo off 

rem 12:46 08/03/2021
rem Autor: David Bernal Navarrete

:inicio
echo.
echo --------------------------------
echo.
echo Primer script
echo.
echo --------------------------------
echo.

rem Vamos a invocar argumentos para el script

shift /1
echo Argumento 1: %0
echo Argumento 2: %1
echo Argumento 3: %2
echo Argumento 4: %3
echo Argumento 5: %4
echo Pulse ENTER para continuar ...
pause > nul
cls

:error1
set /p x="Por favor, introduzca un numero positivo: "

if %x% leq 0 (
	echo.
	echo Ha introducido un numero negativo
	echo Error, introduce un numero positivo, por favor.
	pause & cls
	goto :error1
	)
) else (
	if %x% geq a (
		echo.
		echo Ha introducido una cadena de caracteres
		echo Error, introduce un numero positivo, por favor.
		pause & cls
		goto :error1
	)
	echo.
	echo Exito. Has introducido un numero bien. Enhorabuena!
	echo Variable: %x%
	echo.
	pause & cls
	goto :final
)
	

:final
echo Gracias por usar este script: %0
echo.

exit /b