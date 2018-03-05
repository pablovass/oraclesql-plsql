/*
  1. crear una funci�n llamada year que reciba un par�metro de tipo fecha y retorne el a�o correspondiente.
  elaborar una sentencia sql que retorne los empleados que ingresaron en el a�o 2007 utilizando la funci�n year.
*/

create or replace function year(fechaentrada date)
return number
is
  a�os number;
begin
  a�os := to_char(fechaentrada,'yyyy');
  return a�os;
end year;
/


select (first_name || ' ' || last_name) nameemployee, year(hire_date) as year from employees
where year(hire_date) = '2007';


/*
  2. crear una funci�n llamada month que reciba un par�metro de tipo fecha y retorne el nombre del mes correspondiente
  (enero, febrero, marzo, etc.).
*/


create or replace function month(fechaentrada date)
return nvarchar2
is
  meses nvarchar2(20);
begin
  select to_char(fechaentrada,'month') into meses from dual;
  return meses;
end month;
/

declare
  mesprueba nvarchar2(20);
begin
  mesprueba := month('30/08/1995');
  dbms_output.put_line('mes: ' || mesprueba);
end;
/
/*
  3. crear una funci�n llamada day que reciba un par�metro de tipo fecha y retorne el nombre del d�a correspondiente
  (lunes, martes, etc.).
*/

create or replace function day(fechaentrada date)
return nvarchar2
is
  dias nvarchar2(20);
begin
  select to_char(fechaentrada,'day') into dias from dual;
  return dias;
end day;
/

declare
  diaprueba nvarchar2(20);
begin
  diaprueba := day('30/08/1995');
  dbms_output.put_line('dia: '|| diaprueba);
end;

/*
  4. crear una funci�n llamada fn_region que reciba un identificador de location (location_id) y retorne el nombre
  de la regi�n a la cual pertenece.
*/

/
create or replace function fn_region(id_locations number)
return nvarchar2
is
  nombreregion nvarchar2(30);
begin

  select region_name into nombreregion from regions
  inner join countries on regions.region_id = countries.region_id
  inner join locations on locations.country_id = countries.country_id
  where locations.location_id = id_locations;
  return nombreregion;
end fn_region;
/
  select fn_region(location_id) from locations order by 1 ;
  /
/*
  5. crear una funci�n llamada fn_calcular_antig que reciba un id de empleado y retorne la cantidad de a�os
  trabajados desde su contrataci�n hasta la actualidad.
*/
/
create or replace function fn_calcular_antig(id_empleado number)
return number
is
  cantidada�ostrabajados number;
begin
  select trunc((sysdate - hire_date)/364) into cantidada�ostrabajados from employees
  where employee_id = id_empleado;
  return cantidada�ostrabajados;
end fn_calcular_antig;
/

select first_name,last_name,fn_calcular_antig(employee_id) as a�ostrabajados from employees;
/
/*
  6. crear un procedimiento llamado pr_aumento_sueldo_depto que reciba como par�metros un
  identificador de departamento y un valor num�rico de porcentaje de aumento. dicho procedimiento debe efectuar
  un aumento del salario de cada empleado del departamento en base al valor (porcentaje) recibido como par�metro.
  el procedimiento debe devolver mediante un tercer par�metro de salida de tipo texto el valor ?ok? en caso de
  aplicar el aumento para todos los empleados o bien retornar ?error? en caso que ocurra alg�n error durante la
  ejecuci�n.
  se debe verificar previamente a aplicar los cambios que ambos par�metros de entrada no sean nulos
  (si alguno es nulo retornar ?error ? verificar parametros nulos? en el par�metro de salida).
*/
/
create or replace procedure pr_aumento_sueldo_depto (id_dep number, pr number)
is
  vid_dep number;
  vpr number;
begin
  vid_dep := id_dep;
  vpr := pr;
  if (vid_dep is not null) and (vpr is not null) then
    dbms_output.put_line('ok');
    update employees set salary = salary + (salary*vpr/100)
    where department_id = id_dep;
  else
    dbms_output.put_line('error - verificar parametros nulos');
  end if;
end pr_aumento_sueldo_depto;
/

declare
  id_depart number;
  vporcentaje number;
begin
  id_depart := 90;
  vporcentaje := 30;
  pr_aumento_sueldo_depto(id_depart,vporcentaje);
end;
/


/*
  7. crear un procedimiento llamado pr_detalle_empleados_depto que reciba como par�metro un identificador de departamento e imprima en pantalla como primera l�nea el nombre
  del departamento y luego detalle el nombre y apellido de cada empleado del departamento junto con su funci�n y salario.
  si el empleado cumple 10 a�os de antig�edad debe indicarse tambi�n.
*/

create or replace procedure pr_detalle_empleados_depto (id_dep number)
as
cursor curs_1
is
  select employee_id from employees where department_id=id_dep;

  vdep_name departments.department_name%type;
  vfirst_name employees.first_name%type;
  vlast_name employees.last_name%type;
  vfuncion jobs.job_title%type;
  vsalario employees.salary%type;
  vcant_empleados number;
  vid_empl number;
  vcontador number := 0;
  va�os number;
begin
  open curs_1;
  fetch curs_1 into vid_empl;

  select count(employee_id) into vcant_empleados from employees where department_id=id_dep;
  while (vcontador < vcant_empleados)
      loop
        select departments.department_name,employees.first_name,employees.last_name,jobs.job_title,employees.salary,trunc((sysdate - to_date(hire_date, 'dd/mm/yyyy'))/364) into vdep_name,vfirst_name,vlast_name,vfuncion,vsalario,va�os
        from employees inner join departments on employees.department_id = departments.department_id inner join jobs on employees.job_id = jobs.job_id where employees.department_id=id_dep and employees.employee_id=vid_empl order by employees.employee_id;

          dbms_output.put_line('departamento: ' || vdep_name);
          dbms_output.put_line('-----------------');
          dbms_output.put_line('empleado: ' || vfirst_name ||', '|| vlast_name);
          dbms_output.put_line('puesot: ' || vfuncion);
          dbms_output.put_line('salario: ' || vsalario);
          if (va�os = 10) then
            dbms_output.put_line('** cumple 10 a�os **');
          end if;
          dbms_output.put_line('-----------------');
          vcontador := vcontador + 1;
          vid_empl := vid_empl + 1;
      end loop;
      close curs_1;
    exception when others then dbms_output.put_line('error: '||sqlerrm);
end pr_detalle_empleados_depto;
/

declare
  vid_depto number;
begin
  vid_depto := 60;
pr_detalle_empleados_depto(vid_depto);
end;
/

/*
  8. crear un procedimiento llamado pr_aumentos que lea los registros de la tabla temporal cfg_aumento_departamento mediante un cursor
  y ejecute el procedure del punto 6 (pr_aumento_sueldo_depto) para cada registro configurado.
  los campos de la tabla son:
  department_id - number
  porcentaje_aumento - number(5,2)
  El proceso debe ir mostrando en pantalla el nombre del departamento procesado y el resultado de ejecutar el procedure pr_aumento_sueldo_depto.
*/

create global temporary table cfg_aumento_departamento (department_id number,porcentaje_aumento number(5,2));
  insert into cfg_aumento_departamento (department_id,porcentaje_aumento) values (10,60);
  insert into cfg_aumento_departamento (department_id,porcentaje_aumento) values (20,30);
  insert into cfg_aumento_departamento (department_id,porcentaje_aumento) values (40,10);

  select * from cfg_aumento_departamento;

create or replace procedure pr_aumentos
as
cursor curs_1_temp
is
  select department_id,porcentaje_aumento from cfg_aumento_departamento;
  vid_dep number;
  vpr number;
  vdep_name departments.department_name%type;
