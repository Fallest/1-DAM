set headsep |
ttitle 'LISTADO DE LOS EMPLEADOS DE LA TABLA EMPLE'
btitle left 'Con ruptura por departamento y por oficio calculando totales'

column loc heading 'Localidad'
column apellidos heading 'Apellidos'
column emp_no heading 'Nº de empleado'
column oficio heading 'Oficio'
column salario heading 'Salario'
column comision heading 'Comisión'

break on loc on oficio skip 1
compute sum label "Suma Salarios por Localidad" of salario on oficio
compute sum label "Suma salarios por oficio en localidad" of salario on loc on oficio

set linesize 80
set pagesize 80
set newpage 0

select loc, apellido, emp_no, oficio, salario, comision
from depart, emple
where depart.dept_no = emple.dept_no;

ttitle off
btitle off