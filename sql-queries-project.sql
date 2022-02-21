/* SQL questions - regression

1. Create a database called house_price_regression.
2. Create a table house_price_data with the same columns as given in the csv file. Please make sure you use the correct data types for the columns.
3. Import the data from the csv file into the table. Before you import the data into the empty table, make sure that you have deleted the headers from the csv file. To not modify the original data, if you want you can create a copy of the csv file as well. Note you might have to use the following queries to give permission to SQL to import data from csv files in bulk:
SHOW VARIABLES LIKE 'local_infile'; -- This query would show you the status of the variable ‘local_infile’. If it is off, use the next command, otherwise you should be good to go
SET GLOBAL local_infile = 1;

4. Select all the data from table house_price_data to check if the data was imported correctly
5. Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. Limit your returned results to 10.
6. Use sql query to find how many rows of data you have.

7. Now we will try to find the unique values in some of the categorical columns:
What are the unique values in the column bedrooms?
What are the unique values in the column bathrooms?
What are the unique values in the column floors?
What are the unique values in the column condition?
What are the unique values in the column grade?

8. Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.
9. What is the average price of all the properties in your data?

10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data
What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices. Use an alias to change the name of the second column.
What is the average sqft_living of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the sqft_living. Use an alias to change the name of the second column.
What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only two columns, waterfront and Average of the prices. Use an alias to change the name of the second column.
Is there any correlation between the columns condition and grade? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.

11. One of the customers is only interested in the following houses:
Number of bedrooms either 3 or 4
Bathrooms more than 3
One Floor
No waterfront
Condition should be 3 at least
Grade should be 5 at least
Price less than 300000
For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them?

12. Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. Write a query to show them the list of such properties. You might need to use a sub query for this problem.
13. Since this is something that the senior management is regularly interested in, create a view of the same query.
14. Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms?
15. What are the different locations where properties are available in your database? (distinct zip codes)
16. Show the list of all the properties that were renovated.
17. Provide the details of the property that is the 11th most expensive property in your database. */

-- 1. Create a database called house_price_regression.

CREATE DATABASE house_price_regression;

-- 2. Create a table house_price_data with the same columns as given in the csv file. 

