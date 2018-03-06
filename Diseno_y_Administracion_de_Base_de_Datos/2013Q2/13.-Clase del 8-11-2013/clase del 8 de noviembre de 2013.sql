--ejemplo1
select oficina, region as 'region de la oficina'
from oficinas
where dir =108

select oficina, region, dir
from oficinas
where dir =108

select oficina, region, dir
from oficinas
where dir in (104, 103, 108)

select oficina, region, dir
from oficinas
where dir not in (104, 103, 108)

select oficina, region, dir
from oficinas
where oficina>11 and oficina<22

select oficina, region, dir
from oficinas
where oficina between 12 and 21

select oficina, region, dir
from oficinas
where oficina not between 12 and 21

select oficina, region, dir, ciudad
from oficinas
where ciudad not like '___a%'

select *
from repventas
where OFICINA_REP is null

select * from pedidos
select * from clientes
select * from repventas

select NUM_PEDIDO,EMPRESA,NOMBRE,IMPORTE
from [dbo].[Repventas],[dbo].[Pedidos],[dbo].[Clientes]
where clie=num_clie 
and rep= num_empl
and importe > 31000


select year(fecha_pedido) as año from pedidos
where fecha_pedido between '19890401' and '19900201'

select getdate(), year(getdate()), month(getdate())




