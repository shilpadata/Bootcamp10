-- Databricks notebook source
CREATE DATABASE retail

-- COMMAND ----------

use retail

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS RETAIL

-- COMMAND ----------

show databases

-- COMMAND ----------

CREATE TABLE CUSTOMERS (
   ID       INT NOT NULL,
   NAME     VARCHAR(20) NOT NULL,
   AGE      INT NOT NULL,
   ADDRESS  CHAR(25),
   SALARY   DECIMAL(18, 2)
);

-- COMMAND ----------

SHOW TABLES;

-- COMMAND ----------

INSERT INTO CUSTOMERS VALUES 
(1, 'Ramesh', 32, 'Ahmedabad', 2000.00 ),
(2, 'Khilan', 25, 'Delhi', 1500.00 ),
(3, 'Kaushik', 23, 'Kota', 2000.00 ),
(4, 'Chaitali', 25, 'Mumbai', 6500.00 ),
(5, 'Hardik', 27, 'Bhopal', 8500.00 ),
(6, 'Komal', 22, 'Hyderabad', 4500.00 ),
(7, 'Muffy', 24, 'Indore', 10000.00 );

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ADD COL

-- COMMAND ----------

ALTER TABLE CUSTOMERS 
ADD COLUMN EMAIL VARCHAR(100); 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC DISPLAY DATA

-- COMMAND ----------

SELECT * FROM CUSTOMERS;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Modify Column Data Type

-- COMMAND ----------

-- MAGIC %md
-- MAGIC DROP table

-- COMMAND ----------

DROP TABLE customers 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Create New table

-- COMMAND ----------

DROP TABLE IF EXISTS workspace.default.customers;

CREATE TABLE workspace.default.customers (
    customer_id INT,
    customer_name STRING,
    city STRING,
    state STRING,
    age INT,
    gender STRING,
    purchase_amount DECIMAL(10,2),
    membership STRING,
    email STRING
)
USING DELTA;

-- COMMAND ----------

INSERT INTO workspace.default.customers VALUES
(101, 'Amit', 'Delhi', 'Delhi', 28, 'M', 4500.00, 'Gold', 'amit@gmail.com'),
(102, 'Priya', 'Mumbai', 'Maharashtra', 32, 'F', 7200.00, 'Silver', 'priya@gmail.com'),
(103, 'Rahul', 'Delhi', 'Delhi', 25, 'M', 3200.00, 'Gold', 'rahul@gmail.com'),
(104, 'Sneha', 'Bangalore', 'Karnataka', 29, 'F', 8500.00, 'Platinum', 'sneha@gmail.com'),
(105, 'Vikas', 'Mumbai', 'Maharashtra', 35, 'M', 2100.00, 'Silver', NULL),
(106, 'Neha', 'Pune', 'Maharashtra', 27, 'F', 5600.00, 'Gold', 'neha@gmail.com'),
(107, 'Arjun', 'Delhi', 'Delhi', 41, 'M', 9100.00, 'Platinum', 'arjun@gmail.com'),
(108, 'Pooja', 'Pune', 'Maharashtra', 30, 'F', 4300.00, 'Silver', 'pooja@gmail.com'),
(109, 'Karan', 'Bangalore', 'Karnataka', 24, 'M', 1800.00, 'Gold', NULL),
(110, 'Anita', 'Mumbai', 'Maharashtra', 38, 'F', 6700.00, 'Platinum', 'anita@gmail.com'),
(111, 'Rohit', 'Delhi', 'Delhi', 28, 'M', 4500.00, 'Gold', 'rohit@gmail.com'),
(112, 'Meera', 'Pune', 'Maharashtra', 31, 'F', 3900.00, NULL, 'meera@gmail.com');

-- COMMAND ----------

SELECT *
FROM workspace.default.customers;

-- COMMAND ----------

SELECT customer_id, customer_name, city
FROM workspace.default.customers;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Rename columns using alias

-- COMMAND ----------

SELECT
    customer_name AS name,
    purchase_amount AS total_purchase
FROM workspace.default.customers;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC WHERE

-- COMMAND ----------

SELECT *
FROM workspace.default.customers
WHERE city = 'Delhi';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Comparison Operators

-- COMMAND ----------

