/* Casos practicos */
/* 1 */

select abs(salario-10000) from emple;
select ceil(18.4), ceil(0), ceil(-0.2), ceil(-14.5) from dual;
select floor(18.4), floor(0), floor(-0.2), floor(-14.5) from dual;
select mod(172535, 5), mod(35, -14), mod(-25, 3), mod(7.4, 3.1) from dual;
select salario, comision, salario + nvl(comision, 0) from emple;
select power(5, 4), power(-2, 5), power(2, -1), power(0.95, 20) from dual;
select round(4.78, 1), round(4.78), round(7.273617231, 2), round(9.998462, 3) from dual;
select round(13.762, -1), round(203, -2) from dual;
select sign(-82663120), sign(213123123) from dual;
select sqrt(36), sqrt(89.9) from dual;
select trunc(sqrt(89.9, 1)), trunc(143.23123123, 2), trunc(-765.23, -2) from dual;

/* 2 */

select avg(salario) from emple where dept_no = 10;
select count(*) from emple;
select count(comision) from emple;
select max(salario) from emple;
select max(apellido) from emple;
select apellido from emple where salario = (select max(salario) from emple);
select min(salario) from emple;
select apellido from emple where salario = (select min(salario) from emple);
select sum(salario) from emple;
select variance(salario) from emple;

/* 3 */

select count(oficio) from emple;
select count(distinct oficio) from emple;

/* 4 */

select nombre_alumno, greatest(nota1, nota2, nota3), least(nota1,nota2,nota3) from notas_alumnos;
select greatest('BENITO','JORGE','ANDRES','ISABEL') from dual;

/* 5 */

select chr(75), chr(65) from dual;

select concat('El apellido es: ', apellido) from emple;

select lower('oRACle Y sqL'), upper('oRACle Y sqL'), initcap('oRACle Y sqL') from dual;

select lpad(nombre_alumno, 30, '.'), rpad(nombre_alumno, 30, '.') from notas_alumnos;

select ltrim(' hola') || rtrim(' adios  ') || '*' from dual;

/* Lo que hace es quitar los espacios en blanco de la izq de la primera cadena,
luego quita los espacios en blanco de la derecha de la segunda cadena (por eso 
está separada en el resultado) y al final pone un asterisco. */

select rtrim(titulo, '."') from mistextos;
select ltrim(titulo, '"') from mistextos;

select replace('BLANCO Y NEGRO', 'O', 'AS') from dual;

select substr('ABCDEFG', 3, 2) "Col1", substr('ABCDEFG', -3, 2) "Col2", substr(4) "Col3" from dual;
select apellido, substr(apellido, 1, 1) from emple where dept_no = 10;

select translate('LOS PILARES DE LA TIERRA', 'AEIOU', 'aeiou') from dual;
select translate('LOS PILARES DE LA TIERRA', 'LAEIOU', 'l') from dual;
/* Este último comando quita las vocales y solo sustituye la L por l. Esto es
debido a que como no hay más caracteres en la cad3, los de la cad2 se sustituyen
por nada. */

/* 6 */

select ascii('A') from dual;
select instr('II VUELTA CICLISTA A TALAVERA', 'TA', 3, 2) from dual;
/* 
Esta instruccion busca la nª ocurrencia (en el cuarto argumento) a partir de
la nª posición (tercer argumento) de la cadena 'TA' (segundo argumento) en la cadena del primer argumento. 
Si el tercer argumento es negativo, se comienza a buscar desde el final, de 
derecha a izquierda.
Devuelve la posición del caracter que se busca. Si se buscan varios caracteres,
devuelve la posicion del primer caracter.
*/

select instr('II VUELTA CICLISTA A TALAVERA', 'A', -1) from dual;

select autor, instr(autor, 'A', 1, 2) from mistextos;

select titulo, length(titulo) "Longitud Titulo", autor, length(autor) "Longitud autor" from mistextos;

/* 7 */

select sysdate "Fecha del sistema" from dual;

selet fecta_alt, add_months(fecha_alt, 12) "Mas doce meses" from emple
where dept_no = 10;

select fecha_alt, last_day(fecha_alt) from emple where dept_no = 10;

select trunc(months_between(sysdate, '23/06/2001') / 12) "Edad" from dual;

select sysdate "Hoy", next_day(sysdate, 'JUEVES') "Prox. Jueves" from dual;

/* 8 */

select to_char(fecha_alt, 'month DD, YYYY') "Nueva fecha" from emple where dept_no = 10;
/*
Este comando formatea la fecha almacenada (en formato DD/MM/YYYY) a mes (nombre
completo), día (números) y año (números). Si se usa 'month' en minúscula el mes
aparecerá en minúscula, pero la máscara respetará las mayúsculas que uses. Por 
ejemplo, mOntH resultará en eNerO.
*/

select to_char(fecha_alta, 'mon ddd y yyy') "FECHA" from emple where dept_no = 10;

/* 9 */

alter session set nls_date_language = French;
/*
Con esto se puede cambiar el idioma que el sistema usará para los nombres de los
meses, el formato de las fechas, etc.
*/
select to_char(sysdate, '"Hoy es " day "," dd " de " month " de " yyyy') "fecha" from dual;

/* 10 */

select to_number('-123456') "NUMERO1", to_number('123,99','99D99') "NUMERO2" from dual;

/*
Para que una cadena sea válida para convertir, solo puede tener números, el signo
'-' o una ',' para los decimales. No puede haber espacios en blanco ni otros
caracteres. Por esto, el siguiente comando no convertirá:
*/
select to_number('123.456', '999G999') from dual;

alter session set nls_date_format='DD/MM/YYYY';

select to_date('01012006') from dual;

