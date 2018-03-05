SELECT * FROM COUNTRIES;

SELECT * FROM JOBS;

DESCRIBE jobs; /* describe los datos de una tabla */

SELECT job_id, min_salary 
FROM JOBS;

/*alias */
SELECT job_id AS  "Trabajos" ,min_salary AS "salario minimo"  from  JOBS;

DESC EMPLOYEES;
/* Departamentos que pertenecen a los empleados */

select DEPARTMENT_ID from EMPLOYEES;
/* que departamentos si estan asignados */
SELECT DISTINCT department_id  FROM EMPLOYEES;
/*DISTINCT TAMBIEN SE PUEDE USAR CUNDO TENEMOS MAS DE UNA COLUMNA*/

SELECT DISTINCT department_id , JOB_ID FROM EMPLOYEES;/* MUESTAS MAS DATOS Y REPETIDO DADO A LA COMPARACION DE LA OTRA TABLE*/

/*tabla dual */
SELECT * FROM dual;
SELECT 2*4 FROM dual;

SELECT 'hola mundo ' FROM dual;
select SYSDATE  from dual; /*para la fecha */
SELECT USER FROM DUAL ;

SELECT 'esto es una cadena ' || ' '|| 'otra cadenal de prueva ' FROM dual;
/* con encabezado*/

SELECT ('Usuario: '|| user || ', el dia de hoy es: ' || SYSDATE)AS " Encabezado" from dual;

