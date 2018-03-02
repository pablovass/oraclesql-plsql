// estos son los scrit de selet del usuario hr:
//para escribir en aqua hay que eliminar los ";" los puntos y comas finales.

select * from JOBS

// el comando decribe no funciona en aqua 
describe JOBS
//mas select 
select JOB_ID from JOBS

select JOB_ID from JOBS

SELECT JOB_ID, MIN_SALARY  FROM JOBS  


SELECT job_id AS Trabajo , min_salary as "minimo salario " from JOBS 
// es el describe su otra forma de escritura 
DESC EMPLOYEES

SELECT department_id  FROM EMPLOYEES

SELECT DISTINCT department_id  FROM EMPLOYEES

SELECT DISTINCT department_id  , job_id  from EMPLOYEES

select * from REGIONS

//tablas nombre de la tabla dual 

select 3*4 from EMPLOYEES


select* from dual 

select 3*4 from dual 

select 'hola mundo ' from dual 

select sysdate from dual 

select user from dual 

select 'Esta es una cadena ' || ' '||' Otra cadena de prueva '   from  dual 

select ('usuario ' || user || ', el dia de hoy es : '|| sysdate) as Encabesado  
from dual 

//where 

select  first_name || '' || last_name "Name", department_id
from employees
where DEPARTMENT_ID = 80


select  department_name 
from DEPARTMENTS
where DEPARTMENT_ID = 90


select* from JOB_HISTORY
where job_id = 'AC_ACCOUNT'

SELECT region_name FROM REGIONS
WHERE region_id = 4

--diferente <>, != 

select first_name || ''|| last_name "Name", commission_pct
from EMPLOYEES
where commission_pct != 0.35


select first_name || ''|| last_name "Name", commission_pct
from EMPLOYEES
where commission_pct >= 0.35

--IN definir de valores 

select first_name || ''|| last_name "Name", department_id
from EMPLOYEES
where department_id IN (10,20,50)


--mas filros
select first_name, department_id
from EMPLOYEES
where not (department_id >= 30)

select first_name, salary
from EMPLOYEES
where last_name= 'Smith' and salary > 7500

select first_name , last_name
from EMPLOYEES
where first_name = 'Kelly 'or last_name = 'Smith'

--between
select first_name , last_name, salary
from EMPLOYEES
where salary between 5000 and 6000

-- mismo resultado que between 
select first_name , last_name, salary
from EMPLOYEES
where salary >=5000 and salary <=6000

-- comodin %% remplasa uno o mas caracteres
select first_name , last_name
from EMPLOYEES
where first_name like '%m%'




-- las comparasiones contra null con = no se pueden hacer . ejem.
select first_name , last_name 
from EMPLOYEES
where department_id =  null

-- asi se hace 
select first_name , last_name 
from EMPLOYEES
where department_id is null

select first_name , last_name 
from EMPLOYEES
where department_id is not null

-- Order by 

select * from COUNTRIES
order by region_id, country_name 

select first_name || '' || last_name "Employess name"
from EMPLOYEES 
where department_id = 90
order by last_name