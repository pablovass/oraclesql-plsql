/*
Elaborar una sentencia SQL que muestre los empleados que hayan sido contratados
en el año 2006 */

SELECT LAST_NAME, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN TO_DATE('01/01/2006','DD/MM/YYYY')and TO_DATE('31/12/2006','DD/MM/YYYY')   ;

/*
Elaborar una sentencia SQL que muestre los empleados que perciban un salario
menor a 10000
*/

SELECT LAST_NAME, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY <10000   ;
/*
Elaborar una sentencia SQL que muestre los empleados que hayan sido contratados
en el año 2004 y que también perciban un salario mayor o igual a 10000.
*/
SELECT LAST_NAME, FIRST_NAME, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '%2004' AND SALARY >=10000;

/*
Elaborar una sentencia SQL que muestre el nombre de cada departamento y el
nombre y apellido del manager asignado
*/
SELECT D.DEPARTMENT_NAME, FIRST_NAME, LAST_NAME 
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.MANAGER_ID=E.EMPLOYEE_ID;

desc DEPARTMENTS;
desc EMPLOYEES;
-- esta no te muestra los que tienen valores nulos 
SELECT DEPARTMENT_NAME, FIRST_NAME, LAST_NAME
from DEPARTMENTS d join EMPLOYEES E
ON d.MANAGER_ID=E.EMPLOYEE_ID;
/*
6-Elaborar una sentencia SQL que muestre ID, DIRECCION y CODIGO POSTAL de todas
las oficinas (LOCATIONS) ubicadas en Estados Unidos y Canadá.

*/
SELECT * FROM LOCATIONS; 

SELECT LOCATION_ID, STREET_ADDRESS,POSTAL_CODE, COUNTRY_ID
FROM LOCATIONS
WHERE (COUNTRY_ID = 'US')OR (COUNTRY_ID= 'CA');

/*
Elaborar una sentencia SQL que muestre en mayúsculas el nombre de las ciudades
donde están ubicadas las oficinas (LOCATIONS) de Italia.
*/
SELECT UPPER(CITY) AS CUIDADES, 
      COUNTRY_ID AS PAIS
FROM  LOCATIONS
WHERE COUNTRY_ID='IT';

/*
Elaborar una sentencia SQL que permita insertar como empleado a cada integrante
del grupo (tabla EMPLOYEES) utilizando un valor de EMPLOYEE_ID mayor a 500. La
fecha de contratación (HIRE_DATE) debe ser 01/08/2016, la función (JOB) debe ser
“Programmer” y el departamento asignado debe ser “IT Support

*/

INSERT INTO EMPLOYEES(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, JOB_ID ,HIRE_DATE, DEPARTMENT_ID)
VALUES (501,'Pablo', 'Vallejos','DAVINCI' ,'IT_PROG' ,to_date('01082016','DD/MM/YY'), 210 );
SELECT *FROM EMPLOYEES;

/*
Elaborar una sentencia SQL que permita actualizar como manager del departamento
“IT Support” (tabla DEPARTMENTS) a Diana Lorentz (ID_EMPLOYEE 107).
*/

UPDATE EMPLOYEES
SET DEPARTMENT_ID=210
WHERE EMPLOYEE_ID=107;

/*
10-Elaborar una sentencia SQL que permita actualizar los empleados creados en el punto
8 asignándoles el manager del punto 9.
*/
UPDATE EMPLOYEES
SET MANAGER_ID=103
WHERE EMPLOYEE_ID=501;

SELECT * FROM EMPLOYEES;
