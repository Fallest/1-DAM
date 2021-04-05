@echo off
setlocal

rem 8:25 19/03/2021
rem Autor: DBN
rem Se va a evaluar una variable para que no esté vacía


rem Vamos a evaluar una cadena
:introdatos
set x=
set /P x="Por favor, introduce una cadena: "

rem Primero, se evalua si tiene contenido
if "%x%"=="" (
	echo No se han introducido datos.
	pause > nul
	cls && goto :introdatos
) else (
	rem Luego se evalua si 
	if "%x%" lss "a" (
		echo No se ha introducido una cadena.
		pause > nul
		cls && goto :introdatos
	)
) else (
	echo Exito. Has introducido una cadena
	goto :fin
)

:fin
echo Gracias por usar el script %0
echo.
endlocal
exit /b