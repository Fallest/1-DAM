@echo off
setlocal
setlocal enabledelayedexpansion

rem Alumno: David Bernal Navarrete
rem Grupo: 1

rem El siguiente script solo continuará con su funcionamiento si
rem se han introducido dos argumentos: la cadena david en %1 y la 
rem cadena de la fecha con formato aa-mm-dd, en %2, siendo igual a 
rem la fecha del sistema.
rem El resto del script mostrará un menú que tendrá tres opciones:
rem 1. Dada una ruta y una extensión, el número total de archivos
rem en esa ruta y con esa extensión.
rem 2. Dada una ruta, el número total de archivos ocultos en esa ruta.
rem 3. Salir del programa

rem -----------------------------------------------------
rem Comprobar que se han introducido los dos argumentos correctos

rem Crear una variable con la fecha del sistema formateada a aa-mm-dd
for /f "tokens=1,2,3 delims=/" %%i in ('date /T') do (
	set fechasys=%%i-%%j-%%k
)
set fechasys=%fechasys:~8,2%%fechasys:~2,3%-%fechasys:~0,2%

if "%1"=="" (
	echo Error: Faltan los dos argumentos.
	echo El script debe usarse con dos argumentos:
	echo El nombre del alumno en minusculas, sin tildes ni "enyes";
	echo y la fecha del sistema en formato aa-mm-dd.
	goto :fin
) else (
	if "%2"=="" (
		echo Error: Falta el segundo argumento.
		echo El script debe usarse con dos argumentos:
		echo El nombre del alumno en minusculas, sin tildes ni "enyes";
		echo y la fecha del sistema en formato aa-mm-dd.
		goto :fin
	) else (
		if not "%3"=="" (
			echo Error: Se han usado mas de dos argumentos.
			echo El script debe usarse con dos argumentos:
			echo El nombre del alumno en minusculas, sin tildes ni "enyes";
			echo y la fecha del sistema en formato aa-mm-dd.
			goto :fin
		) else (
			if not "%1"=="david" (
				echo Error: El primer argumento es incorrecto. Tiene que ser igual al nombre del alumno,
				echo en minusculas, y sin tildes ni "enyes".
				goto :fin
			) else (
				if not "%2"=="%fechasys%" (
					echo Error: El segundo argumento es incorrecto. Tiene que ser igual a la fecha del sistema,
					echo con formato aa-mm-dd.
					goto :fin
				)
			)
		)
	)
)

rem -----------------------------------------------------
rem Mostrar el menú por pantalla

:menu
cls
echo - - -
echo Menu:
echo.
echo 1. Numero total de archivos
echo 2. Numero total de archivos ocultos
echo 3. Salir
echo - - -

rem Pedir por variable la opción a seleccionar
set /P opcion="Introduzca la opcion: "

if "%opcion%" equ "1" (
	cls
	goto :opcion1
) else (
	if "%opcion%" equ "2" (
		cls
		goto :opcion2
	) else (
		if "%opcion%" equ "3" (
			cls
			goto :fin
		) else (
			echo Error: Opcion incorrecta.
			goto :menu
		)
	)
)

rem -----------------------------------------------------
rem 1. Numero total archivos
:opcion1

echo.
echo - - -
set /P ruta_opc1="Ruta: "
set /P extension="Extension: "

if "%ruta_opc1%" lss "A" (
	echo Error: Ruta no valida.
	echo Se debe usar una ruta absoluta.
	pause
	goto :menu
) else (
	if "%extension%" lss "." (
		echo Error: Extension no valida.
		echo La extension debe darse con un '.'.
		pause
		goto :menu
	) else (
		if "%ruta_opc1:~0,1%%ruta_opc1:~-1,-1%" == "\"\"" (
			echo Error: No usar comillas en la ruta.
			pause
			goto :menu
		) else (
			goto :ejecopc1
		)
	)
)

:ejecopc1

rem Variable contador:
set contador_opc1=0

for /F "tokens=1" %%i in ('attrib "%ruta_opc1%\*%extension%" /S /D') do (
	set /A contador_opc1=!contador_opc1!+1
)

echo Numero total de archivos: %contador_opc1%
echo - - -
pause
goto :menu

rem -----------------------------------------------------
rem 2. Numero total archivos ocultos
:opcion2

echo.
echo - - -
set /P ruta_opc2="Ruta: "

if "%ruta_opc2%" lss "A" (
	echo Error: Ruta no valida.
	echo Se debe usar una ruta absoluta.
	pause
	goto :menu
) else (
	
	if "%ruta_opc2:~0,1%%ruta_opc2:~-1,-1%" == "\"\"" (
		echo Error: No usar comillas en la ruta.
		pause
		goto :menu
	) else (
		goto :ejecopc2
	)
)


:ejecopc2

rem Variable contador:
set contador_opc2=0

rem Utilizamos tokens=2 porque ahí aparecerá la H si está.
rem La H aparecerá si el archivo tiene el atributo de oculto.
rem Como estamos buscando archivos, todos van a tener la A.
for /F "tokens=2" %%i in ('attrib "%ruta%\*%extension%" /S /D') do (
	if "%%i" == "H" (
		set /A contador_opc2=!contador_opc2!+1
	)
)

echo Numero total de archivos ocultos: %contador_opc2%
echo - - -
pause
goto :menu


rem -----------------------------------------------------
rem 3. Salir

:fin
echo.
echo - - -
echo Gracias por usar nuestro script: %0
echo - - -
endlocal
exit /B