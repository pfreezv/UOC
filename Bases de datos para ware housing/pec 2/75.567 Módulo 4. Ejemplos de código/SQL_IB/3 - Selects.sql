-- Página 29
SELECT *
FROM CLIENTES;

SELECT codigo_cli, nombre_cli, direccion, ciudad
FROM CLIENTES;

-- Página 30
SELECT codigo_empl
FROM EMPLEADOS
WHERE num_proy = 4;

-- Página 31
SELECT DISTINCT sueldo 
FROM EMPLEADOS;

-- Página 32
SELECT COUNT(*) AS numero_dpt
FROM DEPARTAMENTOS
WHERE ciudad_dpt = 'Lerida';

-- Página 33
SELECT codigo_proy, nombre_proy
FROM PROYECTOS
WHERE precio = (SELECT MAX(precio) FROM PROYECTOS);

SELECT codigo_empl
FROM EMPLEADOS
WHERE sueldo BETWEEN 20000.0 AND 50000.0;

-- Página 34
SELECT nombre_dpt, ciudad_dpt
FROM DEPARTAMENTOS
WHERE ciudad_dpt IN ('Lerida', 'Tarragona');

-- Página 35
SELECT codigo_empl, nombre_empl
FROM EMPLEADOS
WHERE nombre_empl LIKE 'J%';

SELECT codigo_proy
FROM PROYECTOS
WHERE TRIM(nombre_proy) LIKE 'S____';

SELECT codigo_empl, nombre_empl
FROM EMPLEADOS
WHERE num_proy IS NULL;

-- Página 36
SELECT codigo_proy, nombre_proy
FROM PROYECTOS
WHERE precio > ALL
(
	SELECT sueldo
	FROM EMPLEADOS
	WHERE codigo_proy = num_proy
);

SELECT codigo_proy, nombre_proy
FROM PROYECTOS
WHERE precio < ANY
(
	SELECT sueldo
	FROM EMPLEADOS
	WHERE codigo_proy = num_proy
);
-- No devuelve ninguno

-- Página 37
SELECT codigo_empl, nombre_empl
FROM EMPLEADOS
WHERE EXISTS
(
	SELECT *
	FROM PROYECTOS
	WHERE codigo_proy = num_proy
);

-- Página 38
SELECT codigo_empl, nombre_empl, apellido_empl, sueldo
FROM EMPLEADOS
ORDER BY sueldo, nombre_empl;

-- Página 39
SELECT nombre_dpt, ciudad_dpt, AVG(sueldo) AS sueldo_medio
FROM EMPLEADOS
GROUP BY nombre_dpt, ciudad_dpt;

-- Página 40
SELECT num_proy
FROM EMPLEADOS
GROUP BY num_proy
HAVING SUM(sueldo) > 180000.0;

-- Página 41
SELECT PROYECTOS.codigo_proy, PROYECTOS.precio, CLIENTES.nif
FROM CLIENTES, PROYECTOS
WHERE CLIENTES.codigo_cli = PROYECTOS.codigo_cliente
AND CLIENTES.codigo_cli = 20;

--  Página 42
SELECT p.codigo_proy, p.precio, c.nif, p.codigo_cliente, c.codigo_cli
FROM CLIENTES c, PROYECTOS p
WHERE c.codigo_cli = p.codigo_cliente
AND c.codigo_cli = 20;

SELECT p.codigo_proy, p.precio, c.nif, p.codigo_cliente, c.codigo_cli
FROM CLIENTES c JOIN PROYECTOS p
ON c.codigo_cli = p.codigo_cliente
WHERE c.codigo_cli = 20;


SELECT e1.codigo_empl, e1.apellido_empl
FROM EMPLEADOS e1 JOIN EMPLEADOS e2
ON e1.sueldo > e2.sueldo
WHERE e2.codigo_empl = 5;

-- Página 43
SELECT codigo_empl, nombre_empl
FROM EMPLEADOS NATURAL JOIN DEPARTAMENTOS
WHERE telefono = '977.333.852';
-- no devuelve nada


SELECT codigo_empl, nombre_empl
FROM EMPLEADOS JOIN DEPARTAMENTOS
USING (nombre_dpt,ciudad_dpt)
WHERE telefono = '977.33.38.52';

-- Página 44
SELECT e.codigo_empl, e.nombre_empl, e.nombre_dpt, e.ciudad_dpt, d.telefono
FROM EMPLEADOS e NATURAL JOIN DEPARTAMENTOS d;


SELECT e.codigo_empl, e.nombre_empl, e.nombre_dpt, e.ciudad_dpt, d.telefono
FROM EMPLEADOS e NATURAL LEFT OUTER JOIN DEPARTAMENTOS d;

-- Página 45
SELECT e.codigo_empl, e.nombre_empl, e.nombre_dpt, e.ciudad_dpt, d.telefono
FROM EMPLEADOS e NATURAL RIGHT OUTER JOIN DEPARTAMENTOS d;

SELECT e.codigo_empl, e.nombre_empl, e.nombre_dpt, e.ciudad_dpt, d.telefono
FROM EMPLEADOS e NATURAL FULL OUTER JOIN DEPARTAMENTOS d;

-- Página 46
SELECT *
FROM EMPLEADOS, PROYECTOS, CLIENTES
WHERE num_proy = codigo_proy
AND codigo_cliente = codigo_cli;

SELECT *
FROM (EMPLEADOS JOIN PROYECTOS
ON num_proy = codigo_proy)
JOIN CLIENTES
ON codigo_cliente = codigo_cli;

-- Página 47
SELECT ciudad
FROM CLIENTES
UNION 
SELECT ciudad_dpt
FROM DEPARTAMENTOS;

-- Página 48
SELECT ciudad
FROM CLIENTES
INTERSECT
SELECT ciudad_dpt
FROM DEPARTAMENTOS;

-- Página 49
SELECT ciudad
FROM CLIENTES
WHERE ciudad IN
(
	SELECT d.ciudad_dpt
	FROM DEPARTAMENTOS d
);

SELECT c.ciudad
FROM CLIENTES c
WHERE EXISTS
(
	SELECT *
	FROM DEPARTAMENTOS d
	WHERE c.ciudad = d.ciudad_dpt
);

SELECT codigo_cli
FROM CLIENTES
EXCEPT
SELECT codigo_cliente
FROM PROYECTOS;

-- Página 50
SELECT codigo_cli
FROM CLIENTES
WHERE codigo_cli NOT IN
(
	SELECT codigo_cliente
	FROM PROYECTOS
);

SELECT c.codigo_cli
FROM CLIENTES c
WHERE NOT EXISTS
(
	SELECT *
	FROM PROYECTOS p
	WHERE c.codigo_cli = p.codigo_cliente
);
