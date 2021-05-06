set headsep |
ttitle 'RESUMEN DEPARTAMENTAL'

column dnombre heading 'Nombre Departamento'
column maxSalario heading 'Maximo | Salario' format 9G999
column minSalario heading 'Minimo | Salario' format 9G999
column sumSalario heading 'Suma | Salarios' format 99G999
column avgSalario heading 'Salario | Medio' format 9G999
column numEmple heading 'Numero | Empleados' format 99

set linesize 80
set pagesize 50
set newpage 0

break on report on dnombre skip 1

select dnombre, max(salario) "maxSalario", min(salario) "minSalario", sum(salario) "sumSalario", avg(salario) "avgSalario", count(emp_no) "numEmple"
from emple, depart
where emple.dept_no = depart.dept_no
group by dnombre;

ttitle off
btitle off