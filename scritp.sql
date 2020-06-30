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

