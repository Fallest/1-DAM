/* Casos prácticos */

/* 1 */
create table alumnos07 (
	numero_matricula number(6) not null,
	nombre varchar2(15) not null,
	fecha_nacimiento date,
	direccion varchar2(30),
	localidad varchar2(15)
);

drop table alumnos07;

/* 2 */
create table provin
(
	codigo number(2) primary key,
	nombre varchar2(25)
);

create table empleado
(
	nombre varchar2(25),
	edad number,
	cod_provincia number(2),
	constraint pk_empleado primary key (nombre),
	constraint ck_edad check(edad between 18 and 35),
	constraint fk_empleado foreign key (cod_provincia)
			references provin on delete cascade
);

drop table provin;
drop table empleado;

/* 3 */
create tables bloquespisos
(
	calle varchar2(30) not null,
	numero number(3) not null,
	piso number(2) not null,
	puerta char(1) not null,
	codigo_postal number(5),
	metros number(5),
	comentarios varchar2(60),
	cod_zona number(2),
	dni varchar2(10),
	constraint pk_viv primary key (calle, numero, piso, puerta)
);

create table zonas
(
	cod_zona number(2) primary key,
	nombrezona varchar2(20) not null,
	masdatos varchar2(50)
);

drop table bloquespisos;
drop table zonas;

/* 4 */
create table provincias
(
	codprovincia number(2) primary key,
	nom_provincia varchar(15) not null
);

create table personas
(
	dni varchar2(9) primary key,
	nombre varchar2(15),
	direccion varchar2(25),
	poblacion varchar2(15),
	codprovin number(2) not null,
	foreign key (codprovin) references provincias
);

/* 5 */
delete provincias; /* No se pueden borrar las filas de provincias porque hay datos
		      en la tabla personas (que hacen referencia a provincias) */

drop table personas;
create table personas
(
	dni varchar2(9) primary key,
	nombre varchar2(15),
	direccion varchar2(25),
	poblacion varchar2(15),
	codprovin number(2) not null,
	foreign key (codprovin) references provincias on delete cascade
);

/* 6 */
drop table personas;
drop table provincias;

create table provincias
(
	codprovincia number(2) contraint pk_prov primary key,
	nom_provincia varchar2(15),
);

create table personas
(
	dni number(8) constraint pk_per primay key,
	nombre varchar2(15),
	direccion varchar2(25),
	poblacion varchar2(20),
	codprovin number(2) not null,
	constraint fk_per foreign key (codprovin) references provincias on delete cascade
);

insert into provincias values(28, 'MADRID');
insert into provincias values(28, 'SEVILLA');
/* Segundo comando falla porque ya hay una fila con codigo 28 */

insert into personas values (1133, 'Luis', 'La Peña 12', 'Berrocalejo', 22);
/* Error porque el codprovincia no existe en provincias */

/* 7 */
create table ejemplo
(
	nif varchar2(10) not null,
	nombre varchar2(30) constraint nomnonulo not null,
	edad number(2)
);

insert into ejemplo (nif) values ('45222111-A');
/* Error porque nombre está vacío y tiene una restricción not null,
además, el nombre dado a la restricción no aparece */

/* 8 */
create table ejemplo1
(
	dni varchar2(10) not null,
	nombre varchar(30),
	fecha date default sysdate
);

insert into ejemplo1 (dni, nombre) values('1234', 'PEPA');
select * from ejemplo1;
/* aparece la fecha del sistema */
 
/* 9 */
create table ejemplo3
(
	dni varchar2(10) not null,
	nombre varchar(15) not null,
	edad number(2) check(edad between 5 and 20),
	curso number(1),
	constraint pk_ejemplo3 primary key (dni),
	constraint nom_mayus check(nombre = upper(nombre)),
	constraint check (curso in(1,2,3))
);

/* 10 */
create table ejemplo1_u
(
	dni varchar2(10) primary key,
	nom varchar2(30) unique,
	edad number(2)
);

insert into ejemplo1_U values('11111', 'PEPA', 20);
insert into ejemplo1_U values('11112', 'PEPA', 21);
/* Error porque ya hay una fila con nombre 'PEPA' */

/* 11 */
select constraint_name, table_name, constraint_type from user_constraints
where table_name = 'ejemplo';

/* 12 */
create table ejemplo_as 
as select * from ejemplo;

create table ejemplo_as2 (col1, col2, col3, col4)
as select * from ejemplo;

create table empleydepart
as select apellido, dnombre
from emple, depart
where emple.dept_no = depart.dept_no;

select constraint_name, table_name from user_constraints 
where table_name in('ejemplo', 'ejemplo_as');

/* 13 */
drop table provincias;

drop table provincias cascade constraints;

