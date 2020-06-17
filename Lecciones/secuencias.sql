/*
EJEMPLOS DE SECUENCIAS,T_TEMPORALES/GLOBALES Y EXCEPCIONES 
*/
----- Ejemplo de secuencias----
create sequence seq_pagos
    start with 10 
    increment by 1
    maxvalue 21
    cycle;

select seq_pagos.Nextval from dual;

create table pagos(
    numero_pago NUMBER,
    fecha DATE,
    monto  number(10,2),
    primary key (numero_pago));
    
insert into pagos 
    values (seq_pagos.nextval, sysdate,110.05);

-- formatear las fechas de los pagos --
select numero_pago, to_char(fecha , 'dd-mm-yyyy hh24:mi:ss')fecha, monto from pagos;

select * from pagos;

CREATE GLOBAL 
    TEMPORARY TABLE temp_cuenta as
    select * from cuenta;

select * from temp_cuenta;
drop table temp_cuenta;

create global
    temporary table temp_cuenta
    on commit preserve rows as
    select * from cuenta;
    
insert into temp_cuenta
    values('C-007','Plata',150);
    
--- prueba excepciones---
exec agregar_sucursal('BN Bank','Guacima',1000);
set serveroutput ON;
BEGIN
    insert into sucursal values ('BN Bank','Guacima',1000);
    DBMS_OUTPUT.put_line('Se ha insertado la sucursal: BN BANK');
    EXCEPTION WHEN OTHERS THEN
        IF SQLCODE=1 THEN
            DBMS_OUTPUT.put_line(' Ya existe esa sucursal');
        ELSE:
            DBMS_OUTPUT.put_line(SQLERRM);
        END IF;
END;
/