/*
En este caso no se ha dado formato, pero el sistema la convierte exitosamente. 
Esto es porque la cadena dada coincide con el formato del sistema. Si no
coincide, dará error.
*/

select to_char(to_date('01012007', 'ddmmyyyy'), 'Month') "Mes" from dual;
/*
Devuelve el mes de la fecha dada. Para ello la fecha, que viene en forma de
cadena, hay que convertirla en formato fecha, que se hace con el to_date().
Una vez tenemos la fecha formateada, se usa to_char(fecha, 'Month') para obtener
el Mes.
*/

/* 11 */

select apellido, oficio, decode(upper(oficio), 'PRESIDENTE', 1, 'EMPLEADO', 2, 5) "Codigo" from emple;
/*
decode() toma un valor, y comprueba si coincide con alguno de los parametros 
dados. Si coincide con uno, lo susituye por el parámetro que es contiguo al valor 
comparado. En este ejemplo, lee upper(oficio). Si es igual a 'PRESIDENTE', lo
sustituirá por 1. El último parámetro es el valor por defecto, que es el que se 
le asignará a todos los valores que no encajen en ninguno de los otros parámetros.
*/

select apellido, vsize(apellido) "N de Bytes" from emple where dept_no = 10;
/*
vsize() devuelve el numero de bytes que ocupa la expresión.
*/

select apellido, dump(apellido, 16, 1, 4) from emple where apellido like 'SALA';
/*
La función dump() toma una cadena (primer parametro), y convierte los carácteres 
del 1 al 4 (tercer y cuarto parametro) a hexadecimal (segundo parametro).
*/

select user, uid from dual;

show user;

/*-------------------------------------------------------------------*/
/* Actividades propuestas */
/* 1 */

/* 
ABS(146)= 146	ABS(-30)= 30	POWER(3,-1)= 0.333	ROUND(33.67)= 34
CEIL(2)= 2 	CEIL(1.3)= 2	ROUND(-33.67,2)= -33.67	ROUND(-33.67,-2)= 0
CEIL(-2.3)= -2	CEIL(-2)= -2	ROUND(-33.27,1)= -33.3	ROUND(-33.27,-1)= -30
FLOOR(-2)= -2	FLOOR(-2.3)= -3	TRUNC(67.232)= 67	TRUNC(67.232,-2)= 100
FLOOR(2)= 2	FLOOR(1.3)= 1	TRUNC(67.232,2)= 67.23	TRUNC(67.58,-1)= 70
MOD(22,23)= -1	MOD(10,3)= 1	TRUNC(67.58,1)= 67.5
POWER(10,0)= 1	POWER(3,2)= 9
*/

/* 2 */

select count(apellido) "Apellidos empezados por A" from emple
where apellido like 'A%';
select apellido from emple
where apellido like 'A%' and salario = (select max(salario) from emple
					where apellido like 'A%');

/*-------------------------------------------------------------------*/
/* Actividades complementarias */
/* 1 */

select to_char(round(avg(salario),2), '9G999D99') "Sueldo medio", 
count(comision) "Comisiones no nulas",
to_char(max(salario), '9G999D99') "Max Sueldo",
to_char(min(salario), '9G999D99') "Min Sueldo"
from emple
where dept_no = 30;

/* 2 */

select tema
from libreria
where instr(upper(tema), 'E') != 0
and ejemplares >= (select trunc(avg(L.ejemplares)) from libreria L);

/* 3 */

select rpad(rtrim(ltrim(upper(titulo), '"'), '."'), 38, '-^') "RESULTADO" from mistextos;

/* 4 */

select lower(ltrim(rtrim(titulo, '."'), '"')) "Titulo" from mistextos;
select lower(translate(titulo, 'A".', 'A')) "Titulo" from mistextos;

/* 5 */

select autor "Autor", substr(autor, 1, instr(autor, ',')-1) "Apellido" from libros;

/* 6 */

select autor "Autor", substr(autor, instr(autor, ',')+1) "Nombre" from libros;

/* 7 */

select substr(autor, instr(autor, ',')+1)||', '||substr(autor, 1, instr(autor, ',')-1) "Autor" from libros;

/* 8 */

select titulo from libros
order by length(titulo);

/* 9 */

select nombre, fechanac, to_char(fechanac, '"Nació el " dd " de " month " de " yyyy') "FECHA_FORMATEADA"
from nacimientos;

/* 10 */

select tema, substr(rtrim(tema, ' '), -1), length(rtrim(tema, ' '))
from libreria
order by tema;

/* 11 */

select translate(nombre, 'a ', 'a') "Nombre", to_char(fechanac, '"Nació el " dd " de " month " de " yyyy') "FECHA_FORMATEADA" 
from nacimientos;

/* 12 */

select to_date('010712', 'ddmmyy') "Fecha", to_char(to_date('010712', 'ddmmyy'), 'MONTH') "MES" from dual;

/* 13 */

select decode(ejemplares, 7, 'SEVEN', tema) from libreria;

/* 14 */

select apellido
from emple
where trunc(months_between(sysdate, fecha_alt) / 12) > 15;

/* 15 */

select apellido
from emple, depart
where emple.dept_no = depart.dept_no
and trunc(months_between(sysdate, fecha_alt) / 12) > 16
and dnombre = 'VENTAS';

/* 16 */

select apellido, salario, emple.dept_no 
from emple, depart
where emple.dept_no = depart.dept_no
and salario = (select max(E.salario) 
		from emple E
  		where E.dept_no = depart.dept_no);

/* 17 */

select apellido, salario, emple.dept_no 
from emple, depart
where emple.dept_no = depart.dept_no
and salario > (select avg(E.salario) 
		from emple E
  	where E.dept_no = depart.dept_no);
