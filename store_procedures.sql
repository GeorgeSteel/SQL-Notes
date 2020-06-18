DELIMITER //

CREATE PROCEDURE loan(user_id INT, book_id INT)
BEGIN
  INSERT INTO books_users(book_id, user_id) VALUES (book_id, user_id);
  UPDATE books SET stock = stock - 1 WHERE books.book_id = book_id;
END//

DELIMITER ;

CALL loan(3,20)

DROP PROCEDURE loan;

-- TRANSACTION
CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT)
BEGIN

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
  END;

  START TRANSACTION;

  INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
  UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;
  
  COMMIT;

END//