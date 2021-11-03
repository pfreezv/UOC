
-- 1
-- Create the SCHEMA to work on

CREATE SCHEMA videogames;

SET search_path TO videogames, "$user", public;

-- Create tables

BEGIN WORK;

CREATE TABLE video_games(
	game_code INTEGER,
  	game_name VARCHAR(30) NOT NULL,
	rental_fee DECIMAL(5,2) NOT NULL,
	min_age INTEGER NOT NULL,
	total_amount INTEGER DEFAULT 1 NOT NULL,
	CONSTRAINT pk_video_games PRIMARY KEY (game_code),
	CONSTRAINT u_game_name UNIQUE(game_name),
	CONSTRAINT ck_fee CHECK(rental_fee > 0 AND rental_fee <= 100),
	CONSTRAINT ck_min_age CHECK(min_age >= 4),
	CONSTRAINT ck_total_amount CHECK(total_amount >= 1)
);

CREATE TABLE customers(
	customer_code INTEGER,
	customer_name VARCHAR(50) NOT NULL,
	age INTEGER NOT NULL,
	phone_number CHAR(9) NOT NULL,
	CONSTRAINT pk_customers PRIMARY KEY(customer_code),
	CONSTRAINT ck_age CHECK(age BETWEEN 4 AND 100)
);

CREATE TABLE employees(
	empl_code INTEGER,
	empl_name VARCHAR(50) NOT NULL,
	salary DECIMAL(5,2) NOT NULL,
	age INTEGER NOT NULL,
	CONSTRAINT pk_employee PRIMARY KEY(empl_code),
	CONSTRAINT u_employees UNIQUE(empl_name),
	CONSTRAINT ck_salary CHECK(salary BETWEEN 300 AND 800),
	CONSTRAINT ck_empl_age CHECK(age BETWEEN 18 AND 65)
);

CREATE TABLE game_rental(
	game_code INTEGER, 
	customer_code INTEGER, 
	rental_date DATE DEFAULT CURRENT_DATE, 
	ret_date DATE DEFAULT NULL, 
	empl_code INTEGER NOT NULL,
	CONSTRAINT pk_game_rental PRIMARY KEY(game_code, customer_code, rental_date),
	CONSTRAINT fk_video_games FOREIGN KEY(game_code) REFERENCES video_games(game_code),
	CONSTRAINT fk_customers FOREIGN KEY(customer_code) REFERENCES customers(customer_code),
	CONSTRAINT fk_employees FOREIGN KEY(empl_code) REFERENCES employees(empl_code),
	CONSTRAINT ck_dates CHECK(ret_date IS NULL OR rental_date <= ret_date)
);

COMMIT WORK;

-- 2
-- Insert rows into tables

BEGIN WORK;
SET DATESTYLE = MDY;

INSERT INTO video_games VALUES(1, 'J001' ,80, 14, 5);
INSERT INTO video_games VALUES(2, 'J002' ,90, 18, 3);
INSERT INTO video_games VALUES(3, 'J003' ,40, 8, 4);
INSERT INTO video_games VALUES(4, 'J004' ,18, 18, 3);
INSERT INTO video_games VALUES(5, 'J005' ,80, 12, 4);
INSERT INTO video_games VALUES(6, 'J006' ,90, 18, 2);
INSERT INTO video_games VALUES(7, 'J007' ,10, 4, 1);

INSERT INTO customers VALUES(1, 'Pablo Roig', 18, '934505151');
INSERT INTO customers VALUES(2, 'Maria Ba', 21, '916800000');
INSERT INTO customers VALUES(3, 'Pepe Puig', 14, '933500000');
INSERT INTO customers VALUES(4, 'Ana Ruiz', 18, '932660000');
INSERT INTO customers VALUES(5, 'Mario Caro', 21, '974600000');
INSERT INTO customers VALUES(6, 'Pepe Perez', 15, '913000000');
INSERT INTO customers VALUES(7, 'Clara Diaz', 18, '982428000');
INSERT INTO customers VALUES(8, 'Pepe Perez', 21, '938900000');
INSERT INTO customers VALUES(9, 'Raul Cano', 50, '981560000');

