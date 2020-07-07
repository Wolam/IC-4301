--- Planes de ejcucion sobre consultas ---
create table mis_empleados as
select * from HR.employees;


-- Plan Ejecucion Estimado
EXPLAIN PLAN FOR
Select first_name    
    FROM mis_empleados
where employee_id = 112;

Select * from table (dbms_xplan.display);

---Plan Ejecucion Real

Select first_name    
    FROM mis_empleados
where employee_id = 112;

Select * from table (dbms_xplan.display_cursor);

--- Creacion de indices

--TIPO UNIQUE
Create unique index id_empleado_idx
    on mis_empleados (employee_id);

--TIPO BITMAP
Create BITMAP index phone_number_idx
    on mis_empleados (phone_number);

--- INDICES SOBRE EL SALARIO
Create index salary_idx_mis_empleados
    on mis_empleados (salary);
    
Select * from mis_empleados
    where salary >2400;
    
Select * from table (dbms_xplan.display_cursor);

Select * from mis_empleados
    where salary >13000;

 Select * from table (dbms_xplan.display_cursor);

---Optimizacion con LENGTH

Select first_name
from mis_empleados
where length(last_name)>5;

--Indice del largo
create index l_name_idx
    on mis_empleados(last_name, length(last_name));
    
    
--- Ejemplo de EXTRACT DATE    
Create index hire_date_idx on mis_empleados (EXTRACT(YEAR FROM HIRE_DATE));

Select * from mis_empleados where extract(year from hire_date)=1998;

Select * from table(dbms_xplan.display_cursor);


--- Ejemplo de primer y segundo nombre
Create index first_last_name_idx on mis_empleados (first_name,last_name);

Select * from mis_empleados where last_name='Cambrault' ;

Select * from table(dbms_xplan.display_cursor);

select  * from user_indexes where table_name = 'MIS_EMPLEADOS';
DROP INDEX L_NAME_IDX; 
 
