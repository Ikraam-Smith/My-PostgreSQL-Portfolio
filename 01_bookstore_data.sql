/* In my first postgresql porfolio project i will answer a few basic
questions based on a bookstore dataset obtained on Kaggle */

-- First create the table
CREATE TABLE bookstore_data
(title VARCHAR(250),
book_category VARCHAR(50),
star_rating VARCHAR(10),
price DECIMAL,
quantity_in_stock INTEGER);
/* I then used the import function available on pgAdmin to import the csv file
into the bookstore_data table that i just created */

-- Insert into the table information about a new book being sold
INSERT INTO bookstore_date
(title,book_category,star_rating,price,quantity_in_stock)
VALUES
('Beginners guide to SQL','Education','Five',24.99,25);

-- What are the different book categories?
SELECT DISTINCT (book_category)
FROM bookstore_data;

-- How many books received five star ratings?
SELECT COUNT (title)
FROM bookstore_data
WHERE star_rating = 'Five';

-- What is the title and price of the most expensive book being sold
SELECT title, price
FROM bookstore_data
GROUP BY title, price
ORDER BY price DESC
LIMIT 1;

-- Which books only have 1 left in stock
SELECT title FROM bookstore_data
WHERE quantity_in_stock = 1;
