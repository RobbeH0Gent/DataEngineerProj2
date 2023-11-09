import pandas as pd
import pyodbc
from dotenv import load_dotenv
import os

load_dotenv()

SERVER = os.getenv('SERVER')
DATABASE = os.getenv('DATABASE')
USER = os.getenv('USER')
PWD = os.getenv('PASSWORD')

connection_string = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={SERVER};DATABASE={DATABASE};UID={USER};PWD={PWD}'
connection = pyodbc.connect(connection_string)
cursor = connection.cursor()

sql_statements = [
    'USE DW;',
    # 'TRUNCATE TABLE dim_date;',
    # 'EXEC fill_dim_date;',
    'TRUNCATE TABLE dim_customer;',
    'EXEC fill_dim_customer;',
    'TRUNCATE TABLE dim_contact;',
    'EXEC fill_dim_contact;',
    'TRUNCATE TABLE dim_email;',
    'EXEC fill_dim_email;',
    'EXEC fill_fact_account;',
    'EXEC fill_fact_customer;'
]

#exec
for statement in sql_statements:
    cursor.execute(statement)

connection.commit()
connection.close()
