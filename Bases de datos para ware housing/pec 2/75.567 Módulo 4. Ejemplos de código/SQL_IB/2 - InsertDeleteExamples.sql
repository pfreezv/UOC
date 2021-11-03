/* Se supone que las tablas ya están creadas, en caso contrario lo podéis hacer con:
	ubd_crearBD;	*/

-- Ejemplos de inserción
INSERT INTO CLIENTES
VALUES (10, 'ECIGSA', '37.248.573-C', 'ARAGON 242', 'Barcelona', DEFAULT);
-- Comprobación: SELECT * FROM CLIENTES; 

-- Si se ha ejecutado la instrucción anterior ésta dará un error de clave duplicada
INSERT INTO CLIENTES(nif, nombre_cli, codigo_cli, telefono, direccion, ciudad) 
VALUES('37.248.573-C', 'ECIGSA', 10, DEFAULT, 'ARAGON 242', 'Barcelona');
-- Resultado: ERROR: duplicate key value violates unique constraint "CLIENTES_pkey"

-- Si borráis la tabla recordad volverla a crear
DELETE FROM PROYECTOS;
-- Comprobación: SELECT * FROM PROYECTOS;
-- Recordad que en PROYECTOS todavía no habéis entrado datos, haced primero el INSERT
DELETE FROM PROYECTOS
WHERE codigo_cliente = 2;
-- Comprobación: NO DEVUELVE NADA

-- Recordad que en EMPLEADOS todavía no habéis entrado datos, haced primero el INSERT
UPDATE EMPLEADOS
SET sueldo = sueldo + 1000.0
WHERE num_proy = 2;
-- Comprobación: NO DEVUELVE NADA

-- Completamos las inserciones con los datos de ejemplo
-- Inserción sin especificar las columnas
INSERT INTO DEPARTAMENTOS VALUES ('DIR','Barcelona','93.422.60.70');
INSERT INTO DEPARTAMENTOS VALUES ('DIR','Gerona','972.23.89.70');
INSERT INTO DEPARTAMENTOS VALUES ('DISS','Lerida','973.23.50.40');
INSERT INTO DEPARTAMENTOS VALUES ('DISS','Barcelona','93.224.85.23');
INSERT INTO DEPARTAMENTOS VALUES ('PROG','Tarragona','977.33.38.52');
INSERT INTO DEPARTAMENTOS VALUES ('PROG','Gerona','972.23.50.91');
-- Comprobación:  SELECT * FROM DEPARTAMENTOS; 

-- Inserción especificando las columnas
INSERT INTO CLIENTES(codigo_cli, nombre_cli, nif, direccion, ciudad, telefono)
VALUES ('20','CME','38.123.898-E','Valencia 22','Gerona','972.23.57.21');

INSERT INTO CLIENTES(codigo_cli, nombre_cli, nif, direccion, ciudad, telefono)
VALUES ('30','ACME','36.432.127-A','Mallorca 33','Lerida','973.23.45.67');

INSERT INTO CLIENTES(codigo_cli, nombre_cli, nif, direccion, ciudad, telefono)
VALUES ('40','JGM','38.782.345-B','Rossellon 44','Tarragona','977.33.71.43');
-- Comprobación: SELECT * FROM CLIENTES; 

-- Ponemos datos en PROYECTOS antes que en EMPLEADOS para mantener la integridad referencial, aunque en el módulo lo pone después
SET datestyle = DMY; --Dependiendo de la instalación, hace falta especificar este formato de fecha para no tener errores de inserción.
INSERT INTO PROYECTOS
VALUES ('1','GESCOM','1000000.0','1-1-98','1-1-99',NULL,'10');

INSERT INTO PROYECTOS
VALUES ('2','PESCI','2000000.0','1-10-96','31-3-98','1-5-98','10');

INSERT INTO PROYECTOS
VALUES ('3','SALSA','1000000.0','10-2-98','1-2-99',NULL,'20');

INSERT INTO PROYECTOS
VALUES ('4','TINELL','4000000.0','1-1-97','1-12-99',NULL,'30');
-- Comprobación: SELECT * FROM PROYECTOS;

INSERT INTO EMPLEADOS
VALUES ('1','Maria','Puig','100000.0','DIR','Gerona','1');

INSERT INTO EMPLEADOS
VALUES ('2','Pedro','Mas','90000.0','DIR','Barcelona','4');

INSERT INTO EMPLEADOS
VALUES ('3','Ana','Ros','70000.0','DISS','Lerida','3');

INSERT INTO EMPLEADOS
VALUES ('4','Jorge','Roca','70000.0','DISS','Barcelona','4');

INSERT INTO EMPLEADOS
VALUES ('5','Clara','Blanc','40000.0','PROG','Tarragona','1');

INSERT INTO EMPLEADOS
VALUES ('6','Laura','Tort','30000.0','PROG','Tarragona','3');
-- Comprobación: SELECT * FROM EMPLEADOS;

-- Es importante darse cuenta de que la FOREIGN KEY acepta valores NULL
INSERT INTO EMPLEADOS
VALUES ('7','Roger','Salt','40000.0',NULL,NULL,'4');

INSERT INTO EMPLEADOS
VALUES ('8','Sergio','Grau','30000.0','PROG','Tarragona',NULL);
-- Comprobación: SELECT * FROM EMPLEADOS;