INSERT INTO employees VALUES(1, 'Ramon Pi', 350, 21);
INSERT INTO employees VALUES(2, 'Sara Ruso', 400, 40);
INSERT INTO employees VALUES(3, 'Juan Paz', 600, 25);
INSERT INTO employees VALUES(4, 'Angel Ros', 350.25, 18);
INSERT INTO employees VALUES(5, 'Marc Coimbra', 500, 40);

INSERT INTO game_rental VALUES(1, 1, '02-27-2006', NULL, 1);
INSERT INTO game_rental VALUES(2, 1, '02-20-2006', '03-01-2006', 1);
INSERT INTO game_rental VALUES(3, 2, CURRENT_DATE, NULL, 2);
INSERT INTO game_rental VALUES(4, 1, '02-28-2006', NULL, 2);
INSERT INTO game_rental VALUES(3, 5, '03-01-2006', NULL, 1);
INSERT INTO game_rental VALUES(4, 2, '03-01-2006', NULL, 2);
INSERT INTO game_rental VALUES(2, 2, '02-10-2006', '02-20-2006', 2);
INSERT INTO game_rental VALUES(5, 6, '02-10-2006', '02-20-2006', 2);
INSERT INTO game_rental VALUES(5, 7, '02-10-2006', NULL, 1);
INSERT INTO game_rental VALUES(5, 8, '02-10-2006', NULL, 3);
INSERT INTO game_rental VALUES(5, 6, '03-01-2006', NULL, 4);
INSERT INTO game_rental VALUES(5, 9, '02-18-2006', NULL, 1);

COMMIT WORK;

-- Check inserted data

BEGIN WORK;

SELECT * FROM video_games;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM game_rental;

COMMIT WORK;

BEGIN WORK;

-- assertion 1: A customer can only rent games that are rated as suitable for their age.
-- That is, customer age is the same as or greater than the age recommended by the manufacturer 
-- of the video game.

SELECT *
FROM game_rental ll, customers c, video_games v
WHERE ll.game_code = v.game_code AND 
      ll.customer_code = c.customer_code AND 
      c.age < v.min_age;  

-- assertion: A rental can only be made if there are enough copies in store. That is, if we have 5
-- copies of a game, there cannot be 5 simultaneous active rentals of that game. Active rentals are  
-- those with a null date of return.

SELECT *
FROM video_games v
WHERE v.total_amount < (SELECT COUNT(*)
		       FROM game_rental ll
		       WHERE ll.game_code = v.game_code AND ll.ret_date IS NULL
		       GROUP BY ll.game_code);

COMMIT WORK;

-- Queries
-- 3 a
SELECT c.customer_name, c.age
FROM customers c
WHERE c.customer_code NOT IN (SELECT ll.customer_code
				  FROM game_rental ll, video_games v
				  WHERE v.game_code = ll.game_code AND 
                                     v.rental_fee > 60)
ORDER BY c.age;

-- or alternatively (using INNER JOIN)

SELECT c.customer_name, c.age
FROM customers c
WHERE c.customer_code NOT IN (SELECT ll.customer_code
			       FROM game_rental ll 
			       INNER JOIN video_games v ON v.game_code=ll.game_code 
			       WHERE v.rental_fee>60)
ORDER BY c.age;

-- or, alternatively, using NOT EXISTS

SELECT c.customer_name, c.age
FROM customers c
WHERE NOT EXISTS (SELECT *
		   FROM game_rental ll, video_games v
		   WHERE v.game_code = ll.game_code AND 
                        v.rental_fee > 60 AND 
                        c.customer_code = ll.customer_code)
ORDER BY c.age;

-- and, alternatively, with INNER JOIN;

SELECT c.customer_name, c.age
FROM customers c
WHERE NOT EXISTS (SELECT *
		   FROM game_rental ll 
		   INNER JOIN video_games v ON v.game_code = ll.game_code
		   WHERE v.rental_fee > 60 AND 
                        c.customer_code = ll.customer_code)
ORDER BY c.age;