/* 14 */
alter table ejemplo3 add(sexo char(1) not null, importe number(4));

alter table ejemplo3 add(sexo char(1), importe number(4));

update ejemplo3 set sexo = 'X';

alter table ejemplo3 drop column sexo;
alter table ejemplo3 drop column importe;

/* 15 */
alter table emple add constraint salmayor check (salario > 0);
alter table emple add constraint apellido_uq unique(apellido);

alter table emple modify comision constraint comi_nonula not null;

alter table emple add constraint pk_emple primary key(emp_no);
alter table depart add constraint fk_emple foreign key(dept_no) 
references depart on delete cascade;

select constraint_name, column_name from user_cons_columns where table_name = 'emple';

alter table emple drop constraint SYS_C005311;
alter table emple drop constraint apellido_uq;

/* 16 */
alter table emple disable constraint pk_emple;
alter table emple disable constraint fk_emple;

/* 17 */
create view emp_dept (emp_no, apellido, dept_no, dnombre) as
select emp_no, apellido, emple.dept_no, dnombre
from emple, depart, where emple.dept_no = depart.dept_no;

insert into emp_dept values(222, 'SUELA', 20, 'INVESTIGACION');

create view pagos (nombre, sal_mes, sal_an, dept_no)
as selct initcap(apellido), salario, salario*12, dept_no
from emple where dept_no = 10;

update pagos set sal_mes = 5000 where nombre = 'Muñoz';

/* 18 */
create synonym departamentos for depart;
select * from departamentos;
select * from depart;

create synonym depart for pedro.depart;


/* Actividades propuestas */

/* 1 */
select * from user_tables;
/* Tiene las columnas table_name, tablespace_name, cluster_name, iot_name,
pct_free, pct_used, ini_trans, max_trans, initial_extent, next_extent,
min_extents, max_extents, ptc_increase, freelists, freelist_groups, log, b,
num_rows, blocks, empty_blocks, avg_space, chain_cnt, avg_row_len, 
avg_space_freelist_blocks, num_freelist_blocks, degree, instances, cache,
table_lo, sample_size, last_ana, par, iot_type, t, s, nes, buffer_row_move,
glo, use, duration, skip_cor, mon, clister_owner*/

select table_name, num_rows from user_tables;

select * from user_objects;
/* Tiene las columnas object_name, subobject_name, object_id, data_object_id, 
object_type, created, last_ddl, timestamp, status, t, g, s*/
select * from user_catalog;
/* Tiene las columnas table_name y table_type */

/* 2 */
create table bloquespisos
(
	calle varchar2(30) not null primary key,
	numero number(3) not null primary key,
	piso number(2) not null primary key,
	puerta char(1) not null primary key,
	codigo_postal number(5),
	metros number(5),
	comentarios varchar2(60),
	cod_zona number(2),
	dni varchar2(10)
);

/* Aparece este error:
	numero number(3) not null primary key,
	                          *
ERROR en línea 4:
ORA-02260: la tabla sólo puede tener una clave primaria*/

/* 3 */
create table provincias
(
	codprovincia number(2) primary key,
	nom_provincia varchar(15) not null
);

create table personas
(
	dni varchar2(9) primary key,
	nombre varchar2(15),
	direccion varchar2(25),
	poblacion varchar2(15),
	codprovin number(2) not null,
	foreign key (codprovin) references provincias
);

insert into provincias values(2, 76);
insert into provincias values(12, 14);
insert into personas (dni, nombre, codprovin) 
values('29381732H', 'Paco', 14);
insert into personas (dni, nombre, codprovin) 
values('75460253FK', 'Antonia', 76);
insert into personas (dni, nombre, codprovin) 

insert into personas (dni, nombre, codprovin)
values('1234', 'Manuel', 21);
/* Da error por no existir la provincia con codprovin 21*/

/* 4 */ 
create table ejemplo2
(
	dni varchar(9),
	nombre varchar2(25) default 'No definido',
	usuario varchar2(10) default uid
);
insert into ejemplo2 (dni) values('1234');

/* DNI       NOMBRE                    USUARIO
--------- ------------------------- ----------
1234      No definido               35  	*/

/* 5 */
insert into table ejemplo3 (nombre, edad) values ('antonio', 23);
insert into table ejemplo3 (nombre, curso, edad) values ('ANA', 6, 3);

/* 6 */
create table fabricantes
(
	cod_fabricante number(3) constraint pk_fabricante primary key,
	nombre varchar2(15) constraint nom_mayus check (nombre = upper(nombre)),
	pais varchar2(15) constraint pais_mayus check (pais = upper(pais))
);

