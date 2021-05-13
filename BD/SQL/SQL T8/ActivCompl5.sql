ttitle 'PEDIDOS REALIZADOS POR PRODUCTO'

column descripcion heading 'Descripcion Producto'
column unidades heading 'Unidades pedidas'
column total_imp heading 'Total de la cantidad'

set linesize 80
set pagesize 50
set newpage 1

break on report skip 1
compute sum label "-Suma" of unidades on report
compute count label "-Nº Pedidos" of descripcion on report

select distinct descripcion, sum(unidades) "unidades" , precio_actual*sum(unidades) "total_imp" 
from pedidos08, productos08
where pedidos08.producto_no = productos08.producto_no
group by descripcion, unidades, precio_actual;

ttitle off