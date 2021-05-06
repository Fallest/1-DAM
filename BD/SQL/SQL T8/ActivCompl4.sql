accept nomcli prompt "Introduzca el nombre del cliente a consultar: "

ttitle 'PEDIDOS DE ' &nomcli

column pedido_no heading 'Nº Pedido'
column descripcion heading 'Descripcion Producto'
column fecha_pedido heading 'Fecha'
column unidades heading 'Unidades'
column importe heading 'Importe' format 9G999D9

set linesize 80
set pagesize 50
set newpage 1

break on report skip 1
compute sum label "-Suma" count label "-Nº Pedidos" of importe on report

select pedido_no, descripcion, fecha_pedido, unidades, (unidades*precio_actual) "importe"
from clientes08 C, productos08 PR, pedidos08 PE
where C.nombre = '&nomcli'
and C.cliente_no = PE.cliente_no
and PR.producto_no = PE.producto_no
order by pedido_no;

ttitle off