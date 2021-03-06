/* Casos prácticos */
/*1*/

select count(*), dept_no from emple group by dept_no;

/*2*/

select dept_no, to_char(sum(salario), '99G999D99') "Suma total",
to_char(max(salario), '99G999D99') "Maximo", 
to_char(min(salario), '99G999D99') "Minimo" 
from emple group by dept_no;

select dept_no, oficio, count(*) "Nº Emple" from emple
group by dept_no, oficio;

select max(count(*)) from emple
group by dept_no;

/*3*/

select nombre from alum
union
select nombre from nuevos;

/*4*/

select nombre from alum
intersect
select nombre from antiguos;

/*5*/

select nombre, localidad from alum
minus
select nombre, localidad from antiguos
order by localidad;

select nombre, localidad from alum 
where nombre not in (select nombre from antiguos)
order by localidad;

select nombre from alum
intersect
select nombre from nuevos 
minus
select nombre from antiguos;

select nombre from alum 
where nombre in (select nombre from nuevos 
		minus 
		select nombre from antiguos);

select nombre from alum
intersect
(select nombre from nuevos
union
select nombre from antiguos);

/*---------------------------------------------------------*/
/* Actividades propuestas */
/*1*/

select dept_no from emple
group by dept_no
having avg(salario) >= (select avg(salario) from emple);

/*2*/

select dnombre, count(*) from emple, depart
where emple.dept_no = depart.dept_no
group by dnombre
having count(*) > 4;

/*3*/


select d.dept_no, dnombre, count(*)
from emple e, depart d
where e.dept_no (+) = d.dept_no
group by d.dept_no, dnombre;
/* Como está contando la fila si hay un dato en cualquier campo,
no está contando solo si hay empleados en ese departamento, por lo que
aparentemente da un dato falso en el departamento de producción (1 en vez de 0)*/

select e.dept_no, dnombre, count(e.emp_no)
from emple e, depart d
where e.dept_no (+) = d.dept_no
group by d.dept_no, dnombre;
/* Nos da un error, diciendo que no es una expresión group by, puesto que
está intentando agrupar el dept_no de una tabla con el dept_no de otra. */

/*4*/

select a.nombre from antiguos a
where a.nombre in (select alum.nombre from alum);

/*5*/

select nombre from alum
where nombre in (select nombre from nuevos)
or nombre in (select nombre from antiguos);

select nombre from alum
intersect
(	select nombre from nuevos
	union
	select nombre from antiguos
);

select nombre from alum
where nombre in (select nombre from antiguos
		union
		select nombre from nuevos);

/*---------------------------------------------------------*/
/* Actividades complementarias */
/*1*/

select sum(salario) from emple
where dept_no = (select depart.dept_no from depart
			where depart.dnombre = 'VENTAS')
group by emple.oficio;

/*2*/

select E1.apellido from emple E1
where E1.salario = (select round(avg(E2.salario)) from emple E2
			where E2.dept_no = E1.dept_no);

/*3*/

select count(emp_no) "Empleados", dept_no from emple
where oficio = 'EMPLEADO'
group by dept_no;

/*4*/

select dept_no, count(emp_no) "Empleados" from emple
where oficio = 'EMPLEADO'
group by dept_no
having count(emp_no) = (select max(count(emp_no)) from emple 
    where oficio = 'EMPLEADO'
    group by dept_no);

/*5*/

select D.dept_no, D.dnombre from emple E, depart D
where E.dept_no = D.dept_no
and E.oficio = 'EMPLEADO'
group by D.dnombre, D.dept_no
having count(E.emp_no) = (select max(count(emp_no)) from emple 
    where oficio = 'EMPLEADO'
    group by dept_no);

/*6*/

select E1.dept_no from emple E1
where (2 <= (select count(emp_no) from emple where oficio = 'EMPLEADO' 
		and dept_no = E1.dept_no))
or (2 <= (select count(emp_no) from emple where oficio = 'VENDEDOR' 
		and dept_no = E1.dept_no)) 
or (2 <= (select count(emp_no) from emple where oficio = 'DIRECTOR' 
		and dept_no = E1.dept_no)) 
or (2 <= (select count(emp_no) from emple where oficio = 'PRESIDENTE' 
		and dept_no = E1.dept_no)) 
or (2 <= (select count(emp_no) from emple where oficio = 'ANALISTA' 
		and dept_no = E1.dept_no)) 
group by dept_no;


/*7*/

select nombre from alum
where nombre in (select nombre from antiguos
		union
		select nombre from nuevos);

/*8*/

select nombre from alum
where nombre in (select nombre from nuevos)
or nombre in (select nombre from antiguos);

select nombre from alum
intersect
(	select nombre from nuevos
	union
	select nombre from antiguos
);

/*9*/

select nombre from alum
minus
(
	select nombre from antiguos
	union
	select nombre from nuevos
);

/*10*/

select C.nombre "Centro", PRO.especialidad "Especialidad",
nvl(count(PRO.dni), 0) "Profesores"
from profesores PRO, centros C
where PRO.cod_centro (+) = C.cod_centro
group by C.nombre, PRO.especialidad;

/*11*/

select C.nombre "Centro", nvl(count(PER.dni), 0) "Empleados"
from personal PER, centros C
where PER.cod_centro (+) = C.cod_centro
group by C.nombre;

/*12*/

select PRO.especialidad, count(PRO.dni) "Profesores" from profesores PRO
group by PRO.especialidad
having count(PRO.dni) = (select min(count(PRO2.dni)) from profesores PRO2
			group by PRO2.especialidad);


/*13*/

select B.nombre_banc "Nombre Banco", count(S.cod_sucur) "NºSucursales"
from bancos B, sucursales S
where B.cod_banco = S.cod_banco (+)
group by B.nombre_banc
having count(S.cod_sucur) = (select max(count(S2.cod_sucur)) from sucursales S2
				group by S2.cod_banco);

/*14*/

select B.nombre_banc "Nombre Banco", sum(C.saldo_debe) "Saldo debe",
sum(C.saldo_haber) "Saldo haber" from bancos B, cuentas C, sucursales S
where B.cod_banco = S.cod_banco (+)
and B.cod_banco = C.cod_banco
and S.cod_sucur = C.cod_sucur (+)
and B.poblacion = 'GUADALAJARA'
group by B.nombre_banc;

/*15*/

select C.nombre_cta "Nombre Cta", count(M.num_cta) "Nºmovimientos"
from cuentas C, movimientos M
where C.cod_banco = M.cod_banco
and C.cod_sucur = M.cod_sucur
and C.num_cta = M.num_cta
group by C.nombre_cta
having count(M.num_cta) = (select max(count(M2.num_cta)) from movimientos M2
			group by M2.num_cta);

/*16*/

select S.nombre_suc "Nombre sucursal", to_char(sum(M.importe), '99G999D99') "Suma reintegros"
from sucursales S, movimientos M
where S.cod_sucur = M.cod_sucur (+)
and M.tipo_mov = 'R'
group by S.nombre_suc
having sum(M.importe) = (select max(sum(M2.importe)) from movimientos M2
			where M2.tipo_mov = 'R'
			group by M2.cod_sucur)
