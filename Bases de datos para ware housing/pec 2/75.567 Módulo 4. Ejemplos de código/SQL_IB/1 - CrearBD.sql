/* Se supone que la BD ya está creada, en caso contrario lo podéis hacer con:
	CREATE DATABASE DBUOC; */

CREATE TABLE CLIENTES 
(
	codigo_cli INTEGER,
	nombre_cli CHAR(30) NOT NULL,
	nif CHAR(12),
	direccion CHAR(30),
	ciudad CHAR(20),
	telefono CHAR(12) DEFAULT NULL,
	PRIMARY KEY(codigo_cli),
	UNIQUE(nif)
);


CREATE TABLE DEPARTAMENTOS
(
	nombre_dpt CHAR(20),
	ciudad_dpt CHAR(20),
	telefono CHAR(12) DEFAULT NULL,
	PRIMARY KEY (nombre_dpt, ciudad_dpt)
);


CREATE TABLE PROYECTOS
(
	codigo_proy INTEGER,
	nombre_proy CHAR(20),
	precio REAL,
	fecha_inicio DATE,
	fecha_prev_fin DATE,
	fecha_fin DATE DEFAULT NULL,
	codigo_cliente INTEGER,
	PRIMARY KEY (codigo_proy),
	FOREIGN KEY (codigo_cliente) REFERENCES CLIENTES(codigo_cli),
	CHECK (fecha_inicio < fecha_prev_fin),
	CHECK (fecha_inicio < fecha_fin)
);

CREATE TABLE EMPLEADOS
(
	codigo_empl INTEGER,
	nombre_empl CHAR(20),
	apellido_empl CHAR(20),
	sueldo REAL CHECK(sueldo > 7000.0),
	nombre_dpt CHAR(20),
	ciudad_dpt CHAR(20),
	num_proy INTEGER,
	PRIMARY KEY (codigo_empl),
	FOREIGN KEY (nombre_dpt, ciudad_dpt) REFERENCES DEPARTAMENTOS(nombre_dpt, ciudad_dpt),
	FOREIGN KEY (num_proy) REFERENCES PROYECTOS(codigo_proy)
);
