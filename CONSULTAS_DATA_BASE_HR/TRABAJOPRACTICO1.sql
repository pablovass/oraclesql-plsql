
--EJERCICIO 1
--1. Elaborar una sentencia SQL que muestre los empleados que hayan sido contratados en el año 2006.

SELECT *
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '%2006';

--EJERCICIO 2
--2. Elaborar una sentencia SQL que muestre los empleados que perciban un salario menor a 10000.

SELECT *
FROM EMPLOYEES
WHERE SALARY < 10000;
/
--EJERCICIO 3
/*3. Elaborar una sentencia SQL que muestre los empleados que hayan sido contratados en el año 2004
y que también perciban un salario mayor o igual a 10000.
*/
SELECT *
FROM EMPLOYEES
WHERE HIRE_DATE  LIKE '%2004' AND   SALARY >= 10000;

/*
4. Elaborar una sentencia SQL que muestre aquellos empleados que hayan sido contratados en el año 2005 
y cuya función (job) sea “Programmer”. 
La consulta debe mostrar también los que pertenezcan al departamento de Marketing sin tener en cuenta el año de ingreso y función.
*/
SELECT EMPLOYEES.FIRST_NAME ||' '|| EMPLOYEES.LAST_NAME AS NOMBRES, 
      JOBS.JOB_TITLE AS PROFESION,
      DEPARTMENTS.DEPARTMENT_NAME AS DEPARTAMENTOS , 
      EMPLOYEES.HIRE_DATE as FECHA_DE_INGRESO
FROM EMPLOYEES, JOBS,DEPARTMENTS
WHERE (JOBS.JOB_TITLE='Programmer' AND EMPLOYEES.HIRE_DATE LIKE '%2005') or (DEPARTMENTS.DEPARTMENT_NAME='Marketing')  ;
/*
5. Elaborar una sentencia SQL que muestre el nombre de cada departamento y el nombre y apellido del manager asignado.
*/
SELECT EMPLOYEES.FIRST_NAME ||' '|| EMPLOYEES.LAST_NAME AS NOMBRES, 
       DEPARTMENTS.DEPARTMENT_NAME AS DEPARTAMENTOS , 
       DEPARTMENTS.MANAGER_ID
FROM EMPLOYEES,DEPARTMENTS;

SELECT EMPLOYEES.FIRST_NAME ||' '|| EMPLOYEES.LAST_NAME AS NOMBRES,
      JOBS.JOB_ID,
      JOBS.JOB_TITLE
FROM EMPLOYEES, JOBS
where JOBS.JOB_ID = 'IT_PROG';

--6. Elaborar una sentencia SQL que muestre ID, DIRECCION y CODIGO POSTAL de todas las oficinas (LOCATIONS) ubicadas en Estados Unidos y Canadá.
SELECT  LOCATION_ID AS ID ,
        STREET_ADDRESS AS dIRECCIONES ,
        POSTAL_CODE AS CODIGO_POSTAL,
        STATE_PROVINCE AS ESTADOS,
        COUNTRY_ID AS PAIS 
FROM  LOCATIONS
WHERE (COUNTRY_ID ='US') OR (COUNTRY_ID= 'CA') ;

--7. Elaborar una sentencia SQL que muestre en mayúsculas el nombre de las ciudades donde están ubicadas las oficinas (LOCATIONS) de Italia.

SELECT UPPER(CITY) AS CUIDADES, 
      COUNTRY_ID AS PAIS
FROM  LOCATIONS
WHERE COUNTRY_ID='IT';


/*
8. Elaborar una sentencia SQL que permita insertar como empleado a cada 
integrante del grupo (tabla EMPLOYEES) utilizando un valor de EMPLOYEE_ID 
mayor a 500. La fecha de contratación (HIRE_DATE) debe ser 01/08/2016, 
la función (JOB) debe ser “Programmer” y el departamento asignado debe ser “IT Support”.
*/
INSERT INTO EMPLOYEES(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, JOB_ID ,HIRE_DATE, DEPARTMENT_ID)
VALUES (501,'Pablo', 'Vallejos','DAVINCI' ,'IT_PROG' ,to_date('01082016','DD/MM/YY'), 210 );

/*
9. Elaborar una sentencia SQL que permita actualizar como manager del departamento “IT Support” 
(tabla DEPARTMENTS) a Diana Lorentz (ID_EMPLOYEE 107).
*/
--IT SOPORTE 210 
UPDATE EMPLOYEES
SET DEPARTMENT_ID=210
WHERE EMPLOYEE_ID=107;

--10. Elaborar una sentencia SQL que permita actualizar los empleados creados en el punto 8 asignándoles el manager del punto 9.

UPDATE EMPLOYEES
SET MANAGER_ID=103
WHERE EMPLOYEE_ID=501;

SELECT * FROM EMPLOYEES;