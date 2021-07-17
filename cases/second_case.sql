--- CREAR LAS TABLAS CON RESPECTIVOS DATOS ---
CREATE TABLE profesor
    (id_profesor number(10) NOT NULL,
    nombre_profesor varchar2(30) NOT NULL,
    id_departamento varchar2(5 CHAR) NOT NULL,
    PRIMARY KEY (id_profesor));

CREATE TABLE grupo
    (num_grupo number(2) NOT NULL,
    id_profesor number(10),
    id_materia varchar2(8 CHAR) NOT NULL);
    
CREATE TABLE estudiante
    (carnet number(10) NOT NULL,
    nombre_estudiante varchar2(30) NOT NULL,
    id_provincia number NOT NULL,
    PRIMARY KEY (carnet)); 

CREATE TABLE provincia 
    (id_provincia number(1) NOT NULL,
    provincia varchar2(15) NOT NULL,
    PRIMARY KEY (id_provincia));
 
CREATE TABLE beca
    (id_beca varchar2(10 CHAR) NOT NULL,
    nombre_beca varchar2(20) NOT NULL,
    Monto number(8,2) NOT NULL,
    PRIMARY KEY (id_beca));
    
CREATE TABLE materia
    (nombre_materia VARCHAR2(30) NOT NULL,
    id_materia VARCHAR2(8 CHAR) NOT NULL,
    creditos NUMBER(2) NOT NULL,
    id_departamento VARCHAR2(3 CHAR) NOT NULL,
    PRIMARY KEY (id_materia));
    
CREATE TABLE departamento
    (nombre_departamento VARCHAR2(20) NOT NULL,
    id_departamento VARCHAR2(3 CHAR) NOT NULL,
    PRIMARY KEY (id_departamento));
    
CREATE TABLE aula
    (id_aula NUMBER(3) NOT NULL,
    nombre_aula VARCHAR2(8 CHAR) NOT NULL,
    PRIMARY KEY (id_aula));
    
CREATE TABLE horario
    (id_horario NUMBER(3) NOT NULL,
    dia CHAR(1) NOT NULL,
    hora_inicio VARCHAR2(5 CHAR) NOT NULL,
    hora_fin VARCHAR2(5 CHAR) NOT NULL,
    PRIMARY KEY (nombre_cliente));
    
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
    
INSERT INTO beca values ('B1', 'Socioeconomica', 120000);
INSERT INTO beca values ('B2', 'Deportiva', 80000);
INSERT INTO beca values ('B3', 'Academica', 220000);
INSERT INTO beca values ('B4', 'Residencia', 40000);
INSERT INTO beca values ('B5', 'Honor', 220000);


INSERT INTO profesor values (2436276430, 'Jaime Gutierrez Alfaro', 'IC');
INSERT INTO profesor values (4629510894, 'Diego Munguia Solano', 'IC');
INSERT INTO profesor values (9754210874, 'Roberto Azofeifa Cubero', 'MA');
INSERT INTO profesor values (5028791983, 'Ernesto Carrera Granadoz', 'MA');
INSERT INTO profesor values (6879102576, 'Samanta Rodriguez Varela', 'IE');
    
INSERT INTO grupo values (90, 2436276430, 'IC-4301');
INSERT INTO grupo values (74, 4629510894, 'IC-3400');
INSERT INTO grupo values (22, 9754210874, 'MA-1012');
INSERT INTO grupo values (35, 5028791983, 'MA-321');
INSERT INTO grupo values (5, 5028791983, 'IE-3047');    
    

--- INSERTAR VALORES A LAS TABLAS SIN RELACIONAR ---

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
    VALUES (1,'M','9:00','10:40');
    
INSERT INTO horario
    VALUES (2,'K','9:00','11:30');
    
INSERT INTO horario
    VALUES (3,'L','16:00','17:50');
    
INSERT INTO horario
    VALUES (4,'M','16:00','17:50');    
    
INSERT INTO horario
    VALUES (5,'V','1:00','4:30');
    
INSERT INTO horario
    VALUES (6,'S','8:00','12:00');
    
---VALORES A DEPARTAMENTO

INSERT INTO departamento
    VALUES ('ING. Computacion','IC');
    
INSERT INTO departamento
    VALUES ('ING. Electronica','IE');
    
INSERT INTO departamento
    VALUES ('Escuela Matematica','MA');

INSERT INTO departamento
    VALUES ('Escuela Ciencias Exactas','CE');
    
INSERT INTO departamento
    VALUES ('Escuela Lenguaje','CL');
    
---VALORES A MATERIA

INSERT INTO materia
    VALUES ('Bases de Datos I','IC-4301',4,'IC');
    
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
    
