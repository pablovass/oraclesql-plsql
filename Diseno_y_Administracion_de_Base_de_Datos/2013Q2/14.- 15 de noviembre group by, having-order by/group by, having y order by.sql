--limite de credito promedio de todos los clientes:

select avg(limite_credito) as lim_cred_promedio
from clientes


select * from clientes

--limite de credito promedio de todos los clientes
--para aquellos con numeros de clientes entre 2105 y 2114

select avg(limite_credito) as lim_cred_promedio
from clientes
where num_clie between 2105 and 2114

select num_clie,avg(limite_credito) as lim_cred_promedio
from clientes

--este da error porque no se sabe que cliente todos estan juntos

select * 
from pedidos

--importe maximo gastado en un pedido de acme
select max(importe) as importemaximo
from pedidos, clientes
where empresa like '%acme%'
and num_clie=clie

select * from repventas

--importe maximo gastado en un pedido de acme
--cuando lo atendio Bill Adams

select max(importe) as importemaximo
from pedidos, clientes, repventas
where empresa like '%acme%'
and num_clie=clie
and rep= num_empl
and nombre like '%Adams%'

--Group by:
--Es para calcular funciones de agregacion a grupos 
--de igual valor

--Listar los clientes y su importe maximo de pedidos ordenado
--en forma descendente por importe maximo y luego descendente
-- por numero de cliente


--order by ordena la salida por los campos que yo quiero en forma ascendente
--si quiero descendente debo poner desc

select clie as cliente, max(importe) as importemaximoporclie
from pedidos
group by clie
order by importemaximoporclie desc,cliente desc

--Listar los clientes, su nombre de empresa y su importe maximo
-- de pedidos ordenado
--en forma descendente por importe maximo y luego descendente
-- por numero de cliente

select clie as cliente,empresa, max(importe) as importemaximoporclie
from pedidos, clientes
where clie= num_clie
group by clie, empresa
order by importemaximoporclie desc,cliente desc


--La sentencia having es un where para despues de agrupar y en general se 
--pregunta por los valores de funciones de agregacion

--Listar los clientes, su nombre de empresa y su importe maximo
-- de pedidos ordenado
--en forma descendente por importe maximo y luego descendente
-- por numero de cliente. Mostrar solo los de importe maximo
-- mayor a 10000

select clie as cliente,empresa, max(importe) as importemaximoporclie
from pedidos, clientes
where clie= num_clie
group by clie, empresa
having max(importe) > 10000
order by importemaximoporclie desc,cliente desc

select * from clientes
