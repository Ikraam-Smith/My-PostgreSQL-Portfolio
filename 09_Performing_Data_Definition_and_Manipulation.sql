/* In this project i will demonstrate my ability to create, alter, rename, delete and truncate tables as well
as inserting and manipulating the data inside these tables */

-- Creating the sales table
CREATE TABLE sales(
purchase_number INT PRIMARY KEY,
date_of_purchase DATE NOT NULL,
customer_id INT NOT NULL,
item_code VARCHAR(10) NOT NULL);

-- Creating the customers table
CREATE TABLE customers(
customer_id INT PRIMARY KEY,
first_name VARCHAR(250) NOT NULL,
last_name VARCHAR(250) NOT NULL,
email_address VARCHAR(250),
number_of_complaints INT);

-- Creating the items table
CREATE TABLE items(
item_code VARCHAR(10) PRIMARY KEY,
item VARCHAR(250),
unit_price DECIMAL(5,2),
company_id INT,
company_name VARCHAR(250) NOT NULL);

-- Insert five (5) records into the sales table
INSERT INTO sales (purchase_number,date_of_purchase,customer_id,item_code)
VALUES
(1,'2022-09-28',1,'A11'),
(2,'2022-09-27',2,'B11'),
(3,'2022-09-27',2,'A12'),
(4,'2022-09-30',3,'C11'),
(5,'2022-09-30',4,'B12');

-- Insert five (5) records into the customers table
INSERT INTO customers (customer_id,first_name,last_name,email_address,number_of_complaints)
VALUES
(1,'Bruce','Wayne','brucewayne@gmail.com',0),
(2,'Barry','Allen','barryallen@gmail.com',2),
(3,'Clark','Kent','clarkkent@gmail.com',1),
(4,'Oliver','Queen','oliverqueen@gmail.com',0),
(5,'Steve','Rogers','steverogers@gmail.com',5);

-- Insert five (5) records into the items table
INSERT INTO items
VALUES
('A11','Flask',12.50,1,'Company A'),
('A12','Lamp',10,1,'Company A'),
('B11','Desk',50,2,'Company B'),
('B12','Chair',35.50,2,'Company B'),
('C11','Bicycle',150,3,'Company C');

-- Create the companies table and upload the CSV file into the table using the import function available in PostgreSQL
CREATE TABLE companies(
company_id INT PRIMARY KEY,
company_name VARCHAR(250),
headquarters_phone_number VARCHAR(255));

-- Create the sales_dup table
CREATE TABLE sales_dup(
purchase_number INT PRIMARY KEY,
date_of_purchase DATE NOT NULL,
customer_id INT NOT NULL,
item_code VARCHAR(10) NOT NULL);

-- Create the customers_dup table
CREATE TABLE customers_dup(
customer_id INT PRIMARY KEY,
first_name VARCHAR(250) NOT NULL,
last_name VARCHAR(250) NOT NULL,
email_address VARCHAR(250),
number_of_complaints INT);

-- Insert records from sales table into sales_dup table
INSERT INTO sales_dup
SELECT * FROM sales;

-- Insert records from customers table into customers_dup table
INSERT INTO customers_dup
SELECT * FROM customers;

-- Add a new column gender after the last_name field in the customer_dup table
ALTER TABLE customers_dup
ADD COLUMN gender CHAR(2);

-- Insert new records to the customers_dup table
INSERT INTO customers_dup
VALUES 
(6,'Tony','Stark','tonystark@gmail.com',2,'M'),
(7,'Bruce','Banner','brucebanner@gmail.com',11,'M');

-- Rename the sales_dup table to sales_data
ALTER TABLE sales_dup
RENAME TO sales_data;

-- Rename the unit_price column in the items table to item_price
ALTER TABLE items
RENAME unit_price TO item_price;

-- Update the first_name of the 6th record in the customers_dup table
UPDATE customers_dup
SET first_name = 'Toni'
WHERE customer_id = 6;

-- DROP the customers_dup table
DROP TABLE customers_dup;

-- TRUNCATE the sales_data table
TRUNCATE TABLE sales_data;

-- DELETE records from the companies table
DELETE FROM companies
WHERE company_id = 3;