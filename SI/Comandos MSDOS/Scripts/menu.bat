@echo off

rem 12:45 10/03/2021
rem Autor: DBN
rem Menu sin choice

rem -------------------------------------------------------
rem Mostrar el menu
set local
:menuini
cls
echo.
echo 1. Opcion A
echo 2. Opcion B
echo 3. Opcion C
echo 4. Salir
echo.

set /P opcion="Escoja una opcion: "

rem -------------------------------------------------------
rem Control de errores

if "%opcion%"=="" (
	echo.
	echo Por favor, introduce un numero valido.
	goto :menuini
)
if %opcion% gtr a (
	echo.
	echo Has introducido una cadena.
	echo Por favor, introduce un numero valido.
	goto :menuini
)
if %opcion% gtr 4 (
	echo.
	echo Por favor, introduce un numero valido.
	goto :menuini
)
if %opcion% leq 0 (
	echo.
	echo Por favor, introduce un numero valido.
	goto :menuini
)

rem -------------------------------------------------------
rem Manejo de opciones

if %opcion% equ 1 (
	goto :menu1
) else (
	if %opcion% equ 2 (
		goto :menu2
	) else (
		if %opcion% equ 3 (
			goto :menu3
		) else (
			if %opcion% equ 4 (
				cls
				goto :fin
			)
		)
	)
)

rem -------------------------------------------------------
rem Lo que se mostrará al seleccionar una opcion

:menu1
cls
echo.
echo Has escogido la opcion A.
echo.
pause > nul
goto :menuini

:menu2
cls
echo.
echo Has escogido la opcion B.
echo.
pause > nul
goto :menuini

:menu3
cls
echo.
echo Has escogido la opcion C.
echo.
pause > nul
goto :menuini

rem -------------------------------------------------------
rem Final del script

:fin
echo.
echo Gracias por usar el menu: %0
end local
exit /B