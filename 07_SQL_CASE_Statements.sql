/* In this project I will use SQL CASE Statements to answer questions on a dataset that cointains the tables
employees, customers, salaries and sales */

--Change M to Male and F to Female in the employees table
SELECT emp_no,first_name,last_name,
CASE
	WHEN gender = 'M' THEN 'Male'
	ELSE 'Female'
END AS gender
FROM employees;

/* Create a column called age_category that returns Young for ages less than 30,
Aged for ages greater than 60, and Middle Aged otherwise */
SELECT *,
CASE
	WHEN age < 30 THEN 'Young'
	WHEN age > 60 THEN 'Aged'
	ELSE 'Middle Aged'
END AS age_category
FROM customers;

/* Retrieve a list of the average salary of employees over the years. If the average salary is more than
80000, return Paid Well. If the average salary is less than 80000, return Underpaid,
otherwise, return Unpaid */
SELECT emp_no, ROUND(AVG(salary),2) AS average_salary,
CASE
	WHEN AVG(salary) > 80000 THEN 'Paid Well'
	WHEN AVG(salary) < 80000 THEN 'Underpaid'
	ELSE 'Unpaid'
END AS salary_category
FROM salaries
GROUP BY emp_no
ORDER BY average_salary DESC;

-- In this task, we will learn how to use the SQL CASE statement to
-- transpose retrieved data

/* Retrieve the count of the different profit_category from the sales table with profit less than
0 as No Profit, between 0 and 500 as Low Profit, between 500 and 1500 as Good Profit and High Profit otherwise */
SELECT a.profit_category, COUNT(*)
FROM (
SELECT order_line, profit,
CASE
	WHEN profit < 0 THEN 'No Profit'
	WHEN profit > 0 AND profit < 500 THEN 'Low Profit'
	WHEN profit > 500 AND profit < 1500 THEN 'Good Profit'
	ELSE 'High Profit'
END AS profit_category 
FROM sales
) a
GROUP BY a.profit_category;

--Transpose the above result
SELECT SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS no_profit,
SUM(CASE WHEN profit > 0 AND profit < 500 THEN 1 ELSE 0 END) AS low_profit,
SUM(CASE WHEN profit > 500 AND profit < 1500 THEN 1 ELSE 0 END) AS good_profit,
SUM(CASE WHEN profit > 1500 THEN 1 ELSE 0 END) AS high_profit
FROM sales;