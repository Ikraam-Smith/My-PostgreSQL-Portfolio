/* In this project based on the dataset, 120 years of olympic history (till 2016), obtained on Kaggle I will used the
data provided to answer a few questions */

--I first created the tables
CREATE TABLE olympic_history(
id INTEGER,
name VARCHAR(150),
sex VARCHAR(10),
age VARCHAR(100),
height VARCHAR(250),
weight VARCHAR(150),
team VARCHAR(50),
noc VARCHAR(10),
games VARCHAR(50),
year INTEGER,
season VARCHAR(50),
city VARCHAR(50),
sport VARCHAR(50),
event VARCHAR(100),
medal VARCHAR(50));

CREATE TABLE regions(
noc VARCHAR(10),
region VARCHAR(50),
notes VARCHAR(50));

--I then used the Postgresql import function to import the csv files into the tables and answer the below questions

--How many olympic games have been held?
SELECT COUNT (DISTINCT(games))
FROM olympic_history;

--Which nation has participated in all the olympic games?
SELECT team, COUNT (DISTINCT (games))
FROM olympic_history
GROUP BY team
HAVING COUNT (DISTINCT (games)) = (SELECT COUNT (DISTINCT(games))
FROM olympic_history);

--Which athlete won the most gold medals?
SELECT name, COUNT(medal) AS total_metals
FROM olympic_history
WHERE medal = 'Gold'
GROUP BY name
ORDER BY COUNT(medal) DESC
LIMIT 1;

--Identify the sports that were played in all summer olympics
WITH t1 AS
(SELECT COUNT (DISTINCT(games)) AS total_summer_games FROM olympic_history
WHERE season = 'Summer'),
t2 AS
(SELECT DISTINCT (sport),games FROM olympic_history),
t3 AS
(SELECT sport, COUNT(games) AS no_of_games
FROM t2
GROUP BY sport)
SELECT * FROM t3
INNER JOIN t1 ON t1.total_summer_games = t3.no_of_games;
