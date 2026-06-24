-- DATABASE SETUP
CREATE DATABASE sql_project_1;

CREATE TABLE info2(
 	transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
)


-- DATA EXPLORING AND CLEANING
SELECT * FROM info2;

SELECT FROM info2
WHERE 
		transactions_id IS NULL
		OR sale_date IS NULL
		OR sale_time IS NULL
		OR customer_id IS NULL
		OR gender IS NULL
		OR age IS NULL
		OR category IS NULL
		OR quantiy IS NULL
		OR price_per_unit IS NULL
		OR cogs IS NULL
		OR total_sale IS NULL;

DELETE FROM info2 
WHERE 
		transactions_id IS NULL
		OR sale_date IS NULL
		OR sale_time IS NULL
		OR customer_id IS NULL
		OR gender IS NULL
		OR age IS NULL
		OR category IS NULL
		OR quantiy IS NULL
		OR price_per_unit IS NULL
		OR cogs IS NULL
		OR total_sale IS NULL;


-- DATA ANALYSIS AND FINDINGS

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM info2 
WHERE sale_date ='2022-11-05'
ORDER BY quantiy DESC


-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT transactions_id AS TRANSACTIONS, category,quantiy, sale_date  FROM info2
WHERE 
	category='Clothing' 
	AND 
	quantiy>=4 
	AND 
	TO_CHAR(sale_date, 'YYYY-MM')='2022-11'           -- IMPORTANT-- IMPORTANT-- IMPORTANT-- IMPORTANT-- IMPORTANT-- IMPORTANT-- IMPORTANT                                    -- IMPORTANT
ORDER  BY transactions_id


-- 3. Write a SQL query to calculate the total sales (total_sale) for each category:
SELECT 
	category, 
	SUM(total_sale), 
	COUNT(*) AS amount FROM info2
GROUP BY category


-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category:
SELECT 
	ROUND(AVG(age),2) AS average_age, 
	category
FROM info2
WHERE 
	category='Beauty'
GROUP BY category


-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000:
SELECT 
	transactions_id,
	total_sale
FROM info2
WHERE 
	total_sale>1000
ORDER  BY total_sale DESC


-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT 
	COUNT(*) AS counts,
	gender,
	category
FROM info2
GROUP BY 2,3
ORDER BY 3,1 DESC


-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    ROUND(AVG(total_sale::numeric), 2) AS avg_sale
FROM info2
GROUP BY 1,2
ORDER BY 1,2


-- 8. Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
	DISTINCT customer_id,
	SUM(total_sale)
FROM info2
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 5


-- 9. Write a SQL query to find the NUMBER of UNIQUE CUSTOMERS who purchased items from EACH CATEGORY:
SELECT 
	 COUNT(DISTINCT customer_id) ,
	 category
FROM info2
GROUP BY 2


-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

 
								-- CTE (Common Table Expression)
WITH hourly_sale as(SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS sale_shift
FROM info2)
select 
	sale_shift,
	SUM(quantiy) AS quantity
	
FROM  hourly_sale
GROUP BY sale_shift
ORDER BY 1

									-- PROJECT END
