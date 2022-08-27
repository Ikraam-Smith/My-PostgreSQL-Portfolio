/* In this project i will use the dataset provided by data analyst Ian Klosowics
to answer a few basic questions */

--First i created the tables
CREATE TABLE aliens(
alien_id SERIAL PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100),
gender VARCHAR(20),
type VARCHAR(50),
birth_year INTEGER);

CREATE TABLE location(
loc_id INTEGER REFERENCES aliens(alien_id),
current_location VARCHAR(50),
state VARCHAR(50),
country VARCHAR(100),
occupation VARCHAR(150));

CREATE TABLE details
detail_id INTEGER REFERENCES alien(alien_id),
favorite_food VARCHAR(100),
feeding_frequency VARCHAR(50),
aggressive VARCHAR(20));

/* I then used the import function on postgresql to import the csv files into the tables
and answered the below questions */

--What are different feeding frequencies for the aliens?
SELECT DISTINCT (feeding_frequency)
FROM details;

--How many aliens never eat?
SELECT COUNT(feeding_frequency)
FROM details
WHERE feeding_frequency = 'Never';

--Produce an output table that displays first_name,last_name and age of the aliens
SELECT first_name,last_name,(2022-birth_year) AS age
FROM aliens;

--What is the average age of the aliens?
SELECT ROUND(AVG(2022-birth_year),2)
FROM aliens;

--I then used the above query as a subquery to display only aliens who are above the average age
SELECT first_name,last_name,(2022-birth_year)
FROM aliens
WHERE (2022-birth_year)
AS age > (SELECT ROUND(AVG(2022-birth_year),2) FROM aliens);

--Lastly list the aliens classified as aggressive
SELECT first_name,last_name,type
FROM aliens
INNER JOIN details
ON aliens.alien_id = details.detail_id
WHERE aggressive = 'TRUE';