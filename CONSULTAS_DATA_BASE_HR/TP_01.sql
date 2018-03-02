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