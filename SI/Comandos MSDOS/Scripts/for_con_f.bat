@echo off
setlocal

rem Ejemplo de for /F

rem Con tokens=* se va a guardar toda la informacion de la linea de archivo.txt
for /F "tokens=1,2,3 delims=-" %%i in (archivo.txt) do (
	set var=%%i
	echo %var:~-2,2% %%j %%k
)

endlocal