-- Active: 1687803132509@@localhost@3306@hw_3


CREATE SCHEMA hw_3;
-- Персонал
DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	firstname VARCHAR(45),
	lastname VARCHAR(45),
	post VARCHAR(100),
	seniority INT, 
	salary INT, 
	age INT
);

-- Наполнение данными
INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
('Вася', 'Петров', 'Начальник', '40', 100000, 60),
('Петр', 'Власов', 'Начальник', '8', 70000, 30),
('Катя', 'Катина', 'Инженер', '2', 70000, 25),
('Саша', 'Сасин', 'Инженер', '12', 50000, 35),
('Иван', 'Иванов', 'Рабочий', '40', 30000, 59),
('Петр', 'Петров', 'Рабочий', '20', 25000, 40),
('Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
('Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
('Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
('Максим', 'Максимов', 'Рабочий', '2', 11000, 22),
('Юрий', 'Галкин', 'Рабочий', '3', 12000, 24),
('Людмила', 'Маркина', 'Уборщик', '10', 10000, 49);

--Отсортируйте данные по полю заработная плата (salary) в порядке убывания; 
SELECT * FROM staff
ORDER BY salary;


--Отсортируйте данные по полю заработная плата (salary) в порядке возрастания;
SELECT * FROM staff
ORDER BY salary DESC;

--Выведите 5 максимальных заработных плат (saraly)
SELECT * FROM staff
ORDER BY salary DESC
LIMIT 5;

--Посчитайте суммарную зарплату (salary) по каждой специальности (роst)

SELECT post, SUM(salary) 
FROM staff
GROUP BY (post);

--Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
SELECT  COUNT(*) 
FROM staff
WHERE 
post = "Рабочий"
AND
age BETWEEN 24 AND 49
GROUP BY (post);

--Найдите количество специальностей

SELECT COUNT(*) FROM
(SELECT DISTINCT post FROM
 staff) as posts_staff;


--Выведите специальности, у которых средний возраст сотрудников меньше 40 лет 
SELECT post
FROM staff
GROUP BY post
HAVING
AVG(age)<40;