create table articulos
(
	articulo varchar2(20) not null,
	cod_fabricante number(3) not null,
	peso number(3) not null,
	categoria varchar2(10) not null,
	precio_venta number(6,2),
	precio_costo number(6,2),
	existencias number(5),
	constraint pk_articulos primary key (articulo, cod_fabricante, peso, categoria),
	constraint fk_articulos foreign key (cod_fabricante) references fabricantes,
	constraint pventa_positivo check (precio_venta > 0),
	constraint pcosto_positivo check (precio_costo > 0),
	constraint peso_positivo check (peso > 0),
	constraint cat_valida check (categoria in ('Primera', 'Segunda', 'Tercera'))
);

/* 7 */
create table tiendas
(
	nif varchar2(10),
	nombre varchar2(20),
	direccion varchar2(20),
	poblacion varchar2(20),
	provincia varchar2(20),
	codpostal number(5)
);

alter table tiendas
add constraint pk_tiendas primary key nif;
alter table tiendas 
add constraint provin_mayus check (provincia = upper(provincia));
alter table tiendas
modify nombre varchar2(30);

/* 8 */
create view datos_emple
as select * from emple where dept_no = 10 and salario > 1200;
commit;

insert into datos_emple(emp_no, salario, dept_no)
values (12, 850, 20);
update datos_emple set dept_no = 40
where dept_no = 10;
rollback;
delete datos_emple where salario > 1700;

/* 9 */
create or replace view dep30
as select * from emple where dept_no = 30 with read only;

insert into dep30(emp_no, salario, dept_no)
values (53, 1700, 30);
update dep30 set dept_no = 40
where dept_no = 30;
delete dep30 where salario >= 2000;

/* todas las instrucciones dan error */

/* 10 */
create view vmedia (Num_depart, Nom_depart, Sal_medio, Sal_maximo)
as select depart.dept_no, dnombre, avg(salario), max(salario)
from emple, depart
where emple.dept_no = depart.dept_no
group by depart.dept_no, dnombre, dnombre, dnombre;


/* Actividades complementarias */
/* 1 */
create table pedidos
(
	nif			varchar2(10),
	articulo		varchar2(20),
	cod_fabricante 		number(3),
	peso			number(3),
	categoria		varchar2(10),
	fecha_pedido		date,
	unidades_pedidas	number(4),
	constraint pk_pedidos primary key (nif, articulo, cod_fabricante, peso, categoria, fecha_pedido),
	constraint fk_codfab foreign key (cod_fabricante) references fabricantes,
	constraint chk_uni check (unidades_pedidas > 0),
	constraint pedido_catvalida check(categoria in ('Primera','Segunda','Tercera')),
	constraint fk_pedidos foreign key (articulo, cod_fabricante, peso, categoria) references articulos on delete cascade,
	constraint fk_nif foreign key (nif) references tiendas
);

create table ventas
(
	nif			varchar2(10),
	articulo		varchar2(20),
	cod_fabricante 		number(3),
	peso			number(3),
	categoria		varchar2(10),
	fecha_venta		date,
	unidades_vendidas	number(4),
	constraint pk_ventas primary key (nif, articulo, cod_fabricante, peso, categoria, fecha_venta),
	constraint fk_ventas foreign key cod_fabricante references fabricantes,
	constraint chk_univendidas check(unidades_vendidas > 0),
	constraint vent_catvalida check(categoria in ('Primera','Segunda','Tercera')),
	constraint fk_ventas foreign key (articulo, cod_fabricante, peso, categoria) references articulos on delete cascade,
	constraint fk_ventasnif foreign key nif references tiendas
);

/* 2 */
select constraint_name from user_constraints
where table_name = 'VENTAS' or table_name = 'PEDIDOS';

/* 3 */
alter table pedidos modify unidades_pedidas number(6);
alter table ventas modify unidades_vendidas number(6);

/* 4 */
alter table tiendas add constraint nomastiendasentoledo check(upper(provincia) not in ('TOLEDO'));

/* 5 */
alter table pedidos add(pvp number(6));
alter table ventas add(pvp number(6));

/* 6 */
create view conserjes (Nombre_centro, Nombre_conserje)
as select centros.nombre, personal.apellidos 
from personal, centros
where personal.cod_centro = centros.cod_centro
and personal.funcion = 'CONSERJE';

/* 7 */
create public synonym conser for conserjes;

/* 8 */
alter table profesores add(cod_asig number(2));

/* 9 */
create table tasig
(
	cod_asig number(2),
	nom_asig varchar2(20)
);

/* 10 */
alter table tasig add constraint pk_asig primary key (cod_asig);

/* 11 */
alter table profesores add constraint fk_tasig foreign key (cod_asig) 
references tasig;
select constraint_name from user_constraints
where table_name = 'TASIG' and table_name = 'PROFESORES';



