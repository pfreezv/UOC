-- SET SEARCH_PATH TO olympic;

-- ALTER TABLE tb_register
-- 	ALTER COLUMN register_ts SET DATA TYPE timestamp;
	
-- ALTER TABLE tb_register
-- 	RENAME COLUMN register_ts TO register_date;


-- ALTER TABLE tb_register
-- 	ADD COLUMN register_update timestamp;

-- CREATE OR REPLACE FUNCTION fn_register_inserted()
-- RETURNS TRIGGER AS $$
-- BEGIN
-- 	new.register_updated = new.register_ts;
-- RETURN NEW;
-- END
-- $$
-- LANGUAGE plpgsql;

-- CREATE TRIGGER tg_register_inserted 
-- BEFORE INSERT ON tb_register
-- FOR EACH ROW
-- EXECUTE PROCEDURE fn_register_inserted();

-- CREATE OR REPLACE FUNCTION fn_register_updated()
-- RETURNS TRIGGER AS $$
-- BEGIN
-- 	new.register_updated = now();
-- RETURN NEW;
-- END
-- $$
-- LANGUAGE plpgsql;

-- CREATE TRIGGER tg_register_updated
-- BEFORE UPDATE ON tb_register
-- FOR EACH ROW
-- EXECUTE PROCEDURE fn_register_updated();


-- CREATE TABLE olympic.tb_play    (
--   athlete_id    CHARACTER(7) NOT NULL,
--   discipline_id  INT NOT NULL,
--   CONSTRAINT pk_play PRIMARY KEY (athlete_id, discipline_id),
--   CONSTRAINT fk_play_athlete FOREIGN KEY (athlete_id) REFERENCES olympic.tb_athlete (athlete_id),
--   CONSTRAINT fk_play_discipline FOREIGN KEY (discipline_id) REFERENCES olympic.tb_discipline (discipline_id)
-- );

-- CREATE TABLE olympic.tb_athletes_info_log(
-- 	athlete_id CHAR (7) NOT NULL,
-- 	discipline_id INT NOT NULL,
-- 	round_number INT NOT NULL,
-- 	athlete_nme VARCHAR (50) NOT NULL,
-- 	discipline_name VARCHAR (50) NOT NULL,
-- 	mark VARCHAR (12) NOT NULL,
-- 	rating INT NOT NULL,
-- 	info_log_dt DATE,
-- 	CONSTRAINT pk_athlete_info_log PRIMARY KEY (athlete_id,discipline_id,round_number),
-- 	CONSTRAINT fk_athlete_info_log FOREIGN KEY (athlete_id,discipline_id,round_number) REFERENCES olympic.tb_register (athlete_id,discipline_id,round_number) 

-- )


------------------
CREATE OR REPLACE FUNCTION fn_athletes_info()
RETURNS TRIGGER AS $$
DECLARE 

	name_2 varchar (50);
	discipline_2 varchar (50);
	marck_athlete varchar (12);
	fecha date;
	
BEGIN
		name_2 = (
				SELECT name
				FROM tb_athlete a
				WHERE a.athlete_id = new.athlete_id
			);
		discipline_2 = (
			SELECT name
			FROM tb_discipline a
			WHERE a.discipline_id = new.discipline_id
		);
		
		fecha = now();
		
		IF new.register_time  isnull then
			marck_athlete = new.register_measure;
		ELSE
			marck_athlete = new.register_time;
		END IF;
		
		IF EXISTS(
			SELECT * 
			FROM tb_register 
			WHERE athlete_id = new.athlete_id AND discipline_id = new.discipline_id AND round_id = new.round_number)
			THEN 
				INSERT INTO tb_athletes_info_log values (1,	1,1,1,1,1,1,1);
			ELSE
				INSERT INTO tb_athletes_info_log values (2,	1,1,1,1,3,2,1);
		END IF;
		INSERT INTO tb_athletes_info_log values (
			new.athlete_id,
			new.discipline_id,
			new.round_number,
			name_2,
			discipline_2,
			marck_athlete,
			new.register_position,
			fecha
);
RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;


-- CREATE TRIGGER tg_athletes_info
-- AFTER INSERT OR DELETE OR UPDATE ON tb_register
-- FOR EACH ROW
-- EXECUTE PROCEDURE fn_athletes_info();



-- SELECT round_number
-- FROM tb_register
-- where athlete_id = '1436004';
-- INSERT INTO olympic.tb_register(athlete_id, discipline_id, round_number, register_ts, register_position, register_time, register_measure) VALUES('1436004', 6, 2, '2021-06-12', 2, '00:12:34',NULL);


-- UPDATE  tb_register 
-- SET register_time = '02:03:01'
-- WHERE athlete_id = '1467945' AND round_number = 2 and discipline_id = 1 ;

-- create or replace function test()
-- returns trigger as $$
-- begin
-- 	delete from tb_athletes_info_log
-- 	where

-- dELETE FROM tb_athletes_info_log WHERE athlete_id = '1687746' ; 
-- INSERT INTO olympic.tb_register(athlete_id, discipline_id, round_number, register_ts, register_position, register_time, register_measure) VALUES('1328204', 3, 1, '2021-06-11', 4, NULL,71.2);


-- SELECT athlete_id
-- FROM tb_register
-- WHERE register_measure = '79.39'

-- INSERT INTO olympic.tb_register(athlete_id, discipline_id, round_number, register_date, register_position, register_time, register_measure) VALUES('1467945', 14, 2, '2021-06-13', 0, '00:12:17',NULL);
-- INSERT INTO olympic.tb_register(athlete_id, discipline_id, round_number, register_date, register_position, register_time, register_measure) VALUES('1328204', 13, 2, '2021-06-11', 9, NULL,71.14);




----------

-- set search_path to  olympic;
-- SELECT NAME 
-- FROM tb_athlete a
-- WHERE a.athlete_id = b.athlete_id


INSERT INTO olympic.tb_register(athlete_id, discipline_id, round_number, register_ts, register_position, register_time, register_measure) 
VALUES('1328204', 6, 1, '2021-06-11', 4, '02:02:01',null);

-- DELETE FROM  tb_athletes_info_log
-- where athlete_id = '1328204' and discipline_id = 11 and round_number = 1;

select * from tb_athletes_info_log;
