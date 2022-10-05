/* In the project i will use regular expressions to analyze the data */

-- I first created the tables, customers and twitter
CREATE TABLE customers(
CustomerId SERIAL PRIMARY KEY,
FirstName VARCHAR(255),
LastName VARCHAR(255),
Address text,
City VARCHAR(255),
Country VARCHAR(255),
PostalCode VARCHAR(12),
Phone VARCHAR(20),
Email text,
SupportRepId INT);

CREATE TABLE twitter(
tweetid INT,
tweets text);

/*  I then used the import function in PostgreSQL to import the csv files for the customers and twitter tables
and performed the below tasks */

-- Extract a list of all customers whose first name starts with 'He'
SELECT *
FROM customers
WHERE firstname LIKE('He%');

-- Extract a list of all customers whose last name ends with 's'
SELECT *
FROM customers
WHERE lastname LIKE('%s');

-- What do you think the result of this query will be? contains ar in firstname
SELECT *
FROM customers
WHERE firstname LIKE('%ar%');

-- What do you think the output will be here? starts with Mar followed by single character
SELECT *
FROM customers
WHERE firstname LIKE ('Mar_');
    
-- Extract all individuals from the customers table whose first name does not contain 'Mar'
SELECT *
FROM customers
WHERE firstname NOT LIKE ('%Mar%');

-- Retrieve a list of all customers whose first name starts with a
SELECT * FROM customers
WHERE firstname ~* '^a+[a-z]+$';

-- Retrieve a list of all customers whose city starts with s
SELECT * FROM customers
WHERE city ~* '^s+[a-z\s]+$';

-- Retrieve a list of all customers whose city starts with a, b, c, or d
SELECT * FROM customers
WHERE city ~* '^(a|b|c|d)+[a-z\s]+$';

-- Retrieve the first name, last name, phone number and email of all customers with a gmail account
SELECT firstname,lastname,phone,email
FROM customers
WHERE email ~ 'gmail';

-- Retrieve the first name, last name, phone number and email of all customers whose email starts with t
SELECT firstname,lastname,phone,email
FROM customers
WHERE email ~* '^t';

-- Retrieve the first name, last name, phone number and email of all customers whose email ends with com
SELECT firstname,lastname,phone,email
FROM customers
WHERE email ~ 'com$';

-- Retrieve the first name, last name, phone number and email of all customers whose email starts with a, b, or t
SELECT firstname,lastname,phone,email
FROM customers
WHERE email ~ '^[abt]';

-- Retrieve the first name, last name, phone number and email of all customers whose email contain a number
SELECT firstname,lastname,phone,email
FROM customers
WHERE email ~ '[0-9]';

-- Retrieve the first name, last name, phone number and email of all customers whose email contain two-digit numbers
SELECT firstname,lastname,phone,email
FROM customers
WHERE email ~ '[0-9]{2}';

-- Retrieve the numbers in the email addresses of customers
SELECT SUBSTRING(email FROM '[0-9]+')
FROM customers
WHERE email ~ '[0-9]';

-- Retrieve all tweets and tweetid with the word #COVID
SELECT tweetid,tweets
FROM twitter
WHERE tweets ~* '#COVID';

-- Retrieve all tweets and tweetid with the word #COVID19
SELECT tweetid,tweets
FROM twitter
WHERE tweets ~* '#COVID19';

-- Retrieve all tweetid and all hashtags
SELECT tweetid, regexp_matches(tweets,'#[A-Za-z0-9_]+','g')
FROM twitter;

-- Retrieve all tweetid and all COVID19 hashtags using regexp_matches()
SELECT tweetid, regexp_matches(tweets,'#(COVID19)','g')
FROM twitter;