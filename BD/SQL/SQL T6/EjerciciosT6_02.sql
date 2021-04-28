/* 1.Insertar un nuevo centro en la tabla CENTROS: Código:70, Nombre:IES El Majuelo, Número de plazas: será el 10% del total de plazas de todos los centros. */

insert into centros (cod_centro, nombre, num_plazas)
select 70, 'IES El Majuelo', sum(num_plazas)*0.1
from centros;

/*-----------------------------------------------------------------------------*/
/* 2.Insertar un nuevo profesor en la tabla PROFESORES:Dni:30090088, Nombre: Rivera García, Pedro, La especialidad y el centro serán los de  Elisa */

insert into profesores
select cod_centro, 30090088, 'Rivera García, Pedro', especialidad
from profesores
where apellidos like '%Elisa%';

/*-----------------------------------------------------------------------------*/
/* 3.Insertar un nuevo empleado  de nombre 'Maria Gómez' con dni 29001111 en el centro que tiene más profesores. */

insert into personal (cod_centro, dni, apellidos)
select cod_centro, 29001111, 'Maria Gómez' 
from centros
where cod_centro = (
	select cod_centro from centros
	group by cod_centro
	having count(cod_centro) = (
		select max(count(cod_centro)) from profesores
		where profesores.cod_centro = centros.cod_centro
		group by cod_centro
	)
);

/*-----------------------------------------------------------------------------*/
/* 4.lnsertar un nuevo profesor de nombre 'María Fernández' con dni 28001112 en el centro que todavía no tiene ninguno.  */

insert into profesores (cod_centro, apellidos, dni)
select cod_centro, 'María Fernández', 28001112
from centros
where cod_centro in (
	select cod_centro from centros
	group by cod_centro
	minus
	select cod_centro from profesores
	group by cod_centro
);

/*-----------------------------------------------------------------------------*/
/* 5.Insertar un nuevo empleado de nombre 'María Fernández' y dni 29901111 en el centro de la calle Granada. Su función será la que tiene un salario medio superior a 200000 €. */

insert into personal (cod_centro, dni, apellidos, funcion)
select distinct (
	select cod_centro from centros where direccion like '%Granada%'
), 29901111, 'María Fernández', funcion
from personal
where funcion = (
	select funcion from personal
	group by funcion
	having avg(salario) > 200000
);

/*-----------------------------------------------------------------------------*/
/* 6.Insertar un nuevo empleado de nombre 'María García' en el centro que cuenta con mas profesores de Matemáticas. */

insert into personal (cod_centro, apellidos)
select cod_centro, 'María García'
from centros
where cod_centro = (
	select cod_centro from profesores
	where especialidad = 'MATEMATICAS'
	group by cod_centro
	having count(cod_centro) = (
		select max(count(cod_centro)) from profesores
		where especialidad = 'MATEMATICAS'
		group by cod_centro
	) 
);

/*-----------------------------------------------------------------------------*/
/* 7.Insertar un nuevo profesor en el centro que tiene idéntico número de administrativos que el centro cuyo teléfono termina en 4. */

insert into profesores (cod_centro, dni, apellidos)
select cod_centro, 29837162, 'Antonio Pérez'
from personal
where funcion = 'ADMINISTRATIVO'
group by cod_centro
having count(cod_centro) = (
	select count(cod_centro) from centros
	where substr(telefono, -1, 1) = '4'
);

/*-----------------------------------------------------------------------------*/
/* 8.Insertar un nuevo empleado de función ‘inspector’ en todos los centros que tienen profesores. */

insert into personal (cod_centro, funcion)
select distinct centros.cod_centro, 'inspector'
from centros, profesores
where centros.cod_centro = profesores.cod_centro;

/*-----------------------------------------------------------------------------*/
/* 9.Aumentar el número de plazas de los centros que no tienen profesores sumándole un  10% del mayor número de plazas de los que más profesores tienen. */

update centros set num_plazas = num_plazas + (
	select trunc(max(num_plazas)*0.1) from centros
	where cod_centro in (
		select cod_centro from profesores 
		group by cod_centro
		having count(*) = (
			select max(count(*)) from profesores
			group by cod_centro
		)
	)
) where cod_centro not in (select cod_centro from profesores);


/*-----------------------------------------------------------------------------*/
/* 10.Eliminar el personal que menos gana del centro que tiene más profesores por especialidad. */

delete from personal
where salario = (
	select min(salario) from personal
	where cod_centro in (
		select cod_centro from profesores
		group by cod_centro, especialidad
		having count(*) = (
			select max(count(*)) from profesores
			group by cod_centro, especialidad
		)
	)
)
and cod_centro in (
	select cod_centro from profesores 
	group by cod_centro, especialidad
	having count(*) = (
		select max(count(*))
		from profesoes
		group by cod_centro, especialidad
	)
);
