@echo off

rem 12:12 09/03/2021
rem Autor: David Bernal Navarrete
rem Va a mostrar por pantalla la longitud de una cadena
rem dada por argumento.

rem Mensaje de bienvenida
echo.
echo Bienvenido al software: %0
echo.
echo Se va a proceder al calculo de la longitud de la cadena:
echo %1
echo.

rem Comprobar que hay solo un argumento
if "%1"=="" (

	echo.
	echo ERROR: Forma incorrecta de invocar al script.
	echo Por favor, use el script con un argumento.
	goto :fin
) else (

	if not "%2"=="" (

		echo.
		echo ERROR: Forma incorrecta de invocar al script.
		echo Por favor, use el script con un argumento.
		goto :fin
	)
)


rem Calcular la longitud de la cadena

set cadena=%1
set long=0
set cont=1
set c=%cadena:~0,1%
:bucle
if not "%c%"=="" (
	set /a long=%long%+1
	call set c=%%cadena:~%cont%,1%%
	set /a cont=%cont%+1
	goto :bucle
)

rem Mostrar la longitud por pantalla
echo.
echo La longitud de la cadena: %1
echo es: %long%
:fin
exit /b