USE house_price_regression;
CREATE TABLE house_price_data (
    id BIGINT NOT NULL,
    `date` VARCHAR(255) NOT NULL,  -- doesn't show right values with date type
    bedrooms INT NOT NULL,
    bathrooms FLOAT NOT NULL,
    sqft_living INT NOT NULL,
    sqft_lot INT NOT NULL,
    floors FLOAT NOT NULL,
    waterfront INT NOT NULL,
    `view` INT NOT NULL,
    `condition` INT NOT NULL,  -- shows error without ` mark
    grade INT NOT NULL,
    sqft_above INT NOT NULL,
    sqft_basement INT NOT NULL,
    yr_built INT NOT NULL,
    yr_renovated INT NOT NULL,
    zipcode INT NOT NULL,
    lat FLOAT NOT NULL,
    `long` FLOAT NOT NULL,
    sqft_living15 INT NOT NULL,
    sqft_lot15 INT NOT NULL,
    price INT NOT NULL,
    PRIMARY KEY (id)
);

-- 3. Import the data from the csv file into the table. 

/* Done in Command Line after setting local_infile and secure_file_priv.
mysql> load data local infile '/Users/Hajar_1/Desktop/data_mid_bootcamp_project_regression/regression_data.csv'
    -> into table house_price_data
    -> fields terminated by ','
    -> lines terminated by '\n';
Query OK, 21420 rows affected, 13237 warnings (0.25 sec)
Records: 21597  Deleted: 0  Skipped: 177  Warnings: 13237 */

-- 4. Select all the data from table house_price_data to check if the data was imported correctly

SELECT 
    *
FROM
    house_price_data;  -- ok
    
-- 5. Use the alter table command to drop the column date from the database, as we would not use it in the analysis 
-- with SQL. Select all the data from the table to verify if the command worked. Limit your returned results to 10.

ALTER TABLE house_price_data
DROP COLUMN date;

-- 6. Use sql query to find how many rows of data you have.

SELECT 
    COUNT(*) AS 'Number of rows'
FROM
    house_price_data;

-- 7. Now we will try to find the unique values in some of the categorical columns: 
-- bedrooms, bathrooms, floors, condition, grade.

SELECT DISTINCT
    bedrooms AS 'Unique number of bedrooms'
FROM
    house_price_data
ORDER BY bedrooms;  -- outlier value 33 (not logical)

SELECT DISTINCT
    bathrooms AS 'Unique number of bathrooms'
FROM
    house_price_data
ORDER BY bathrooms;

SELECT DISTINCT
    floors AS 'Unique number of floors'
FROM
    house_price_data
ORDER BY floors;

SELECT DISTINCT
    `condition` AS 'Unique condition mark'
FROM
    house_price_data
ORDER BY `condition`;

SELECT DISTINCT
    grade AS 'Unique grades'
FROM
    house_price_data
ORDER BY grade;

-- 8. Arrange the data in a decreasing order by the price of the house. 
-- Return only the IDs of the top 10 most expensive houses in your data.

SELECT 
    id, price
FROM
    house_price_data
ORDER BY price DESC
LIMIT 10;

-- 9. What is the average price of all the properties in your data?

SELECT 
    ROUND(AVG(price)) AS 'Average of house prices'
FROM
    house_price_data;

-- 10.1 What is the average price of the houses grouped by bedrooms? 

SELECT 
    bedrooms, ROUND(AVG(price)) AS 'Average of the prices'
FROM
    house_price_data
GROUP BY bedrooms
ORDER BY bedrooms;  -- houses with 8 bedrooms has the highest average price

-- 10.2 What is the average sqft_living of the houses grouped by bedrooms?

SELECT 
    bedrooms, ROUND(AVG(sqft_living)) AS 'Average of the sqft_living'
FROM
    house_price_data
GROUP BY bedrooms
ORDER BY bedrooms;  -- houses with 33 bedrooms have average sq.ft. less than with 3 bedrooms?! (remove them later)

-- 10.3 What is the average price of the houses with a waterfront and without a waterfront? 

SELECT 
    waterfront, ROUND(AVG(price)) AS 'Average of the prices'
FROM
    house_price_data
GROUP BY waterfront
ORDER BY waterfront;  -- average price of houses with a view to waterfront are twice more than without

-- 10.4 Is there any correlation between the columns condition and grade? 

SELECT 
    grade, ROUND(AVG(`condition`)) AS 'Average of condition'
FROM
    house_price_data
GROUP BY grade
ORDER BY grade;  -- the average of condition seems to be stable, so there is no correlation

-- 11. One of the customers is only interested in the following houses:
/* Number of bedrooms either 3 or 4
Bathrooms more than 3
One Floor
No waterfront
Condition should be 3 at least
Grade should be 5 at least
Price less than 300000 */

SELECT 
    *
FROM
    house_price_data
WHERE
    bedrooms IN (3 , 4) AND bathrooms > 3
        AND floors = 1
        AND waterfront = 0
        AND `condition` >= 3
        AND grade >= 5
        AND price < 300000;  -- no such houses in dataset
        
-- 12. Find out the list of properties whose prices are twice more than the average of all the properties in the database.

SELECT 
    id, price
FROM
    house_price_data
WHERE
    price >= (SELECT 
            AVG(price) * 2 AS 'Twice average of price'
        FROM
            house_price_data)
ORDER BY price;

-- 13. Since this is something that the senior management is regularly interested in, create a view of the same query.

CREATE VIEW properties_2x_average_price AS
(SELECT 
    id, price
FROM
    house_price_data
WHERE
    price >= (SELECT 
            AVG(price) * 2 AS 'Twice average of price'
        FROM
            house_price_data)
ORDER BY price);

-- 14. What is the difference in average prices of the properties with three and four bedrooms?

WITH cte_bedrooms_avg_price AS (SELECT bedrooms, ROUND(AVG(price)) as avg_price
							FROM house_price_data
							WHERE bedrooms IN (3 , 4)
							GROUP BY bedrooms
                            ORDER BY bedrooms)
SELECT bedrooms, avg_price, (avg_price - lag(avg_price, 1) OVER ()) AS difference
FROM cte_bedrooms_avg_price;

-- 15. What are the different locations where properties are available in your database? (distinct zip codes)

SELECT DISTINCT
    (zipcode) AS 'Unique locations'
FROM
    house_price_data;

-- 16. Show the list of all the properties that were renovated.

SELECT 
    id, yr_renovated
FROM
    house_price_data
WHERE
    yr_renovated <> 0;
    
-- 17. Provide the details of the property that is the 11th most expensive property in your database. 

WITH cte_top11 AS (SELECT *
					FROM house_price_data
					ORDER BY price DESC
					LIMIT 11)
SELECT 
    *
FROM
    cte_top11
ORDER BY price ASC
LIMIT 1;