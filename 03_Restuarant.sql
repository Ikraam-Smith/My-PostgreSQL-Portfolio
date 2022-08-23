/* In this project i will create a database for a restuarant and answer questions
based on the tables in the database */

--Create tables
CREATE TABLE customers(
customer_id SERIAL PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50));

INSERT INTO customers(first_name,last_name)
VALUES
('Bruce','Wayne'),
('Clark','Kent'),
('Diana','Prince');

CREATE TABLE menu(
product_id SERIAL PRIMARY KEY,
product_name VARCHAR(50),
price INTEGER);

INSERT INTO menu(product_name,price)
VALUES
('sushi',10),
('curry',15),
('burger',20);

CREATE TABLE sales(
customer_id INTEGER REFERENCES customers(customer_id),
order_date DATE,
product_id INTEGER REFERENCES menu(product_id));

INSERT INTO sales(customer_id,order_date,product_id)
VALUES
(1,'2022-01-01',1),
(1,'2022-01-01',2),
(1,'2022-01-07',2),
(1,'2022-01-10',3),
(1,'2022-01-11',3),
(1,'2022-01-11',3),
(2,'2022-01-01',2),
(2,'2022-01-02',2),
(2,'2022-01-04',1),
(2,'2022-01-11',1),
(2,'2022-01-16',3),
(2,'2022-02-01',3),
(3,'2022-01-01',3),
(3,'2022-01-01',3),
(3,'2022-01-07',3);

--Which product has been purchased the most?
SELECT product_name,COUNT(sales.product_id) FROM sales
INNER JOIN menu
ON sales.product_id = menu.product_id
GROUP BY product_name
ORDER BY COUNT (sales.product_id) DESC
LIMIT 1;

--How many days has each customer visited the restuarant?
SELECT customers.customer_id,first_name,last_name,COUNT (DISTINCT order_date) 
FROM sales
INNER JOIN customers
ON sales.customer_id = customers.customer_id
GROUP BY customers.customer_id;

--What is the total amount that each customer has spent in total?
SELECT customers.customer_id,first_name,last_name, SUM(price) AS total_spent
FROM sales
INNER JOIN menu
ON sales.product_id = menu.product_id
INNER JOIN customers
ON customers.customer_id = sales.customer_id
GROUP BY customers.customer_id;
