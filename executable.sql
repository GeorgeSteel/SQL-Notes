DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE IF NOT EXISTS bookstore;
USE bookstore;

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
CREATE TABLE IF NOT EXISTS books(
  book_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  author_id INT UNSIGNED NOT NULL,
  title VARCHAR(50) NOT NULL,
  description VARCHAR(250),
  pages INT UNSIGNED NOT NULL DEFAULT 0,
  release_date Date NOT NULL,
  create_date DATETIME DEFAULT current_timestamp,
  FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS users(
  user_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name varchar(25) NOT NULL,
  lastname varchar(25),
  username varchar(25) NOT NULL,
  email varchar(50) NOT NULL,
  create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS books_users(
  book_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,

  FOREIGN KEY (book_id) REFERENCES books(book_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO authors (name, lastname, pseudonym, birthday, gender, nationality)
  VALUES ('Stephen Edwin', 'King', 'Richard Bachman', '1947-09-27', 'M', 'USA'),
         ('Joanne', 'Rowling', 'J.K Rowling', '1947-09-27', 'F', 'Reino unido'),
         ('Daniel', 'Brown',  NULL, '1964-06-22', 'M', 'USA'),
         ('John', 'Katzenbach ', NULL,'1950-06-23', 'M', 'USA'),
         ('John Ronald', 'Reuel Tolkien', NULL, '1892-01-03', 'M', 'Reino unido'),
         ('Miguel', 'de Unamuno', NULL, '1892-01-03', 'M', 'USA'),
         ('Arturo', 'Pérez Reverte', NULL, '1951-11-25', 'M', 'España'),
         ('George Raymond', 'Richard Martin', NULL, '1948-09-20', 'M', 'USA');

INSERT INTO books(author_id, title, release_date)
VALUES (1, 'Carrie','1974-01-01'),
      (1, 'El misterio de Salmes Lot','1975-01-01'),
      (1, 'El resplando','1977-01-01'),
      (1, 'Rabia','1977-01-01'),
      (1, 'El umbral de la noche','1978-01-01'),
      (1, 'La danza de la muerte','1978-01-01'),
      (1, 'La larga marcha','1979-01-01'),
      (1, 'La zona muerta','1979-01-01'),
      (1, 'Ojos de fuego','1980-01-01'),
      (1, 'Cujo','1981-01-01'),
      (1, 'La torre oscura 1 El pistolero','1982-01-01'),
      (1, 'La torre oscura 2 La invocación','1987-01-01'),
      (1, 'Apocalipsis','1990-01-01'),
      (1, 'La torre oscura 3 Las tierras baldías','1991-01-01'),
      (1, 'La torre oscura 4 Bola de cristal','1997-01-01'),
      (1, 'La torre oscura 5 Los de Calla','2003-01-01'),
      (1, 'La torre oscura 6 La torre oscura','2004-01-01'),
      (1, 'La torre oscura 7 Canción de Susannah','2004-01-01'),
      (1, 'La niebla','1981-01-01'),

      (2, 'Harry Potter y la Piedra Filosofal', '1997-06-30'),
      (2, 'Harry Potter y la Cámara Secreta', '1998-07-2'),
      (2, 'Harry Potter y el Prisionero de Azkaban','1999-07-8'),
      (2, 'Harry Potter y el Cáliz de Fuego','2000-03-20'),
      (2, 'Harry Potter y la Orden del Fénix','2003-06-21'),
      (2, 'Harry Potter y el Misterio del Príncipe','2005-06-16'),
      (2, 'Harry Potter y las Reliquias de la Muerte','2007-07-21'),

      (3, 'Origen', '2017-01-01'),
      (3, 'Inferno', '2013-01-01'),
      (3, 'El simbolo perdido', '2009-01-01'),
      (3, 'El código Da Vinci', '2006-01-01'),
      (3, 'La consipiración', '2003-01-01'),

      (4, 'Al calor del verano', '1982-01-01'),
      (4, 'Un asunto pendiente', '1987-01-01'),
      (4, 'Juicio Final', '1992-01-01'),
      (4, 'La sombra', '1995-01-01'),
      (4, 'Juego de ingenios', '1997-01-01'),
      (4, 'El psicoanalista', '2002-01-01'),
      (4, 'La historia del loco', '2004-01-01'),
      (4, 'El hombre equivocado', '2006-01-01'),
      (4, 'El estudiante', '2014-01-01'),

      (5, 'El hobbit','1937-01-01'),
      (5, 'Las dos torres','1954-01-01'),
      (5, 'El señor de los anillos','1954-01-01'),
      (5, 'La comunidad del anillo','1954-01-01'),
      (5, 'El retorno del rey','1955-01-01'),

      (6, 'La niebla','1914-01-01'),

      (7, 'Eva','2017-01-01'),
      (7, 'Falcó','2016-01-01'),
      (7, 'Hombre buenos','2015-01-01'),
      (7, 'Los barcos se pierden en tierra','2011-01-01'),

      (8, 'Juego de tronos','1996-08-01'),
      (8, 'Choque de reyes','1998-11-16'),
      (8, 'Tormenta de espadas','2005-10-17'),
      (8, 'Festin de cuervos','2011-07-12'),
      (8, 'Danza de dragones','2011-07-12');

INSERT INTO users (name, lastname, username, email)
VALUES  ('Eduardo', 'García', 'eduardogpg', 'eduardo@codigofacilito.com'),
        ('Codi1', 'Facilito', 'codigofacilito', 'ayuda@codigofacilito.com'),
        ('Codi2', 'Facilito', 'codigofacilito', 'ayuda@codigofacilito.com'),
        ('Codi3', 'Facilito', 'codigofacilito', 'ayuda@codigofacilito.com');

INSERT INTO books_users(book_id, user_id)
VALUES  (1, 1), (2, 1), (3, 1),
        (55, 3), (55, 3), (55, 3);