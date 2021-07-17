
--- EJEMPLOS DE INSERTAR CARACTERES ESPECIALES---- 

select * from cliente;

delete from cliente
where nombre_cliente ='Zesta';

insert into cliente values('Zesta','Xcape','Einstein');

create table tabla_byte(hilera varchar2(8));
create table tablachar(hilera varchar2(8 char));


alter table tabla_byte hilera varchar2(8 char);
ALTER TABLE tabla_byte modify (hilera varchar2(8 char));

insert into tabla_byte values('abc12345');
insert into tabla_byte values('oración.');

insert into tablachar values('abc12345');
insert into tablachar values('oración.');

select * from tablachar;
select * from tabla_byte;



-- sleccionar max saldos---

select * from (select * from cuenta ORDER BY  saldo desc) 
where rownum <=3;
 
select nombre_sucursal, avg(saldo)
from cuenta
group by nombre_sucursal;