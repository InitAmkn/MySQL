-- Active: 1687803132509@@localhost@3306@s4


/*
Создайте таблицу users_old, 
аналогичную таблице users. Создайте процедуру,  
с помощью которой можно переместить любого (одного) 
пользователя из таблицы users в таблицу users_old. 
(использование транзакции с выбором commit или rollback – обязательно).
*/


DROP TABLE users_old;
CREATE TABLE users_old as (SELECT * FROM users Where users.id = -1);


SELECT * FROM users_old;

SELECT * FROM users;

DROP PROCEDURE IF EXISTS del_users;
DELIMITER //
CREATE PROCEDURE del_users(IN id_user INT)
	BEGIN
    START TRANSACTION;
        INSERT users_old SELECT * FROM users WHERE users.id = id_user;
        DELETE FROM users WHERE users.id = id_user;
    COMMIT;
END //
DELIMITER ;

CALL del_users(7);

DROP PROCEDURE IF EXISTS refund_users;
DELIMITER //
CREATE PROCEDURE refund_users(IN id_user INT)
	BEGIN
    START TRANSACTION;
        INSERT users SELECT * FROM users_old WHERE users_old.id = id_user;
        DELETE FROM users_old WHERE users_old.id = id_user;
    COMMIT;
END //
DELIMITER ;
CALL refund_users(5);

/*
Создайте хранимую функцию hello(), 
которая будет возвращать приветствие, 
в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу 
"Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу 
"Добрый день", с 18:00 до 00:00 — "Добрый вечер", 
с 00:00 до 6:00 — "Доброй ночи".
*/

DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
RETURNS VARCHAR(45)
DETERMINISTIC
BEGIN
    SET GLOBAL time_zone = '+2:00';
    IF(HOUR(CURTIME()) < 6)
    THEN RETURN "Доброй ночи";
    END IF;
    IF(HOUR(CURTIME()) < 12)
    THEN RETURN "Доброе утро";
    END IF;
    IF(HOUR(CURTIME()) < 18)
    THEN RETURN "Добрый день";
    END IF;
    IF(HOUR(CURTIME()) < 24)
    THEN RETURN "Добрый вечер";
    END IF;
END//
DELIMITER ;

-- Вызов функции:
SELECT hello();
SELECT HOUR(CURRENT_TIME());
SELECT NOW();

/*
(по желанию)* Создайте таблицу logs типа Archive. 
Пусть при каждом создании записи в таблицах users, 
communities и messages в таблицу logs помещается время 
и дата создания записи, название таблицы, идентификатор первичного ключа.
*/

