-- 1.
SELECT apellido_empl, nombre_empl, codigo_empl
FROM EMPLEADOS
ORDER BY apellido_empl DESC, nombre_empl DESC;

-- 2.
SELECT p.codigo_proy, p.nombre_proy
FROM PROYECTOS p, CLIENTES c
WHERE c.ciudad = 'Barcelona'
AND c.codigo_cli = p.codigo_cliente;

SELECT p.codigo_proy, p.nombre_proy
FROM PROYECTOS p JOIN CLIENTES c
ON c.codigo_cli = p.codigo_cliente
WHERE c.ciudad = 'Barcelona';

-- 3.
SELECT DISTINCT e.nombre_dpt, e.ciudad_dpt
FROM EMPLEADOS e
WHERE e.num_proy IN (3,4);

-- 4.
SELECT e.codigo_empl, p.nombre_proy
FROM EMPLEADOS e, PROYECTOS p
WHERE e.sueldo BETWEEN 50000.0 AND 80000.0
AND e.num_proy = p.codigo_proy;

SELECT e.codigo_empl, p.nombre_proy
FROM EMPLEADOS e JOIN PROYECTOS p
ON e.num_proy = p.codigo_proy
WHERE e.sueldo BETWEEN 50000.0 AND 80000.0;

-- 5.
SELECT DISTINCT d.*
FROM DEPARTAMENTOS d, EMPLEADOS e, PROYECTOS p
WHERE p.nombre_proy = 'GESCOM'
AND d.nombre_dpt = e.nombre_dpt
AND d.ciudad_dpt = e.ciudad_dpt
AND e.num_proy = p.codigo_proy;

SELECT DISTINCT d.nombre_dpt, d.ciudad_dpt, d.telefono
FROM (DEPARTAMENTOS d NATURAL JOIN EMPLEADOS e)
JOIN PROYECTOS p
ON e.num_proy = p.codigo_proy
WHERE nombre_proy = 'GESCOM';

-- 6.
SELECT e.codigo_empl, e.nombre_empl, e.apellido_empl
FROM PROYECTOS p, EMPLEADOS e
WHERE e.num_proy = p.codigo_proy
AND p.precio = (SELECT MAX(p1.precio) FROM PROYECTOS p1);

SELECT e.codigo_empl, e.nombre_empl, e.apellido_empl
FROM EMPLEADOS e JOIN PROYECTOS p
ON e.num_proy = p.codigo_proy
WHERE p.precio = (SELECT MAX(p1.precio) FROM PROYECTOS p1);

-- 7.
SELECT nombre_dpt, ciudad_dpt, MAX(sueldo) AS sueldo_maximo
FROM EMPLEADOS
GROUP BY nombre_dpt, ciudad_dpt;

-- 8.
SELECT c.codigo_cli, c.nombre_cli
FROM PROYECTOS p, CLIENTES c
WHERE c.codigo_cli = p.codigo_cliente
GROUP BY c.codigo_cli, c.nombre_cli
HAVING COUNT(*) > 1;

SELECT c.codigo_cli, c.nombre_cli
FROM PROYECTOS p JOIN CLIENTES c
ON c.codigo_cli = p.codigo_cliente
GROUP BY c.codigo_cli, c.nombre_cli
HAVING COUNT(*) > 1;

-- 9.
SELECT p.codigo_proy, p.nombre_proy
FROM PROYECTOS p, EMPLEADOS e
WHERE e.num_proy = p.codigo_proy
GROUP BY p.codigo_proy, p.nombre_proy
HAVING MIN(e.sueldo) > 30000.0;

SELECT p.codigo_proy, p.nombre_proy
FROM EMPLEADOS e JOIN PROYECTOS p
ON e.num_proy = p.codigo_proy
GROUP BY p.codigo_proy, p.nombre_proy
HAVING MIN(e.sueldo) > 30000.0;

-- 10.
SELECT d.nombre_dpt, d.ciudad_dpt
FROM DEPARTAMENTOS d
WHERE NOT EXISTS
(
	SELECT *
	FROM EMPLEADOS e
	WHERE e.nombre_dpt = d.nombre_dpt
	AND e.ciudad_dpt = d.ciudad_dpt
);

SELECT nombre_dpt, ciudad_dpt
FROM DEPARTAMENTOS
EXCEPT
SELECT nombre_dpt, ciudad_dpt
FROM EMPLEADOS;
