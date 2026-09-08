-- Databricks notebook source
show tables in workspace.default

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## SUBQUERY

-- COMMAND ----------

--main query
 --  query (subquery)
    --produce result


-- COMMAND ----------

select * from customers

-- COMMAND ----------

select AVG(AGE) FROM CUSTOMERS

-- COMMAND ----------

SELECT * FROM CUSTOMERS
WHERE AGE > 
(
    SELECT AVG(AGE) FROM CUSTOMERS
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## SUBQUERY USING MAX

-- COMMAND ----------

SELECT * FROM CUSTOMERS
WHERE AGE < 
(
    SELECT MAX(AGE) FROM CUSTOMERS
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## SUBQUERY IN

-- COMMAND ----------

SELECT CUSTOMER_ID FROM CUSTOMERS

-- COMMAND ----------

SELECT CUSTOMER_ID FROM ORDERS

-- COMMAND ----------

SELECT * FROM customers
WHERE customer_id IN (
SELECT CUSTOMER_ID FROM ORDERS)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## SUBQUERY WITH GROUP BY 

-- COMMAND ----------

SELECT customer_id, SUM(amount) AS TOTAL_SPENT 
FROM ORDERS GROUP BY CUSTOMER_ID

-- COMMAND ----------

SELECT * FROM (
SELECT customer_id, SUM(amount) AS TOTAL_SPENT 
FROM ORDERS GROUP BY CUSTOMER_ID
) CUSTOMER_SPENDING
WHERE TOTAL_SPENT > 50000


-- COMMAND ----------

-- MAGIC %md
-- MAGIC - READIBLITY
-- MAGIC - DEBUG
-- MAGIC - MAINTENANCE 
-- MAGIC - EXTEND

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## CTE

-- COMMAND ----------

SELECT * FROM (
SELECT customer_id, SUM(amount) AS TOTAL_SPENT 
FROM ORDERS GROUP BY CUSTOMER_ID
) CUSTOMER_SPENDING
WHERE TOTAL_SPENT > 50000

-- COMMAND ----------

WITH CUSTOMER_SPENDING AS(
    SELECT customer_id, SUM(amount) AS TOTAL_SPENT 
FROM ORDERS GROUP BY CUSTOMER_ID
)
SELECT * FROM CUSTOMER_SPENDING
WHERE TOTAL_SPENT > 50000

-- COMMAND ----------

WITH CUSTOMER_SPENDING AS( --CTE1
    SELECT customer_id, SUM(amount) AS TOTAL_SPENT , COUNT(*) AS TOTAL_ORDERS
FROM ORDERS GROUP BY CUSTOMER_ID
),
HIGH_VALUE_CUSTOMERS( --CTE2
    SELECT customer_id, total_spent, TOTAL_ORDERS FROM CUSTOMER_SPENDING
    WHERE TOTAL_SPENT > 20000
)
SELECT * FROM HIGH_VALUE_CUSTOMERS WHERE total_orders >= 2

-- COMMAND ----------

WITH CUSTOMER_SPENDING AS( --CTE1
    SELECT customer_id, SUM(amount) AS TOTAL_SPENT , COUNT(*) AS TOTAL_ORDERS
FROM ORDERS GROUP BY CUSTOMER_ID
)
SELECT C.customer_id, C.CUSTOMER_NAME, CS.TOTAL_SPENT, CS.TOTAL_ORDERS
FROM customers C
INNER JOIN CUSTOMER_SPENDING CS
ON C.customer_id = CS.customer_id
WHERE total_orders >=2 
-- global_customers_dataset


-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## CASE WHEN

-- COMMAND ----------

-- MAGIC %md
-- MAGIC - IF CONDITION (CAR)
-- MAGIC -     THEN RESULT
-- MAGIC - ELSE (PUBLIC TRANSPORT)
-- MAGIC -     RESULT

-- COMMAND ----------

SELECT customer_name, AGE,
CASE 
    WHEN AGE <25 THEN 'YOUNG'
    WHEN AGE BETWEEN 25 AND 35 THEN 'ADULT'
    ELSE 'SENIOR'
END AS AGE_GROUP
 FROM customers

-- COMMAND ----------

select order_id, amount,
case
    WHEN AMOUNT >=50000 THEN 'HIGHVALUE'
    WHEN AMOUNT >=10000 THEN 'MEDIUMVALUE'
    ELSE 'LOWVALUE'
END AS ORDER_CATEGORY 
from orders

-- COMMAND ----------

select order_id, amount,
IF (AMOUNT >=50000, 'HIGHVALUE', IF(AMOUNT >=10000, 'MEDIUMVALUE', 'LOWVALUE')) AS ORDER_CATEGORY 
from orders
-- select order_id, amount,
-- case
--     WHEN AMOUNT >=50000 THEN 'HIGHVALUE'
--     WHEN AMOUNT >=10000 THEN 'MEDIUMVALUE'
--     ELSE 'LOWVALUE'
-- END AS ORDER_CATEGORY 
-- from orders

-- COMMAND ----------

SELECT
CASE WHEN AGE <25 THEN 'YOUNG'
WHEN AGE BETWEEN 25 AND 35 THEN 'ADULT'
ELSE 'SENIOR'
END AS AGE_CATEGORY,
COUNT(*) AS CX_COUNT

FROM CUSTOMERS
GROUP BY ALL

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## EXISTS

-- COMMAND ----------

-- DOES AN ORDER EXISTS FOR A PARTICULAR CUSTOMER
select *
from 
customers c
where 
EXISTS(
    select  1 from orders o
    where o.customer_id = c.customer_id 
)
and c.city = 'Delhi'

-- COMMAND ----------

select *
from orders