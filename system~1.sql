--- EJEMPLO DE COMPARAR VARCHAR Y VARCHAR2---

drop table tabla_prueba;

CREATE TABLE t_tipodato2(
    descripcion VARCHAR2(10));
    
insert into t_tipodato
    VALUES('ME LLAMO');
    
insert into t_tipodato2
    VALUES('ME LLAMO');

select * from user_tables where table_name = 'TABLA_PRUEBA';

select * from t_tipodato;

select * from t_tipodato where descripcion = 'ME LLAMO';

select * from t_tipodato x, t_tipodato2 y
    where trim(x.descripcion) = y.descripcion;