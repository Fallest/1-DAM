set headsep |
ttitle 'Ventas por artículos durante mayo'
btitle left 'solo mayo de 2005'

column denom heading 'Articulo|Vendido'
column denom format A15
column denom truncated

column fecha_venta heading 'Fecha|Venta'
column uni_vend heading 'Unidades|Vendidas' format 9G999
column importe format 9G999D99

break on denom duplicate skip 2
compute sum of uni_vend on denom
compute sum of importe on denom

set linesize 50
set pagesize 50
set newpage 0

spool listado.lst

select denom, fecha_venta, uni_vend, uni_vend * pvp "Importe"
from tarticulos A, tventas V
where A.codigo = V.codigo
and fecha_venta between '01/05/2005' and '31/05/2005'
order by denom, fecha_venta;

ttitle off
btitle off

spool off