CREATE DATABASE VG;
USE VG;
SELECT * FROM vgsales;


DESC vgsales;
 ------- WE will make a new table similar to our table inorder to start the EDA -------
 
 
 CREATE TABLE Games_Sales
 LIKE vgsales;
 
 
 SELECT * FROM Games_Sales;
 
 ------ Now we will import all the values\ fill in this dataset with the values from the vgsales -----
 
 INSERT INTO Games_Sales
 SELECT * FROM vgsales;
 
 SELECT * FROM 
 Games_Sales;
 
 
SELECT *,
ROW_NUMBER() OVER(PARTITION BY  `Name`, Platform, Genre) as row_num
from Games_Sales
ORDER BY `Rank` ;

 ------ CREATING A CTE TO CHECK THE Duplicates and will remove them ---------
 
 
  WITH GAME_CTE AS (
SELECT*,
ROW_NUMBER() OVER(PARTITION BY `Rank`, `Name` ORDER BY Platform, `Year`, Genre, Publisher, NA_Sales,
EU_Sales, JP_Sales,Other_Sales,Global_Sales) as row_num
from Games_Sales

)
SELECT * FROM GAME_CTE
WHERE row_num >1;

------- There are no duplicates so we will continue ahead and see the data types issues ------------


CREATE TABLE `games_sales2` (
  `Rank` int DEFAULT NULL,
  `Name` text,
  `Platform` text,
  `Year` int DEFAULT NULL,
  `Genre` text,
  `Publisher` text,
  `NA_Sales` double DEFAULT NULL,
  `EU_Sales` double DEFAULT NULL,
  `JP_Sales` double DEFAULT NULL,
  `Other_Sales` double DEFAULT NULL,
  `Global_Sales` double DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM Games_Sales2;

INSERT INTO Games_Sales2
SELECT*,
ROW_NUMBER() OVER(PARTITION BY `Rank`, `Name` ORDER BY Platform, `Year`, Genre, Publisher, NA_Sales,
EU_Sales, JP_Sales,Other_Sales,Global_Sales) as row_num
from Games_Sales;

SELECT DISTINCT `NAME`
FROM Games_Sales2
WHERE Name LIKE '%.' ;
UPDATE Games_Sales
SET NAME = 'Super Mario Bros'
WHERE NAME LIKE  'Super Mario Bros.%';
SELECT DISTINCT NAME
FROM Games_Sales;


SELECT DISTINCT Genre
FROM Games_Sales;


