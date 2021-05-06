accept ndep number prompt 'Introduzca el numero de departamento: '
accept ofi prompt 'Introduzca el oficio a filtrar: '

define cabecera="Departamento: " ndep
define pie="Oficio: " ofi

ttitle center 'Departamento ' ndep skip 1
btitle center 'Oficio ' ofi skip 1

select loc, apellido, emp_no, salario, comision
from emple, depart
where emple.dept_no = depart.dept_no
and oficio = '&ofi'
and emple.dept_no = &ndep
order by apellido;

ttitle off
btitle off