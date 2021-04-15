/* 1.Visualizar el número de estantes diferentes que hay en la tabla LIBRERÍA. */

select estante "Estante" from libreria
group by estante;

/*------------------------------------------------------------------*/
/* 2.Visualizar el número de estantes distintos que hay en la tabla LIBRERIA de aquellos temas que contienen al menos una ‘E’. */

select estante "Estantes con E" from libreria
where estante like 'E%'
or estante like '%E'
group by estante;

/*------------------------------------------------------------------*/
/* 3.Visualizar los diferentes estantes de la tabla LIBRERÍA ordenados descendentemente por estante. */

select estante "Estante" from libreria
group by estante
order by estante desc;

/*------------------------------------------------------------------*/
/* 4.Averiguar cuántos temas tiene cada estante. */

select count(tema) "Temas", estante "Estante" from libreria
group by estante;

/*------------------------------------------------------------------*/
/* 5.Visualizar los estantes que tengan tres temas. */

select estante "Estante" , count(tema) "Temas" from libreria
group by estante
having count(tema) = 3;

/*------------------------------------------------------------------*/
/* 6.Dada la tabla LIBRERÍA, visualizar por cada estante la suma de los ejemplares. */

select estante "Estante", sum(ejemplares) "Suma Ejemplares"
from libreria
group by estante;

/*------------------------------------------------------------------*/
/* 7.Visualizar por cada estante la suma de los ejemplares, siempre que ésta sea superior a 10. */


select estante "Estante", sum(ejemplares) "Suma Ejemplares"
from libreria
group by estante
having sum(ejemplares) > 10;

/*------------------------------------------------------------------*/
/* 8.Visualizar la suma de los ejemplares para cada uno de los estantes A, C y E, siempre que ésta sea superior a 10. */

select estante "Estante", sum(ejemplares) "Suma Ejemplares"
from libreria
where estante in ('A', 'C', 'E')
group by estante
having sum(ejemplares) > 10;

/*------------------------------------------------------------------*/
/* 9.Visualizar el número de temas para los estantes A, C y E cuya suma de ejemplares sea superior a 10. */

select estante "Estante", sum(ejemplares) "Suma Ejemplares", count(tema) "Temas" 
from libreria
where estante in ('A', 'C', 'E')
group by estante
having sum(ejemplares) > 10;

/*------------------------------------------------------------------*/
/* 10.Visualizar el estante con más ejemplares de la tabla LIBRERÍA. La consulta   deberá mostrar el número que le correspondería si los enumerásemos del 1 en adelante. (‘A’->1,’B’->2,...) */

select sum(ejemplares) "Ejemplares", estante "Estante" 
from libreria
group by estante
having sum(ejemplares) = (select max(sum(ejemplares)) from libreria
			group by estante);

select sum(ejemplares) "Ejemplares", estante "Estante", 
decode(upper(estante), 'A', 1, 'C', 2, 'B', 3, 'D', 4, 'E', 5) "Orden"
from libreria
group by estante
order by sum(ejemplares) desc;

/*------------------------------------------------------------------*/
/* 11.Visualizar los cuatro primeros caracteres de los temas seguidos de un carácter de subrayado y del estante correspondiente en minúscula. */

select rpad(substr(tema, 1, 4), 5, '_') "Tema", lower(estante) "Estante"
from libreria;

/*------------------------------------------------------------------*/
/* 12.Mostrar la información de la tabla librería, de forma que el tema quede justificado a la derecha y el número de ejemplares justificado a la izquierda. */

select lpad(tema, 15), estante, rpad(ejemplares, 3) from libreria;

/*------------------------------------------------------------------*/
/* 13.Calcular el número de oficios distintos que hay en total en los departamentos 10 y 20. */

select sum(count(distinct oficio)) "Oficios distintos" from emple
where dept_no in (10, 20) group by oficio;

/*------------------------------------------------------------------*/
/* 14.Obtener, por cada oficio, el número de trabajadores. */

select count(emp_no) "Num Empleados", oficio from emple
group by oficio;

/*------------------------------------------------------------------*/
/* 15.Visualizar los departamentos en los que el salario medio es mayor o igual que la media de todos los salarios de los departamentos 10 y 20. */

select dept_no from emple
group by dept_no
having avg(salario) >= (select avg(salario) from emple where dept_no = 10 group by dept_no)
or avg(salario) >= (select avg(salario) from emple where dept_no = 20 group by dept_no);

/*------------------------------------------------------------------*/
/* 16.Mostrar el nombre de cada empleado junto con el nombre de su jefe. */

select apellido "Empleado", decode(dir, 7566, 'JIMENEZ', 7698, 'NEGRO', 7782, 'CEREZO',
7788, 'GIL', 7839, 'REY', 7902, 'FERNANDEZ', 'Sin jefe') "Jefe" from emple;

select e1.apellido, e2.apellido from emple e1, emple e2
where e1.dir = e2.emp_no;

/*------------------------------------------------------------------*/
/* 17.Mostrar el apellido de los empleados que tienen 3 ó más trabajadores a su cargo. */

select apellido from emple 
where emp_no in (select dir from emple group by dir having count(*) >= 3);


