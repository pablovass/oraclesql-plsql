--sentencias select 
--TE TRAE TODO 
SELECT *FROM jobs;
-- DESCRIBIE LA TABLA
DESCRIBE JOBS;

-- SELECCIONAS DE LA TABLA UNA COLUNA DETERMINADA
SELECT job_id FROM JOBS;

--MAS COLUMNAS 
SELECT job_id, min_salary FROM JOBS;

--CON ALIAS 
SELECT JOB_ID AS JOB, MIN_SALARY AS SALARIO__MINIMO 
FROM JOBS;

--CON ALIAS LAS COMILLAS RESPETAN TIPO DE LETRA Y LOS ESPACIOS
SELECT JOB_ID AS "Job", MIN_SALARY AS "Ssalario MINIMO" 
FROM JOBS;

--datos distintos 
DESC EMPLOYEES;
-- VER LOS DEPARTAMENTOS QUE PERTENECEN A LOS EMPLEADOS 

SELECT DEPARTMENT_ID
FROM EMPLOYEES;
-- COMO HAY UN EMPLEADO QUE ESTA CON DATO NULO . SIRVE 
SELECT DISTINCT department_id 
FROM EMPLOYEES;
-- ASI QUE SON 12 DEPARTAMENTOS 

SELECT DISTINCT department_id 
FROM EMPLOYEES
ORDER BY  DEPARTMENT_ID;

SELECT DISTINCT department_id ,JOB_ID
FROM EMPLOYEES;
ORDER BY  DEPARTMENT_ID;

--CON WHERE 
-- PEDIR LOS DEPARTAMENTOS QUE SON MENORES A 30 
SELECT FIRST_NAME, DEPARTMENT_ID 
FROM employees
WHERE NOT (DEPARTMENT_ID >= 30);

-- PEDIMOS EL APELLIDO DE SMITH  Y QUE SU SALARIO SEA + 7500
SELECT FIRST_NAME , salary 
FROM EMPLOYEES 
WHERE LAST_NAME = 'Smith' AND SALARY > 7500;
--nombre y apellido de empleados que se llamen kelly o se apelliden Smith

SELECT FIRST_NAME , LAST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME='Kelly' or LAST_NAME='Smith';

--empleados que estre 5000 y 6000 de salario
--between toma los extremos 

select FIRST_name, LAST_name, salary
from EMPLOYEES
where salary BETWEEN 5000 and 6000;

-- igual que la anterion 

select FIRST_name, LAST_name, salary
from EMPLOYEES
where salary >= 5000 and salary <= 6000;

-- seleccioname los nombre y apellidos
-- donde los nombre empiensen con Su

select FIRST_name, LAST_name, salary
from EMPLOYEES
where FIRST_NAME like 'Su%';

-- seleccioname los nombre y apellidos
-- donde los nombre empiensen con C y terminen con a

select FIRST_name, LAST_name, salary
from EMPLOYEES
where FIRST_NAME like 'C%a';
-- todos los que contengan una c dentro. 
select FIRST_name, LAST_name, salary
from EMPLOYEES
where FIRST_NAME like '%c%';
--preguntar el empleado que esta en nul con depto id 
-- osea que  no tiene despto asignado 

select FIRST_name, LAST_name, salary
from EMPLOYEES
where DEPARTMENT_ID is null;


--preguntar el empleado que no esta en nul con depto id 
-- osea que  no tiene despto asignado 

select FIRST_name, LAST_name, salary
from EMPLOYEES
where DEPARTMENT_ID IS NOT NULL;

/*tabla dual 
*/
select * from dual ;
select 3 *4 from dual ;

/*
ver la fecha 
*/
SELECT SYSDATE FROM dual ;

/* ver que usuario esta haciendo la consulta */

select user from dual ;

/* concadenar consultas */
SELECT 'ESTA ES UNA CADENA '|| '' || 'ESTA ES OTRA CADENA '
FROM DUAL;

SELECT ('USUARIO: ' || USER || ', EL DIA DE HOY: ' || SYSDATE ) AS "ENCABEZADO "  
FROM DUAL;

-- COMO ESCRIBIR I AM DE LA FORMA CORTA
SELECT 'I''m '|| user from dual;

--MAS ORDER BY 

SELECT * FROM COUNTRIES;
-- PAISES ORDENADO POR ALFABETO 
SELECT * FROM COUNTRIES
ORDER BY COUNTRY_NAME;

--PAISES ORDENADO POR REGION 
SELECT * FROM COUNTRIES
ORDER BY REGION_ID;

-- ORDENADO ALFABETICAMENTE Y POR REGION 
SELECT * FROM COUNTRIES
ORDER BY REGION_ID, COUNTRY_NAME;

-- ORDEN DE EMPLEADOS DONDE EL DEPARTAMTO ID =90 Y POR APELLIDO = 3 PERSONAS
SELECT FIRST_NAME || ' ' || LAST_NAME  " EMPLEADOS NAME"
FROM EMPLOYEES
WHERE DEPARTMENT_ID=90
ORDER BY LAST_NAME;

/*SELECCIONAR LOS APELLIDO DE FORMA DESENTENTE DE LOS
EMPLEADOS  DE LA Z A LA A
*/
SELECT  LAST_NAME
FROM EMPLOYEES
ORDER BY LAST_NAME DESC;