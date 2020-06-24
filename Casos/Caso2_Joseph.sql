--- CREAR LAS TABLAS CON RESPECTIVOS DATOS ---
CREATE TABLE profesor
    (id_profesor number(10) NOT NULL,
    nombre_profesor varchar2(30) NOT NULL,
    id_departamento varchar2(5 CHAR) NOT NULL,
    PRIMARY KEY (id_profesor));

drop table grupo;

CREATE TABLE grupo
    (num_grupo number(2) NOT NULL,
    id_profesor number(10),
    id_materia varchar2(8 CHAR) NOT NULL,
    constraint UC_grupo unique (num_grupo, id_profesor));
    
--llave foranea grupo
ALTER TABLE grupo 
    add constraint FK_grupo
    foreign key (id_profesor)
    references profesor (id_profesor);
    
CREATE TABLE estudiante
    (carnet number(10) NOT NULL,
    nombre_estudiante varchar2(30) NOT NULL,
    id_provincia number NOT NULL,
    PRIMARY KEY (carnet)); 

CREATE TABLE provincia 
    (id_provincia number(1) NOT NULL,
    provincia varchar2(15) NOT NULL,
    PRIMARY KEY (id_provincia),
    constraint UC_provincia unique (provincia));
  
CREATE TABLE beca
    (id_beca varchar2(10 CHAR) NOT NULL,
    nombre_beca varchar2(20) NOT NULL,
    Monto number(8,2) NOT NULL,
    PRIMARY KEY (id_beca),
    constraint UC_beca unique (nombre_beca));
    
drop table aula;   
CREATE TABLE materia
    (nombre_materia VARCHAR2(30) NOT NULL,
    id_materia VARCHAR2(8 CHAR) NOT NULL,
    creditos NUMBER(2) NOT NULL,
    id_departamento VARCHAR2(3 CHAR) NOT NULL,
    PRIMARY KEY (id_materia),
    constraint UC_materia unique (nombre_materia));
   
--FORANEA DE MATERIA   
ALTER TABLE materia 
    add constraint FK_materia
    foreign key (id_departamento)
    references departamento (id_departamento);
    
CREATE TABLE departamento
    (nombre_departamento VARCHAR2(20) NOT NULL,
    id_departamento VARCHAR2(3 CHAR) NOT NULL,
    PRIMARY KEY (id_departamento),
    constraint UC_departamento unique (nombre_departamento));
    
CREATE TABLE aula
    (id_aula NUMBER(3) NOT NULL,
    nombre_aula VARCHAR2(8 CHAR) NOT NULL,
    PRIMARY KEY (id_aula),
    constraint UC_aula unique (nombre_aula));
    
drop table horario;

CREATE TABLE horario
    (id_horario NUMBER(3) NOT NULL,
    dia CHAR(1) NOT NULL,
    hora_inicio date NOT NULL,
    hora_fin date NOT NULL,
    PRIMARY KEY (id_horario),
    constraint UC_horario unique (dia, hora_inicio, hora_fin));
    
 --- INSERTAR VALORES A LAS TABLAS SIN RELACIONAR ---    

---VALORES A ESTUDIANTE
INSERT INTO estudiante 
    values (2019039864, 'Joseph Valenciano Madrigal', 2);
INSERT INTO estudiante 
    values (2019344583, 'Wilhelm Carstens Soto', 2);
INSERT INTO estudiante 
    values (2015329584, 'Jeremy Madrigal Portilla', 4);
INSERT INTO estudiante 
    values (2008654327, 'Felipe Suarez Rodriguez', 2);
INSERT INTO estudiante 
    values (2016175133, 'David Herrera Cortina', 2);   
  
---VALORES A PROVINCIA
INSERT INTO provincia 
    values (1, 'San Jose');
INSERT INTO provincia 
    values (2, 'Alajuela');
INSERT INTO provincia 
    values (3, 'Cartago');
INSERT INTO provincia 
    values (4, 'Heredia');
INSERT INTO provincia 
    values (5, 'Guanacaste');

---VALORES A BECA
INSERT INTO beca 
    values ('B1', 'Socioeconomica', 120000);
INSERT INTO beca 
    values ('B2', 'Deportiva', 80000);
INSERT INTO beca 
    values ('B3', 'Academica', 220000);
INSERT INTO beca 
    values ('B4', 'Residencia', 40000);
INSERT INTO beca 
    values ('B5', 'Honor', 220000);
    
---VALORES A PROFESOR
INSERT INTO profesor 
    values (2436276430, 'Jaime Gutierrez Alfaro', 'IC');
INSERT INTO profesor 
    values (4629510894, 'Diego Munguia Solano', 'IC');
INSERT INTO profesor 
    values (9754210874, 'Roberto Azofeifa Cubero', 'MA');
INSERT INTO profesor 
    values (5028791983, 'Ernesto Carrera Granadoz', 'MA');
INSERT INTO profesor 
    values (6879102576, 'Samanta Rodriguez Varela', 'IE');
    
---VALORES A GRUPO
INSERT INTO grupo 
    values (90, 2436276430, 'IC-4301');
INSERT INTO grupo 
    values (74, 4629510894, 'IC-3400');
INSERT INTO grupo 
    values (22, 9754210874, 'MA-1012');
INSERT INTO grupo 
    values (35, 5028791983, 'MA-321');
INSERT INTO grupo 
    values (5, 5028791983, 'IE-3047');    

---VALORES A AULA
INSERT INTO aula
    VALUES (120,'D-110');
    
INSERT INTO aula
    VALUES (32,'E-40');

INSERT INTO aula
    VALUES (43,'I-910');
    
INSERT INTO aula
    VALUES (53,'A-540');

