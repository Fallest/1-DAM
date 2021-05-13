/* Casos prácticos */
/* 3 */

grant select, insert on tabla1 to FRANCISCO;

grant all on tabla1 to public;

grant update (temperatura) on tabla1 to JUAN;

grant insert on tabla1 to FRANCISCO with grant option;

grant insert on Milagros.tabla1 to juan;

/*---------------------------------------------------------*/
/* 4 */

create user pedro identified by pedro quota 500k on users;
gran create session to pedro;

grant connect to pedro;

grant drop user to milagros with admin option;

grant select any table to public;

/*---------------------------------------------------------*/
/* 5 */

revoke select, update on tabla1 from francisco;

revoke all on tabla1 from francisco, juan;

revoke drop user from milagros;

revoke select any table from public;

/*---------------------------------------------------------*/
/* Actividades propuestas */
/* 1 */

grant select, insert on depart to Francisco
with grant option;

grant update (apellido) on emple to JoseMaría;

/* Como Francisco */
select * from David.depart;

grant select on David.emple to JoseMaría;

/* Como JoseMaría */
update David.emple set apellido = 'Méndez' where nombre = 'Paco';

select * from David.emple;

/*---------------------------------------------------------*/
/* 2 */

create user usu1 identified by usu1 quota 500k on users;
grant create session to usu1;
grant create table to usu1;

connect usu1/usu1;

select * from session_privs;

create table alumnos07 (
	numero_matricula number(6) not null,
	nombre varchar2(15) not null,
	fecha_nacimiento date,
	direccion varchar2(30),
	localidad varchar2(15)
);

grant select on alumnos07 to scott;

select * from user_tab_privs_recd;
select * from user_tab_privs_made;


