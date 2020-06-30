-- César Arnoldo Tajiboy Orozco
-- 201325661

-- Schema: public

-- DROP SCHEMA public;

CREATE SCHEMA public
  AUTHORIZATION postgres;

GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;
COMMENT ON SCHEMA public
  IS 'standard public schema';




-- 1. Generar el script que crea cada una de las tablas que conforman la base de datos propuesta por el Comité Olímpico.

-- CREAR TABLA PROFESION

create table PROFESION(
	cod_prof integer,
	nombre varchar(50) UNIQUE constraint nn_profesion_nombre not null,
	constraint pk_cod_prof primary key(cod_prof)
);

-- CREAR TABLA PAIS

create table PAIS(
	cod_pais integer,
	nombre varchar(50) UNIQUE constraint nn_pais_nombre not null,
	constraint pk_cod_pais primary key(cod_pais)
);

-- CREAR TABLA PUESTO

create table PUESTO(
	cod_puesto integer,
	nombre varchar(50) UNIQUE constraint nn_puesto_nombre not null,
	constraint pk_cod_puesto primary key(cod_puesto)
);

-- CREAR TABLA DEPARTAMENTO

create table DEPARTAMENTO(
	cod_depto integer,
	nombre varchar(50) UNIQUE constraint nn_departamento_nombre not null,
	constraint pk_cod_depto primary key(cod_depto)
);

-- CREAR TABLA MIEMBRO

create table MIEMBRO(
	cod_miembro integer,
	nombre varchar(100) constraint nn_miembro_nombre not null,
	apellido varchar(100) constraint nn_miembro_apellido not null,
	edad integer constraint nn_miembro_edad not null,
	telefono integer constraint nn_miembro_telefono null,
	residencia varchar(100) constraint nn_miembro_residencia null,
	PAIS_cod_pais integer constraint nn_miembro_cod_pais not null,
	PROFESION_cod_prof integer constraint nn_miembro_cod_prof not null,
	constraint pk_cod_miembro primary key(cod_miembro),
	constraint fk_miembro_cod_pais foreign key(PAIS_cod_pais)references 
	PAIS(cod_pais),
	constraint fk_miembro_cod_prof foreign key(PROFESION_cod_prof)references 
	PROFESION(cod_prof)	
);

-- CREAR TABLA PUESTO_MIEMBRO

create table PUESTO_MIEMBRO(
	MIEMBRO_cod_miembro integer constraint nn_puesto_miembro_cod_miembro not null,
	PUESTO_cod_puesto integer constraint nn_puesto_miembro_cod_puesto not null,
	DEPARTAMENTO_cod_depto integer constraint nn_puesto_miembro_cod_depto not null,
	fecha_inicio date constraint nn_puesto_miembro_fecha_inicio not null,
	fecha_fin date constraint nn_puesto_miembro_fecha_fin null,
	constraint pk_MIEMBRO_PUESTO_DEPARTAMENTO primary key(MIEMBRO_cod_miembro,PUESTO_cod_puesto,DEPARTAMENTO_cod_depto),
	constraint fk_puesto_miembro_cod_miembro foreign key(MIEMBRO_cod_miembro)references 
	MIEMBRO(cod_miembro),
	constraint fk_puesto_miembro_cod_puesto foreign key(PUESTO_cod_puesto)references 
	PUESTO(cod_puesto),
	constraint fk_puesto_miembro_cod_depto foreign key(DEPARTAMENTO_cod_depto)references 
	DEPARTAMENTO(cod_depto)	
);

-- CREAR TABLA TIPO_MEDALLA

create table TIPO_MEDALLA(
	cod_tipo integer,
	medalla varchar(20) UNIQUE constraint nn_tipo_medalla_medalla not null,
	constraint pk_cod_tipo primary key(cod_tipo)
);

-- CREAR TABLA MEDALLERO

create table MEDALLERO(
	PAIS_cod_pais integer constraint nn_medallero_cod_pais not null,
	cantidad_medallas integer constraint nn_medallero_cantidad_medallas not null,
	TIPO_MEDALLA_cod_tipo integer constraint nn_medallero_cod_tipo not null,
	constraint pk_PAIS_TIPO_MEDALLA primary key(PAIS_cod_pais,TIPO_MEDALLA_cod_tipo),
	constraint fk_medallero_cod_pais foreign key(PAIS_cod_pais)references 
	PAIS(cod_pais),
	constraint fk_medallero_cod_tipo foreign key(TIPO_MEDALLA_cod_tipo)references 
	TIPO_MEDALLA(cod_tipo)	
);

-- CREAR TABLA DISCIPLINA

create table DISCIPLINA(
	cod_disciplina integer,
	nombre varchar(50) constraint nn_disciplina_nombre not null,
	descripcion varchar(150) constraint nn_disciplina_descripcion null,
	constraint pk_cod_disciplina primary key(cod_disciplina)
);

