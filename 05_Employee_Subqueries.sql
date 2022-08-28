/* In this guided project with techTFQ on Youtube i will use the tables
 created to answer the below questions using subqueries */

CREATE TABLE department(
dept_id INTEGER ,
dept_name VARCHAR(50) PRIMARY KEY,
location VARCHAR(100));

INSERT INTO department 
VALUES 
(1, 'Admin', 'Bangalore'),
(2, 'HR', 'Bangalore'),
(3, 'IT', 'Bangalore'),
(4, 'Finance', 'Mumbai'),
(5, 'Marketing', 'Bangalore'),
(6, 'Sales', 'Mumbai');

CREATE TABLE employee(
emp_id INTEGER PRIMARY KEY,
emp_name VARCHAR(50) NOT NULL,
dept_name VARCHAR(50) NOT NULL REFERENCES department(dept_name),
salary INTEGER);

INSERT INTO employee 
VALUES
(101, 'Mohan', 'Admin', 4000),
(102, 'Rajkumar', 'HR', 3000),
(103, 'Akbar', 'IT', 4000),
(104, 'Dorvin', 'Finance', 6500),
(105, 'Rohit', 'HR', 3000),
(106, 'Rajesh',  'Finance', 5000),
(107, 'Preet', 'HR', 7000),
(108, 'Maryam', 'Admin', 4000),
(109, 'Sanjay', 'IT', 6500),
(110, 'Vasudha', 'IT', 7000),
(111, 'Melinda', 'IT', 8000),
(112, 'Komal', 'IT', 10000),
(113, 'Gautham', 'Admin', 2000),
(114, 'Manisha', 'HR', 3000),
(115, 'Chandni', 'IT', 4500),
(116, 'Satya', 'Finance', 6500),
(117, 'Adarsh', 'HR', 3500),
(118, 'Tejaswi', 'Finance', 5500),
(119, 'Cory', 'HR', 8000),
(120, 'Monica', 'Admin', 5000),
(121, 'Rosalin', 'IT', 6000),
(122, 'Ibrahim', 'IT', 8000),
(123, 'Vikram', 'IT', 8000),
(124, 'Dheeraj', 'IT', 11000);

CREATE TABLE sales(
store_id INTEGER,
store_name VARCHAR(50),
product_name VARCHAR(50),
quantity INTEGER,
price INTEGER);

INSERT INTO sales 
VALUES
(1, 'Apple Store 1','iPhone 13 Pro', 1, 1000),
(1, 'Apple Store 1','MacBook pro 14', 3, 6000),
(1, 'Apple Store 1','AirPods Pro', 2, 500),
(2, 'Apple Store 2','iPhone 13 Pro', 2, 2000),
(3, 'Apple Store 3','iPhone 12 Pro', 1, 750),
(3, 'Apple Store 3','MacBook pro 14', 1, 2000),
(3, 'Apple Store 3','MacBook Air', 4, 4400),
(3, 'Apple Store 3','iPhone 13', 2, 1800),
(3, 'Apple Store 3','AirPods Pro', 3, 750),
(4, 'Apple Store 4','iPhone 12 Pro', 2, 1500),
(4, 'Apple Store 4','MacBook pro 16', 1, 3500);

/* Find the employees who's salary is greater than the average salary 
earned by all employees */
SELECT * FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee);

--Find the employees who earn the highest salary in each department
SELECT * FROM employee
WHERE (dept_name,salary) IN
(SELECT dept_name,MAX(salary) FROM employee
GROUP BY dept_name);

--Find the departments who do not have any employees
SELECT * FROM department
WHERE dept_name 
NOT IN (SELECT DISTINCT(dept_name) FROM employee);

/*Find the employees in each department who earn more than the average 
salary of that department */
SELECT * FROM employee e1
WHERE salary > 
(SELECT AVG(salary) FROM employee e2 where e2.dept_name = e1.dept_name);

--Find stores who's sales where better than the average sales accross all stores
WITH sales AS
(SELECT store_name,SUM(price) AS total_sales
FROM sales
GROUP BY store_name)
SELECT * FROM sales
INNER JOIN (SELECT AVG(total_sales) AS sales
FROM sales x) avg_sales
ON sales.total_sales > avg_sales.sales;

--Fetch all employee details and add remarks to these employees who earn more than the average salary
SELECT *,(CASE WHEN salary > (SELECT AVG(salary) FROM employee)
		  THEN 'Higher than average'
		  ELSE NULL
		  END) AS remarks
FROM employee;

--Find the stores that have sold more units than the average units sold by all stores.
SELECT store_name,SUM(quantity)
FROM sales
GROUP BY store_name
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);