/*------------------------------------------------------------------*/
/* 18.Mostrar el apellido y el salario del empleado con más trabajadores a su cargo. */

select apellido ,salario from emple 
where emp_no in (select dir from emple group by dir 
                 having count(*) = (select max(count(*)) from emple group by dir));

/*------------------------------------------------------------------*/
/* 19.A partir de la tabla emple, visualizar el número de vendedores del departamento de VENTAS. */

select count(emp_no) from emple
where dept_no = (select dept_no from depart where dnombre = 'VENTAS');

/*------------------------------------------------------------------*/
/* 20.Visualizar el código de los empleados que entraron en la empresa un domingo. */

select emp_no from emple
where lower(to_char(fecha_alt, 'day')) like '%domingo%';

/*------------------------------------------------------------------*/
/* 21.Visualizar el código de los empleados que entraron en la empresa un domingo del primer trimestre del año.  */

select emp_no from emple
where to_char(fecha_alt, 'q day') like '1%domingo%';

/*------------------------------------------------------------------*/
/* 22.Mostrar el saldo medio de las cuentas de las sucursales de Toledo. */

select avg(saldo_debe) "Media Saldo Debe", avg (saldo_haber) "Media Saldo Haber"
from cuentas C, sucursales S
where C.cod_banco = S.cod_banco
and C.cod_sucur = S.cod_sucur
and S.loc_suc = 'TOLEDO';

/*------------------------------------------------------------------*/
/* 23.Mostrar el nif (sustituyendo cada ‘3’ por  un ‘8’), el nombre del banco(deberá mostrarse la palabra ‘caja’ en lugar de ‘banco’) y el domicilio fiscal del banco con más sucursales. */

select translate(nf_banco, '3', '8') "NIF", 
replace(nombre_banc, 'BANCO', 'CAJA') "Nombre",
dom_fiscal "DOM Fiscal"
from bancos
where cod_banco = (select cod_banco from sucursales group by cod_banco having 				count(*) = (select max(count(*)) from sucursales 
				group by cod_banco));

/*------------------------------------------------------------------*/
/* 24.Mostrar el nombre del banco y de la sucursal de la cuenta con más movimientos. */

select b.nombre_banc, s.nombre_suc from bancos b, sucursales s
where s.cod_banco = b.cod_banco
and (b.cod_banco, s.cod_sucur) = (select cod_banco, cod_sucur from movimientos
				group by cod_banco, cod_sucur, num_cta
				having count(*) = (select max(count(*)) 
						from movimientos 
						group by cod_banco, cod_sucur, num_cta ));

/*------------------------------------------------------------------*/
/* 25.Visualizar el código, el nombre y la población de los bancos que tienen sucursales. Utiliza la cláusula EXISTS. */

select cod_banco, nombre_banc, poblacion from bancos B
where exists (select cod_sucur from sucursales S where B.cod_banco = S.cod_banco);

/*------------------------------------------------------------------*/
/* 26.Visualizar el código, el nombre y la población de los bancos que no tienen ninguna cuenta. Utiliza la cláusula EXISTS. */

select cod_banco, nombre_banc, poblacion from bancos B
where not exists (select num_cta from cuentas C where B.cod_banco = C.cod_banco);

/*------------------------------------------------------------------*/
/* 27.Visualizar el código, el nombre y la población de los bancos que no tienen ni sucursales ni  cuentas. Utiliza la cláusula EXISTS. */

select cod_banco, nombre_banc, poblacion from bancos B
where not exists (select num_cta from cuentas C where B.cod_banco = C.cod_banco)
and not exists (select cod_sucur from sucursales S where B.cod_banco = S.cod_banco);

/*------------------------------------------------------------------*/
/* 28.Mostrar los datos de la sucursal cuyo saldo total (haber-debe) sea mayor que el saldo total de alguna de las cuentas.  */

select * from sucursales S
where (
  select (sum(saldo_haber) - sum(saldo_debe)) from cuentas C 
  where (C.cod_sucur = S.cod_sucur) 
) > any (
    select (saldo_haber-saldo_debe) from cuentas C1 where c1.cod_sucur = S.cod_sucur
  );

/*------------------------------------------------------------------*/
/* 29.Mostrar los datos de la sucursal que tenga menor saldo total (haber-debe. No se podrá utilizar la función de grupo MIN(). */

select * from sucursales
where (cod_banco, cod_sucur) = 
(
  select cod_banco, cod_sucur from cuentas
  group by cod_banco, cod_sucur
  having sum(saldo_haber - saldo_debe) <= all
  (
    select sum(nvl(saldo_haber, 0) - nvl(saldo_debe, 0)) from cuentas
    group by cod_banco, cod_sucur
  )
);

/*------------------------------------------------------------------*/
/* 30.Mostrar los importes de los ingresos como números positivos y los reintegros   como números negativos. El número de cuenta debe mostrarse de la siguiente forma: ‘******9999’ */

select decode(tipo_mov, 'I', importe, 'R', -importe) "Importes",
lpad(substr(num_cta, 4, 4), 10, '*') "Num Cuenta"
from movimientos;
