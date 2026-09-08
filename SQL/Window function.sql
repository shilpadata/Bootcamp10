-- Databricks notebook source
-- MAGIC %md
-- MAGIC - ROW NUMBER
-- MAGIC - RANK
-- MAGIC - DENSE RANK
-- MAGIC - LAG
-- MAGIC - LEAD
-- MAGIC - SUM

-- COMMAND ----------

DROP TABLE IF EXISTS workspace.default.sales_orders;

CREATE TABLE workspace.default.sales_orders (
    order_id INT,
    customer_id INT,
    customer_name STRING,
    city STRING,
    product STRING,
    category STRING,
    order_date DATE,
    amount DECIMAL(10,2)
)
USING DELTA;

-- COMMAND ----------

INSERT INTO workspace.default.sales_orders VALUES

(1001, 101, 'Amit', 'Delhi', 'Laptop', 'Electronics', '2026-01-05', 65000),
(1002, 101, 'Amit', 'Delhi', 'Mobile', 'Electronics', '2026-01-15', 30000),
(1003, 101, 'Amit', 'Delhi', 'Monitor', 'Electronics', '2026-02-10', 18000),
(1004, 101, 'Amit', 'Delhi', 'Keyboard', 'Accessories', '2026-03-05', 2500),
(1036, 101, 'Amit', 'Delhi', 'Mobile', 'Electronics', '2026-04-05', 30000),

(1005, 102, 'Priya', 'Mumbai', 'Laptop', 'Electronics', '2026-01-08', 65000),
(1006, 102, 'Priya', 'Mumbai', 'Mobile', 'Electronics', '2026-02-12', 30000),
(1007, 102, 'Priya', 'Mumbai', 'Headphones', 'Electronics', '2026-03-15', 5000),
(1037, 102, 'Priya', 'Mumbai', 'Mobile', 'Electronics', '2026-04-10', 30000),

(1008, 103, 'Rahul', 'Delhi', 'Laptop', 'Electronics', '2026-01-10', 65000),
(1009, 103, 'Rahul', 'Delhi', 'Monitor', 'Electronics', '2026-02-20', 18000),
(1010, 103, 'Rahul', 'Delhi', 'Keyboard', 'Accessories', '2026-03-10', 2500),

(1011, 104, 'Sneha', 'Bangalore', 'Laptop', 'Electronics', '2026-01-12', 65000),
(1012, 104, 'Sneha', 'Bangalore', 'Mobile', 'Electronics', '2026-01-25', 30000),
(1013, 104, 'Sneha', 'Bangalore', 'Monitor', 'Electronics', '2026-02-18', 18000),
(1014, 104, 'Sneha', 'Bangalore', 'Headphones', 'Electronics', '2026-03-20', 5000),

(1015, 105, 'Vikas', 'Mumbai', 'Mobile', 'Electronics', '2026-01-20', 30000),
(1016, 105, 'Vikas', 'Mumbai', 'Monitor', 'Electronics', '2026-02-15', 18000),
(1017, 105, 'Vikas', 'Mumbai', 'Keyboard', 'Accessories', '2026-03-12', 2500),

(1018, 106, 'Neha', 'Pune', 'Laptop', 'Electronics', '2026-01-18', 65000),
(1019, 106, 'Neha', 'Pune', 'Mobile', 'Electronics', '2026-02-22', 30000),
(1020, 106, 'Neha', 'Pune', 'Monitor', 'Electronics', '2026-03-18', 18000),

(1021, 107, 'Arjun', 'Delhi', 'Laptop', 'Electronics', '2026-01-22', 65000),
(1022, 107, 'Arjun', 'Delhi', 'Mobile', 'Electronics', '2026-02-25', 30000),
(1023, 107, 'Arjun', 'Delhi', 'Headphones', 'Electronics', '2026-03-25', 5000),

(1024, 108, 'Pooja', 'Pune', 'Mobile', 'Electronics', '2026-01-28', 30000),
(1025, 108, 'Pooja', 'Pune', 'Monitor', 'Electronics', '2026-02-28', 18000),
(1026, 108, 'Pooja', 'Pune', 'Keyboard', 'Accessories', '2026-03-28', 2500),

(1027, 109, 'Karan', 'Bangalore', 'Laptop', 'Electronics', '2026-01-30', 65000),
(1028, 109, 'Karan', 'Bangalore', 'Mobile', 'Electronics', '2026-02-26', 30000),
(1029, 109, 'Karan', 'Bangalore', 'Monitor', 'Electronics', '2026-03-22', 18000),

