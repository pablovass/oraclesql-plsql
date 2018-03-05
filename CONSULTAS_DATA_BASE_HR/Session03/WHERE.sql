--filtros con where 

--muestra los nombres y apellidos de la tabla empleado filtrando por el id de departamento
SELECT FIRST_NAME || ' '|| LAST_NAME "Name" ,DEPARTMENT_ID FROM EMPLOYEES
where DEPARTMENT_ID=80;

-- cual es el departamento segun el id que le indiquemos 
SELECT DEPARTMENT_NAME 
FROM DEPARTMENTS
where DEPARTMENT_ID=80;

desc JOB_HISTORY;

select *from JOB_HISTORY
where JOB_ID= 'AC_ACCOUNT';

-- OTROS TIPO DE COMPARADORES 
--DIFERENTE <> , != ^=
--MENOR QUE < <=
--MAYOU QUE > >=


--muestra los nombres y apellidos de la tabla empleado filtrando por COMISION DIFERENTE 
SELECT FIRST_NAME || ' '|| LAST_NAME "Name" ,DEPARTMENT_ID, COMMISSION_PCT
FROM EMPLOYEES
where COMMISSION_PCT != 0.35;

--cuales son los paises de la region 4 
select * from COUNTRIES
WHERE REGION_ID=4;

--cueales es la region 4?
select region_name
from regions
where region_id=4;

-- 
--MOSTRAR LOS EMPLEADOS QUE TENGAN UN VALOR DIFERENTES A 0.35
SELECT FIRST_NAME || ' '|| LAST_NAME "NOMBRES" , 
        COMMISSION_PCT

FROM EMPLOYEES
WHERE COMMISSION_PCT != .35 ;

--OPERADORES DE CONJUNTOS IN 

-- SELECCIONAME LAS PERSONAS DE LOS SIGUIENTES DEPARTAMENTOS 
SELECT FIRST_NAME || ' '|| LAST_NAME "NOMBRES" , 
        DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (10,20,50);



