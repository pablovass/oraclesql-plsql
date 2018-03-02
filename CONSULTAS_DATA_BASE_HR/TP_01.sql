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

