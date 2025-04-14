# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
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
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Q.1 WRITE A SQL QUERY TO RETRIVE ALL COLUMNS FOR SALES MADE ON '2022-11-05'**:
```sql
select * from retail_sales where sale_date = '2022-11-05'; 
```

2. **Q.2 WRITE A SQL QUERY TO RETIRVE ALL TRANSACTIONS WHERE THE CATEGORY IS 'CLOTHING' AND THE QUANTITY SOLD IS MORE THAN 10 IN THE MONTH OF NOV-2022**:
```sql
select * from retail_sales where category = 'Clothing' and quantiy >= 4 and sale_date >= '2022-11-01' and sale_date < '2022-12-01';
```

3. **Q.3 WRITE A SQL QUERY TO CALCULATE THE TOTAL SALES FOR EACH CATEGORY**:
```sql
select category, sum(total_sale), count(total_sale) as total_orders from retail_sales group by category;
```

4. **Q.4 WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE BEAUTY CATEGORY**:
```sql
select round(avg (age)) as average_age from retail_sales where category = "Beauty";
```

5. **Q.5 WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE THE TOTAL_SALE IS GREATER THAN 1000**:
```sql
select * from retail_sales where total_sale > 1000;
```

6. **Q.6 WRITE A SQL QUERY TO FIND THE TOAL NUMBER OF TRANSACTIONS (TRANSACTION_ID) MADE BY EACH GENDER IN EACH CATEGORY**:
```sql
select category, gender, count(*) as total_transaction from retail_sales group by category,gender order by category;
```

7. **WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALES FOR EACH MONTH. FIND OUT BEST SELLING MONTH IN EACH YEAR**:
```sql
select * from ( 
select year(sale_date) as year, month(sale_date) as month, avg(total_sale) as average_sale, rank() over(partition by year(sale_date) order by avg(total_sale) desc) as ranks from retail_sales group by year,month
) as t1 where ranks = 1;
```

8. **Q.8 WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES**:
```sql
select customer_id, sum(total_sale) from retail_sales group by customer_id order by sum(total_sale) desc limit 5;
```

9. **Q.9 WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITMES FROM EACH CATEGORY**:
```sql
select count(distinct customer_id), category from retail_sales group by category;
```

10. **Q.10 WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS (EXAMPLE MORNING <=12, AFTERNOON BETWEEN 12 & 17, EVENING > 17)**:
```sql
with hourly_shift 
as 
(
select * ,
case 
when hour(sale_time) < 12 then "morning"
when hour(sale_time) between 12 and 17 then "afternoon"
else "evening"
end as shift 
from retail_sales
)
select count(*) as total_order, shift from hourly_shift group by shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
