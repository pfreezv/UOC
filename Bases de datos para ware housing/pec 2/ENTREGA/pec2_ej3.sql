3-----------

--A)

INSERT INTO 
	olimpic.tb_athlete (athlete_id, name, country,substitute_id) 
VALUES
	('0000001','REMBRAND Luc','FRA',NULL),
	('0000002','SMITH Mike','ENG',NULL),
	('0000003','LEWIS Carl','USA',NULL);

--B)

ALTER TABLE
	tb_athlete
ADD CONSTRAINT
	ck_spain_athlete
CHECK
	(country = 'ESP' and substitute_id is not NULL) 
NOT VALID;

--C)

CREATE VIEW
	olimpic.exercise33
		(athlete_id,name,country,substitute_id) 
	AS
		(SELECT 
				athlete_id,
				name,
				country,
				substitute_id
			FROM 
				tb_athlete
			WHERE 
				(country LIKE 'ESP' AND
				name LIKE 'PE%'	)
		)
	WITH CHECK OPTION;

--D)

ALTER TABLE 
	tb_athlete
ADD COLUMN 
	data_add 
	DATE NOT NULL 
	DEFAULT CURRENT_DATE 

--E)

CREATE ROLE registerer WITH
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	PASSWORD 1234';
GRANT USAGE 
ON SCHEMA 
	olimpic 
TO 
	registerer

GRANT SELECT, INSERT, UPDATE, DELETE ON 
	tb_register 
IN SCHEMA 
	olimpic 
TO 
	registerer
GRANT SELECT ON 
	tb_athlete 
IN SCHEMA 
	olimpic 
TO 
	registerer
