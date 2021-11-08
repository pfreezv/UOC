3-----------

--A)

INSERT INTO 
	olimpic.tb_athlete
	(
		athlete_id, name, 
		country, 
		substitute_id
	) 
VALUES
(
	'0000001',
	'REMBRAND Luc',
	'FRA',
	NULL
);

INSERT INTO olimpic.tb_athlete(athlete_id, name, country, substitute_id) VALUES('0000002','SMITH Mike','ENG',NULL 
INSERT INTO olimpic.tb_athlete(athlete_id, name, country, substitute_id) VALUES('0000003','LEWIS Carl','USA',NULL);

--B)

ALTER TABLE
	tb_athlete
ADD CONSTRAINT
	ck_spain_athlete
CHECK
(
	country = 'ESP' and 
	substitute_id is not NULL
) 
NOT VALID;

--C)

CREATE VIEW
	olimpic.exercise33
		(
			athlete_id,
			name,
			country,
			substitute_id
		) 
	AS
		(
			SELECT 
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