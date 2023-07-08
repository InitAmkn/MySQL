-- Active: 1687803132509@@localhost@3306@s4
/*
Добрый день!
В первом задании не совсем правильный ответ. Не видно само количество лайков
Вывелся id = 7 и количество лайков = 0. Нужно получить суммарное количество лайков для группы пользователей из условия.
Да и лайков там не 0, а три)
Второе задание выполнено верно, хотя хотелось бы увидеть именно ответ, у кого лайков больше, а не просто сопоставление двух чисел)
В третьем задании вы вывели как раз всех пользователей, которые отправляли сообщения. А задание звучит ровно наоборот) там должны быть пользователи 5,6,7
Попробуйте внести корректировки к запросам. Их можете отправить в личные сообщения. Оценку поправлю)
*/
SELECT 
users.firstname,
users.lastname,
users.email,
media.body,
media.filename
FROM 
likes 
JOIN users on likes.id = users.id
JOIN media on media_id = media.id;

--Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.

SELECT 
media.user_id,
users.firstname,
users.lastname,
profiles.birthday,
COUNT(likes.user_id) as number_of_likes
FROM
media
LEFT JOIN likes ON likes.media_id = media.id
LEFT JOIN profiles ON media.user_id = profiles.user_id
LEFT JOIN users ON profiles.user_id = users.id
GROUP BY media.user_id
HAVING 
YEAR(UTC_DATE()) - YEAR(profiles.birthday) < 12;


--Определить кто больше поставил лайков (всего): мужчины или женщины. 

SELECT 
profiles.gender,
COUNT(likes.id) as count_likes
FROM
users
LEFT JOIN likes ON likes.user_id = users.id
LEFT JOIN profiles ON users.id = profiles.user_id
GROUP BY profiles.gender;

--Вывести всех пользователей, которые не отправляли сообщения.

SELECT 
users.id,
users.firstname,
users.lastname,
messages.from_user_id
FROM
users
LEFT JOIN messages ON users.id = messages.from_user_id
GROUP BY users.id
HAVING ;

--(по желанию)* Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех написал ему сообщений.


CREATE OR REPLACE VIEW friend_id_1 AS
WITH
	cte1 AS (SELECT 
                messages.from_user_id AS cte1_from_user_id,
                messages.to_user_id AS cte1_to_user_id,
                COUNT(*) AS cte1_COUNT_messages
            FROM messages 
            GROUP BY messages.from_user_id, messages.to_user_id),

	cte2 AS (SELECT 
                friend_requests.initiator_user_id ,
                friend_requests.target_user_id AS cte2_target_user_id,
                friend_requests.status
            FROM friend_requests
            WHERE friend_requests.status = "approved"),
            
    cte3 AS (SELECT cte1_from_user_id, cte1_to_user_id, cte1_COUNT_messages
    FROM 
        cte2
         JOIN cte1 ON cte1_from_user_id = cte2_target_user_id)

SELECT *
FROM cte3
WHERE cte1_to_user_id = 1;

/*
-- Найти самых высокооплачиваемых сотрудников по каждой должности

SELECT rank_salary, 
	staff,
	post, 
	salary
FROM 	
(SELECT 
	DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS rank_salary, 
	CONCAT(firstname, ' ', lastname) AS staff,
	post, 
	salary
FROM staff) AS list
WHERE rank_salary=1
ORDER BY salary DESC;
*/

SELECT * FROM friend_id_1;
