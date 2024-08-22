create database Dataanalysis;

show databases; 
use Dataanalysis;

create table Reatil_Sales
    (
      transactions_id int,
      sale_date DATE,
      sale_time TIME,
      customer_id int,
      gender varchar(20),
      age int,
      category varchar(20),
      quantity INT,
      price_per_unit float,
      cogs float,
      total_sale float
)
select * from Reatil_Sales;
RENAME TABLE Reatil_Sales to retail_sales;

select * from retail_sales;

-- Data cleaning --

select * from retail_sales 
where 
     transactions_id IS NULL
     OR
     sale_date IS NULL
     OR 
     sale_time IS NULL 
     OR 
     gender is null
     or
     category is null
     or
     quantity is null
     or 
     cogs is null
     or 
     total_sale is null;
     
-- DATA EXPLORATION 

-- HOW MANY SALES WE HAVE?
SELECT COUNT(*) AS total_sale from retail_sales;

-- HOW many unique customer we have?

SELECT COUNT(DISTINCT customer_id) as total_sale from retail_sales;


-- How many unique category

SELECT COUNT(DISTINCT category) as category from retail_sales;

-- Unique category name 

SELECT DISTINCT category from retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * FROM retail_sales WHERE sale_date ='2022-11-05'; 

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT 
  *
FROM retail_sales
WHERE 
category = 'Clothing'
  AND
  quantity >=4
  AND
  DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
	category,
	SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
from retail_sales
GROUP BY 1


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
    ROUND(AVG(age),2) as avg_age
FROM 
retail_sales 
WHERE
 category="Beauty";
 
 
 -- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT 
    *
FROM 
retail_sales
WHERE total_sale>1000


 -- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
 
SELECT 
      category,
      gender,
      COUNT(*) as total_trans
FROM 
retail_sales 
GROUP 
     BY
     category,
     gender
ORDER BY 1


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
    DATE_FORMAT(sale_date, '%Y') AS month_year,
    MONTH(sale_date) AS month,
    AVG(total_sale) AS monthly_sale
FROM retail_sales
GROUP BY month_year,month
ORDER BY monthly_sale DESC; 


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id,
    SUM(total_sale) as highest_Sal
FROM retail_sales
GROUP BY customer_id
ORDER BY highest_Sal DESC
LIMIT 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    category,
    COUNT(distinct customer_id)
FROM retail_sales 
GROUP BY category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT 
    CASE
        WHEN HOUR(sale_time) <= 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM retail_sales
GROUP BY shift;


-- END OF PROJECT 