begin
  open curs_1_temp;
  fetch curs_1_temp into vid_dep, vpr;

  while (curs_1_temp%found)
    loop
      select department_name into vdep_name from departments where department_id = vid_dep;
      dbms_output.put_line('departamento: ' || vdep_name);
      pr_aumento_sueldo_depto(vid_dep,vpr);
      dbms_output.put_line(' ');
      fetch curs_1_temp into vid_dep,vpr;
    end loop;
end pr_aumentos;
/

begin
  pr_aumentos;
end;
/

/*
  9. elaborar una sentencia que permita modificar la tabla employees agreg�ndole dos nuevos campos:
  -usuario - varchar2(30)
  -fecha_modificacion - date
  crear un trigger en la tabla employees que grabe, ante un insert o update de alg�n
  registro, en los campos usuario y fecha_modificacion los valores correspondientes
  al usuario que realiza la acci�n y la fecha de ocurrencia.
*/

alter table employees add(usuario nvarchar2, fecha_modificacion date);

create or replace trigger employeetrigger
  before update or insert on employees
  for each row
begin
  if inserting then
      dbms_output.put_line('insertando datos');
  dbms_output.put_line('inserting');
  :new.usuario := user;
  :new.fecha_modificacion := sysdate;
  elsif updating then
   dbms_output.put_line(' - updating');
  :new.usuario := user;
  :new.fecha_modificacion := sysdate;
end if;
end employeetrigger;

update employees set last_name = 'paz' where employee_id = 100;

select * from employees where employee_id= 100;

/*
  10. elaborar una sentencia sql que permita crear la tabla employees_audit con los siguientes campos:
    -employee_id ? number(6)
    -salary_old ? number(8,2)
    -salary_new ? number(8,2)
    -fecha_modificacion ? date
  crear un trigger en la tabla employees que grabe, ante una modificaci�n de salario
  de alg�n empleado, los valores de salario actual y nuevo en la tabla employees_audit
  (campos salary_old y salary_new) junto con la fecha de modificaci�n
  correspondiente.
*/

create table employee_audit(
  employee_id number(6),
  salary_old number(8,2),
  salary_new number(8,2),
  fecha_modificacion date
);


create or replace trigger employee_audit_trigger
  before update on employees
    for each row
    declare
      sal_new number(8,2);
    begin
    :new.salary_old := old.salary_new;
    :new.salary_new := sal_new;
    :new.fecha_modificacion := sysdate;
end employee_audit_trigger;
/

update employees set salary = 3000 where employee_id = 100;
select * from employees where employee_id = 100 ;


--EJERCICIO 1
CREATE OR REPLACE
FUNCTION FN_YEAR (FECHA DATE )
RETURN VARCHAR2
IS
    VHIRE_DATE  EMPLOYEES.HIRE_DATE%TYPE;
BEGIN
    SELECT hire_date
    INTO VHIRE_DATE
    FROM EMPLOYEES
    WHERE HIRE_DATE = FECHA;

RETURN VHIRE_DATE;
END FN_YEAR;
/
/*
Elaborar una sentencia SQL que retorne los empleados que ingresaron
en el a�o 2007 utilizando la funci�n YEAR.

*/
DECLARE
V DATE ;
BEGIN
V :=('2007','YYYY');
SELECT FN_YEAR
FROM EMPLOYEES
WHERE HIRE_DATE= V;
END ;

--EJERCICIO 2
/*
  1. crear una función llamada year que reciba un parámetro de tipo fecha y retorne el año correspondiente.
  elaborar una sentencia sql que retorne los empleados que ingresaron en el año 2007 utilizando la función year.
*/

create or replace function year(fechaentrada date)
return number
is
  años number;
begin
  años := to_char(fechaentrada,'yyyy');
  return años;
end year;
/


select (first_name || ' ' || last_name) nameemployee, year(hire_date) as year from employees
where year(hire_date) = '2007';


/*
  2. crear una función llamada month que reciba un parámetro de tipo fecha y retorne el nombre del mes correspondiente
  (enero, febrero, marzo, etc.).
*/


create or replace function month(fechaentrada date)
return nvarchar2
is
  meses nvarchar2(20);
begin
  select to_char(fechaentrada,'month') into meses from dual;
  return meses;
end month;
/

declare
  mesprueba nvarchar2(20);
begin
  mesprueba := month('30/08/1995');
  dbms_output.put_line('mes: ' || mesprueba);
end;

/*
  3. crear una función llamada day que reciba un parámetro de tipo fecha y retorne el nombre del día correspondiente
  (lunes, martes, etc.).
*/

create or replace function day(fechaentrada date)
return nvarchar2
is
  dias nvarchar2(20);
begin
  select to_char(fechaentrada,'day') into dias from dual;
  return dias;
end day;
/

declare
  diaprueba nvarchar2(20);
begin
  diaprueba := day('30/08/1995');
  dbms_output.put_line('dia: '|| diaprueba);
end;

/*
  4. crear una función llamada fn_region que reciba un identificador de location (location_id) y retorne el nombre
  de la región a la cual pertenece.
*/


create or replace function fn_region(id_locations number)
return nvarchar2
is
  nombreregion nvarchar2(30);
begin

  select region_name into nombreregion from regions
  inner join countries on regions.region_id = countries.region_id
  inner join locations on locations.country_id = countries.country_id
  where locations.location_id = id_locations;
  return nombreregion;
end fn_region;

  select fn_region(location_id) from locations order by 1 ;

/*
  5. crear una función llamada fn_calcular_antig que reciba un id de empleado y retorne la cantidad de años
  trabajados desde su contratación hasta la actualidad.
*/

create or replace function fn_calcular_antig(id_empleado number)
return number
is
  cantidadañostrabajados number;
begin
  select trunc((sysdate - hire_date)/364) into cantidadañostrabajados from employees
  where employee_id = id_empleado;
  return cantidadañostrabajados;
end fn_calcular_antig;
/

select first_name,last_name,fn_calcular_antig(employee_id) as añostrabajados from employees;

/*
  6. crear un procedimiento llamado pr_aumento_sueldo_depto que reciba como parámetros un
  identificador de departamento y un valor numérico de porcentaje de aumento. dicho procedimiento debe efectuar
  un aumento del salario de cada empleado del departamento en base al valor (porcentaje) recibido como parámetro.
  el procedimiento debe devolver mediante un tercer parámetro de salida de tipo texto el valor ok en caso de
  aplicar el aumento para todos los empleados o bien retornar error en caso que ocurra algún error durante la
  ejecución.
  se debe verificar previamente a aplicar los cambios que ambos parámetros de entrada no sean nulos
  (si alguno es nulo retornar error  verificar parametros nulos en el parámetro de salida).
*/

create or replace procedure pr_aumento_sueldo_depto (id_dep number, pr number)
is
  vid_dep number;
  vpr number;
begin
  vid_dep := id_dep;
  vpr := pr;
  if (vid_dep is not null) and (vpr is not null) then
    dbms_output.put_line('ok');
    update employees set salary = salary + (salary*vpr/100)
    where department_id = id_dep;
  else
    dbms_output.put_line('error - verificar parametros nulos');
  end if;
end pr_aumento_sueldo_depto;
/

declare
  id_depart number;
  vporcentaje number;
begin
  id_depart := 90;
  vporcentaje := 30;
  pr_aumento_sueldo_depto(id_depart,vporcentaje);
end;
/


/*
  7. crear un procedimiento llamado pr_detalle_empleados_depto que reciba como parámetro un identificador de departamento e imprima en pantalla como primera línea el nombre
  del departamento y luego detalle el nombre y apellido de cada empleado del departamento junto con su función y salario.
  si el empleado cumple 10 años de antigüedad debe indicarse también.
*/