-- CREAR TABLA ATLETA

create table ATLETA(
	cod_atleta integer,
	nombre varchar(50) constraint nn_atleta_nombre not null,
	apellido varchar(50) constraint nn_atleta_apellido not null,
	edad integer constraint nn_atleta_edad not null,
	participaciones varchar(100) constraint nn_atleta_participaciones not null,
	DISCIPLINA_cod_disciplina integer constraint nn_atleta_cod_disciplina not null,
	PAIS_cod_pais integer constraint nn_atleta_cod_pais not null,
	constraint pk_cod_atleta primary key(cod_atleta),
	constraint fk_atleta_cod_disciplina foreign key(DISCIPLINA_cod_disciplina)references 
	DISCIPLINA(cod_disciplina),
	constraint fk_atleta_cod_pais foreign key(PAIS_cod_pais)references 
	PAIS(cod_pais)
);

-- CREAR TABLA CATEGORIA

create table CATEGORIA(
	cod_categoria integer,
	categoria varchar(50) constraint nn_categoria_categoria not null,
	constraint pk_cod_categoria primary key(cod_categoria)
);

-- CREAR TABLA TIPO_PARTICIPACION

create table TIPO_PARTICIPACION(
	cod_participacion integer,
	tipo_participacion varchar(100) constraint nn_tipo_participacion_tipo_participacion not null,
	constraint pk_cod_participacion primary key(cod_participacion)
);

-- CREAR TABLA EVENTO

create table EVENTO(
	cod_evento integer ,
	fecha date constraint nn_evento_fecha not null,
	ubicacion varchar(50) constraint nn_evento_ubicacion not null,
	hora date constraint nn_evento_hora not null,
	DISCIPLINA_cod_disciplina integer constraint nn_evento_cod_dosciplina not null,
	TIPO_PARTICIPACION_cod_participacion integer constraint nn_evento_cod_participacion not null,
	CATEGORIA_cod_categoria integer constraint nn_evento_cod_categoria not null,
	constraint pk_cod_evento primary key(cod_evento),
	constraint fk_evento_cod_disciplina foreign key(DISCIPLINA_cod_disciplina)references 
	DISCIPLINA(cod_disciplina),
	constraint fk_evento_cod_participacion foreign key(TIPO_PARTICIPACION_cod_participacion)references 
	TIPO_PARTICIPACION(cod_participacion),
	constraint fk_evento_cod_categoria foreign key(CATEGORIA_cod_categoria)references 
	CATEGORIA(cod_categoria)
);

-- CREAR TABLA EVENTO_ATLETA

create table EVENTO_ATLETA(
	ATLETA_cod_atleta integer constraint nn_evento_atleta_cod_atleta not null,
	EVENTO_cod_evento integer constraint nn_evento_atleta_cod_evento not null,
	constraint pk_ATLETA_EVENTO primary key(ATLETA_cod_atleta,EVENTO_cod_evento),
	constraint fk_evento_atleta_cod_atleta foreign key(ATLETA_cod_atleta)references 
	ATLETA(cod_atleta),
	constraint fk_evento_atleta_cod_evento foreign key(EVENTO_cod_evento)references 
	EVENTO(cod_evento)
);

-- CREAR TABLA TELEVISORA

create table TELEVISORA(
	cod_televisora integer,
	nombre varchar(50) constraint nn_televisora_nombre not null,
	constraint pk_cod_televisora primary key(cod_televisora)
);

-- CREAR TABLA COSTO_EVENTO

create table COSTO_EVENTO(
	EVENTO_cod_evento integer constraint nn_costo_evento_cod_evento not null,
	TELEVISORA_cod_televisora integer constraint nn_costo_evento_cod_televisora not null,
	tarifa numeric constraint nn_costo_evento_tarifa not null,
	constraint pk_EVENTO_TELEVISORA primary key(EVENTO_cod_evento,TELEVISORA_cod_televisora),
	constraint fk_costo_evento_cod_evento foreign key(EVENTO_cod_evento)references 
	EVENTO(cod_evento),
	constraint fk_costo_evento_cod_televisora foreign key(TELEVISORA_cod_televisora)references 
	TELEVISORA(cod_televisora)
);


-- 2 .En la tabla “Evento” se decidió que la fecha y hora se trabajaría en una sola columna

-- Eliminar las columnas fecha y hora

	ALTER TABLE EVENTO DROP COLUMN fecha;
	ALTER TABLE EVENTO DROP COLUMN hora;

-- Crear una columna llamada “fecha_hora” con el tipo de dato que corresponda según el DBMS

	ALTER TABLE EVENTO ADD fecha_hora timestamp constraint nn_evento_fecha_hora not null;

