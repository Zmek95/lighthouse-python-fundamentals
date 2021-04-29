-- Answers to SQLZoo tutorials https://sqlzoo.net/wiki/SQL_Tutorial
-- SQLserver engine
-- Tutorial 1 - SELECT name

/*
	   world
+-------------+-----------+
| name        | continent |
+-------------+-----------+
| Afghanistan | Asia      |
+-------------+-----------+
| Albania     | Europe    |
+-------------+-----------+
| Algeria     | Africa    |
+-------------+-----------+
| Andorra     | Europe    |
+-------------+-----------+
| Angola      | Africa    |
+-------------+-----------+
| ...         | ...       |
+-------------+-----------+
*/

-- Q1) Find the country that start with Y
SELECT name FROM world
	WHERE name LIKE 'Y%';

-- Q2) Find the countries that end with y
SELECT name FROM world
	WHERE name LIKE '%y';
  
-- Q3) Find the countries that contain the letter x
SELECT name FROM world
	WHERE name LIKE '%x%';
  
-- Q4) Find the countries that end with land
SELECT name FROM world
	WHERE name LIKE '%land';
  
-- Q5) Find the countries that start with C and end with ia
SELECT name FROM world
	WHERE name LIKE 'C%ia';
  
-- Q6) Find the country that has oo in the name
SELECT name FROM world
	WHERE name LIKE '%oo%';

-- Q7) Find the countries that have three or more a in the name
SELECT name FROM world
	WHERE name LIKE '%a%a%a%';

-- Q8) Find the countries that have "t" as the second character.
SELECT name FROM world
	WHERE name LIKE '_n%';
 
 -- Q9) Find the countries that have two "o" characters separated by two others.
SELECT name FROM world
	WHERE name LIKE '%o__o%';

-- Q10) Find the countries that have exactly four characters.
SELECT name FROM world
	WHERE name LIKE '____';
	
-- Q11) Find the country where the name is the capital city.
SELECT name FROM world
	WHERE name = capital;

-- Q12) Find the country where the capital is the country plus "City".
SELECT name FROM world
	WHERE concat(name, ' City') = capital;

-- Q13) Find the capital and the name where the capital includes the name of the country.
SELECT capital, name FROM world
	WHERE PATINDEX(('%'+ name + '%'), capital) > 0;

-- Q14) Find the capital and the name where the capital is an extension of name of the country.
SELECT capital, name FROM world
	WHERE PATINDEX(('%' + name +'%'), capital) > 0 AND LEN(name) < LEN(capital);
	
-- Q15) Show the name and the extension where the capital is an extension of name of the country.
SELECT name, REPLACE( capital, name, '') as extension FROM world
	WHERE capital LIKE concat(name, '_%');


-- Tutorial 2 - SELECT from WORLD

/*
						world
+-------------+-----------+---------+------------+--------------+
| name        | continent | area    | population | gdp          |
+-------------+-----------+---------+------------+--------------+
| Afghanistan | Asia      | 652230  | 25500100   | 20343000000  |
+-------------+-----------+---------+------------+--------------+
| Albania     | Europe    | 28748   | 2831741    | 12960000000  |
+-------------+-----------+---------+------------+--------------+
| Algeria     | Africa    | 2381741 | 37100000   | 188681000000 |
+-------------+-----------+---------+------------+--------------+
| Andorra     | Europe    | 468     | 78115      | 3712000000   |
+-------------+-----------+---------+------------+--------------+
| Angola      | Africa    | 1246700 | 20609294   | 100990000000 |
+-------------+-----------+---------+------------+--------------+
| ...         | ...       |         |            |              |
+-------------+-----------+---------+------------+--------------+
*/

-- Q1) show the name, continent and population of all countries.
SELECT name, continent, population FROM world;

-- Q2) Show the name for the countries that have a population of at least 200 million.
SELECT name FROM world
	WHERE population >= 200000000;

-- Q3) Give the name and the per capita GDP for those countries with a population of at least 200 million
SELECT name, gdp/population as per_capita_gdp FROM world
	WHERE population >= 200000000;

-- Q4) Show the name and population in millions for the countries of the continent 'South America'
SELECT name, population/1000000 as population_in_millions FROM world
	WHERE continent = 'South America';
	
-- Q5) Show the name and population for France, Germany, Italy
SELECT name, population FROM world
	WHERE name IN ('France', 'Germany', 'Italy');
	
-- Q6) Show the countries which have a name that includes the word 'United'
SELECT name FROM world 
	WHERE name LIKE '%United%';
	
-- Q7) Show the countries that are big by area or big by population. Show name, population and area.
SELECT name, population, area FROM world
	WHERE population > 250000000 OR area > 3000000;
	
-- Q8) Show the countries that are big by area or big by population but not both. Show name, population and area.
SELECT name, population, area FROM world
	WHERE (population > 250000000 AND area <= 3000000)  OR (area > 3000000 AND population <= 250000000);

-- Q9) For South America show population in millions and GDP in billions both to 2 decimal places.
SELECT name, ROUND(population/1000000, 2) as population_in_millions, ROUND(gdp/1000000000, 2) as gdp_in_billions FROM world
	WHERE continent = 'South America';

-- Q10) Show per-capita GDP for the trillion dollar countries to the nearest $1000.
SELECT name, ROUND(gdp/population, -3) as per_capita_gdp FROM world
	WHERE gdp >= 1000000000000;
	
-- Q11) Show the name and capital where the name and the capital have the same number of characters.
SELECT name, capital FROM world
	WHERE LEN(name) = LEN(capital);