create or replace procedure pr_detalle_empleados_depto (id_dep number)
as
cursor curs_1
is
  select employee_id from employees where department_id=id_dep;

  vdep_name departments.department_name%type;
  vfirst_name employees.first_name%type;
  vlast_name employees.last_name%type;
  vfuncion jobs.job_title%type;
  vsalario employees.salary%type;
  vcant_empleados number;
  vid_empl number;
  vcontador number := 0;
  vaños number;
begin
  open curs_1;
  fetch curs_1 into vid_empl;

  select count(employee_id) into vcant_empleados from employees where department_id=id_dep;
  while (vcontador < vcant_empleados)
      loop
        select departments.department_name,employees.first_name,employees.last_name,jobs.job_title,employees.salary,trunc((sysdate - to_date(hire_date, 'dd/mm/yyyy'))/364) into vdep_name,vfirst_name,vlast_name,vfuncion,vsalario,vaños
        from employees inner join departments on employees.department_id = departments.department_id inner join jobs on employees.job_id = jobs.job_id where employees.department_id=id_dep and employees.employee_id=vid_empl order by employees.employee_id;

          dbms_output.put_line('departamento: ' || vdep_name);
          dbms_output.put_line('-----------------');
          dbms_output.put_line('empleado: ' || vfirst_name ||', '|| vlast_name);
          dbms_output.put_line('puesot: ' || vfuncion);
          dbms_output.put_line('salario: ' || vsalario);
          if (vaños = 10) then
            dbms_output.put_line('** cumple 10 años **');
          end if;
          dbms_output.put_line('-----------------');
          vcontador := vcontador + 1;
          vid_empl := vid_empl + 1;
      end loop;
      close curs_1;
    exception when others then dbms_output.put_line('error: '||sqlerrm);
end pr_detalle_empleados_depto;
/

declare
  vid_depto number;
begin
  vid_depto := 60;
pr_detalle_empleados_depto(vid_depto);
end;
/

/*
  8. crear un procedimiento llamado pr_aumentos que lea los registros de la tabla temporal cfg_aumento_departamento mediante un cursor
  y ejecute el procedure del punto 6 (pr_aumento_sueldo_depto) para cada registro configurado.
  los campos de la tabla son:
  department_id - number
  porcentaje_aumento - number(5,2)
  El proceso debe ir mostrando en pantalla el nombre del departamento procesado y el resultado de ejecutar el procedure pr_aumento_sueldo_depto.
*/

create global temporary table cfg_aumento_departamento (department_id number,porcentaje_aumento number(5,2));
  insert into cfg_aumento_departamento (department_id,porcentaje_aumento) values (10,60);
  insert into cfg_aumento_departamento (department_id,porcentaje_aumento) values (20,30);
  insert into cfg_aumento_departamento (department_id,porcentaje_aumento) values (40,10);

  select * from cfg_aumento_departamento;

create or replace procedure pr_aumentos
as
cursor curs_1_temp
is
  select department_id,porcentaje_aumento from cfg_aumento_departamento;
  vid_dep number;
  vpr number;
  vdep_name departments.department_name%type;
begin
  open curs_1_temp;
  fetch curs_1_temp into vid_dep, vpr;

  while (curs_1_temp%found)
    loop
      select department_name into vdep_name from departments where department_id = vid_dep;
      dbms_output.put_line('departamento: ' || vdep_name);
      pr_aumento_sueldo_depto(vid_dep,vpr);
      dbms_output.put_line(' ');
      fetch curs_1_temp into vid_dep,vpr;
    end loop;
end pr_aumentos;
/

begin
  pr_aumentos;
end;
/

/*
  9. elaborar una sentencia que permita modificar la tabla employees agregándole dos nuevos campos:
  -usuario - varchar2(30)
  -fecha_modificacion - date
  crear un trigger en la tabla employees que grabe, ante un insert o update de algún
  registro, en los campos usuario y fecha_modificacion los valores correspondientes
  al usuario que realiza la acción y la fecha de ocurrencia.
*/

alter table employees add(usuario nvarchar2, fecha_modificacion date);

create or replace trigger employeetrigger
  before update or insert on employees
  for each row
begin
  if inserting then
      dbms_output.put_line('insertando datos');
  dbms_output.put_line('inserting');
  :new.usuario := user;
  :new.fecha_modificacion := sysdate;
  elsif updating then
   dbms_output.put_line(' - updating');
  :new.usuario := user;
  :new.fecha_modificacion := sysdate;
end if;
end employeetrigger;

update employees set last_name = 'paz' where employee_id = 100;

select * from employees where employee_id= 100;

/*
  10. elaborar una sentencia sql que permita crear la tabla employees_audit con los siguientes campos:
    -employee_id  number(6)
    -salary_old  number(8,2)
    -salary_new  number(8,2)
    -fecha_modificacion  date
  crear un trigger en la tabla employees que grabe, ante una modificación de salario
  de algún empleado, los valores de salario actual y nuevo en la tabla employees_audit
  (campos salary_old y salary_new) junto con la fecha de modificación
  correspondiente.
*/

create table employee_audit(
  employee_id number(6),
  salary_old number(8,2),
  salary_new number(8,2),
  fecha_modificacion date
);


create or replace trigger employee_audit_trigger
  before update on employees
    for each row
    declare
      sal_new number(8,2);
    begin
    :new.salary_old := old.salary_new;
    :new.salary_new := sal_new;
    :new.fecha_modificacion := sysdate;
end employee_audit_trigger;
/

update employees set salary = 3000 where employee_id = 100;
select * from employees where employee_id = 100 ;


/*
  1. crear una función llamada year que reciba un parámetro de tipo fecha y retorne el año correspondiente.
  elaborar una sentencia sql que retorne los empleados que ingresaron en el año 2007 utilizando la función year.
*/

create or replace function year(fechaentrada date)
return number
is
  años number;
begin
  años := to_char(fechaentrada,'yyyy');
  return años;
end year;
/


select (first_name || ' ' || last_name) nameemployee, year(hire_date) as year from employees
where year(hire_date) = '2007';


/*
  2. crear una función llamada month que reciba un parámetro de tipo fecha y retorne el nombre del mes correspondiente
  (enero, febrero, marzo, etc.).
*/


create or replace function month(fechaentrada date)
return nvarchar2
is
  meses nvarchar2(20);
begin
  select to_char(fechaentrada,'month') into meses from dual;
  return meses;
end month;
/

declare
  mesprueba nvarchar2(20);
begin
  mesprueba := month('30/08/1995');
  dbms_output.put_line('mes: ' || mesprueba);
end;

/*
  3. crear una función llamada day que reciba un parámetro de tipo fecha y retorne el nombre del día correspondiente
  (lunes, martes, etc.).
*/

create or replace function day(fechaentrada date)
return nvarchar2
is
  dias nvarchar2(20);
begin
  select to_char(fechaentrada,'day') into dias from dual;
  return dias;
end day;
/

declare
  diaprueba nvarchar2(20);
begin
  diaprueba := day('30/08/1995');
  dbms_output.put_line('dia: '|| diaprueba);
end;

/*
  4. crear una función llamada fn_region que reciba un identificador de location (location_id) y retorne el nombre
  de la región a la cual pertenece.
*/


create or replace function fn_region(id_locations number)
return nvarchar2
is
  nombreregion nvarchar2(30);
begin

  select region_name into nombreregion from regions
  inner join countries on regions.region_id = countries.region_id
  inner join locations on locations.country_id = countries.country_id
  where locations.location_id = id_locations;
  return nombreregion;
end fn_region;

  select fn_region(location_id) from locations order by 1 ;

/*
  5. crear una función llamada fn_calcular_antig que reciba un id de empleado y retorne la cantidad de años
  trabajados desde su contratación hasta la actualidad.
*/

create or replace function fn_calcular_antig(id_empleado number)
return number
is
  cantidadañostrabajados number;
