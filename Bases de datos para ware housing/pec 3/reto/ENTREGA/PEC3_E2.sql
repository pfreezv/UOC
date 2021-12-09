
--2A

CREATE DOMAIN email_type AS TEXT 
  CHECK ( value ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' );

ALTER TABLE tb_sponsor
	ADD COLUMN email email_type;

ALTER TABLE tb_collaborator
	ADD COLUMN email email_type;


--2B
CREATE TABLE olympic.tb_athletes_info_log(
	athlete_id CHAR (7) NOT NULL,
	discipline_id INT NOT NULL,
	round_number INT NOT NULL,
	athlete_name VARCHAR (50) NOT NULL,
	discipline_name VARCHAR (50) NOT NULL,
	mark VARCHAR (12) NOT NULL,
	rating INT NOT NULL,
	info_log_dt DATE,
	CONSTRAINT pk_athlete_info_log PRIMARY KEY (athlete_id,discipline_id,round_number),
	CONSTRAINT fk_athlete_info_log FOREIGN KEY (athlete_id,discipline_id,round_number) REFERENCES olympic.tb_register (athlete_id,discipline_id,round_number) 

)



--2C
ALTER TABLE olympic.tb_athletes_info_log
drop CONSTRAINT fk_athlete_info_log;

ALTER TABLE olympic.tb_athletes_info_log
ADD CONSTRAINT fk_athlete_info_log
   FOREIGN KEY (round_number, athlete_id, discipline_id)
   REFERENCES olympic.tb_register (round_number, athlete_id, discipline_id)
   ON DELETE CASCADE ON UPDATE CASCADE;


CREATE OR REPLACE FUNCTION fn_athletes_info()
RETURNS TRIGGER AS $$
DECLARE 

	name_2 varchar (50);
	discipline_2 varchar (50);
	marck_athlete varchar (12);
	fecha DATE;
	
	
	
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
		
		IF (TG_OP = 'INSERT') THEN
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
		ELSIF (TG_OP = 'DELETE') THEN	
			DELETE FROM  tb_athletes_info_log
				WHERE athlete_id = new.athlete_id 
				AND discipline_id = new.discipline_id 
				AND round_number = new.round_number;
		ELSIF (TG_OP = 'UPDATE') THEN
			UPDATE tb_athletes_info_log
			SET (mark , rating) = ( marck_athlete ,new.register_position) 
			WHERE athlete_id = new.athlete_id 
				AND discipline_id = new.discipline_id 
				AND round_number = new.round_number;
		END IF;
RETURN new;
END;
$$ 
LANGUAGE plpgsql;



CREATE TRIGGER tg_athletes_info
AFTER INSERT OR DELETE OR UPDATE ON tb_register
FOR EACH ROW
EXECUTE PROCEDURE fn_athletes_info();


--2D
CREATE OR REPLACE FUNCTION fn_get_info_by_sponsor(select_date DATE ,sponsor character varying)
RETURNS TABLE (
	sponsor_email olympic.email_type,
	sponsor_name VARCHAR (50),
	athlete_n VARCHAR (50),
	discipline_n VARCHAR (50),
	round_n INT,
	athlete_ma VARCHAR (12),
	register_p INT,
	information_d DATE
) 

AS $$

BEGIN
RETURN QUERY
		SELECT c.email , c.name , a.athlete_name, a.discipline_name, a.round_number,a.mark,a.rating,a.info_log_dt 
		FROM olympic.tb_athletes_info_log a 
		LEFT JOIN olympic.tb_finance b ON a.athlete_id = b.athlete_id
		LEFT JOIN olympic.tb_sponsor c ON b.sponsor_name = c.name
		WHERE sponsor = c.name 
		AND a.info_log_dt = select_date;
		
		
END; $$
LANGUAGE plpgsql