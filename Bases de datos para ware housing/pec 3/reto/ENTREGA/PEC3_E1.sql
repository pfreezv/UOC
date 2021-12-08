1
SET SEARCH_PATH TO olympic;

ALTER TABLE tb_register
	ALTER COLUMN register_ts SET DATA TYPE timestamp;
	
ALTER TABLE tb_register
	RENAME COLUMN register_date TO register_ts;

ALTER TABLE tb_register
	ADD COLUMN register_updated timestamp;

2
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

3
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



2.1
CREATE DOMAIN email_type AS TEXT 
  CHECK ( value ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' );

ALTER TABLE tb_sponsor
	ADD COLUMN email email_type;


ALTER TABLE tb_colLaborator
	ADD COLUMN email email_type;