begin
  select trunc((sysdate - hire_date)/364) into cantidadañostrabajados from employees
  where employee_id = id_empleado;
  return cantidadañostrabajados;
end fn_calcular_antig;
/

select first_name,last_name,fn_calcular_antig(employee_id) as añostrabajados from employees;

/*
  6. crear un procedimiento llamado pr_aumento_sueldo_depto que reciba como parámetros un
  identificador de departamento y un valor numérico de porcentaje de aumento. dicho procedimiento debe efectuar
  un aumento del salario de cada empleado del departamento en base al valor (porcentaje) recibido como parámetro.
  el procedimiento debe devolver mediante un tercer parámetro de salida de tipo texto el valor ok en caso de
  aplicar el aumento para todos los empleados o bien retornar error en caso que ocurra algún error durante la
  ejecución.
  se debe verificar previamente a aplicar los cambios que ambos parámetros de entrada no sean nulos
  (si alguno es nulo retornar error  verificar parametros nulos en el parámetro de salida).
*/

create or replace procedure pr_aumento_sueldo_depto (id_dep number, pr number)
is
  vid_dep number;
  vpr number;
begin
  vid_dep := id_dep;
  vpr := pr;
  if (vid_dep is not null) and (vpr is not null) then
    dbms_output.put_line('ok');
    update employees set salary = salary + (salary*vpr/100)
    where department_id = id_dep;
  else
    dbms_output.put_line('error - verificar parametros nulos');
  end if;
end pr_aumento_sueldo_depto;
/

declare
  id_depart number;
  vporcentaje number;
begin
  id_depart := 90;
  vporcentaje := 30;
  pr_aumento_sueldo_depto(id_depart,vporcentaje);
end;
/


/*
  7. crear un procedimiento llamado pr_detalle_empleados_depto que reciba como parámetro un identificador de departamento e imprima en pantalla como primera línea el nombre
  del departamento y luego detalle el nombre y apellido de cada empleado del departamento junto con su función y salario.
  si el empleado cumple 10 años de antigüedad debe indicarse también.
*/

create or replace procedure pr_detalle_empleados_depto (id_dep number)
as
cursor curs_1
is
  select employee_id from employees where department_id=id_dep;

  vdep_name departments.department_name%type;
  vfirst_name employees.first_name%type;
  vlast_name employees.last_name%type;
  vfuncion jobs.job_title%type;
  vsalario employees.salary%type;
  vcant_empleados number;
  vid_empl number;
  vcontador number := 0;
  vaños number;
begin
  open curs_1;
  fetch curs_1 into vid_empl;

  select count(employee_id) into vcant_empleados from employees where department_id=id_dep;
  while (vcontador < vcant_empleados)
      loop
        select departments.department_name,employees.first_name,employees.last_name,jobs.job_title,employees.salary,trunc((sysdate - to_date(hire_date, 'dd/mm/yyyy'))/364) into vdep_name,vfirst_name,vlast_name,vfuncion,vsalario,vaños
        from employees inner join departments on employees.department_id = departments.department_id inner join jobs on employees.job_id = jobs.job_id where employees.department_id=id_dep and employees.employee_id=vid_empl order by employees.employee_id;

          dbms_output.put_line('departamento: ' || vdep_name);
          dbms_output.put_line('-----------------');
          dbms_output.put_line('empleado: ' || vfirst_name ||', '|| vlast_name);
          dbms_output.put_line('puesot: ' || vfuncion);
          dbms_output.put_line('salario: ' || vsalario);
          if (vaños = 10) then
            dbms_output.put_line('** cumple 10 años **');
          end if;
          dbms_output.put_line('-----------------');
          vcontador := vcontador + 1;
          vid_empl := vid_empl + 1;
      end loop;
      close curs_1;
    exception when others then dbms_output.put_line('error: '||sqlerrm);
end pr_detalle_empleados_depto;
/

declare
  vid_depto number;
begin
  vid_depto := 60;
pr_detalle_empleados_depto(vid_depto);
end;
/

/*
  8. crear un procedimiento llamado pr_aumentos que lea los registros de la tabla temporal cfg_aumento_departamento mediante un cursor
  y ejecute el procedure del punto 6 (pr_aumento_sueldo_depto) para cada registro configurado.
  los campos de la tabla son:
  department_id - number
  porcentaje_aumento - number(5,2)
  El proceso debe ir mostrando en pantalla el nombre del departamento procesado y el resultado de ejecutar el procedure pr_aumento_sueldo_depto.
*/

create global temporary table cfg_aumento_departamento (department_id number,porcentaje_aumento number(5,2));
  insert into cfg_aumento_departamento (department_id,porcentaje_aumento) values (10,60);
  insert into cfg_aumento_departamento (department_id,porcentaje_aumento) values (20,30);
  insert into cfg_aumento_departamento (department_id,porcentaje_aumento) values (40,10);

  select * from cfg_aumento_departamento;

create or replace procedure pr_aumentos
as
cursor curs_1_temp
is
  select department_id,porcentaje_aumento from cfg_aumento_departamento;
  vid_dep number;
  vpr number;
  vdep_name departments.department_name%type;
begin
  open curs_1_temp;
  fetch curs_1_temp into vid_dep, vpr;

  while (curs_1_temp%found)
    loop
      select department_name into vdep_name from departments where department_id = vid_dep;
      dbms_output.put_line('departamento: ' || vdep_name);
      pr_aumento_sueldo_depto(vid_dep,vpr);
      dbms_output.put_line(' ');
      fetch curs_1_temp into vid_dep,vpr;
    end loop;
end pr_aumentos;
/

begin
  pr_aumentos;
end;
/

/*
  9. elaborar una sentencia que permita modificar la tabla employees agregándole dos nuevos campos:
  -usuario - varchar2(30)
  -fecha_modificacion - date
  crear un trigger en la tabla employees que grabe, ante un insert o update de algún
  registro, en los campos usuario y fecha_modificacion los valores correspondientes
  al usuario que realiza la acción y la fecha de ocurrencia.
*/

alter table employees add(usuario nvarchar2, fecha_modificacion date);

create or replace trigger employeetrigger
  before update or insert on employees
  for each row
begin
  if inserting then
      dbms_output.put_line('insertando datos');
  dbms_output.put_line('inserting');
  :new.usuario := user;
  :new.fecha_modificacion := sysdate;
  elsif updating then
   dbms_output.put_line(' - updating');
  :new.usuario := user;
  :new.fecha_modificacion := sysdate;
end if;
end employeetrigger;

update employees set last_name = 'paz' where employee_id = 100;

select * from employees where employee_id= 100;

/*
  10. elaborar una sentencia sql que permita crear la tabla employees_audit con los siguientes campos:
    -employee_id  number(6)
    -salary_old  number(8,2)
    -salary_new  number(8,2)
    -fecha_modificacion  date
  crear un trigger en la tabla employees que grabe, ante una modificación de salario
  de algún empleado, los valores de salario actual y nuevo en la tabla employees_audit
  (campos salary_old y salary_new) junto con la fecha de modificación
  correspondiente.
*/

create table employee_audit(
  employee_id number(6),
  salary_old number(8,2),
  salary_new number(8,2),
  fecha_modificacion date
);


create or replace trigger employee_audit_trigger
  before update on employees
    for each row
    declare
      sal_new number(8,2);
    begin
    :new.salary_old := old.salary_new;
    :new.salary_new := sal_new;
    :new.fecha_modificacion := sysdate;
end employee_audit_trigger;
/

update employees set salary = 3000 where employee_id = 100;
select * from employees where employee_id = 100 ;


/*
  1. crear una función llamada year que reciba un parámetro de tipo fecha y retorne el año correspondiente.
  elaborar una sentencia sql que retorne los empleados que ingresaron en el año 2007 utilizando la función year.
*/

