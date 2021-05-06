set headsep |
ttitle 'LISTADO DE LOS SALARIOS DE LOS EMPLEADOS'

column dnombre heading 'Nombre | Departamento'
column apellido heading 'Apellido'
column salario heading 'Salario' format 99G999

set linesize 50
set pagesize 50
set newpage 0

break on dnombre skip 1
compute sum label "-Suma" max label "-Maximo" min label "-Minimo" avg label "-Media" of salario on dnombre

accept dnom prompt "Introduzca el nombre del departamento: "

select dnombre, apellido, salario
from emple, depart
where emple.dept_no = depart.dept_no
and depart.dnombre = '&dnom'
order by dnombre, apellido;

ttitle off