INSERT INTO aula
    VALUES (21,'E-225'); 
    

   ---VALORES A HORARIO

INSERT INTO horario
    VALUES (1,'M',to_date('1:00', 'hh24:mi'),to_date('3:00', 'hh24:mi'));
    
INSERT INTO horario
    VALUES (2,'K',to_date('9:00', 'hh24:mi'),to_date('11:00', 'hh24:mi'));
    
INSERT INTO horario
    VALUES (3,'L',to_date('10:00', 'hh24:mi'),to_date('12:40', 'hh24:mi'));
    
INSERT INTO horario
    VALUES (4,'M',to_date('7:00', 'hh24:mi'),to_date('10:00', 'hh24:mi'));    
    
INSERT INTO horario
    VALUES (5,'V',to_date('8:00', 'hh24:mi'),to_date('12:00', 'hh24:mi'));
    
INSERT INTO horario
    VALUES (6,'S',to_date('9:00', 'hh24:mi'),to_date('12:40', 'hh24:mi'));

select id_horario, dia, to_char(hora_inicio, 'hh24:mi')hora_inicio, to_char(hora_fin, 'hh24:mi')hora_fin from horario;     
    
---VALORES A DEPARTAMENTO

INSERT INTO departamento
    VALUES ('ING. Computacion','IC');
    
INSERT INTO departamento
    VALUES ('ING. Electronica','IE');
    
INSERT INTO departamento
    VALUES ('Escuela Matematica','MA');

INSERT INTO departamento
    VALUES ('Escuela Ciencias','CE');
    
INSERT INTO departamento
    VALUES ('Escuela Lenguaje','CL');
    

  ---VALORES A MATERIA

INSERT INTO materia
    VALUES ('Bases de Datos 2','IC-2301',4,'QR');
    
INSERT INTO materia
    VALUES ('Analisis de Algoritmos','IC-3400', 4,'IC');
    
INSERT INTO materia
    VALUES ('Calculo diferencial e Integral', 'MA-1012', 4,'MA');

INSERT INTO materia
    VALUES ('Comunicacion Tecnica','CL-9832', 2,'CL');  
    
    INSERT INTO materia
    VALUES ('Matematica Discreta','MA-321',4,'CE');
    
INSERT INTO materia
    VALUES ('Laboratorio Robotica','IE-3047',2,'IE');
  
---TABLAS RELACIONADAS
drop table estudiante_beca; 

CREATE TABLE estudiante_beca
    (carnet number(10) NOT NULL,
    id_beca varchar2(10 CHAR) NOT NULL,
    constraint UC_estudiante_beca unique (carnet, id_beca));
    
ALTER TABLE estudiante_beca 
    add constraint FK_estudiante_carnet
    foreign key (carnet)
    references estudiante(carnet);
    
ALTER TABLE estudiante_beca 
    add constraint FK_beca_id
    foreign key (id_beca)
    references beca(id_beca);
    
drop table grupo_horario_aula;
CREATE table grupo_horario_aula
    (num_grupo number(2) NOT NULL, 
    id_horario NUMBER(3) NOT NULL,
    id_aula NUMBER(3),
    constraint UC_grupo_horario_aula unique (num_grupo,id_horario, id_aula));
    
ALTER TABLE grupo_horario_aula 
    add constraint FK_grupo_num
    foreign key (num_grupo)
    references grupo(num_grupo); --depende de si hay repeticiones
                                            
ALTER TABLE grupo_horario_aula 
    add constraint FK_horario_id
    foreign key (id_horario)
    references horario(id_horario);

ALTER TABLE grupo_horario_aula 
    add constraint FK_aula_id
    foreign key (id_aula)
    references aula(id_aula);
        
CREATE TABLE estudiante_grupo
    (carnet number(10) NOT NULL,
    num_grupo number(2) NOT NULL,
    nota number(3) NOT NULL,
    constraint UC_estudiante_grupo unique (carnet, num_grupo));
    
ALTER TABLE estudiante_grupo 
    add constraint FK_est_grup_num_grupo
    foreign key (num_grupo)
    references grupo(num_grupo);
    
ALTER TABLE estudiante_grupo 
    add constraint FK_est_grup_carnet
    foreign key (carnet)
    references estudiante(carnet);
  
    
drop table estudiante_beca;

--AGREGAR ATRIBUTOS A TABLAS CON RELACIONES

--AGREGAR A ESTUDIANTE_GRUPO
INSERT INTO estudiante_grupo
    VALUES (2019039864, 90, 85);
INSERT INTO estudiante_grupo 
    values (2019344583, 57, 98);
INSERT INTO estudiante_grupo
    values (2015329584, 22, 67);
INSERT INTO estudiante_grupo
    values (2008654327, 35, 78);
INSERT INTO estudiante_grupo
    values (2016175133, 5, 95);
 
 
--AGREGAR A ESTUDIANTE_BECA
INSERT INTO estudiante_beca
    VALUES (2019344583, 'B3');
INSERT INTO estudiante_beca 
    values (2019344583, 'B2');
INSERT INTO estudiante_beca
    values (2015329584, 'B3');
INSERT INTO estudiante_beca
    values (2008654327, 'B4');
INSERT INTO estudiante_beca 
    values (2016175133, 'B5');

--AGREGAR A GRUPO_HORARIO_AULA
INSERT INTO grupo_horario_aula
    VALUES (30, 2, 100);
INSERT INTO grupo_horario_aula
    values (74, 2, 32);
INSERT INTO grupo_horario_aula
    values (22, 3, 43);
INSERT INTO grupo_horario_aula
    values (35, 4, 53);
INSERT INTO grupo_horario_aula
    values (5, 5, 21);




