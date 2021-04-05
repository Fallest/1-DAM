/* Ejercicios T3 */
/* 1 */

select pobla from alumnos
group by pobla;

/* 2 */

select direc from alumnos
where dni='4448242';

/* 3 */

select direc from alumnos
where (pobla='Madrid' and dni='4448242')
and pobla='Móstoles';

/* 4 */

select nombre from asignaturas
where cod in (2, 4, 7) 
and ((nombre like '%a') or (nombre like '%á') 
or (nombre like 'A%') or (nombre like 'Á%')
or (nombre like '%a%') or (nombre like '%á%'));


/* 5 */

select * from emple
where apellido like 'A%'
and ((oficio like '%e') or (oficio like '%é') 
or (oficio like 'E%') or (oficio like 'É%')
or (oficio like '%e%') or (oficio like '%é%'));

/* 6 */

select dni from notas, asignaturas
where asignaturas.cod = notas.cod
and asignaturas.cod = 4
and notas.nota > 5;

/* 7 */

select dni, notas.cod, nota from notas, asignaturas
where notas.cod = asignaturas.cod
and notas.nota between 7 and  8;

/* 8 */

select tema from libreria
where estante in ('A', 'C')
and ejemplares < 10;

/* 9 */

select nombre_alumno from notas_alumnos
where (nota1 between 5 and 6)
or (nota2 between 5 and 6)
or (nota3 between 5 and 6)
group by nombre_alumno;

/* 10 */

select nombre_alumno from notas_alumnos
where (nota1 between 9 and 10)
or (nota2 between 9 and 10)
or (nota3 between 9 and 10)
group by nombre_alumno;

/* 11 */

select tema, estante from libreria
where estante in ('B', 'C', 'D')
and ejemplares between 10 and 20
order by tema desc;

/* 12 */

select apellido, salario from emple
where (oficio = 'VENDEDOR' and salario > 1200)
and (oficio = 'ANALISTA' and comision = null)
order by apellido asc, salario desc;

/* 13 */

select depart.dept_no from depart, emple
where depart.dept_no = emple.dept_no 
and fecha_alt like '%91'
group by depart.dept_no;

/* 14 */

select emp_no, apellido, salario + comision from emple, depart
where emple.dept_no = depart.dept_no
and (oficio = 'DIRECTOR' and emple.dept_no = 30)
or (oficio = 'ANALISTA' and emple.dept_no = 20)
order by emp_no desc;

/* 15 */

select apellido, oficio, dir from emple
where (fecha_alt > '15/03/91' and salario between 1000 and 1500)
or (fecha_alt < '15/01/91');

/* 16 */

select emp_no, oficio, salario from emple
where (fecha_alt like '%/02/%') 
or (fecha_alt like '%/09/%' and dept_no = 20);

/* 17 */

select salario from emple
where (oficio = 'PRESIDENTE')
or (salario < 1200 or salario > 2200);

/* 18 */

select apellido from emple
where salario > (select salario from emple where apellido = 'MARTIN');

/* 19 */

select apellido from emple
where dir = (select emp_no from emple where apellido = 'REY');

/* 20 */

select salario, comision from emple
where fecha_alt > (select fecha_alt from emple where apellido = 'GIL');

/* 21 */

select apellido from emple 
where oficio = (select oficio from emple where apellido ='ARROYO')
and salario < (select salario from emple where apellido = 'ARROYO');

/* 22 */

select apellido from emple
where dept_no = (select dept_no from depart where dnombre = 'CONTABILIDAD')
and comision in (0, null);

/* 23 */

select apellido from emple
where oficio = 'VENDEDOR'
and dept_no = (select dept_no from depart where loc = 'BARCELONA')
and salario > 1200;