(1030, 110, 'Anita', 'Mumbai', 'Laptop', 'Electronics', '2026-01-14', 65000),
(1031, 110, 'Anita', 'Mumbai', 'Mobile', 'Electronics', '2026-02-14', 30000),
(1032, 110, 'Anita', 'Mumbai', 'Monitor', 'Electronics', '2026-03-14', 18000),

(1033, 111, 'Rohit', 'Delhi', 'Laptop', 'Electronics', '2026-01-16', 65000),
(1034, 111, 'Rohit', 'Delhi', 'Mobile', 'Electronics', '2026-02-16', 30000),
(1035, 111, 'Rohit', 'Delhi', 'Headphones', 'Electronics', '2026-03-16', 5000);

-- COMMAND ----------

SELECT *
FROM workspace.default.sales_orders
ORDER BY customer_id, order_date;

-- COMMAND ----------

select sum(amount), customer_id,customer_name from sales_orders
group by customer_id, customer_name

-- COMMAND ----------

-- DBTITLE 1,Syntax
-- function() OVER(
--     PARTITION BY customer_id
--     ORDER BY order_date DESC
-- )

-- COMMAND ----------

select
*,
SUM(amount) OVER(
    PARTITION BY customer_id
    ORDER BY order_date 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) as runniingtotal

FROM sales_orders
ORDER BY customer_id

-- COMMAND ----------

select
*,
SUM(amount) OVER(
    PARTITION BY customer_id
    ORDER BY order_date 
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) as runniingtotal

FROM sales_orders
ORDER BY customer_id, order_date

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## ROW_NUMBER()

-- COMMAND ----------

SELECT
* ,
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date DESC) AS ORD_NO
FROM sales_orders
ORDER BY customer_id
 

-- COMMAND ----------

WITH RANKORDERS AS(
SELECT
* ,
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date DESC) AS ORD_NO
FROM sales_orders
ORDER BY customer_id
)
SELECT *
FROM RANKORDERS
WHERE ORD_NO = 1
 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## RANK()

-- COMMAND ----------

SELECT
 *,
RANK() OVER(PARTITION BY customer_id ORDER BY amount DESC) AS rank
FROM sales_orders
QUALIFY rank = 1
ORDER BY customer_id, rank
 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Dense_rank()

-- COMMAND ----------

SELECT
 *,
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY amount DESC) AS ROWN,
DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY amount DESC) AS DENSE_rank,
RANK() OVER(PARTITION BY customer_id ORDER BY amount DESC) AS rank
FROM sales_orders

ORDER BY customer_id, rank

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## LAG()

-- COMMAND ----------

SELECT *,
LAG(amount) OVER(PARTITION BY customer_id ORDER BY order_date) as previousamt
from sales_orders
order by customer_id, order_date

-- COMMAND ----------

SELECT *,
LAG(amount,2) OVER(PARTITION BY customer_id ORDER BY order_date) as previousamt
from sales_orders
order by customer_id, order_date

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ###Difference between current and previous order amount

-- COMMAND ----------

with cte as(
SELECT *,
LAG(amount) OVER(PARTITION BY customer_id ORDER BY order_date) as previousamt
from sales_orders
)
select * , amount - previousamt as diff
from cte
-- where amount - previousamt >0
order by customer_id, order_date

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ##LEAD()

-- COMMAND ----------

SELECT *,
LEAD(amount) OVER(PARTITION BY customer_id ORDER BY order_date) as NEXTAMT
from sales_orders
order by customer_id, order_date

-- COMMAND ----------



-- COMMAND ----------

SELECT *,
LAG(amount) OVER(PARTITION BY customer_id ORDER BY order_date) as PREVIOUS,
LEAD(amount) OVER(PARTITION BY customer_id ORDER BY order_date) as NEXTAMT
from sales_orders
order by customer_id, order_date

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## TOP 2 orders per customer

-- COMMAND ----------

with cte as(
select 
*, row_number() over(partition by customer_id order by amount desc) as rn
from sales_orders)
select * from cte where rn <=2 

-- COMMAND ----------


select 
*, row_number() over(partition by customer_id order by amount desc) as rn
from sales_orders
qualify rn <= 2


-- COMMAND ----------

-- MAGIC %md
-- MAGIC