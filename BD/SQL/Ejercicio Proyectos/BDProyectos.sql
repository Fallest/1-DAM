/* Crear las tablas */

create table departamento
(
	cddep 	number(2) primary key,
	nombre 	varchar2(20),
	ciudad 	varchar2(15)
);

create table empleado
(
	cdemp		varchar2(3) primary key,
	nombre		varchar2(20),
	fecha_ingreso	date,
	cdjefe		varchar2(3),
	cddep		number(2)
);

create table proyecto
(
	cdpro	varchar2(3),
	nombre	varchar2(30),
	cddep	number(2),
	constraint pk_proyecto primary key (cdpro, nombre)
);

create table trabaja
(
	cdemp	varchar2(3),
	cdpro	varchar2(3),
	nhoras	number(3),
	constraint pk_trabaja primary key (cdemp, cdpro)
);

/* 1 */

alter table departamento add constraint ck_dep_cod_valido 
check(cddep between 1 and 15);

/* 2 */

alter table departamento add constraint ck_dep_prov_andaluza
check(ciudad in ('Huelva', 'Cádiz', 'Sevilla', 'Málaga', 'Jaén', 'Córdoba', 'Almería', 'Granada'));

/* 3 */

alter table trabaja add constraint ck_trab_nhoras_validas 
check(nhoras <= 180);

/* 4 */

alter table departamento modify nombre varchar2(20) default 'Málaga';

/* 5 */

alter table empleado add(tlf number(9) not null);

/* 6 */

alter table proyecto add(descripcion varchar2(60));

/* 7 */

alter table proyecto drop column descripcion;

/* 8 */

alter table proyecto add constraint nombre_unico unique (nombre);

/* 9 */

alter table proyecto add constraint ck_pro_nom_mayus 
check(nombre = upper(nombre));
/* o tambien */
update proyecto set nombre = upper(nombre);

/* 10 */

alter table departamento drop constraint ck_dep_cod_valido;
insert into departamento(cddep) values(16);

/* 11 */
alter table empleado drop column tlf;

insert into departamento values(01, 'Contabilidad-1', 'Almería');
insert into departamento values(02, 'Ventas', 'Almería');
insert into departamento values(03, 'I+D', 'Málaga');
insert into departamento values(04, 'Gerencia', 'Córdoba');
insert into departamento values(05, 'Administracion', 'Córdoba');
insert into departamento values(06, 'Contabilidad-2', 'Córdoba');

insert into empleado values('C01', 'Juan Rojo', '03-02-1997', 'A03', 01);
insert into empleado values('B02', 'María Azul', '09-01-1996', 'A03', 01);
insert into empleado values('A03', 'Pedro Rojo', '07-03-1995', 'A11', 01);
insert into empleado values('C04', 'Ana Verde', null, 'A07', 02);
insert into empleado values('C05', 'Alfonso Amarillo', '03-12-1998', 'B06', 02);
insert into empleado values('B06', 'Carmen Violeta', '03-02-1997', 'A07', 02);
insert into empleado values('A07', 'Elena Blanco', '09-04-1994', 'A11', 02);
insert into empleado values('C08', 'Javier Naranja', null, 'B09', 03);
insert into empleado values('B09', 'Pablo Verde', '12-10-1998', 'A11', 03);
insert into empleado values('A10', 'Dolores Blanco', '15-11-1998', 'A11', 04);
insert into empleado values('A11', 'Esperanza Amarillo', '23-09-1993', null, 04);
insert into empleado values('B12', 'Juan Negro', '03-02-1997', 'A11', 05);
insert into empleado values('A13', 'Jesús Marrón', '21-02-1999', 'A11', 05);
insert into empleado values('A14', 'Manuel Amarillo', '01-09-2000', 'A11', null);

insert into proyecto values('GRE', 'GESTION RESIDUOS', 03);
insert into proyecto values('DAG', 'DEPURACION DE AGUAS', 03);
insert into proyecto values('AEE', 'ANALISIS ECONOMICO ENERGIAS', 04);
insert into proyecto values('MES', 'MARKETING DE ENERGIA SOLAR', 02);

insert into trabaja values('C01', 'GRE', 10);
insert into trabaja values('C08', 'GRE', 54);
insert into trabaja values('C01', 'DAG', 5);
insert into trabaja values('C08', 'DAG', 150);
insert into trabaja values('B09', 'DAG', 100);
insert into trabaja values('A14', 'DAG', 10);
insert into trabaja values('A11', 'AEE', 15);
insert into trabaja values('C04', 'AEE', 20);
insert into trabaja values('A11', 'MES', 0);
insert into trabaja values('A03', 'MES', 0);

/* Creacion de las FKs */
alter table empleado add constraint fk_emple_cdjefe foreign key (cdjefe) references empleado;
alter table empleado add constraint fk_emple_cddep foreign key (cddep) references departamento;

alter table proyecto add constraint fk_pro_cddep foreign key (cddep) references departamento;

alter table trabaja add constraint fk_trab_cdemp foreign key (cdemp) references empleado;
alter table trabaja add constraint fk_trab_cdpro foreign key (cdpro) references proyecto;

/* 12 */

insert into proyecto values('GRE', 'GESTION DEL AMBIENTE', 08);

/* 
ERROR en línea 1:
ORA-02291: restricción de integridad (SCOTT.FK_PRO_CDDEP) violada - clave padre
no encontrada
*/

/* 13 */

insert into trabaja values('B20', 'AEE', 128);

/*
ERROR en línea 1:
ORA-02291: restricción de integridad (SCOTT.FK_TRAB_CDEMP) violada - clave
padre no encontrada
*/

