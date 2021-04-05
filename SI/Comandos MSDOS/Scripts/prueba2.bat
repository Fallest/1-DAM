@echo off

rem Se va a comprobar que no tiene argumentos
rem 13:59 08/03/2021
rem Autor: David Bernal Navarrete

if not "%1"=="" (
	echo.
	echo Error: se han detectado argumentos.
	echo Procediendo a la eliminacion de los argumentos:
	echo -----------------------------------------------
	set x=1

	:bucle
	if not "%1"=="" (
		shift /1
		echo Argumento %x%: %1 --------- eliminado
		echo.
		set /A x=x+1
		goto :bucle
	)
) else (
	echo.
	echo Llamada al script correcta.
	echo.
	echo Ejecutando...
	goto :fin
)

:fin
echo Fin del programa.
echo Saliendo...
echo.
exit /b