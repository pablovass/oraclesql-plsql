/*
Elaborar una sentencia SQL que muestre los empleados que hayan sido contratados
en el año 2006 */

SELECT LAST_NAME, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN TO_DATE('01/01/2006','DD/MM/YYYY')and TO_DATE('31/12/2006','DD/MM/YYYY')   ;

