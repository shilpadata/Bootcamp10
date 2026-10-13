# Databricks notebook source
from pyspark.sql.functions import col

# COMMAND ----------

from pyspark.sql.functions import *

# COMMAND ----------

from datetime import date

data = [
    (1001, 501, date(2026, 1, 5), "Rahul", "Delhi", "Electronics", "Laptop", 1, 1200.00, "Credit Card", "Completed"),
    (1002, 502, date(2026, 1, 6), "Anita", "Mumbai", "Fashion", "Jacket", 2, 80.00, "UPI", "Completed"),
    (1003, 503, date(2026, 1, 7), "Amit", "Bangalore", "Electronics", "Headphones", 1, 150.00, "Credit Card", "Completed"),
    (1004, 501, date(2026, 1, 10), "Rahul", "Delhi", "Home", "Chair", 4, 75.00, "Debit Card", "Completed"),
    (1005, 504, date(2026, 1, 12), "Neha", "Pune", "Fashion", "Shoes", 1, 120.00, "UPI", "Returned"),
    (1006, 505, date(2026, 1, 15), "Ravi", "Chennai", "Electronics", "Mobile", 2, 600.00, "Credit Card", "Completed"),
    (1007, 506, date(2026, 1, 18), "Priya", "Hyderabad", "Home", "Table", 1, 250.00, "UPI", "Completed"),
    (1008, 507, date(2026, 1, 20), "Karan", "Delhi", "Fashion", "T-Shirt", 5, 25.00, "Cash", "Completed"),
    (1009, 503, date(2026, 1, 22), "Amit", "Bangalore", "Electronics", "Keyboard", 2, 75.00, "Credit Card", "Cancelled"),
    (1010, 508, date(2026, 1, 25), "Sneha", "Mumbai", "Home", "Sofa", 1, 900.00, "Debit Card", "Completed"),
    (1011, 509, date(2026, 2, 2), "Vikram", "Pune", "Electronics", "Monitor", 2, 300.00, "Credit Card", "Completed"),
    (1012, 510, date(2026, 2, 5), "Pooja", "Delhi", "Fashion", "Handbag", 1, 150.00, "UPI", "Completed"),
    (1013, 501, date(2026, 2, 8), "Rahul", "Delhi", "Electronics", "Mouse", 3, 30.00, "UPI", "Completed"),
    (1014, 504, date(2026, 2, 10), "Neha", "Pune", "Fashion", "Dress", 2, 100.00, "Credit Card", "Completed"),
    (1015, 505, date(2026, 2, 12), "Ravi", "Chennai", "Home", "Lamp", 3, 45.00, "Cash", "Completed"),
    (1016, 506, date(2026, 2, 15), "Priya", "Hyderabad", "Electronics", "Tablet", 1, 450.00, "UPI", "Completed"),
    (1017, 507, date(2026, 2, 18), "Karan", "Delhi", "Fashion", "Jeans", 2, 60.00, "Credit Card", "Returned"),
    (1018, 508, date(2026, 2, 20), "Sneha", "Mumbai", "Home", "Bed", 1, 700.00, "Debit Card", "Completed"),
    (1019, 509, date(2026, 2, 22), "Vikram", "Pune", "Electronics", "Camera", 1, 800.00, "Credit Card", "Completed"),
    (1020, 510, date(2026, 2, 25), "Pooja", "Delhi", "Fashion", "Watch", 1, 200.00, "UPI", "Completed")
]


# COMMAND ----------

columns = [
    "order_id",
    "customer_id",
    "order_date",
    "customer_name",
    "city",
    "category",
    "product",
    "quantity",
    "unit_price",
    "payment_method",
    "order_status"
]

df = spark.createDataFrame(data, columns)

df.show()

# COMMAND ----------

df.show(5, truncate = False)

# COMMAND ----------

df.printSchema()

# COMMAND ----------

df.count()

# COMMAND ----------

df1 = df.select("customer_id", "customer_name", "product", "quantity", "unit_price")
df1.show(5)

# COMMAND ----------

df.select("*").show()

# COMMAND ----------

df.select(col("customer_name"),col("product"),col("quantity"),col("unit_price"), 
          (col("quantity") * col("unit_price")).alias("totalprice")
          ).show()


# COMMAND ----------

from pyspark.sql.functions import expr

# COMMAND ----------

df.select(
    expr("customer_name"), expr("product")).show()
    
    # col("customer_name"),col("product"),col("quantity"),col("unit_price"), 
    #       (col("quantity") * col("unit_price")).alias("totalprice")
    #       ).show()

# COMMAND ----------

df.createOrReplaceTempView("sales")

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT * FROM SALES 

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT QUANTITY, UNIT_PRICE, PRODUCT, QUANTITY * UNIT_PRICE AS REVENUE  FROM SALES

# COMMAND ----------

res = spark.sql("SELECT QUANTITY, UNIT_PRICE, PRODUCT, QUANTITY * UNIT_PRICE AS REVENUE  FROM SALES")
res.show()

# COMMAND ----------

dftable = spark.read.table("sales.gold.orders")
dftable.show(5)
