3-----------

a)
INSERT INTO 
	olimpic.tb_athlete(
		athlete_id, name, 
		country, 
		substitute_id) VALUES('0000001','REMBRAND Luc','FRA',NULL);
INSERT INTO olimpic.tb_athlete(athlete_id, name, country, substitute_id) VALUES('0000002','SMITH Mike','ENG',NULL 
INSERT INTO olimpic.tb_athlete(athlete_id, name, country, substitute_id) VALUES('0000003','LEWIS Carl','USA',NULL);
b)
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