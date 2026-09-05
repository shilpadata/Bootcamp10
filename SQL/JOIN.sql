-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## INNER JOIN

-- COMMAND ----------

select * 
from customers c

-- COMMAND ----------

select * 
from orders o

-- COMMAND ----------

-- MAGIC %md
-- MAGIC - 101 - 101
-- MAGIC - 102 - 102
-- MAGIC - 103 -103
-- MAGIC - 104 - 104
-- MAGIC - 107 -107
-- MAGIC - 108 -108

-- COMMAND ----------

select 
c.customer_id, c.customer_name, o.order_id, o.amount,o.order_date
from 
default.customers c
INNER JOIN default.orders o 
ON c.customer_id = o.customer_id 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## LEFT JOIN

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 101- 101
-- MAGIC 101- 101
-- MAGIC 102- 102
-- MAGIC 103- 103
-- MAGIC 107- 107
-- MAGIC 107- 107

-- COMMAND ----------

select 
c.customer_id, c.customer_name, o.order_id, o.amount,o.order_date
from 
default.customers c
LEFT JOIN default.orders o 
ON c.customer_id = o.customer_id 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## FULL OUTER

-- COMMAND ----------

select 
c.customer_id, c.customer_name, o.order_id, o.amount,o.order_date
from 
default.customers c
FULL OUTER JOIN default.orders o 
ON c.customer_id = o.customer_id 

-- COMMAND ----------

select * from products

-- COMMAND ----------

select 
c.customer_id,p.product_name,p.product_id, c.customer_name, o.order_id, o.amount,o.order_date
from 
default.customers c
 INNER JOIN default.orders o 
ON c.customer_id = o.customer_id 
INNER JOIN products p
ON o.product_id = p.product_id