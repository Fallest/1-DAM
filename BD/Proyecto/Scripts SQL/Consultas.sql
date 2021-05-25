/* Consultas en SQL */
/* 1. Eliminar los empleados de los centros de trabajo donde haya dos o menos trabajadores, sin contar a los encargados. */

delete empleado where exists (
	select dni_emp, cod_centro_tra from empleado
	group by dni_emp, cod_centro_tra
	having count(dni_emp) =< 2;
);

/*---------------------------------------------*/
/* 2. Mostrar los encargados de los centros de trabajo que tengan algún empleado.*/

select * from encargado
where dni_enc any (select dni_enc from empleado);

/*---------------------------------------------*/
/* 3. Mostrar los empleados y los encargados de los centros de trabajo que estén bajo la administración con código 823716.*/

select dni_emp, E.nombre
from empleado E
where cod_centro_tra in (
	select cod_centro_tra from centro_trabajo
	where cod_admin = 823716	
)
intersect
select dni_enc, En.nombre
from encargado En
where cod_centro_tra in (
	select cod_centro_tra from centro_trabajo
	where cod_admin = 823716	
);

/*---------------------------------------------*/
/* 4. Mostrar el director de la administración encargada del centro de trabajo que tenga al mayor número de empleados. */

select Dir.dni_dir, Dir.nombre 
from director_admin Dir
where Dir.dni_dir in (
	select Ad.dni_dir from administracion Ad
	where Ad.cod_admin in (
		select Ct.cod_admin from centro_trabajo Ct
		where Ct.cod_centro_tra = (
			select Em.cod_centro_tra	
			from empleado Em
			group by Em.cod_centro_tra
			having count(*) = (
				select max(count(*)) from empleado
				group by cod_centro_tra
			)
		)
	)
);

/*---------------------------------------------*/
/* 5. Cambiar el salario a los encargados de los centros de trabajo que no tenga ningún empleado. Añadir 200€. */

update encargado set salario = salario + 200
where dni_enc in (
	select encargado.dni_enc from empleado, encargado
	where empleado.dni_enc (+) = encargado.dni_enc
	group by encargado.dni_enc
	having count(encargado.dni_emp) =< 2;
);
