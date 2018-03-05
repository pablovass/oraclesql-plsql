--Dual 
--Nos ayuda a realizar a realisar operaciones arimesticas y de concadenacion sensilla 
-- si o si para realizar operaciones tenemos elegir select from 

-- si elegimos una tabla cualquiera y a la seleccion le ponemos una operacion va a repetir su resultado tantas veces como filas tenga
select 3 *4  from JOBS;
-- dual solo un resultado
select 3 *4  from dual ;

SELECT 'hola mundo' FROM dual;
SELECT 'hola oracle' as "yo te saludo" FROM dual;

-- nos da la fecha de sistema
SELECT SYSDATE  FROM dual ;

--nos muestra el usuario
SELECT user FROM dual;

--concadenando cadenas
SELECT 'Esta es una cadena,' ||' '||'esta es otra cadena' FROM dual;
-mas concadenaciones 
SELECT ('Usuario: '|| user || ', el dia de hoy es '|| SYSDATE ) as "Encabezado"  FROM DUAL ;
