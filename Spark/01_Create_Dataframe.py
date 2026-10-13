# Databricks notebook source
from pyspark.sql import SparkSession

# COMMAND ----------

spark = SparkSession.builder.appName("Spark_DataFrames").getOrCreate()

# COMMAND ----------

# MAGIC %md
# MAGIC # Create Dataframe 
# MAGIC

# COMMAND ----------

data = [('Alice', 25), ("Bob", 30)]
df_data = spark.createDataFrame(data)

# COMMAND ----------

df_data.show()

# COMMAND ----------

df_data.display()

# COMMAND ----------

data = [('Alice', 25), ("Bob", 30)]
col = ['Name', "Age"]
df = spark.createDataFrame(data, schema = col)
df.show()

# COMMAND ----------

from pyspark.sql.types import StructType, StructField, StringType, IntegerType


# COMMAND ----------

schema = StructType([StructField('Name', StringType()), StructField('Age', IntegerType())])
df = spark.createDataFrame(data, schema = schema)
df.show()

# COMMAND ----------

# MAGIC %md
# MAGIC ## Pandas DF

# COMMAND ----------

import pandas as pd 

# COMMAND ----------

pandas_df = pd.DataFrame(
    {
        "name": ["ALICE", "BOB","CHARLIE"],
        'AGE': [24,20,19]
    }
)
df_p = spark.createDataFrame(pandas_df)
df_p.show()


# COMMAND ----------

# MAGIC %md
# MAGIC ## Reading from CSV

# COMMAND ----------

df = spark.read.csv("/Volumes/sales/default/spotify/cxdata1.csv", header = True, inferSchema = True)
df.show()

# COMMAND ----------

df1 = spark.read.format("csv").option("header", "true").option("inferSchema", "true").option("delimiter",",").load("/Volumes/sales/default/spotify/cxdata1.csv")
df1.show()
