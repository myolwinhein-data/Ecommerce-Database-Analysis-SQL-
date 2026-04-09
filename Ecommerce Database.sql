CREATE DATABASE ECommerce_DB;

USE ECommerce_DB;

CREATE TABLE customers (
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(255),
    email_address VARCHAR(255),
    gender VARCHAR(255),
    signup_date DATE,
    country VARCHAR(255)
    );
    
INSERT INTO customers (customer_name,email_address,gender,signup_date,country) VALUES
( "Allison Hill", "donaldgarcia@example.net", "Other", "2025-2-15", "Japan"),
("Amanda Davis", "williamjohnson@example.org", "Male", "2024-3-30", "England"),
("Connie Lawrence", "blakeerik@example.com", "Male", "2022-5-13", "Singapore"),
("Phillip Garcia", "wdavis@example.net", "Other", "2021-12-26", "USA"),
("Kimberly Dudley", "smiller@example.net", "Female", "2023-10-4", "Tuckey"),
("Corey Jones", "kendragalloway@example.org", "Male","2024-12-30", "Hong Kong"),
("Mark Diaz", "michael41@example.net", "Male", "2023-11-3", "Germany"),
("Carla Gray", "gabriellecameron@example.org", "Male", "2021-10-5", "Singapore"),
("Jennifer Jones", "jason76@example.net", "Other", "2022-12-16", "USA"),
("Patrick Ryan", "zhurst@example.com", "Other", "2021-10-4", "Japan"),
("Ann Williams", "hernandezernest@example.net",	"Female", "2022-10-10", "China"),
("Kyle Mcdonald", "	tasha01@example.net", "Other", "2025-2-1", "Germany"),
("Dr. Cynthia Allen", "	millertodd@example.org", "Female", "2025-7-21", "USA");



CREATE TABLE orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    payment_method VARCHAR(255),
    shipping_country VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
    );

INSERT INTO orders (customer_id, order_date, total_amount, payment_method, shipping_country) VALUES
(12, "2025-05-12", "1391.35", "Cash", "Germany"),
(9, "2022-12-31", "861.95", "Bank Transfer", "Liechtenstein"),
(10, "2021-10-19", "2635.25", "Credit Card", "India"),
(8,"2022-01-21", "997.77", "Credit Card", "Sri Lanka"),
(2,"2024-05-26", "344.78", "Cash", "England"),
(3, "2022-08-31", "2032.4","PayPal", "Italy"),
(3, "2023-02-05","2845.36","Credit Card", "France"),
(1, "2025-08-05", "1113.08", "Bank Transfer", "Congo"),
(7, "2023-11-16", "1188.96", "Credit Card", "Albania"),
(10, "2021-12-11", "3850.11", "Credit Card", "Sri Lanka"),
(5, "2023-12-15", "573.67", "PayPal", "Colombia"),
(1, "2025-02-20", "1330.36", "Cash", "Japan"),
(9, "2023-03-26", "1625.92", "Bank Transfer", "United Kingdom"),
(4, "2022-01-1", "4064.80", "Bank Transfer", "Brazil"),
(7, "2022-10-05", "792.64", "PayPal", "Brazil"),
(11, "2024-09-18", "307.60", "Cash", "China"),
(13, "2025-07-22", "479.56", "Bank Transfer", "Egypt");



CREATE TABLE product (
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(255),
    price DECIMAL(10,2),
    stock_quantity INT,
    branch VARCHAR(255)
    );
    
INSERT INTO product (product_name, category, price, stock_quantity, branch) VALUES
("Plan Get", "Books", "278.27", "50", "BrandA"),
("Field Yet", "Beauty", "479.56", "5", "BrandA"),
("Technology Her", "Books", "332.59", "30", "BrandA"),
("Decade Pick", "Toys", "198.16", "15", "BrandB"),
("Finally Develop", "Beauty", "307.6", "86", "BrandC"),
("Play Several", "Electronics", "406.48", "30", "BrandA"),
("Various Account", "Electronics", "200.95", "35", "BrandC"),
("Build Of", "Beauty", "262.73", "19", "BrandA"),
("Save Keep", "Clothing", "155.47", "100", "BrandD"),
("Grow Think", "Electronics", "172.39", "22", "BrandA");


CREATE TABLE order_items (
	order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
    );

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(17, 2, "1", "479.56"),
(7, 6, "7", "406.48"),
(16, 5, "2", "307.60"),
(11, 8, "1", "262.73"),
(11, 9, "2", "155.47"),
(3, 6, "5", "406.48"),
(3, 7, "3", "200.95"),
(1, 1, "5", "278.27"),
(15, 4, "4", "198.16"),
(4, 3, "3", "332.59"),
(2, 10, "5", "172.39"),
(12, 3, "4", "332.59"),
(10, 6, "7", "406.48"),
(10, 7, "5", "200.95"),
(5, 10, "2", "172.39"),
(14, 6, "10", "406.48"),
(6, 6, "5", "406.48"),
(9, 4, "6", "198.16"),
(13, 6, "4", "406.48"),
(8,  1, "4", "278.27");


SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM product;
SELECT * FROM order_items;