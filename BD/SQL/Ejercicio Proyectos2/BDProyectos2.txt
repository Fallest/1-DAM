/* 1.Nombre de los departamentos de Córdoba ordenados descendentemente. */

select nombre from departamento where ciudad='Córdoba' order by nombre desc;

/* 2.Nombre y fecha de ingreso de los empleados de los departamentos de Córdoba.*/

select empleado.nombre, fecha_ingreso from empleado, departamento
where empleado.cddep = departamento.cddep
and departamento.ciudad = 'Córdoba';

/* 3.Nombre y fecha de ingreso de los empleados de los departamentos de Córdoba y 
Almería.*/


select empleado.nombre, fecha_ingreso from empleado, departamento
where empleado.cddep = departamento.cddep
and departamento.ciudad in ('Córdoba', 'Almería');

/* 4.Nombre y fecha de ingreso de los empleados cuyo jefe sea del departamento de Almería. */

select empleado.nombre, fecha_ingreso from empleado, departamento
where empleado.cddep = departamento.cddep
and cdjefe = (	select cdemp from empleado E, departamento D
		where E.cddep = D.cddep
		and D.ciudad = 'Almería'
		and empleado.cdjefe = E.cdemp);

/* 5.Nombre de los proyectos de Málaga.*/

select proyecto.nombre from proyecto, departamento
where proyecto.cddep = departamento.cddep
and departamento.ciudad = 'Málaga';

/* 6.Nombre de los empleados que trabajan en proyectos de Málaga de menos de 100 horas.*/

select empleado.nombre from empleado, trabaja, proyecto, departamento
where empleado.cdemp = trabaja.cdemp
and empleado.cddep = departamento.cddep
and trabaja.cdpro = proyecto.cdpro
and proyecto.cddep = departamento.cddep
and departamento.ciudad = 'Málaga'
and trabaja.nhoras < 100;

/* 7.Nombre de los empleados que trabajan en proyectos de Málaga de menos de 100 horas, junto con el nombre de los proyectos. Ordenar por nombre de proyecto descendentemente y por nombre de empleado ascendentemente.*/

select empleado.nombre, proyecto.nombre from empleado, trabaja, proyecto, departamento
where empleado.cdemp = trabaja.cdemp
and empleado.cddep = departamento.cddep
and trabaja.cdpro = proyecto.cdpro
and proyecto.cddep = departamento.cddep
and departamento.ciudad = 'Málaga'
and trabaja.nhoras < 100
order by proyecto.nombre desc, empleado.nombre asc;

/* 8.Nombre de los empleados del mismo departamento que aquellos que se apellidan Verde junto con los nombres de los proyectos en los que trabajan.*/

select empleado.nombre, proyecto.nombre 
from empleado, trabaja, proyecto, departamento
where empleado.cdemp = trabaja.cdemp
and empleado.cddep = departamento.cddep
and trabaja.cdpro = proyecto.cdpro
and proyecto.cddep = departamento.cddep
and empleado.cddep in (select D.cddep from empleado E, departamento D
			where E.cddep = D.cddep and E.nombre like '% Verde');

/* 9.Mostrar el nombre y la fecha de ingreso de los empleados que tienen como jefe a Esperanza Amarillo y entraron en la empresa en el mes de Febrero.*/

select E.nombre, E.fecha_ingreso from empleado E
where E.cdjefe = 	(select E1.cdemp from empleado E1
			where E1.nombre = 'Esperanza Amarillo')
and E.fecha_ingreso like '%02%';

/* 10.Apellido del empleado junto con el nombre del día de la semana en el que entró en la empresa.*/

select substr(E.nombre, instr(E.nombre, ' ')) "Apellido", 
to_char(E.fecha_ingreso, '"Entro un " day') "Dia de alta"
from empleado E;


/* 11.Siglas del empleado junto con el nombre del mes (en mayúsculas) en el que entró en la empresa.*/

select concat(substr(E.nombre, 1, 1), substr(substr(E.nombre, instr(E.nombre, ' ')), 2, 1)) "Siglas", 
to_char(E.fecha_ingreso, 'MONTH') "Mes de ingreso"
from empleado E;

/* 12.Número de empleados del departamento de Ventas.*/

select count(E.cdemp) from empleado E, departamento D
where E.cddep = D.cddep
and D.nombre = 'Ventas';

/* 13.Número de empleados del departamento al que pertenece el jefe de Juan Rojo.*/

select count(E.cdemp) from empleado E, departamento D
where E.cddep = D.cddep
and D.cddep = (select E2.cddep from empleado E2
              where E2.cdemp = (select E3.cdjefe from empleado E3 
                                where E3.nombre = 'Juan Rojo'));

/* 14.Número de proyectos del departamento de Málaga.*/

select count(P.cdpro) from proyecto P, departamento D
where P.cddep = D.cddep
and D.ciudad = 'Málaga';

/* 15.Total de horas del proyecto de Depuración de aguas. (Mostrar con cuatro dígitos)*/

select to_char(sum(T.nhoras), '0999') "Suma de horas" from trabaja T, proyecto P
where T.cdpro = P.cdpro
and P.nombre = 'DEPURACION DE AGUAS';

/* 16.Media de horas de los proyectos del departamento de Málaga. (Redondear y mostrar con dos decimales)*/

select round(avg(T.nhoras), 2) "Media de horas" from trabaja T, proyecto P, departamento D
where T.cdpro = P.cdpro
and P.cddep = D.cddep
and D.ciudad = 'Málaga';

/* 17.Modificar el número de horas de los empleados que no tienen jefe y trabajan en el proyecto de Marketing. Su nuevo valor será el 10% de las horas que trabaja Pablo Verde.*/

update trabaja T set T.nhoras = (select T2.nhoras*0.1 from empleado E2, trabaja T2 
                              where E2.cdemp = T2.cdemp and E2.nombre = 'Pablo Verde')
where cdemp in (select E3.cdemp from empleado E3, proyecto P3, trabaja T3
                  where E3.cdemp = T3.cdemp and T3.cdpro = P3.cdpro
                  and P3.nombre like 'MARKETING%' and E3.cdjefe is null);

/* 18.Borrar los empleados que no trabajan en ningún proyecto.*/


/*Hay que modificar algunas restricciones anteriores.*/

alter table empleado drop constraint fk_emple_cdjefe;
alter table empleado drop constraint fk_trab_cdemp;
alter table empleado add constraint fk_emple_cdjefe foreign key (cdjefe)
references empleado on delete cascade;
alter table empleado add constraint fk_trab_cdemp foreign key (cdemp)
references empleado on delete cascade;

delete empleado where empleado.cdemp not in (select E.cdemp from empleado E, trabaja T where E.cdemp = T.cdemp)

