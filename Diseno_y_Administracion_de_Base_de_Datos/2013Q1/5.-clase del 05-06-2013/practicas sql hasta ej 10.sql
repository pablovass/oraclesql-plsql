--Al comenzar debemos estar ubicados
-- en la base ventas para eso hacemos:

use ventas

--o bien la elegimos del combo de la barra de ejecucion

--Es útil tener un select * de cada tabla para poder ver
-- en cualquier momento lo que contiene
select * from clientes
select * from repventas 
select * from productos
select * from pedidos
select * from oficinas

--Sentencias in/not in, between/not between, like/not like, 
--is null, is not null
--Ejemplo:
--Listar los numeros de pedido, el vendedor que lo atendio y su importe
--cuando el importe es <1000 o mayor a 5000 y el vendedor 
--no es el 101, 108 o 103
select NUM_PEDIDO, rep, importe 
from pedidos
--where importe >1000 
where importe not between 1000 and 5000
and rep not in (101, 108,103)
 
--Listar todos los datos de los productos cuyo numero de producto
--no tiene una a en 2do lugar y un 4 en tercer lugar

select * from productos 
--where id_fab like '%i'
where id_producto not like '_a_4%'


--Ejercicio 4
select nombre,cuota, ventas,cuota-ventas  difercuotaventas
from repventas
--
--where difercuotaventas>0
order by cuota desc, nombre asc


select * from repventas
where oficina_rep is null

--Ejercicio 1
select num_pedido, fecha_pedido
from pedidos
where fecha_pedido between '19900501' and '19970430'



/*Hay varios modos de trabajo con este editor de nueva consulta
Un modo es resaltar con el mouse lo que queremos ejecutar, otro modo 
es ir convirtiendo en comentario cada linea ejecutada, para que 
al pulsar el signo rojo de admiración (ejecutar), solo ejecute 
lo no comentariado*/

--Para hacer comentarios -- delante de cada linea del editor
--o bien encerrar todo un bloque de 1 o mas lineas entre /* y */
--En la barra de ejecución tenemos dos iconos que nos permiten 
--pulsar y comentariar y descomentariar un textor tienen una linea
--de color turquesa


select * 
from oficinas
where 
--oficina not between 13 and 22
--dir not in( 104, 108, 106)
ciudad not like 'a%'


select fecha_pedido,
 day(fecha_pedido) as dia,
  month(fecha_pedido) as mes,
   year(fecha_pedido) as anio
   from pedidos

select getdate()

select num_pedido, year(getdate())-year(fecha_pedido)as cantanios
--from repventas
from pedidos

   



--*****************Mas de una tabla:**************************
--Ejercicio 10
select empresa, num_clie, clie, rep
   from clientes,
        pedidos
   where rep=101
   --and num_clie= clie


  -- Ejercicio 14
   select num_empl, oficina, ciudad
   from repventas, oficinas
   where oficina_rep = oficina

   --Ejercicio 11
   select descripcion, existencias
   from productos, pedidos
   where num_pedido between 100000 and 200000
   and id_producto= producto and
   id_fab =fab 