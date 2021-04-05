@echo off

rem 13:55 08/03/2021
rem Autor: David Bernal Navarrete
rem -----------------------------
rem Este script recibe un numero, positivo y menor que 125
rem Segun el numero, se comprabara si pertenece a un rango
rem y dependiendo de a que rango pertenezca, se mostrara un
rem mensaje por pantalla.

rem -----------------------------------------------------------------
rem Comprobar que se ha introducido un unico y obligatorio argumento

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

rem -----------------------------------------------------------------
rem Comprobar que el argumento es un numero, positivo y menor que 125

if %1 leq 0 (
	rem Si el argumento es un numero negativo

	echo.
	echo ERROR: El argumento tiene que ser un numero positivo
	echo y menor que 125.
	goto :fin
)
if %1 gtr 125 (
	rem Si el argumento es positivo pero mayor que 125

	echo.
	echo ERROR: El argumento tiene que ser menor que 125.
	goto :fin
)
if %1 geq a (
	rem Si el argumento empieza por un caracter

	echo.
	echo ERROR: El argumento tiene que ser un numero, positivo
	echo y menor que 125.
	goto :fin
)

rem -----------------------------------------------------------------
rem Comprobar en que rango esta el argumento

if %1 lss 5 (
	rem El argumento esta en [0, 5)
	echo.
	echo Eres un bebe!
	goto :fin
) else (
	if %1 lss 16 (
		rem El argumento esta en [5, 16)
		echo.
		echo Tienes la edad del pavo.
		goto :fin
	) else (
		if %1 lss 18 (
			rem El argumento esta en [16, 18)
			echo.
			echo Eres un adolescente!
			goto :fin
		) else (
			if %1 lss 65 (
				rem El argumento esta en [18, 65)
				echo.
				echo Animo.
				echo.
				echo.
				echo.
				echo La vas a necesitar.
				goto :fin
			) else (
				if %1 lss 100 (
					rem El argumento esta en [65, 100)
					echo.
					echo De camino a las tres cifras.
					goto :fin
				) else (
					if %1 leq 124 (
						rem El argumento esta en [100, 124]
						echo.
						echo WOW, enhorabuena
						echo Achievement unlocked:
						echo Eres un enemigo de las arcas publicas
						goto :fin
					) else (
						if %1 equ 125 (
							rem El argumento es 125
							echo.
							echo Bienvenido al limite genetico para la edad humana.
							goto :fin
						)
					)
				)
			)
		)
	)
)

rem -----------------------------------------------------------------
rem Final del script

:fin
echo.
echo -------------------
echo Gracias por usar el software: %0
echo.
exit /b
