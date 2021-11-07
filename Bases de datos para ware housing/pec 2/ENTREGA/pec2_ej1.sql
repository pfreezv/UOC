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




ejercicio 3

b)

select d.name,a.name,a.athlete_id from tb_athlete a 
left join tb_play p on a.athlete_id = p.athlete_id
left join tb_discipline d on p.discipline_id = d.discipline_id
where a.country = 'FRA' and d.type = 'JUMP'
order by d.name asc , a.athlete_id desc


c)

SELECT d.discipline_id ,d.name , count(p.athlete_id) as conteo_athlete FROM tb_play p NATURAL JOIN tb_discipline d
group by d.discipline_id
order by conteo_athlete desc
limit 1

d)


SELECT a.athlete_id, a.name, a.country , count(*) as total_disciplina 
FROM tb_register r natural join tb_athlete a
group by a.athlete_id
having count(*) >1

e)


SELECT a.athlete_id, a.name, d.name, r.round_number
FROM tb_register r 
left join tb_athlete a on r.athlete_id = a.athlete_id
left join tb_discipline d  on r.discipline_id = d.discipline_id
where r.round_number =(
   SELECT MAX (round_number)
   FROM tb_round
)


3-----------

a)
INSERT INTO olimpic.tb_athlete(athlete_id, name, country, substitute_id) VALUES('0000001','REMBRAND Luc','FRA',NULL);
INSERT INTO olimpic.tb_athlete(athlete_id, name, country, substitute_id) VALUES('0000002','SMITH Mike','ENG',NULL 
INSERT INTO olimpic.tb_athlete(athlete_id, name, country, substitute_id) VALUES('0000003','LEWIS Carl','USA',NULL);
b)
alter table tb_athlete
add constraint ck_spain_athlete
check (country = 'ESP' and substitute_id is not NULL) NOT VALID;