-- 3 b
SELECT v.game_name, v.rental_fee, v.total_amount, COUNT(*) AS total_rentals
FROM video_games v, game_rental ll
WHERE v.min_age >= 10 AND 
      v.game_code = ll.game_code AND 
      ll.ret_date IS NULL
GROUP BY v.game_name, v.rental_fee, v.total_amount
HAVING COUNT(*) >= 2;

-- or alternatively (using INNER JOIN)

SELECT v.game_name, v.rental_fee, v.total_amount, COUNT(*) AS total_rentals
FROM video_games v 
INNER JOIN game_rental ll ON v.game_code = ll.game_code
WHERE v.min_age >= 10 AND 
      ll.ret_date IS NULL
GROUP BY v.game_name, v.rental_fee, v.total_amount
HAVING COUNT(*) >= 2;

-- 3 c
SELECT c.customer_code, c.customer_name, c.age, COUNT(*) AS total_customer_BCN
FROM customers c, customers c1
WHERE c.phone_number LIKE '91%' AND 
      c1.phone_number LIKE '93%' AND 
      c.age > c1.age
GROUP BY c.customer_code, c.customer_name, c.age;

-- 3 d
SELECT c.customer_code, c.customer_name, c.age
FROM customers c
WHERE c.age <= (SELECT AVG(c1.age)
		     FROM customers c1);
		     
-- 3 e	     
SELECT e.empl_code, e.empl_name, e.salary
FROM employees e
WHERE e.salary < ALL (SELECT e1.salary
		       FROM employees e1
		       WHERE e1.age = (SELECT MAX(e2.age)
				         FROM employees e2));
-- Updates				         
-- 4
BEGIN WORK;

-- Increase the salary of employees with at least 4 active rentals by 10%. Only the employee with
-- empl_code equal to 1 meets the conditions. 

SELECT * FROM employees;

UPDATE employees SET salary = salary*1.10
WHERE empl_code IN (SELECT ll.empl_code
		      FROM game_rental ll
		      WHERE ll.ret_date IS NULL
		      GROUP BY ll.empl_code
		      HAVING COUNT(*) >= 4);

-- Only the salary of employee with employee_code equal to 1 will have to be modified.

SELECT * FROM employees;

COMMIT WORK;

-- Delete
-- 5
BEGIN WORK;

-- Delete from the DB the video games that are currently not and have never been rented out by any 
-- customer. The games with game_code 6 and 7 are the only ones that meet the conditions specified in 
-- the delete process.  

SELECT v.game_code
FROM video_games v
WHERE v.game_code NOT IN (SELECT ll.game_code
		             FROM game_rental ll);

DELETE FROM video_games 
       WHERE game_code NOT IN (SELECT ll.game_code
		               FROM game_rental ll);

-- Check that the video games have been deleted

SELECT * FROM video_games;

COMMIT WORK;


-- 6 Views
-- 6 a


BEGIN WORK;

CREATE VIEW february_rentals AS
SELECT *
FROM game_rental
WHERE rental_date BETWEEN '02-01-2006' AND '02-28-2006';

END;
BEGIN;

SELECT * FROM february_rentals;

-- Trying to insert a new rental in February

INSERT INTO february_rentals VALUES (4,1,'02-23-2006', NULL, 5);

SELECT * FROM february_rentals;

-- Inserted rental is wrong (it does not correspond to February), but 
-- the DBMS allows it and inserts the row into game_rentals.
INSERT INTO february_rentals VALUES (4,1,'03-23-2006', NULL, 5);

-- Modifying rentals other than those from February (no rows will be modified)

UPDATE february_rentals SET empl_code = 5 WHERE game_code = 3 AND customer_code = 2 
       AND rental_date = '2019-10-01';
       
ROLLBACK;

-- 6 b
BEGIN WORK;

CREATE VIEW rental_empl AS
SELECT DISTINCT e.empl_name, e.salary
FROM employees e, customers c, game_rental a
WHERE e.empl_code = a.empl_code AND c.customer_code = a.customer_code AND c.age > 20;

-- Check the content of the view

SELECT * FROM rental_empl;

COMMIT WORK;


-- 7
-- Delete the data and the SCHEMA

DROP SCHEMA videogames CASCADE;

SET search_path TO "$user", public;
