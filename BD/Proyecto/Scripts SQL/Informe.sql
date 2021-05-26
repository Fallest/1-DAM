/* Informe de las tablas en SQL 
Salario para cada empleado, agrupado por centro de trabajo.
*/
set headsep |
ttitle "SALARIO PARA CADA EMPLEADO POR CENTRO DE TRABAJO"

column centro heading 'Centro de Trabajo' format 999999
column nombre heading 'Nombre de Empleado'
column salario heading 'Salario' format 9G999D99

set linesize 80
set pagesize 50
set newpage 1

break on centro skip 2
compute sum label "-Suma" count label "-Nº Empleados" max label "-Sal Max" of 

salario on centro

select codcentrotra "centro", nombre, salario 
from empleado
order by codcentrotra;

ttitle off;