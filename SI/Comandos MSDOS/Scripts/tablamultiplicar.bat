@echo off
setlocal enabledelayedexpansion

rem 13:30 10/03/2021
rem Autor: DBN
rem Programa que muestra la tabla de multiplicar de un numero 
rem del 1 al 10.

rem -----------------------------
rem Lectura de datos

:lectdatos
echo.
set /P num="Escoge un numero del 1 al 10: "
echo.

rem -----------------------------
rem Manejo de errores

if %num% leq 0 (
	echo.
	echo Has introducido un numero menor que 1
	echo ERROR: Por favor, introduce un numero valido.
	pause > nul
	cls
	goto :lectdatos
) else (
	if %num% geq a (
		echo.
		echo Has introducido un caracter.
		echo ERROR: Por favor, introduce un numero valido.
		pause > nul
		cls
		goto :lectdatos
	) else (
		if %num% gtr 10 (
			echo.
			echo Has introducido un numero mayor que 10.
			echo ERROR: Por favor, introduce un numero valido.
			pause > nul
			cls
			goto :lectdatos
		)
	)
)

rem -----------------------------
rem Mostrar la tabla por pantalla

echo.
echo Tabla del %num%
echo ---------------

set resul=0
for /L %%i in (1, 1, 10) do (
	set /a resul=%num%*%%i
	echo %num% * %%i = !resul!
)

rem -----------------------------
rem Volver a calcular otra tabla o terminar

echo.
set /P opcion="Desea calcular la tabla de otro numero (s/n)?"

if "%opcion%"=="n" (
	goto :fin
) else (
	if "%opcion%"=="s" (
		cls
		goto :lectdatos
	) else (
		goto :fin
	)
)

rem -----------------------------
rem Fin del script

:fin
echo.
echo Gracias por usar el software: %0
endlocal
exit /B