-- Q12) Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
SELECT name,capital FROM world
WHERE LEFT(name,1) = LEFT(capital,1) AND name <> capital;

-- Q13) Find the country that has all the vowels and no spaces in its name.
SELECT name FROM world
	WHERE name LIKE '%a%'
		AND name LIKE '%e%'
		AND name LIKE '%i%'
		AND name LIKE '%o%'
		AND name LIKE '%u%'
		AND name NOT LIKE '% %';


-- Tutorial 3 - Select from Nobel

/*
				nobel
+------+------------+-----------------------------+
| yr   | subject    | winner                      |
+------+------------+-----------------------------+
| 1960 | Chemistry  | Willard F. Libby            |
+------+------------+-----------------------------+
| 1960 | Literature | Saint-John Perse            |
+------+------------+-----------------------------+
| 1960 | Medicine   | Sir Frank Macfarlane Burnet |
+------+------------+-----------------------------+
| 1960 | Medicine   | Peter Madawar               |
+------+------------+-----------------------------+
| ...  | ...        |                             |
+------+------------+-----------------------------+
*/

-- Q1) Change the query shown so that it displays Nobel prizes for 1950.
SELECT yr, subject, winner FROM nobel
	WHERE yr = 1950;
	
-- Q2) Show who won the 1962 prize for Literature.
SELECT winner FROM nobel
	WHERE yr = 1962 AND subject = 'Literature';

-- Q3) Show the year and subject that won 'Albert Einstein' his prize.
SELECT yr, subject FROM nobel
	WHERE winner = 'Albert Einstein';
	
-- Q4) Give the name of the 'Peace' winners since the year 2000, including 2000.
SELECT winner from nobel
	WHERE yr >= 2000 AND subject = 'Peace';

-- Q5) Show all details of the Literature prize winners for 1980 to 1989 inclusive.
SELECT * FROM nobel
	WHERE subject = 'Literature' AND (yr >= 1980 AND yr <= 1989);

-- Q6) Show all details of the U.S presidential winners.
SELECT * FROM nobel
	WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');

-- Q7) Show the winners with first name John.
SELECT winner FROM nobel
	WHERE winner LIKE 'John%';

-- Q8) Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.
SELECT * FROM nobel
	WHERE (yr = 1980 AND subject = 'Physics')
		OR (yr = 1984 AND subject = 'Chemistry');

-- Q9) Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine.
SELECT * FROM nobel
	WHERE yr = 1980 AND subject NOT IN ('Chemistry', 'Medicine')

-- Q10) Show year, subject, and name of people who won a 'Medicine' prize in an early year together with winners of a 'Literature' prize in a later year.
SELECT * FROM nobel
	WHERE (yr < 1910 AND subject = 'Medicine')
		OR (yr >= 2004 AND subject = 'Literature');

-- Q11) Find all details of the prize won by PETER GRÜNBERG
SELECT * FROM nobel
	WHERE winner = 'Peter Grünberg';
	
-- Q12) Find all details of the prize won by EUGENE O'NEILL
SELECT * FROM nobel
	WHERE winner = 'Eugene O''Neill';

-- Q13) List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
SELECT winner, yr, subject FROM nobel
	WHERE winner LIKE 'Sir%'
	ORDER BY yr DESC, winner;

-- Q14) Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
SELECT winner, subject FROM nobel
	WHERE yr=1984
	ORDER BY CASE WHEN subject IN ('Chemistry','Physics') THEN 1 ELSE 0 END,
	subject, winner;


-- Tutorial 5 - SUM and COUNT

/*
						world
+-------------+-----------+---------+------------+--------------+
| name        | continent | area    | population | gdp          |
+-------------+-----------+---------+------------+--------------+
| Afghanistan | Asia      | 652230  | 25500100   | 20343000000  |
+-------------+-----------+---------+------------+--------------+
| Albania     | Europe    | 28748   | 2831741    | 12960000000  |
+-------------+-----------+---------+------------+--------------+
| Algeria     | Africa    | 2381741 | 37100000   | 188681000000 |
+-------------+-----------+---------+------------+--------------+
| Andorra     | Europe    | 468     | 78115      | 3712000000   |
+-------------+-----------+---------+------------+--------------+
| Angola      | Africa    | 1246700 | 20609294   | 100990000000 |
+-------------+-----------+---------+------------+--------------+
| ...         | ...       |         |            |              |
+-------------+-----------+---------+------------+--------------+
*/

-- Q1) Show the total population of the world.
SELECT SUM(population) FROM world;

-- Q2) List all the continents - just once each.
SELECT DISTINCT continent FROM world;

-- Q3) Give the total GDP of Africa
SELECT SUM(gdp) FROM world
	WHERE continent = 'Africa';

-- Q4) How many countries have an area of at least 1000000.
SELECT COUNT(name) FROM world
	WHERE area >= 1000000;

-- Q5) What is the total population of ('Estonia', 'Latvia', 'Lithuania').
SELECT SUM(population) FROM world
	WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

-- Q6) For each continent show the continent and number of countries.
SELECT continent, COUNT(name) FROM world
	GROUP BY continent;
	
-- Q7) For each continent show the continent and number of countries with populations of at least 10 million.
SELECT continent, COUNT(name) FROM world
	WHERE population >= 10000000
	GROUP BY continent;

-- Q8) List the continents that have a total population of at least 100 million.
SELECT continent FROM world
	GROUP BY continent
	HAVING SUM(population) >= 100000000;
