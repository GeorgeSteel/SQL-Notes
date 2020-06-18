SHOW DATABASES;
DROP DATABASE databasename;
USE databasename;

SELECT DATABASE();
SHOW COLUMNS FROM authors; / DESC authors;

CREATE TABLE IF NOT EXISTS authors(
  author_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  lastname VARCHAR(50) NOT NULL,
  pseudonym VARCHAR(50) UNIQUE,
  gender ENUM('M', 'F', 'Q'),
  birthday DATE NOT NULL,
  nationality VARCHAR(40) NOT NULL,
  create_date DATETIME DEFAULT current_timestamp
);
CREATE TABLE users LIKE authors;

-- CRUD
INSERT INTO authors (author_id, name, lastname, pseudonym, gender, birthday, nationality)
VALUES (11, 'Stephen', 'King', 'Richard Bachman', 'M', '1971-05-01', 'American');

SELECT * FROM books WHERE (title = 'Carrie' AND author_id = 1) OR (title = 'El hobbit' AND author_id = 5);
SELECT * FROM authors WHERE pseudonym IS NOT NULL;
SELECT title, release_date FROM books WHERE release_date BETWEEN '1995-01-01' AND '2015-01-31';
SELECT * FROM books WHERE title IN ('Ojos de fuego', 'El hobbit');
SELECT DISTINCT title FROM books;
SELECT author_id AS Author, title AS Name FROM books;

UPDATE books SET description = 'New change', sales = 1000 WHERE title = 'El hobbit';

DELETE FROM books WHERE book_id = 55;

TRUNCATE TABLE books;

-- Functions
  -- Strings:
SELECT CONCAT(name, " ", lastname) AS fullname FROM authors;
SELECT * FROM authors WHERE LENGTH(name) > 7;
SELECT UPPER(name), LOWER(name) FROM authors;
SELECT TRIM("         DFDSFDSFDSFDS      ");
SELECT * FROM books WHERE LEFT(title, 12) = 'Harry Potter';
SELECT * FROM books WHERE RIGHT(title, 6) = 'anillo';
  -- Numbers
SELECT ROUND(RAND() * 100);
SELECT TRUNCATE(1.123456789, 4);
SELECT POW(2, 16);
  -- Dates
SELECT SECOND(@now), MINUTE(@now), HOUR(@now), MONTH(@now), YEAR(@now);
SELECT DAYOFWEEK(@now), DAYOFMONTH(@now), DAYOFYEAR(@now);
SELECT DATE(@now);
SELECT * FROM books WHERE DATE(create_date) = CURDATE();
SELECT @now + INTERVAL 30 DAY;
  -- Conditions
SELECT IF(10 > 90, 'The 1st number is bigger', 'The 2nd number is bigger');
SELECT IFNULL(pseudonym, 'The author does not have a pseudonym') FROM authors;
  -- Search by strings
SELECT * FROM books WHERE title LIKE 'Harry Potter%';
SELECT * FROM books WHERE title LIKE '%anillo';
SELECT * FROM books WHERE title LIKE '%la%';
SELECT * FROM books WHERE title LIKE '__b__';
SELECT * FROM books WHERE title LIKE '_a__o%';
  -- Regular expressions
SELECT * FROM books WHERE title REGEXP '^[HL]';
  -- ORDER BY
SELECT * FROM books ORDER BY title AND book_id ASC;
SELECT * FROM books ORDER BY title DESC;
  -- LIMIT
SELECT * FROM books WHERE author_id = 2 LIMIT 10;
SELECT * FROM books WHERE author_id = 2 LIMIT 3, 3;
  -- Agregation funtions
SELECT COUNT(*) FROM authors;
SELECT SUM(sales) FROM books;
SELECT MAX(sales) FROM books;
SELECT MIN(sales) FROM books;
SELECT AVG(sales) FROM books;
  -- GROUP
SELECT author_id, SUM(sales) AS total FROM books GROUP BY author_id ORDER BY total DESC LIMIT 1;
  -- HAVING use instead of where while using agregation functions
SELECT author_id, SUM(sales) AS total FROM books GROUP BY author_id HAVING SUM(sales) > 1000;

-- Sub querys
SELECT CONCAT(name, ' ', lastname) FROM authors WHERE author_id IN (
SELECT author_id FROM books GROUP BY author_id HAVING SUM(sales) > (SELECT AVG(sales) FROM books));

-- JOINS
SELECT CONCAT(a.name, ' ', a.lastname) AS Author, b.title AS Book FROM books AS b INNER JOIN authors AS a ON b.author_id = a.author_id;
  -- USING
SELECT CONCAT(a.name, ' ', a.lastname) AS Author, b.title AS Book FROM books AS b INNER JOIN authors AS a USING(author_id);
  -- LEFT JOIN
SELECT CONCAT(a.name, ' ', a.lastname) AS Name, bu.book_id FROM users AS a LEFT JOIN books_users AS bu ON a.user_id = bu.user_id;

-- Views
CREATE OR REPLACE VIEW prestamos_usuarios_vw AS
SELECT
  usuarios.usuario_id,
  usuarios.nombre,
  usuarios.email,
  usuarios.username,
  COUNT(usuarios.usuario_id) AS total_prestamos

FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
GROUP BY usuarios.usuario_id;

  -- Create custom functions
DELIMITER //

CREATE FUNCTION addDays(date DATE, days INT)
RETURNS DATE
BEGIN
  RETURN date + INTERVAL days DAY;
END//

DELIMITER ;

DELIMITER //

CREATE FUNCTION getPages()
RETURNS INT
BEGIN
  SET @pages = (SELECT (ROUND(RAND() * 100) * 4));
  RETURN @pages;
END//

DELIMITER ;

DELIMITER //

CREATE FUNCTION getSales()
RETURNS INT
BEGIN
  SET @sales = (SELECT (ROUND(RAND() * 100) * 6));
  RETURN @sales;
END//

DELIMITER ;

DELIMITER //

CREATE FUNCTION getStock()
RETURNS INT
BEGIN
  SET @stock = (SELECT (ROUND(RAND() * 100) * 9));
  RETURN @stock;
END//

DELIMITER ;


SELECT name FROM mysql.proc WHERE db = database() AND type = 'FUNCTION';
DROP FUNCTION addDays;

-- Alter tables
  -- Renombrar tabla.
ALTER TABLE usuarios RENAME users;

  -- Agregar una nueva columna.
ALTER TABLE books ADD stock INT UNSIGNED NOT NULL DEFAULT 0;

  -- Agregar una nueva columna con constraints.
ALTER TABLE usuarios ADD email VARCHAR(50) NOT NULL DEFAULT '';

  -- Agregar a la tabla usuarios, la columna email, validando su valor único.
ALTER TABLE tabla ADD columna VARCHAR(50) UNIQUE;

  -- Eliminar una columna
ALTER TABLE usuarios DROP COLUMN email;

  -- Modificar el tipo de dato de una columna
ALTER TABLE usuarios MODIFY telefono VARCHAR(50);

  -- Generar una llave primaria.
ALTER TABLE usuarios ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (id);

  -- Agregar llave foránea.
ALTER TABLE usuarios ADD FOREIGN KEY(grupo_id) REFERENCES grupos(grupo_id);

  -- Eliminar llaves foráneas
ALTER TABLE usuarios DROP FOREIGN KEY grupo_id;

SOURCE ./Documents/Courses/SQL/executable.sql;

-- COMMAND LINE
mariadb - u admin - p <./ Documents / Courses / SQL / executable.sql 
mariadb - u admin - p bookstore - e 'SELECT * FROM authors'