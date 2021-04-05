@echo off
setlocal
setlocal enabledelayedexpansion

rem 13:57 10/03/2021
rem Autor: DBN
rem PRograma que lee un numero por argumento, y muestra en pantalla
rem una piramide que depende del numero del argumento.
rem Ejemplo: piramide_numeros.bat 4
rem 1
rem 22
rem 333
rem 4444

rem ----------------------------
rem Control de errores

if "%1"=="" (
	echo.
	echo ERROR: No se ha introducido ningun argumento.
	echo Por favor, use el script con un solo argumento numerico, del 1 al 9.
	goto :fin
) else (
	if not "%2"=="" (
		echo.
		echo ERROR: Ha introducido mas de un argumento.
		echo Por favor, use el script con un solo argumento numerico, del 1 al 9.
		goto :fin
	)
)

if %1 gtr a (
	echo.
	echo ERROR: Ha introducido una cadena.
	echo Por favor, use el script con un solo argumento numerico, del 1 al 9.
) else (
	if %1 lss 1 (
		echo.
		echo ERROR: Ha introducido un numero menor que 1.
		echo Por favor, use el script con un solo argumento numerico, del 1 al 9.
		goto :fin
	) else (
		if %1 gtr 9 (
			echo.
			echo ERROR: Ha introducido un numero mayor que 0.
			echo Por favor, use el script con un solo argumento numerico, del 1 al 9.
			goto :fin
		)
	)
)

rem ----------------------------
rem Mostrar la piramide por pantalla

:piramide
set cad=
for /L %%i in (1, 1, %1) do (
	for /L %%a in (1, 1, %%i) do (
		set cad=!cad! %%i
	)
	echo !cad!
	set cad=
)

rem ----------------------------
rem Final del script

:fin
echo.
echo Gracias por usar el software %0
endlocal
exit /B