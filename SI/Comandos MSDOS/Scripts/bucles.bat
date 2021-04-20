@echo off
setlocal
setlocal enabledelayedexpansion

rem 8:37 19/03/2021 Autor: DBN
rem Script de ejemplos de bucles

set /P nom="Introduzca el nombre de la serie: "
set /P temp="Introduzca la cantidad de temporadas de la serie: "
set /P epi="Introduzca el numero de capitulos por temporada: "

echo %nom%
md "%nom%"
echo --------------
for /L %%i in (1, 1, %temp%) do (
	echo -Temporada %%i
	md "%nom%\Temporada0%%i"
	for /L %%j in (1, 1, %epi%) do (
		echo ----Capitulo %%j
		md "%nom%\Temporada0%%i\Capitulo0%%j"
	)
	echo -------
	echo.
)

:fin
echo.
echo Gracias por usar el script %0
echo.
endlocal
exit /b