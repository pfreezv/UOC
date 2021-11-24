------------------------------------------------------------------------------------------------
--
-- Formato fechas
--
------------------------------------------------------------------------------------------------

SET datestyle = DMY;        -- Formato de fecha día-mes-año

------------------------------------------------------------------------------------------------
--
-- Ejercicio 3.1)
--
------------------------------------------------------------------------------------------------

INSERT INTO olimpic.tb_athlete
  (athlete_id, name, country, substitute_id) 
VALUES
  ('0000001','REMBRAND Luc','FRA',NULL),
  ('0000002','SMITH Mike','ENG',NULL),
  ('0000003','LEWIS Carl','USA',NULL)
;

------------------------------------------------------------------------------------------------
--
-- Ejercicio 3.2)
--
------------------------------------------------------------------------------------------------

ALTER TABLE  olimpic.tb_athlete
ADD CONSTRAINT ck_athlete_esp 
CHECK (country<>'ESP' OR (country='ESP' AND substitute_id IS NOT NULL));

-- Podemos verificarlo con este test
-- UPDATE olimpic.tb_athlete SET substitute_id=NULL WHERE athlete_id='1354668';

------------------------------------------------------------------------------------------------
--
-- Ejercicio 3.3)
--
------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW olimpic.exercise33 AS
SELECT * 
FROM olimpic.tb_athlete 
WHERE country ='ESP' AND name LIKE 'PE%' 
ORDER BY athlete_id DESC
WITH CHECK OPTION;

-- Para verificar
--INSERT INTO olimpic.exercise33 (athlete_id, name, country, substitute_id) VALUES ('0000006','PEÑA Alberto','ESP','0000001');
--INSERT INTO olimpic.exercise33 (athlete_id, name, country, substitute_id) VALUES ('0000007','LAMBORT Rene','FRA','0000001');
------------------------------------------------------------------------------------------------
--
-- Ejercicio 3.4)
--
------------------------------------------------------------------------------------------------

ALTER TABLE olimpic.tb_athlete
  ADD COLUMN date_add DATE NOT NULL DEFAULT CURRENT_DATE
;


------------------------------------------------------------------------------------------------
--
-- Ejercicio 3.5)
--
------------------------------------------------------------------------------------------------
-- La creación de usuarios en PostgreSQL es en base a roles. CREATE USER es un alias de CREATE ROLE. 
CREATE USER registerer WITH LOGIN PASSWORD '1234'; -- Creamos el usuario con la contraseña indicada
GRANT USAGE ON SCHEMA olimpic TO registerer;             -- Damos permiso de uso al esquema Textil al usuario creado   
GRANT ALL ON olimpic.tb_register TO registerer;         -- Damos permiso de SELECT solamente sobre la tabla al usuario creado. No hay WITH GRANT OPTION
GRANT SELECT ON olimpic.tb_athlete TO registerer;        -- Damos permiso de SELECT solamente sobre la tabla al usuario creado. No hay WITH GRANT OPTION
