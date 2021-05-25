/* Consultas en SQL */
/* 1. Eliminar los empleados de los centros de trabajo donde haya dos o menos trabajadores, sin contar a los encargados. */

delete empleado where exists (
	select codcentrotra from empleado
	group by codcentrotra
	having count(dniemp) <= 2;
);

/*---------------------------------------------*/
/* 2. Mostrar los encargados de los centros de trabajo que tengan algún empleado.*/

select * from encargado
where dnienc in (select dnienc from empleado);

/*---------------------------------------------*/
/* 3. Mostrar los empleados de los centros de trabajo que estén bajo la administración con código 632521 y que cobren igual o más de 630 euros. */

select dniemp, E.nombre
from empleado E
where codcentrotra in (
	select codcentrotra from centrotrabajo
	where codadmin = 632521
)
intersect
select dniemp, nombre
from empleado
where salario >= 630;

/*---------------------------------------------*/
/* 4. Mostrar el director de la administración encargada del centro de trabajo que tenga al mayor número de empleados. */

select Dir.dnidir, Dir.nombre 
from directoradmin Dir
where Dir.dnidir in (
	select Ad.dnidir from administracion Ad
	where Ad.codadmin in (
		select Ct.codadmin from centrotrabajo Ct
		where Ct.codcentrotra = (
			select Em.codcentrotra	
			from empleado Em
			group by Em.codcentrotra
			having count(*) = (
				select max(count(*)) from empleado
				group by codcentrotra
			)
		)
	)
);

/*---------------------------------------------*/
/* 5. Cambiar el salario a los encargados de los centros de trabajo que no tenga ningún empleado. Añadir 200€. */

update encargado set salario = salario + 200
where dnienc in (
	select encargado.dnienc from empleado, encargado
	where empleado.dnienc (+) = encargado.dnienc
	group by encargado.dnienc
	having count(encargado.dniemp) =< 2;
);
