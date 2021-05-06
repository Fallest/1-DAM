set headsep |
ttitle 'LISTADO DE LOS SALARIOS DE LOS EMPLEADOS'
btitle 'Con resumen por departamento y por reporte'

column dnombre heading 'Nombre | Departamento'
column apellido heading 'Apellido'
column salario heading 'Salario' format 99G999

set linesize 50
set pagesize 50
set newpage 0

break on report on dnombre skip 1
compute sum label "-Suma" max label "-Maximo" min label "-Minimo" avg label "-Media" of salario on dnombre
compute sum label "-Suma" max label "-Maximo" min label "-Minimo" avg label "-Media" of salario on report

select dnombre, apellido, salario
from emple, depart
where emple.dept_no = depart.dept_no
order by dnombre, apellido;

ttitle off
btitle off