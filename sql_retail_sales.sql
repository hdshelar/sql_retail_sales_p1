-- SQL RETAIL ANALYSIS
create database sql_project_1;

-- DON'T FORGET TO USE THE DATABASE AS SOON AS YOU CREATE THE DATABASE
use sql_project_1;

-- CREATING TABLE 
create table retail_sales(
transactions_id int primary key,
sale_date date,	
sale_time time,
customer_id int,
gender varchar(15),
age int,
category varchar(15),	
quantiy int,	
price_per_unit float,
cogs float,
total_sale float
)

-- COUNT THE TOTAL RECORDS IN THE DATASET
select count(*) from retail_sales;

-- CHECK FOR ANY NULL VALUES IN THE DATASET 
select * from retail_sales where transactions_id is null 
or sale_date is null 
or sale_time is null 
or customer_id is null 
or gender is null 
or age is null 
or category is null 
or quantiy is null
or price_per_unit is null 
or cogs is null 
or total_sale is null;

-- DATA CLEANING
-- DELETE THE NULL ROWS IF ANY 
delete from retail_sales where transactions_id is null 
or sale_date is null 
or sale_time is null 
or customer_id is null 
or gender is null 
or age is null 
or category is null 
or quantiy is null
or price_per_unit is null 
or cogs is null 
or total_sale is null;

-- DATA EXPLORATION
-- HOW MANY SALES DO WE HAVE ??
select count(*) as total_sales from retail_sales;

-- HOW AMNY  UNIQUE CUSTOMERS DO WE HAVE ??
select count(distinct customer_id) from retail_sales;

-- HOW MANY CATEGORIES DO WE HAVE ??
select distinct category from retail_sales;

-- DATA ANALYSIS PROBLEMS
-- Q.1 WRITE A SQL QUERY TO RETRIVE ALL COLUMNS FOR SALES MADE ON '2022-11-05'
select * from retail_sales where sale_date = '2022-11-05'; 

-- Q.2 WRITE A SQL QUERY TO RETIRVE ALL TRANSACTIONS WHERE THE CATEGORY IS 'CLOTHING' AND THE QUANTITY SOLD IS MORE THAN 10 IN THE MONTH OF NOV-2022
select * from retail_sales where category = 'Clothing' and quantiy >= 4 and sale_date >= '2022-11-01' and sale_date < '2022-12-01';

-- Q.3 WRITE A SQL QUERY TO CALCULATE THE TOTAL SALES FOR EACH CATEGORY
select category, sum(total_sale), count(total_sale) as total_orders from retail_sales group by category;

-- Q.4 WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE BEAUTY CATEGORY
select round(avg (age)) as average_age from retail_sales where category = "Beauty";

-- Q.5 WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE THE TOTAL_SALE IS GREATER THAN 1000
select * from retail_sales where total_sale > 1000;

-- Q.6 WRITE A SQL QUERY TO FIND THE TOAL NUMBER OF TRANSACTIONS (TRANSACTION_ID) MADE BY EACH GENDER IN EACH CATEGORY
select category, gender, count(*) as total_transaction from retail_sales group by category,gender order by category;

-- Q.7 WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALES FOR EACH MONTH. FIND OUT BEST SELLING MONTH IN EACH YEAR
select * from ( 
select year(sale_date) as year, month(sale_date) as month, avg(total_sale) as average_sale, rank() over(partition by year(sale_date) order by avg(total_sale) desc) as ranks from retail_sales group by year,month
) as t1 where ranks = 1;

-- Q.8 WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES
select customer_id, sum(total_sale) from retail_sales group by customer_id order by sum(total_sale) desc limit 5;

-- Q.9 WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITMES FROM EACH CATEGORY
select count(distinct customer_id), category from retail_sales group by category;

-- Q.10 WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS (EXAMPLE MORNING <=12, AFTERNOON BETWEEN 12 & 17, EVENING > 17)
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

