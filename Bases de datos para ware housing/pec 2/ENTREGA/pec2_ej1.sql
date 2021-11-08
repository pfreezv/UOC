--EJERCICIO 1
--Primero creamos el DB mediante el comando CREATE DATABASE pec2

CREATE SCHEMA olimpic;


SET search_path TO olimpic,
	"$user",
	public;


CREATE TABLe tb_discipline
( 
	discipline_id INTEGER,
	name CHAR (50) NOT NULL,
	inventor CHAR (50) NOT NULL,
	type CHAR (20) NOT NULL,
	object_type CHAR (10) DEFAULT NULL,
	PRIMARY KEY(discipline_id),
	CONSTRAINT ck_dicipline CHECK(type IN ('RUN', 'JUMP', 'THROW'))
);


CREATE TABLE tb_athlete (athlete_id CHAR(7) NOT NULL,
	name CHAR(50) NOT NULL,
	country CHAR(3) NOT NULL,
	substitute_id CHAR(7),
	PRIMARY KEY(athlete_id),
	FOREIGN KEY(substitute_id) REFERENCES tb_athlete (athlete_id)
);

CREATE TABLE tb_play 
(	
	athlete_id CHAR(7) NOT NULL,
	discipline_id INTEGER NOT NULL,
	PRIMARY KEY(athlete_id,discipline_id),
	FOREIGN KEY(athlete_id) REFERENCES tb_athlete(athlete_id),
	FOREIGN KEY(discipline_id) REFERENCES tb_discipline(discipline_id));

CREATE TABLE tb_round 
(
  	round_number INTEGER,
  	discipline_id INT,
  	PRIMARY KEY (discipline_id,round_number),
	FOREIGN KEY(discipline_id) REFERENCES tb_discipline (discipline_id)
);


CREATE TABLE tb_register 
(
	athlete_id CHAR(7) NOT NULL,
	round_number INTEGER NOT NULL,
	discipline_id INTEGER NOT NULL,
	register_date DATE NOT NULL DEFAULT CURRENT_DATE,
	register_position INTEGER, 
	register_time TIME,
	register_measure REAL, 
	PRIMARY KEY(athlete_id,round_number,discipline_id),
	FOREIGN KEY(athlete_id) REFERENCES tb_athlete(athlete_id),
	FOREIGN KEY(round_number,discipline_id) REFERENCES tb_round(round_number,discipline_id)
);