create or replace function year(fechaentrada date)
return number
is
  años number;
begin
  años := to_char(fechaentrada,'yyyy');
  return años;
end year;
/


select (first_name || ' ' || last_name) nameemployee, year(hire_date) as year from employees
where year(hire_date) = '2007';


/*
  2. crear una función llamada month que reciba un parámetro de tipo fecha y retorne el nombre del mes correspondiente
  (enero, febrero, marzo, etc.).
*/


create or replace function month(fechaentrada date)
return nvarchar2
is
  meses nvarchar2(20);
begin
  select to_char(fechaentrada,'month') into meses from dual;
  return meses;
end month;
/

declare
  mesprueba nvarchar2(20);
begin
  mesprueba := month('30/08/1995');
  dbms_output.put_line('mes: ' || mesprueba);
end;

/*
  3. crear una función llamada day que reciba un parámetro de tipo fecha y retorne el nombre del día correspondiente
  (lunes, martes, etc.).
*/

create or replace function day(fechaentrada date)
return nvarchar2
is
  dias nvarchar2(20);
begin
  select to_char(fechaentrada,'day') into dias from dual;
  return dias;
end day;
/

declare
  diaprueba nvarchar2(20);
begin
  diaprueba := day('30/08/1995');
  dbms_output.put_line('dia: '|| diaprueba);
end;

/*
  4. crear una función llamada fn_region que reciba un identificador de location (location_id) y retorne el nombre
  de la región a la cual pertenece.
*/


create or replace function fn_region(id_locations number)
return nvarchar2
is
  nombreregion nvarchar2(30);
begin

  select region_name into nombreregion from regions
  inner join countries on regions.region_id = countries.region_id
  inner join locations on locations.country_id = countries.country_id
  where locations.location_id = id_locations;
  return nombreregion;
end fn_region;

  select fn_region(location_id) from locations order by 1 ;

/*
  5. crear una función llamada fn_calcular_antig que reciba un id de empleado y retorne la cantidad de años
  trabajados desde su contratación hasta la actualidad.
*/

create or replace function fn_calcular_antig(id_empleado number)
return number
is
  cantidadañostrabajados number;
begin
  select trunc((sysdate - hire_date)/364) into cantidadañostrabajados from employees
  where employee_id = id_empleado;
  return cantidadañostrabajados;
end fn_calcular_antig;
/

select first_name,last_name,fn_calcular_antig(employee_id) as añostrabajados from employees;

/*
  6. crear un procedimiento llamado pr_aumento_sueldo_depto que reciba como parámetros un
  identificador de departamento y un valor numérico de porcentaje de aumento. dicho procedimiento debe efectuar
  un aumento del salario de cada empleado del departamento en base al valor (porcentaje) recibido como parámetro.
  el procedimiento debe devolver mediante un tercer parámetro de salida de tipo texto el valor ok en caso de
  aplicar el aumento para todos los empleados o bien retornar error en caso que ocurra algún error durante la
  ejecución.
  se debe verificar previamente a aplicar los cambios que ambos parámetros de entrada no sean nulos
  (si alguno es nulo retornar error  verificar parametros nulos en el parámetro de salida).
*/

create or replace procedure pr_aumento_sueldo_depto (id_dep number, pr number)
is
  vid_dep number;
  vpr number;
begin
  vid_dep := id_dep;
  vpr := pr;
  if (vid_dep is not null) and (vpr is not null) then
    dbms_output.put_line('ok');
    update employees set salary = salary + (salary*vpr/100)
    where department_id = id_dep;
  else
    dbms_output.put_line('error - verificar parametros nulos');
  end if;
end pr_aumento_sueldo_depto;
/

declare
  id_depart number;
  vporcentaje number;
begin
  id_depart := 90;
  vporcentaje := 30;
  pr_aumento_sueldo_depto(id_depart,vporcentaje);
end;
/


/*
  7. crear un procedimiento llamado pr_detalle_empleados_depto que reciba como parámetro un identificador de departamento e imprima en pantalla como primera línea el nombre
  del departamento y luego detalle el nombre y apellido de cada empleado del departamento junto con su función y salario.
  si el empleado cumple 10 años de antigüedad debe indicarse también.
*/

create or replace procedure pr_detalle_empleados_depto (id_dep number)
as
cursor curs_1
is
  select employee_id from employees where department_id=id_dep;

  vdep_name departments.department_name%type;
  vfirst_name employees.first_name%type;
  vlast_name employees.last_name%type;
  vfuncion jobs.job_title%type;
  vsalario employees.salary%type;
  vcant_empleados number;
  vid_empl number;
  vcontador number := 0;
  vaños number;
begin
  open curs_1;
  fetch curs_1 into vid_empl;

  select count(employee_id) into vcant_empleados from employees where department_id=id_dep;
  while (vcontador < vcant_empleados)
      loop
        select departments.department_name,employees.first_name,employees.last_name,jobs.job_title,employees.salary,trunc((sysdate - to_date(hire_date, 'dd/mm/yyyy'))/364) into vdep_name,vfirst_name,vlast_name,vfuncion,vsalario,vaños
        from employees inner join departments on employees.department_id = departments.department_id inner join jobs on employees.job_id = jobs.job_id where employees.department_id=id_dep and employees.employee_id=vid_empl order by employees.employee_id;

          dbms_output.put_line('departamento: ' || vdep_name);
          dbms_output.put_line('-----------------');
          dbms_output.put_line('empleado: ' || vfirst_name ||', '|| vlast_name);
          dbms_output.put_line('puesot: ' || vfuncion);
          dbms_output.put_line('salario: ' || vsalario);
          if (vaños = 10) then
            dbms_output.put_line('** cumple 10 años **');
          end if;
          dbms_output.put_line('-----------------');
          vcontador := vcontador + 1;
          vid_empl := vid_empl + 1;
      end loop;
      close curs_1;
    exception when others then dbms_output.put_line('error: '||sqlerrm);
end pr_detalle_empleados_depto;
/

declare
  vid_depto number;
begin
  vid_depto := 60;
pr_detalle_empleados_depto(vid_depto);
end;
/

/*
  8. crear un procedimiento llamado pr_aumentos que lea los registros de la tabla temporal cfg_aumento_departamento mediante un cursor
  y ejecute el procedure del punto 6 (pr_aumento_sueldo_depto) para cada registro configurado.
  los campos de la tabla son:
  department_id - number
  porcentaje_aumento - number(5,2)
  El proceso debe ir mostrando en pantalla el nombre del departamento procesado y el resultado de ejecutar el procedure pr_aumento_sueldo_depto.
*/

create global temporary table cfg_aumento_departamento (department_id number,porcentaje_aumento number(5,2));
  insert into cfg_aumento_departamento (department_id,porcentaje_aumento) values (10,60);
  insert into cfg_aumento_departamento (department_id,porcentaje_aumento) values (20,30);
  insert into cfg_aumento_departamento (department_id,porcentaje_aumento) values (40,10);

  select * from cfg_aumento_departamento;

create or replace procedure pr_aumentos
as
cursor curs_1_temp
is
  select department_id,porcentaje_aumento from cfg_aumento_departamento;
  vid_dep number;
  vpr number;
  vdep_name departments.department_name%type;
begin
  open curs_1_temp;
  fetch curs_1_temp into vid_dep, vpr;

  while (curs_1_temp%found)
    loop
      select department_name into vdep_name from departments where department_id = vid_dep;
      dbms_output.put_line('departamento: ' || vdep_name);
      pr_aumento_sueldo_depto(vid_dep,vpr);
      dbms_output.put_line(' ');
      fetch curs_1_temp into vid_dep,vpr;
    end loop;
end pr_aumentos;
/

begin
  pr_aumentos;
