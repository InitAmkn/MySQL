CREATE SCHEMA hw_2;
use hw_2;

CREATE TABLE sales (
    id_sales int(10) PRIMARY KEY AUTO_INCREMENT,
    order_date DATE NOT NULL,
    count_product INT(10)
);

INSERT INTO sales (order_date, count_product)
VALUES
('2022-01-01', 156),
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);

SELECT * FROM sales;

SELECT *,
CASE
WHEN count_product < 100 THEN "Маленький заказ"
WHEN count_product BETWEEN 100 AND 300 THEN "Средний заказ"
WHEN count_product > 300 THEN "Большой заказ"
ELSE "нет информации по кол-ву"
END AS 'Тип заказа'
FROM sales;

CREATE TABLE orders (
    id_orders int(10) PRIMARY KEY AUTO_INCREMENT,
    employee_id INT(10),
    amount DECIMAL NOT NULL,
    order_status VARCHAR(40)
);

CREATE TABLE employee (
    id_employee int(10) PRIMARY KEY AUTO_INCREMENT,
    name_employee VARCHAR(40)
);
INSERT INTO employee (
    name_employee
) VALUES
("IVANOV"),
("SIDOROV"),
("LISOV"),
("MEDVEDEV"),
("VOLKOV");

INSERT INTO orders (
    employee_id,
    amount,
    order_status
) VALUES
(3,15.00,"OPEN"),
(1,25.50,"OPEN"),
(5,100.70,"CLOSED"),
(2,22.18,"OPEN"),
(4,9.50,"CENCELLED");

ALTER TABLE orders ADD FOREIGN KEY (employee_id) REFERENCES employee (id_employee);

SELECT *,
CASE
WHEN order_status = "OPEN" THEN "Заказ открыт"
WHEN order_status = "CLOSED" THEN "Заказ закрыт"
WHEN order_status = "CENCELLED" THEN "Заказ обрабатывается"
ELSE ""
END AS 'Тип заказа'
FROM orders;