SELECT *
FROM workspace.default.customers
WHERE age = 28;

-- COMMAND ----------

SELECT customer_name, age
FROM workspace.default.customers
WHERE age > 30;

-- COMMAND ----------

SELECT customer_name, purchase_amount
FROM workspace.default.customers
WHERE purchase_amount > 5000;

-- COMMAND ----------

SELECT *
FROM workspace.default.customers
WHERE membership <> 'Silver';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC AND / OR / NOT

-- COMMAND ----------

SELECT *
FROM workspace.default.customers
WHERE city = 'Delhi'
AND age > 30;

-- COMMAND ----------

SELECT *
FROM workspace.default.customers
WHERE city = 'Delhi'
OR city = 'Mumbai';

-- COMMAND ----------

SELECT *
FROM workspace.default.customers
WHERE NOT city = 'Delhi';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC DISTINCT

-- COMMAND ----------

SELECT DISTINCT city
FROM workspace.default.customers;

-- COMMAND ----------

-- Find unique memberships
SELECT DISTINCT membership
FROM workspace.default.customers;

-- COMMAND ----------

-- Multiple columns
SELECT DISTINCT city, membership
FROM workspace.default.customers;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC IN

-- COMMAND ----------

SELECT *
FROM workspace.default.customers
WHERE city = 'Delhi'
OR city = 'Mumbai'
OR city = 'Pune';

-- COMMAND ----------

SELECT *
FROM workspace.default.customers
WHERE city IN ('Delhi', 'Mumbai', 'Pune');

-- COMMAND ----------

SELECT *
FROM workspace.default.customers
WHERE city NOT IN ('Delhi', 'Mumbai');

-- COMMAND ----------

-- MAGIC %md
-- MAGIC BETWEEN

-- COMMAND ----------

SELECT *
FROM workspace.default.customers
WHERE age BETWEEN 25 AND 30;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC LIKE

-- COMMAND ----------

SELECT *
FROM workspace.default.customers
WHERE customer_name LIKE 'A%';

-- COMMAND ----------

SELECT *
FROM workspace.default.customers
WHERE customer_name LIKE '%an%';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC NULL Handling

-- COMMAND ----------

SELECT *
FROM workspace.default.customers
WHERE email IS NULL;

-- COMMAND ----------

SELECT *
FROM workspace.default.customers
WHERE email IS NOT NULL;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC COALESCE — Useful NULL Handling

-- COMMAND ----------

SELECT
    customer_name,
    COALESCE(email, 'Email Not Available') AS email
FROM workspace.default.customers;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ORDER BY

-- COMMAND ----------

SELECT customer_name, age
FROM workspace.default.customers
ORDER BY age ASC;

-- COMMAND ----------

SELECT customer_name, age
FROM workspace.default.customers
ORDER BY age DESC;

-- COMMAND ----------

SELECT
    customer_name,
    city,
    purchase_amount
FROM workspace.default.customers
ORDER BY city ASC, purchase_amount DESC;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC SQL Query Execution Order

-- COMMAND ----------

-- SELECT
-- FROM
-- WHERE
-- ORDER BY

-- COMMAND ----------

SELECT
    customer_id,
    customer_name,
    city,
    membership,
    purchase_amount
FROM workspace.default.customers
WHERE city IN ('Delhi', 'Mumbai', 'Pune')
  AND membership IN ('Gold', 'Platinum')
  AND purchase_amount BETWEEN 4000 AND 10000
ORDER BY purchase_amount DESC;

-- COMMAND ----------

DROP TABLE IF EXISTS workspace.default.customers;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC PRACTICE

-- COMMAND ----------

-- MAGIC %md
-- MAGIC - Q7. Find customers from Delhi, Mumbai or Pune.
-- MAGIC
-- MAGIC - Q8. Find customers between age 25 and 30.
-- MAGIC
-- MAGIC - Q9. Find customers whose purchase amount is greater than 5,000.
-- MAGIC
-- MAGIC - Q10. Find customers whose names start with A.
-- MAGIC
-- MAGIC - Q11. Find customers whose names end with a.
-- MAGIC
-- MAGIC - Q12. Find customers whose email is NULL.
-- MAGIC
-- MAGIC - Q13. Find customers whose email is NOT NULL.

-- COMMAND ----------

