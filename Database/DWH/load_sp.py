import pandas as pd
import pyodbc
from dotenv import load_dotenv
import os

load_dotenv()

server = os.getenv('SQL_SERVER')
database = os.getenv('SQL_DATABASE')
username = os.getenv('SQL_USERNAME')
password = os.getenv('SQL_PASSWORD')

connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password};'
connection = pyodbc.connect(connection_string)
cursor = connection.cursor()

sql_statements = [
    'USE DW;',
    'TRUNCATE TABLE dim_date;',
    'EXEC fill_dim_date;',
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
