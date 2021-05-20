set headsep |

ttitle 'NÚMERO DE PISOS POR PROVINCIA'

column provincia heading 'Provincia'
column referencia heading 'Referencia del Piso'
column precio heading 'Precio del Piso'

set pagesize 50
set linesize 50
set newpage 1

break on provincia on report skip 1
compute max label "Precio máximo" of precio on report

select C.provincia, P.referencia, P.precio
from pisos P, ciudades C, inmobiliarias I
where C.ciudad = I.ciudad
and P.inmobiliaria = I.agencia;

ttitle off