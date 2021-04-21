/* Casos prácticos */
/* 2 */

insert into emple30 (emp_no, apellido, oficio, dir, fecha_alt, slario, comision, dept_no)
select emp_no, apellido, oficio, dir, fecha_alt, slario, comision, dept_no 
from emple
where dept_no = 30;

insert into emple30 select * from emple where dept_no = 30;

insert into nombres (nombre)
select apellido from emple
where dept_no = 20;

insert into emple
select distinct 1111, 'GARCÍA', 'DIRECTOR', null, sysdate, 2400, 0, dept_no 
from emple
group by dept_no
having count(*) = (select max(count(*)) from emple group by dept_no);


insert into emple
select distinct 1112, 'QUIROGA', oficio, dir, sysdate, salario, comision, dept_no 
from emple
where apellido = 'GIL';

/*-----------------------------------------------------------
/* 4 */

update centros 
set (direccion, num_plazas) = (select direccion, num_plazas 
				from centros 
				where cod_centro = 50) 
where cod_centro = 10;

update emple 
set salario = salario/2, comision = 0 
where dept_no = (
	select dept_no from emple 
	group by dept_no 
	having count(*)= (
		select max(count(*)) from emple group by dept_no
	)
);

update emple set apellido = lower(apellido), salario = (
	select salario*2 from emple where apellido = 'SÁNCHEZ'
) where dept_no = (
	select dept_no from depart where dnombre = 'CONTABILIDAD'
);

/*-----------------------------------------------------------
/* 5 */

commit;
delete centros where cod_centro = 50;
rollback;

delete centros;
rollback;

delete from libreria L1 where ejemplares < (
	select avg(ejemplares) from libreria L2 where L2.estante = L1.estante
	group by estante
);
rollback;

delete from depart where dept_no in (
	select dept_no from emple group by dept_no
	having count(*) < 4
);

/*-----------------------------------------------------------
/* Actividades propuestas */
/* 2 */

insert into alum select * from nuevos;

insert into emple
select 2000, 'SAAVEDRA', oficio, dir, sysdate, salario*1.2, comision, dept_no
from emple
where apellido = 'SALA';

/*-----------------------------------------------------------
/* 4 */

update emple set dept_no = (
	select dept_no from emple
	where oficio = 'EMPLEADO'
	group by dept_no
	having count(*) = (
		select max(count(*)) from emple
		where oficio = 'EMPLEADO'
		group by dept_no
	)
)
where apellido = 'SAAVEDRA';

/*-----------------------------------------------------------*/
/* Actividades complementarias */
/* 1 */

update centros set num_plazas = num_plazas/2
where cod_centro in (
	select cod_centros from profesores
	group by cod_centros
	having count(*) < 2
);

/*-----------------------------------------------------------
/* 2 */

delete centros where cod_centro not in (
	select cod_centro from personal
);

/*-----------------------------------------------------------
/* 3 */

insert into profesores 
select P1.cod_centro, 8790055, 'Clara Salas', 'IDIOMA'
from personal P1
where funcion = 'ADMINISTRATIVO'
group by cod_centro
having count(*) = 1;

/*-----------------------------------------------------------
/* 4 */

delete personal
where (
	select num_plazas from centros
	where centros.cod_centro = personal.cod_centro
) < 300
and (
	select count(*) from profesores
	where profesores.cod_centro = personal.cod_centro
	group by personal.cod_centro
) < 2;

/*-----------------------------------------------------------
/* 5 */

delete profesores
where dni not in (
	select dni from personal
	where personal.cod_centro = profesores.cod_centro
	group by personal.dni
);

/*-----------------------------------------------------------
/* 6 */

insert into articulos
select 'Raton ordenador', cod_fabricante, 5, 'Primera', 120, 100, 190
from fabricantes
where pais = francia;

select nif, 'Raton ordenador', cod_fabricante, 5, 'Primera', sysdate, 5 from tiendas, fabricantes where pais = 'FRANCIA';

/*-----------------------------------------------------------
/* 7 */

