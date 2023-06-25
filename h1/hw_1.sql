use hw_1;

 CREATE TABLE mobile_phones(
 id_mobile_phones int(10) primary key not null auto_increment,
 product_name varchar(40) not null,
 manufacturer varchar(40) not null,
 product_count int (10) not null,
 price DECIMAL(10)
 );
 INSERT mobile_phones(product_name, manufacturer, product_count, price)
 VALUES ("iPhone X", "Apple", 3, 76000),
 ("iPhone 8", "Apple", 2, 51000),
 ("Galaxy S9", "Samsung", 2, 56000),
 ("Galaxy S8", "Samsung", 1, 41000),
 ("P20 Pro", "Huawei", 5, 36000);
 SELECT product_name,
 manufacturer
 FROM mobile_phones
 WHERE product_count > 2;
 SELECT *
 FROM mobile_phones
 WHERE manufacturer = "Samsung";
 
SELECT *
FROM mobile_phones
WHERE product_name LIKE "%Iphone%"
    or manufacturer LIKE "%Iphone%"
    or product_count LIKE "%Iphone%"
    or price LIKE "%Iphone%";
SELECT *
FROM mobile_phones
WHERE product_name LIKE "%Samsung%"
    or manufacturer LIKE "%Samsung%"
    or product_count LIKE "%Samsung%"
    or price LIKE "%Samsung%";
SELECT *
FROM mobile_phones
WHERE product_name REGEXP '[0-9]';
SELECT *
FROM mobile_phones
WHERE product_name LIKE "%8%";