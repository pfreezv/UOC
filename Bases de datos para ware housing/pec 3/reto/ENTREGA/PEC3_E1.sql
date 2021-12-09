--1.A)
SET SEARCH_PATH TO olympic;

ALTER TABLE tb_register
	ALTER COLUMN register_ts SET DATA TYPE timestamp;
	
ALTER TABLE tb_register
	RENAME COLUMN register_date TO register_ts;

ALTER TABLE tb_register
	ADD COLUMN register_updated timestamp;

--1.B
CREATE OR REPLACE FUNCTION fn_register_inserted()
RETURNS TRIGGER AS $$
BEGIN
	new.register_updated = new.register_ts;
RETURN NEW;
END
$$
LANGUAGE plpgsql;


CREATE TRIGGER tg_register_inserted 
BEFORE INSERT ON tb_register
FOR EACH ROW
EXECUTE PROCEDURE fn_register_inserted();

--1.C
CREATE FUNCTION fn_register_updated()
RETURNS TRIGGER AS $$
BEGIN
	new.register_updated = now();
RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER tg_register_updated
BEFORE UPDATE ON tb_register
FOR EACH ROW
EXECUTE PROCEDURE fn_register_updated();