insert into pedidos
select distinct '1111-A', articulo, cod_fabricante, peso, categoria, sysdate, 20
from ventas
where (articulo, cod_fabricante, peso, categoria) in
(
	select articulo, cod_fabricante, peso, categoria 
	from ventas
	group by articulo, cod_fabricante, peso, categoria
	having count(*) = (
		select max(count(*)) 
		from ventas 
		group by articulo, cod_fabricante, peso, categoria
	)
);

/*-----------------------------------------------------------
/* 8 */

insert into tiendas
values('1234-A', 'Tienda Madrid', 'C/Ejemplo 30', 'Madrid', 'MADRID', 21204);

insert into pedidos
select '1234-A', articulo, cod_fabricante, peso, categoria, sysdate, 20
from articulos;

/*-----------------------------------------------------------
/* 9 */

insert into tiendas
values('0923-K', 'Tienda Sevilla 1', 'C/Ejemplo2 12', 'Sevilla', 'SEVILLA', 41283);
insert into tiendas
values('7372-H', 'Tienda Sevilla 2', 'C/Ejemplo3 15', 'Sevilla', 'SEVILLA', 41283);

insert into pedidos
select nif, articulo, A.cod_fabricante, peso, categoria, sysdate, 30
from articulos A, tiendas T, fabricantes F
where F.provincia = 'SEVILLA'
and F.nombre = 'GALLO'
and A.codfabricante = F.cod_fabricante;

/*-----------------------------------------------------------
/* 10 */

insert into ventas
select nif, articulo, A.cod_fabricante, peso, categoria, sysdate, 10
from tiendas T, articulos A
where T.provincia = 'TOLEDO'
and A.categoria = 'Primera';

/*-----------------------------------------------------------
/* 11 */

insert into pedidos
select distinct '5555-B', articulo, cod_fabricante, peso, categoria, sysdate, 10
from ventas
where (articulo, cod_fabricante, peso, categoria) in (
	select articulo, cod_fabricante, peso, categoria
	from ventas
	group by articulo, cod_fabricante, peso, categoria
	having sum(unidades_vendidas) > 30
);

/*-----------------------------------------------------------
/* 12 */

update tiendas set(nombre, direccion, poblacion, provincia, codpostal)=(
	select nombre, direccion, poblacion, provincia, codpostal
	from tiendas
	where nif = '2222-A'
);

/*-----------------------------------------------------------
/* 13 */

update articulos set categoria='Segunda'
where cod_fabricante in (
	select cod_fabricante from fabricantes
	where pais = 'ITALIA'
);

/*-----------------------------------------------------------
/* 14 */

update pedidos set unidades_pedidas = (
	select 0.2*existencias from articulos
	where pedidos.articulo = A.articulo
	and pedidos.cod_fabricante = A.cod_fabricante
	and pedidos.peso = A.peso
	and pedidos.categoria = A.categoria
) 
where unidades_pedidas > (
	select existencias from articulos A
	where pedidos.articulo = A.articulo
	and pedidos.cod_fabricante = A.cod_fabricante
	and pedidos.peso = A.peso
	and pedidos.categoria = A.categoria
);

/*-----------------------------------------------------------
/* 15 */

delete tiendas
where nif not in (select V.nif from ventas V);

/*-----------------------------------------------------------
/* 16 */

delete articulos
where (articulo, cod_fabricante, peso, categoria) not in (
	select articulo, cod_fabricante, peso, categoria 
	from ventas
)
and (articulo, cod_fabricante, peso, categoria) not in (
	select articulo, cod_fabricante, peso, categoria 
	from pedidos
);

/*-----------------------------------------------------------
/* 17 */

delete pedidos 
where categoria = 'Primera'
and where cod_fabricante in (
	select cod_fabricante 
	from fabricantes
	where pais = 'BELGICA'
);

/*-----------------------------------------------------------
/* 18 */

delete pedidos
where nif not in (select nif from tiendas);

/*-----------------------------------------------------------
/* 19 */

update pedidos set unidades_pedidas = unidades_pedidas - 1
where nif = '5555-B'
and fecha_pedido = (
	select max(fecha_pedido) from pedidos where nif = '5555-B'
);