end;
/

/*
  9. elaborar una sentencia que permita modificar la tabla employees agregándole dos nuevos campos:
  -usuario - varchar2(30)
  -fecha_modificacion - date
  crear un trigger en la tabla employees que grabe, ante un insert o update de algún
  registro, en los campos usuario y fecha_modificacion los valores correspondientes
  al usuario que realiza la acción y la fecha de ocurrencia.
*/

alter table employees add(usuario nvarchar2, fecha_modificacion date);

create or replace trigger employeetrigger
  before update or insert on employees
  for each row
begin
  if inserting then
      dbms_output.put_line('insertando datos');
  dbms_output.put_line('inserting');
  :new.usuario := user;
  :new.fecha_modificacion := sysdate;
  elsif updating then
   dbms_output.put_line(' - updating');
  :new.usuario := user;
  :new.fecha_modificacion := sysdate;
end if;
end employeetrigger;

update employees set last_name = 'paz' where employee_id = 100;

select * from employees where employee_id= 100;

/*
  10. elaborar una sentencia sql que permita crear la tabla employees_audit con los siguientes campos:
    -employee_id  number(6)
    -salary_old  number(8,2)
    -salary_new  number(8,2)
    -fecha_modificacion  date
  crear un trigger en la tabla employees que grabe, ante una modificación de salario
  de algún empleado, los valores de salario actual y nuevo en la tabla employees_audit
  (campos salary_old y salary_new) junto con la fecha de modificación
  correspondiente.
*/

create table employee_audit(
  employee_id number(6),
  salary_old number(8,2),
  salary_new number(8,2),
  fecha_modificacion date
);


create or replace trigger employee_audit_trigger
  before update on employees
    for each row
    declare
      sal_new number(8,2);
    begin
    :new.salary_old := old.salary_new;
    :new.salary_new := sal_new;
    :new.fecha_modificacion := sysdate;
end employee_audit_trigger;
/

update employees set salary = 3000 where employee_id = 100;
select * from employees where employee_id = 100 ;


--EJERCICIO 1
CREATE OR REPLACE FUNCTION YEAR (fechaentrada date)
RETURN NUMBER
IS

  a�os NUMBER ;
BEGIN
  a�os := to_char(fechaentrada,'yyyy');
  RETURN a�os;
END YEAR ;
/


SELECT (first_name || ' ' || last_name) nameemployee, year(hire_date) as year
FROM EMPLOYEES
WHERE YEAR (HIRE_DATE)= '2007';

--EJERCICIO 2
create or replace function month(fechaentrada date)
return nvarchar2
is
  meses nvarchar2(20);
begin
  select to_char(fechaentrada,'month') into meses from dual;
  return meses;
end month;
/
declare
  mesprueba nvarchar2(20);
begin
  mesprueba := MONTH('30/08/1995');
  dbms_output.put_line('mes: ' || mesprueba);
end;

/
--EJERCICIO 3
create or replace function day(fechaentrada date)
return nvarchar2
is
  dias nvarchar2(20);
begin
  select to_char(fechaentrada,'day') into dias from dual;
  return dias;
end day;

/
declare
  diaprueba nvarchar2(20);
begin
  diaprueba := day('30/08/1995');
  dbms_output.put_line('dia: '|| diaprueba);
end;
/

--EJERCICIO 4
CREATE OR REPLACE FUNCTION FN_REGION (PLOC_ID NUMBER) RETURN VARCHAR2

IS
VREGION_NAME REGIONS.REGION_NAME%TYPE;
BEGIN

SELECT R.REGION_NAME INTO VREGION_NAME
FROM REGIONS  R INNER JOIN COUNTRIES C ON R.REGION_ID = C.REGION_ID
INNER JOIN LOCATIONS L ON C.COUNTRY_ID = L.COUNTRY_ID
WHERE L.LOCATION_ID = PLOC_ID;
RETURN VREGION_NAME;
END FN_REGION;
/
SELECT CITY, FN_REGION(LOCATION_ID) AS REGION_N
FROM LOCATIONS;
/
--EJERCICIO 5
CREATE OR REPLACE FUNCTION FN_CALCULAR_ANTIG (PEMP_ID INTEGER) RETURN INTEGER

IS
VCALCULAR_ANTIG NUMBER(8,2);

BEGIN
SELECT (SYSDATE - E.HIRE_DATE)/365 INTO VCALCULAR_ANTIG
FROM EMPLOYEES E
WHERE E.EMPLOYEE_ID = PEMP_ID;
RETURN VCALCULAR_ANTIG;
END FN_CALCULAR_ANTIG;
/
SELECT E.FIRST_NAME, E.LAST_NAME, E.HIRE_DATE, SYSDATE, FN_CALCULAR_ANTIG(EMPLOYEE_ID)
FROM EMPLOYEES E;
/
--EJERCICIO 6
CREATE OR REPLACE PROCEDURE PR_AUMENTO_SUELDO_DEPTO
(PDEP_ID IN NUMBER, PAUMENTO IN NUMBER)
IS
CURSOR CEMPLOYEES
IS
SELECT *
FROM EMPLOYEES E
WHERE E.DEPARTMENT_ID = DEPARTMENT_ID;

REMPLOYEES EMPLOYEES%ROWTYPE;

BEGIN

IF PDEP_ID IS NULL THEN
DBMS_OUTPUT.PUT('ERROR � INGRESAR DEPARTMENT_ID');
END IF;

IF PAUMENTO IS NULL THEN
DBMS_OUTPUT.PUT('ERROR � INGRESAR AUMENTO DESEADO');
END IF;

IF NOT CEMPLOYEES%ISOPEN THEN
OPEN CEMPLOYEES;
END IF;

LOOP
FETCH CEMPLOYEES INTO REMPLOYEES;
EXIT WHEN CEMPLOYEES%NOTFOUND;
--AUMENTO := EMPLOYEES_REG.SALARY + ((EMPLOYEES_REG.SALARY*PERC)/100);
UPDATE EMPLOYEES E
SET SALARY = REMPLOYEES.SALARY*PAUMENTO
WHERE E.DEPARTMENT_ID  = PDEP_ID;
END LOOP;
COMMIT;

IF CEMPLOYEES%ISOPEN THEN
CLOSE CEMPLOYEES;
END IF;

DBMS_OUTPUT.PUT_LINE('OK');

END PR_AUMENTO_SUELDO_DEPTO;

BEGIN
PR_AUMENTO_SUELDO_DEPTO(210,1.2);
END;

SELECT * FROM EMPLOYEES;

--EJERCICIO 7
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, E.FIRST_NAME, E.LAST_NAME,
J.JOB_TITLE, E.SALARY, E.HIRE_DATE, FN_CALCULAR_ANTIG(E.EMPLOYEE_ID) AS ANTIGUEDAD
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
INNER JOIN JOBS J ON E.JOB_ID = J.JOB_ID;

CREATE OR REPLACE PROCEDURE PR_DETALLE_EMPLEADOS_DEPTO (PDEP_ID IN NUMBER)
IS
CURSOR CEMPLOYEES

IS
SELECT *
FROM VIEW_EMPLOYEES
WHERE DEPARTMENT_ID = PDEP_ID;

REMPLOYEES VIEW_EMPLOYEES%ROWTYPE;

BEGIN
IF PDEP_ID IS NULL THEN
DBMS_OUTPUT.PUT('ERROR � VERIFICAR DEPARTAMENTO ID');
END IF;

IF NOT CEMPLOYEES%ISOPEN THEN
OPEN CEMPLOYEES;
END IF;