-- 3. Todos los eventos de las olimpiadas deben ser programados del 24 de julio
--    de 2020 a partir de las 9:00:00 hasta el 09 de agosto de 2020 hasta las 20:00:00.

	ALTER TABLE EVENTO ADD constraint fecha_inicial CHECK 
       (fecha_hora > to_timestamp('24 07 2020 09:00:00','DD MM YYYY HH24:MI:SS'));

	ALTER TABLE EVENTO ADD constraint fecha_final CHECK 
       (fecha_hora <= to_timestamp('09 08 2020 20:00:00','DD MM YYYY HH24:MI:SS'));



-- 4. Se decidió que las ubicación de los eventos se registrarán previamente en
--    una tabla y que en la tabla “Evento” sólo se almacenara la llave foránea
--    según el código del registro de la ubicación, para esto debe realizar lo
--    siguiente:

-- a.Crear la tabla llamada “Sede”. 

	create table SEDE(
		cod_sede integer,
		sede varchar(50) constraint nn_sede_sede not null,
		constraint pk_cod_sede primary key(cod_sede)
	);

-- b. Cambiar el tipo de dato de la columna Ubicación de la tabla Evento por un tipo entero.

	ALTER TABLE EVENTO ALTER COLUMN ubicacion TYPE integer USING ubicacion::integer; 

-- c. Crear una llave foránea en la columna Ubicación de la tabla Evento y
--    referenciarla a la columna código de la tabla Sede, la que fue creada en el paso anterior

	ALTER TABLE EVENTO ADD constraint fk_evento_cod_sede foreign key(ubicacion)references 
	SEDE(cod_sede); 

	
-- 5.  Se revisó la información de los miembros que se tienen actualmente y antes
--     de que se ingresen a la base de datos el Comité desea que a los miembros
--     que no tengan número telefónico se le ingrese el número por Default 0 al
--     momento de ser cargados a la base de datos

	ALTER TABLE MIEMBRO ALTER COLUMN telefono SET DEFAULT 0; 


	
-- 6. Generar el script necesario para hacer la inserción de datos a las tablas requeridas.

	-- INSETAR EN TABLA PAIS
	INSERT INTO PAIS VALUES (1,'Guatemala');	
	INSERT INTO PAIS VALUES (2,'Francia');	
	INSERT INTO PAIS VALUES (3,'Argentina');	
	INSERT INTO PAIS VALUES (4,'Alemania');	
	INSERT INTO PAIS VALUES (5,'Italia');	
	INSERT INTO PAIS VALUES (6,'Brasil');	
	INSERT INTO PAIS VALUES (7,'Estados Unidos');	

	-- INSETAR EN TABLA PROFESION
	INSERT INTO PROFESION VALUES (1,'Médico');	
	INSERT INTO PROFESION VALUES (2,'Arquitecto');	
	INSERT INTO PROFESION VALUES (3,'Ingeniero');	
	INSERT INTO PROFESION VALUES (4,'Secretaria');	
	INSERT INTO PROFESION VALUES (5,'Auditor');

	-- INSETAR EN TABLA MIEMBRO
	INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,residencia,PAIS_cod_pais,PROFESION_cod_prof) 
	VALUES (1,'Scott','Mitchell',32,'1092 Highland Drive Manitowoc, WI 54220',7,3);

	INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,telefono,residencia,PAIS_cod_pais,PROFESION_cod_prof) 
	VALUES (2,'Fanette','Poulin',25,25075853,'49, boulevard Aristide Briand 76120 LEGRAND-QUEVILLY',2,4);

	INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,residencia,PAIS_cod_pais,PROFESION_cod_prof) 
	VALUES (3,'Laura','Cunha Silva',55,'Rua Onze, 86 Uberaba-MG',6,5);

	INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,telefono,residencia,PAIS_cod_pais,PROFESION_cod_prof) 
	VALUES (4,'Juan José','López',38,36985247,'26 calle 4-10 zona 11',1,2);

	INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,telefono,residencia,PAIS_cod_pais,PROFESION_cod_prof) 
	VALUES (5,'Arcangela','Panicucci',39,391664921,'Via Santa Teresa, 11490010-Geraci Siculo PA',5,1);


	INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,residencia,PAIS_cod_pais,PROFESION_cod_prof) 
	VALUES (6,'Jeuel','Villalpando',31,'Acuña de Figeroa 610680101 Playa Pascual',3,5);
		

-- 15. Todos los atletas que se registren deben cumplir con ser menores a 25 años.
--     De lo contrario no se debe poder registrar a un atleta en la base de datos. 

	ALTER TABLE ATLETA ADD CONSTRAINT comprobar_edad CHECK edad < 25;


