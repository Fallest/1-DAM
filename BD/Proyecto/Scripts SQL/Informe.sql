/* Informe de las tablas en SQL 
Salario para cada empleado, agrupado por centro de trabajo.
*/
ttitle "SALARIO PARA CADA EMPLEADO POR CENTRO DE TRABAJO"

column nombre heading 'Nombre de Empleado'
column salario heading 'Salario'
column centro heading 'Centro de Trabajo'

set linesize 80
set pagesize 50
set newpage 1

break on centro skip 1
compute sum label "-Suma" count label "-Nº Empleados" max label "-Sal Max" of salario on centro

select nombre, salario, cod_centro_tra "centro" 
from empleado
group by nombre, salario, cod_centro_tra;

ttitle off;
compute off;
break off;