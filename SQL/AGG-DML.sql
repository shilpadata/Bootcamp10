-- Databricks notebook source
-- DBTITLE 1,customers
DROP TABLE IF EXISTS workspace.default.customers;

CREATE TABLE workspace.default.customers (
    customer_id INT,
    customer_name STRING,
    city STRING,
    state STRING,
    age INT,
    gender STRING,
    membership STRING,
    email STRING
)
USING DELTA;

-- COMMAND ----------

INSERT INTO workspace.default.customers VALUES
(101, 'Amit', 'Delhi', 'Delhi', 28, 'M', 'Gold', 'amit@gmail.com'),
(102, 'Priya', 'Mumbai', 'Maharashtra', 32, 'F', 'Silver', 'priya@gmail.com'),
(103, 'Rahul', 'Delhi', 'Delhi', 25, 'M', 'Gold', 'rahul@gmail.com'),
(104, 'Sneha', 'Bangalore', 'Karnataka', 29, 'F', 'Platinum', 'sneha@gmail.com'),
(105, 'Vikas', 'Mumbai', 'Maharashtra', 35, 'M', 'Silver', NULL),
(106, 'Neha', 'Pune', 'Maharashtra', 27, 'F', 'Gold', 'neha@gmail.com'),
(107, 'Arjun', 'Delhi', 'Delhi', 41, 'M', 'Platinum', 'arjun@gmail.com'),
(108, 'Pooja', 'Pune', 'Maharashtra', 30, 'F', 'Silver', 'pooja@gmail.com'),
(109, 'Karan', 'Bangalore', 'Karnataka', 24, 'M', 'Gold', NULL),
(110, 'Anita', 'Mumbai', 'Maharashtra', 38, 'F', 'Platinum', 'anita@gmail.com'),
(111, 'Rohit', 'Delhi', 'Delhi', 28, 'M', 'Gold', 'rohit@gmail.com'),
(112, 'Meera', 'Pune', 'Maharashtra', 31, 'F', NULL, 'meera@gmail.com');

-- COMMAND ----------

-- DBTITLE 1,products
DROP TABLE IF EXISTS workspace.default.products;

CREATE TABLE workspace.default.products (
    product_id INT,
    product_name STRING,
    category STRING,
    price DECIMAL(10,2)
)
USING DELTA;

-- COMMAND ----------

INSERT INTO workspace.default.products VALUES
(201, 'Laptop', 'Electronics', 65000),
(202, 'Mobile', 'Electronics', 30000),
(203, 'Headphones', 'Electronics', 5000),
(204, 'Keyboard', 'Accessories', 2500),
(205, 'Mouse', 'Accessories', 1500),
(206, 'Monitor', 'Electronics', 18000),
(207, 'Office Chair', 'Furniture', 12000);

-- COMMAND ----------

-- DBTITLE 1,orders
DROP TABLE IF EXISTS workspace.default.orders;

CREATE TABLE workspace.default.orders (
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    amount DECIMAL(10,2)
)
USING DELTA;

-- COMMAND ----------

INSERT INTO workspace.default.orders VALUES
(1001, 101, 201, '2026-01-10', 1, 65000),
(1002, 101, 203, '2026-01-15', 2, 10000),
(1003, 102, 202, '2026-01-20', 1, 30000),
(1004, 103, 204, '2026-02-02', 2, 5000),
(1005, 104, 206, '2026-02-05', 1, 18000),
(1006, 106, 205, '2026-02-10', 3, 4500),
(1007, 107, 201, '2026-02-15', 1, 65000),
(1008, 107, 202, '2026-02-20', 1, 30000),
(1009, 108, 203, '2026-03-01', 1, 5000),
(1010, 110, 206, '2026-03-05', 2, 36000),
(1011, 111, 205, '2026-03-10', 2, 3000);

-- COMMAND ----------

select * from customers

-- COMMAND ----------

select * from products

-- COMMAND ----------

select * from orders

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## COUNT

-- COMMAND ----------

SELECT COUNT(*) AS total_cx
FROM workspace.default.customers

-- COMMAND ----------

SELECT COUNT(email) AS total_cx
FROM workspace.default.customers

-- COMMAND ----------

SELECT COUNT(membership) AS total_cx
FROM workspace.default.customers

-- COMMAND ----------

SELECT DISTINCT membership
FROM workspace.default.customers

-- COMMAND ----------

SELECT COUNT(DISTINCT membership) AS DIST_MEMEBERSHIP
FROM workspace.default.customers

-- COMMAND ----------

SELECT count(*) as counts
FROM workspace.default.customers
where membership is null

-- COMMAND ----------

SELECT count(DISTINCT membership) as counts
FROM workspace.default.customers
where membership is null

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## SUM

-- COMMAND ----------

SELECT SUM(amount) FROM workspace.default.orders

-- COMMAND ----------

SELECT SUM(quantity) FROM workspace.default.orders

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## AVG

-- COMMAND ----------

SELECT * FROM workspace.default.orders

-- COMMAND ----------

SELECT AVG(amount) FROM workspace.default.orders

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## MIN/MAX

-- COMMAND ----------

SELECT MIN(amount) FROM workspace.default.orders

-- COMMAND ----------

SELECT MAX(amount) FROM workspace.default.orders

-- COMMAND ----------

SELECT MIN(amount),MAX(amount) FROM workspace.default.orders

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Multiple agg

-- COMMAND ----------

SELECT 
MIN(amount) AS MIN_ORDER
,MAX(amount) AS MAX_ORDER,
COUNT(*) AS total_orders,
sum(amount) as total_rev,
round(AVG(amount),2) as avg_amount
FROM workspace.default.orders
-- 818182 - 2 digits - 82

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## GROUP BY 

-- COMMAND ----------

3 COLOR - RED, BLUE, GREEN 
4 BUCKETS  -3 BUCKETS EACH BUCKET SAME COLOR 
12 BALLS 
-> 4 balls red
-> 6 balls blue
-> 2 balls green
1 red -4 balls
2 blue -6 balls
3 green - 2 balls


-- COMMAND ----------

SELECT * FROM workspace.default.orders

-- COMMAND ----------

SELECT customer_id,SUM(amount) AS total_spend
FROM  workspace.default.orders
GROUP BY customer_id

-- COMMAND ----------

SELECT SUM(amount) AS total_spend, customer_id
FROM  workspace.default.orders
GROUP BY customer_id

-- COMMAND ----------

SELECT count(*), customer_id
FROM  workspace.default.orders
GROUP BY customer_id

-- COMMAND ----------

SELECT avg(amount) as avg_amt, customer_id
FROM  workspace.default.orders
GROUP BY customer_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## GROUP BY CITY

-- COMMAND ----------

SELECT * FROM default.customers

-- COMMAND ----------

SELECT  city, count(*) as cxcnt FROM default.customers
GROUP BY city

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## HAVING

-- COMMAND ----------

SELECT * FROM default.orders 
WHERE 
amount >10000

-- COMMAND ----------

SELECT * FROM default.orders 
-- WHERE 
-- amount >10000

-- COMMAND ----------

-- MAGIC %md
-- MAGIC find the customers who have spend in total greater than 50,000

-- COMMAND ----------

select customer_id, sum(amount) as totalspend from default.orders
group by customer_id
HAVING SUM(amount) >50000

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Find customers whose orders are above 5000 and whose total spend >20000

-- COMMAND ----------

select 
*
from default.orders where amount >5000

-- COMMAND ----------

select 
customer_id, SUM(AMOUNT) AS TOTALSPENT
from default.orders where amount >5000
group BY customer_id
HAVING SUM(amount) >20000