LOOP
FETCH CEMPLOYEES INTO REMPLOYEES;
EXIT WHEN CEMPLOYEES%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('----------------');
DBMS_OUTPUT.PUT_LINE('DEPARTAMENTO: ' || REMPLOYEES.DEPARTMENT_NAME);
DBMS_OUTPUT.PUT_LINE('----------------');
DBMS_OUTPUT.PUT_LINE('EMPLEADO: ' || REMPLOYEES.FIRST_NAME || ' ' || REMPLOYEES.LAST_NAME);
DBMS_OUTPUT.PUT_LINE('FUNCION: ' || REMPLOYEES.JOB_TITLE);
DBMS_OUTPUT.PUT_LINE('SALARIO: ' || TO_CHAR(REMPLOYEES.SALARY));
IF REMPLOYEES.ANTIGUEDAD >= 10 AND REMPLOYEES.ANTIGUEDAD <11 THEN
DBMS_OUTPUT.PUT_LINE('** CUMPLE 10 A�OS **');
END IF;
DBMS_OUTPUT.PUT_LINE('----------------');
END LOOP;

IF CEMPLOYEES%ISOPEN THEN
CLOSE CEMPLOYEES;
END IF;

END PR_DETALLE_EMPLEADOS_DEPTO;

BEGIN
PR_DETALLE_EMPLEADOS_DEPTO(210);
END;

--EJERCICIO 8
CREATE GLOBAL TEMPORARY TABLE CFG_AUMENTO_DEPARTAMENTO
ON COMMIT PRESERVE ROWS
AS SELECT * FROM DEPARTMENTS;

CREATE OR REPLACE PROCEDURE PR_AUMENTOS (PDEP_ID IN NUMBER,PAUMENTO IN NUMBER)

IS
CURSOR CEMPLOYEES

IS
SELECT *
FROM CFG_AUMENTO_DEPARTAMENTO
WHERE DEPARTMENT_ID = PDEP_ID;

REMPLOYEES CFG_AUMENTO_DEPARTAMENTO%ROWTYPE;

BEGIN

IF PDEP_ID IS NULL THEN
DBMS_OUTPUT.PUT('ERROR � DEPARTMENT ID');
END IF;

IF NOT CEMPLOYEES%ISOPEN THEN
OPEN CEMPLOYEES;
END IF;

LOOP
FETCH CEMPLOYEES INTO REMPLOYEES;
EXIT WHEN CEMPLOYEES%NOTFOUND;

PR_AUMENTO_SUELDO_DEPTO(REMPLOYEES.DEPARTMENT_ID,PAUMENTO);

DBMS_OUTPUT.PUT_LINE('----------------');
DBMS_OUTPUT.PUT_LINE('DEPARTAMENTO: ' || REMPLOYEES.DEPARTMENT_NAME);
DBMS_OUTPUT.PUT_LINE('----------------');
DBMS_OUTPUT.PUT_LINE('RESULTADO: OK');
END LOOP;

IF CEMPLOYEES%ISOPEN THEN
CLOSE CEMPLOYEES;
END IF;

END PR_AUMENTOS;

BEGIN
PR_AUMENTOS(210, 1.2);
END;

--EJERCICIO 9
ALTER TABLE EMPLOYEES ADD USUARIO VARCHAR2(30);

ALTER TABLE EMPLOYEES ADD FECHA_MODIFICACION DATE;

CREATE OR REPLACE TRIGGER LOG_EMPLOYEES
BEFORE INSERT OR UPDATE
OF FIRST_NAME, LAST_NAME, EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY, MANAGER_ID,DEPARTMENT_ID
ON EMPLOYEES
FOR EACH ROW

DECLARE VUSUARIO VARCHAR(30);

BEGIN
SELECT user INTO VUSUARIO FROM dual;
  :NEW.USUARIO := VUSUARIO;
  :NEW.FECHA_MODIFICACION := SYSDATE;
END;

UPDATE EMPLOYEES
SET SALARY = 43465
WHERE EMPLOYEE_ID = 100;
COMMIT;

SELECT * FROM EMPLOYEES;

--EJERCICIO 10
CREATE TABLE EMPLOYEES_AUDIT (EMPLOYEE_ID NUMBER(6), SALARY_OLD NUMBER(8,2),
SALARY_NEW NUMBER(8,2), FECHA_MODIFICACION DATE);

CREATE OR REPLACE TRIGGER LOG_EMPLOYEES_AUDIT
AFTER UPDATE
OF SALARY
ON EMPLOYEES
FOR EACH ROW

DECLARE VUSUARIO VARCHAR(30);

BEGIN
INSERT INTO EMPLOYEES_AUDIT
(EMPLOYEE_ID,SALARY_OLD, SALARY_NEW, FECHA_MODIFICACION)VALUES
( :OLD.EMPLOYEE_ID,:OLD.SALARY,:NEW.SALARY, SYSDATE);
END;
/
SELECT * FROM DEPARTMENTS;
/
UPDATE EMPLOYEES
SET SALARY =30000
WHERE EMPLOYEE_ID = 100;
COMMIT;

SELECT * FROM EMPLOYEES_AUDIT;


--EJERCICIO 1
CREATE OR REPLACE FUNCTION YEAR (fechaentrada date)
RETURN NUMBER
IS

  a�os NUMBER ;
BEGIN
  a�os := to_char(fechaentrada,'yyyy');
  RETURN a�os;
END YEAR ;
/


SELECT (first_name || ' ' || last_name) nameemployee, year(hire_date) as year
FROM EMPLOYEES
WHERE YEAR (HIRE_DATE)= '2007';

--EJERCICIO 2
create or replace function month(fechaentrada date)
return nvarchar2
is
  meses nvarchar2(20);
begin
  select to_char(fechaentrada,'month') into meses from dual;
  return meses;
end month;
/
declare
  mesprueba nvarchar2(20);
begin
  mesprueba := MONTH('30/08/1995');
  dbms_output.put_line('mes: ' || mesprueba);
end;

/
--EJERCICIO 3
create or replace function day(fechaentrada date)
return nvarchar2
is
  dias nvarchar2(20);
begin
  select to_char(fechaentrada,'day') into dias from dual;
  return dias;
end day;

/
declare
  diaprueba nvarchar2(20);
begin
  diaprueba := day('30/08/1995');
  dbms_output.put_line('dia: '|| diaprueba);
end;
/

--EJERCICIO 4
CREATE OR REPLACE FUNCTION FN_REGION (PLOC_ID NUMBER) RETURN VARCHAR2

IS
VREGION_NAME REGIONS.REGION_NAME%TYPE;
BEGIN

SELECT R.REGION_NAME INTO VREGION_NAME
FROM REGIONS  R INNER JOIN COUNTRIES C ON R.REGION_ID = C.REGION_ID
INNER JOIN LOCATIONS L ON C.COUNTRY_ID = L.COUNTRY_ID
WHERE L.LOCATION_ID = PLOC_ID;
RETURN VREGION_NAME;
END FN_REGION;
/
SELECT CITY, FN_REGION(LOCATION_ID) AS REGION_N
FROM LOCATIONS;
/
--EJERCICIO 5
CREATE OR REPLACE FUNCTION FN_CALCULAR_ANTIG (PEMP_ID INTEGER) RETURN INTEGER

IS
VCALCULAR_ANTIG NUMBER(8,2);

BEGIN
SELECT (SYSDATE - E.HIRE_DATE)/365 INTO VCALCULAR_ANTIG
FROM EMPLOYEES E
WHERE E.EMPLOYEE_ID = PEMP_ID;
RETURN VCALCULAR_ANTIG;
END FN_CALCULAR_ANTIG;
/
SELECT E.FIRST_NAME, E.LAST_NAME, E.HIRE_DATE, SYSDATE, FN_CALCULAR_ANTIG(EMPLOYEE_ID)
FROM EMPLOYEES E;
/
--EJERCICIO 6
CREATE OR REPLACE PROCEDURE PR_AUMENTO_SUELDO_DEPTO
(PDEP_ID IN NUMBER, PAUMENTO IN NUMBER)
IS
CURSOR CEMPLOYEES
IS
SELECT *
FROM EMPLOYEES E
WHERE E.DEPARTMENT_ID = DEPARTMENT_ID;

