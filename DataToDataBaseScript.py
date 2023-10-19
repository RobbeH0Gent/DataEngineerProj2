import os
import pandas as pd
import pyodbc

csv_dir = './Data' #path waar de data csv files staan

try:

    # Reconnect to the newly created database
    connectionString = f"DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={os.environ.get('SERVER')};DATABASE={os.environ.get('DATABASE')};UID={os.environ.get('USER')};PWD={os.environ.get('PASSWORD')}TrustServerCertificate=yes"
    conn = pyodbc.connect(connectionString)
    
    cursor = conn.cursor()
    table_names = cursor.tables
    

    for csv_file in csv_dir:
        file_path = os.path.join(csv_dir, csv_file)
        df = pd.read_csv(file_path)

    for table in table_names:
        df.to_sql(table, conn, if_exists='append', index=False)
            

    conn.commit()
    cursor.close()
    conn.close()
    print("Done")

except Exception as e:
    print(f"Error: {str(e)}")
