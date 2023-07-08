-- Active: 1687803132509@@localhost@3306@s4


--1. Создайте представление, в которое попадет информация о  
--пользователях (имя, фамилия, город и пол), которые не старше 20 лет.


CREATE OR REPLACE VIEW users_older20_info AS
SELECT users.firstname,
        users.lastname,
        profiles.hometown,
        profiles.gender
 FROM 
    users
    LEFT JOIN profiles ON users.id = profiles.user_id
WHERE YEAR(UTC_DATE()) - YEAR(profiles.birthday) <= 20;

SELECT * FROM users_older20_info;


--2. Найдите кол-во,  
--отправленных сообщений каждым пользователем и  
--выведите ранжированный список пользователей, указав имя и фамилию пользователя, 
--количество отправленных сообщений и место в рейтинге 
--(первое место у пользователя с максимальным количеством сообщений) . 
--(используйте DENSE_RANK)

CREATE OR REPLACE VIEW VIEW_rank_by_sended_message AS
WITH
	cte1 AS (SELECT 
        from_user_id AS cte1_from_user_id, 
        COUNT(messages.to_user_id) AS COUNT_sended_messages,
        DENSE_RANK() OVER(ORDER BY COUNT(messages.to_user_id)DESC) AS rank_by_sended_message
        FROM messages
        GROUP BY from_user_id
        ORDER BY COUNT_sended_messages DESC),

        cte2 AS (SELECT 
        users.firstname, 
        users.lastname, 
        COUNT_sended_messages,
        rank_by_sended_message

        FROM users
        JOIN cte1 ON users.id = cte1_from_user_id
        ORDER BY rank_by_sended_message)
SELECT * FROM cte2;

SELECT * FROM VIEW_rank_by_sended_message;


--3. Выберите все сообщения, 
--отсортируйте сообщения по возрастанию даты отправления 
--(created_at) и найдите разницу дат отправления между соседними сообщениями, 
--получившегося списка. (используйте LEAD или LAG)

CREATE OR REPLACE VIEW messages_time_difference AS
WITH
	cte1 AS (
        SELECT messages.id AS cte1_id, 
        CONCAT(messages.id,' - ', LEAD(messages.id) OVER()) as neighboring_messages,
        LEAD(created_at) OVER() AS next_created_at
        FROM messages
        ORDER BY messages.created_at)
        ,
        cte2 AS (SELECT neighboring_messages,
        messages.created_at,
        next_created_at,
        TIMESTAMPDIFF(SECOND, messages.created_at, next_created_at) as DIFF_message_by_second
        FROM cte1 JOIN messages ON cte1_id = messages.id)
        
SELECT * FROM cte2;

SELECT * FROM messages_time_difference;