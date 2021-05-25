/* Script para la creación e inserción de datos en las tablas en SQL */
/*-----------------------------------------------------------*/
create table director_admin(
	dni_dir varchar(9) not null,
	nombre varchar(30),
	edad number(2),
	salario number(5)
	direccion varchar(30),
	horas_mensuales number(3),
	constraint pk_dir_admin primary key (dni_dir)
);

create table administracion (
	cod_admin number(6) not null,
	direccion varchar(30),
	fecha_establecimiento date,
	dni_dir varchar(9),
	constraint pk_administracion primary key (cod_admin),
	constraint fk_admin_director foreign key (dni_dir) references director_admin on delete cascade
);

create table gerente(
	dni_ger varchar(9) not null,
	nombre varchar(30),
	edad number(2),
	salario number(5)
	direccion varchar(30),
	horas_mensuales number(3),
	constraint pk_gerente primary key (dni_ger)
);

create table centro_trabajo (
	cod_centro_tra number(6) not null,
	direccion varchar(30),
	fecha_establecimiento date,
	dni_ger varchar(9),
	cod_admin number(6),
	constraint pk_centro_trabajo primary key (cod_centro_tra),
	constraint fk_cen_tra_gerente foreign key (dni_ger) references gerente on delete cascade,
	constraint fk_cent_tra_admin foreign key (cod_admin) references administracion on delete cascade
);

create table director_escolar (
	dni_dir_esc varchar(9) not null,
	nombre varchar(30),
	edad number(2),
	cod_centro_tra number(6),
	constraint pk_dir_escolar primary key (dni_dir_esc),
	constraint fk_dir_escolar foreign key (cod_centro_tra) references centro_trabajo on delete cascade
);

create table centro_escolar (
	cod_centro_esc number(6) not null,
	direccion varchar(30),
	fecha_construccion date,
	dni_dir_esc varchar(9),
	cod_centro_tra number(6),
	constraint pk_centro_escolar primary key (cod_centro_esc),
	constraint fk_cen_esc_director foreign key (dni_dir) references director_escolar on delete cascade,
	constraint fk_centro_escolar foreign key (cod_centro_tra) references centro_trabajo on delete cascade
);

create table encargado(
	dni_enc varchar(9) not null,
	nombre varchar(30),
	edad number(2),
	salario number(5)
	direccion varchar(30),
	horas_mensuales number(3),
	cod_centro_esc number(6),
	cod_centro_tra number(6),
	constraint pk_encargado primary key (dni_enc),
	constraint fk_enc_escuela foreign key (cod_centro_esc) references centro_escolar on delete cascade,
	constraint fk_enc_centro_tra foreign key (cod_centro_tra) references centro_trabajo on delete cascade
);

create table empleado(
	dni_emp varchar(9) not null,
	nombre varchar(30),
	edad number(2),
	salario number(5)
	direccion varchar(30),
	horas_mensuales number(3),
	cod_centro_esc number(6),
	cod_centro_tra number(6),
	dni_enc varchar(9),
	constraint pk_empleado primary key (dni_emp),
	constraint fk_emp_escuela foreign key (cod_centro_esc) references centro_escolar on delete cascade,
	constraint fk_emp_centro_tra foreign key (cod_centro_tra) references centro_trabajo on delete cascade,
	constraint fk_emp_encargado foreign key (dni_enc) references encargado on delete cascade
);

create table vendedor (
	cod_vendedor number(6) not null,
	nombre varchar(30),
	constraint pk_vendedor primary key (cod_vendedor)
);

create table compraventa (
	cod_vendedor number(6) not null,
	dni_ger varchar(9) not null,
	tipo_producto varchar(20),
	constraint pk_compraventa primary key (cod_vendedor, dni_ger),
	constraint fk_cv_vendedor foreign key (cod_vendedor) references vendedor on delete cascade,
	constraint fk_cv_gerente foreign key (dni_ger) references gerente on delete cascade
);