REMPLOYEES EMPLOYEES%ROWTYPE;

BEGIN

IF PDEP_ID IS NULL THEN
DBMS_OUTPUT.PUT('ERROR � INGRESAR DEPARTMENT_ID');
END IF;

IF PAUMENTO IS NULL THEN
DBMS_OUTPUT.PUT('ERROR � INGRESAR AUMENTO DESEADO');
END IF;

IF NOT CEMPLOYEES%ISOPEN THEN
OPEN CEMPLOYEES;
END IF;

LOOP
FETCH CEMPLOYEES INTO REMPLOYEES;
EXIT WHEN CEMPLOYEES%NOTFOUND;
--AUMENTO := EMPLOYEES_REG.SALARY + ((EMPLOYEES_REG.SALARY*PERC)/100);
UPDATE EMPLOYEES E
SET SALARY = REMPLOYEES.SALARY*PAUMENTO
WHERE E.DEPARTMENT_ID  = PDEP_ID;
END LOOP;
COMMIT;

IF CEMPLOYEES%ISOPEN THEN
CLOSE CEMPLOYEES;
END IF;

DBMS_OUTPUT.PUT_LINE('OK');

END PR_AUMENTO_SUELDO_DEPTO;

BEGIN
PR_AUMENTO_SUELDO_DEPTO(210,1.2);
END;

SELECT * FROM EMPLOYEES;

--EJERCICIO 7
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, E.FIRST_NAME, E.LAST_NAME,
J.JOB_TITLE, E.SALARY, E.HIRE_DATE, FN_CALCULAR_ANTIG(E.EMPLOYEE_ID) AS ANTIGUEDAD
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
INNER JOIN JOBS J ON E.JOB_ID = J.JOB_ID;

CREATE OR REPLACE PROCEDURE PR_DETALLE_EMPLEADOS_DEPTO (PDEP_ID IN NUMBER)
IS
CURSOR CEMPLOYEES

IS
SELECT *
FROM VIEW_EMPLOYEES
WHERE DEPARTMENT_ID = PDEP_ID;

REMPLOYEES VIEW_EMPLOYEES%ROWTYPE;

BEGIN
IF PDEP_ID IS NULL THEN
DBMS_OUTPUT.PUT('ERROR � VERIFICAR DEPARTAMENTO ID');
END IF;

IF NOT CEMPLOYEES%ISOPEN THEN
OPEN CEMPLOYEES;
END IF;

LOOP
FETCH CEMPLOYEES INTO REMPLOYEES;
EXIT WHEN CEMPLOYEES%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('----------------');
DBMS_OUTPUT.PUT_LINE('DEPARTAMENTO: ' || REMPLOYEES.DEPARTMENT_NAME);
DBMS_OUTPUT.PUT_LINE('----------------');
DBMS_OUTPUT.PUT_LINE('EMPLEADO: ' || REMPLOYEES.FIRST_NAME || ' ' || REMPLOYEES.LAST_NAME);
DBMS_OUTPUT.PUT_LINE('FUNCION: ' || REMPLOYEES.JOB_TITLE);
DBMS_OUTPUT.PUT_LINE('SALARIO: ' || TO_CHAR(REMPLOYEES.SALARY));
IF REMPLOYEES.ANTIGUEDAD >= 10 AND REMPLOYEES.ANTIGUEDAD <11 THEN
DBMS_OUTPUT.PUT_LINE('** CUMPLE 10 A�OS **');
END IF;
DBMS_OUTPUT.PUT_LINE('----------------');
END LOOP;

IF CEMPLOYEES%ISOPEN THEN
CLOSE CEMPLOYEES;
END IF;

END PR_DETALLE_EMPLEADOS_DEPTO;

BEGIN
PR_DETALLE_EMPLEADOS_DEPTO(210);
END;

--EJERCICIO 8
CREATE GLOBAL TEMPORARY TABLE CFG_AUMENTO_DEPARTAMENTO
ON COMMIT PRESERVE ROWS
AS SELECT * FROM DEPARTMENTS;

CREATE OR REPLACE PROCEDURE PR_AUMENTOS (PDEP_ID IN NUMBER,PAUMENTO IN NUMBER)

IS
CURSOR CEMPLOYEES

IS
SELECT *
FROM CFG_AUMENTO_DEPARTAMENTO
WHERE DEPARTMENT_ID = PDEP_ID;

REMPLOYEES CFG_AUMENTO_DEPARTAMENTO%ROWTYPE;

BEGIN

IF PDEP_ID IS NULL THEN
DBMS_OUTPUT.PUT('ERROR � DEPARTMENT ID');
END IF;

IF NOT CEMPLOYEES%ISOPEN THEN
OPEN CEMPLOYEES;
END IF;

LOOP
FETCH CEMPLOYEES INTO REMPLOYEES;
EXIT WHEN CEMPLOYEES%NOTFOUND;

PR_AUMENTO_SUELDO_DEPTO(REMPLOYEES.DEPARTMENT_ID,PAUMENTO);

DBMS_OUTPUT.PUT_LINE('----------------');
DBMS_OUTPUT.PUT_LINE('DEPARTAMENTO: ' || REMPLOYEES.DEPARTMENT_NAME);
DBMS_OUTPUT.PUT_LINE('----------------');
DBMS_OUTPUT.PUT_LINE('RESULTADO: OK');
END LOOP;

IF CEMPLOYEES%ISOPEN THEN
CLOSE CEMPLOYEES;
END IF;

END PR_AUMENTOS;

BEGIN
PR_AUMENTOS(210, 1.2);
END;

--EJERCICIO 9
ALTER TABLE EMPLOYEES ADD USUARIO VARCHAR2(30);

ALTER TABLE EMPLOYEES ADD FECHA_MODIFICACION DATE;

CREATE OR REPLACE TRIGGER LOG_EMPLOYEES
BEFORE INSERT OR UPDATE
OF FIRST_NAME, LAST_NAME, EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY, MANAGER_ID,DEPARTMENT_ID
ON EMPLOYEES
FOR EACH ROW

DECLARE VUSUARIO VARCHAR(30);

BEGIN
SELECT user INTO VUSUARIO FROM dual;
  :NEW.USUARIO := VUSUARIO;
  :NEW.FECHA_MODIFICACION := SYSDATE;
END;

UPDATE EMPLOYEES
SET SALARY = 43465
WHERE EMPLOYEE_ID = 100;
COMMIT;

SELECT * FROM EMPLOYEES;

--EJERCICIO 10
CREATE TABLE EMPLOYEES_AUDIT (EMPLOYEE_ID NUMBER(6), SALARY_OLD NUMBER(8,2),
SALARY_NEW NUMBER(8,2), FECHA_MODIFICACION DATE);

CREATE OR REPLACE TRIGGER LOG_EMPLOYEES_AUDIT
AFTER UPDATE
OF SALARY
ON EMPLOYEES
FOR EACH ROW

DECLARE VUSUARIO VARCHAR(30);

BEGIN
INSERT INTO EMPLOYEES_AUDIT
(EMPLOYEE_ID,SALARY_OLD, SALARY_NEW, FECHA_MODIFICACION)VALUES
( :OLD.EMPLOYEE_ID,:OLD.SALARY,:NEW.SALARY, SYSDATE);
END;
/
SELECT * FROM DEPARTMENTS;
/
UPDATE EMPLOYEES
SET SALARY =30000
WHERE EMPLOYEE_ID = 100;
COMMIT;

SELECT * FROM EMPLOYEES_AUDIT;
