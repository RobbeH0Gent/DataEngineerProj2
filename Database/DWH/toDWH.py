import pandas as pd
import pyodbc

# Aanpassen naar het juiste
dep2_connection_string = 'DRIVER={SQL Server};SERVER=DEP2_SERVER;DATABASE=?;UID=?;PWD=?'
dw_connection_string = 'DRIVER={SQL Server};SERVER=DW_SERVER;DATABASE=?;UID=?;PWD=?'

dep2_connection = pyodbc.connect(dep2_connection_string)
dw_connection = pyodbc.connect(dw_connection_string)

# Gegevens over te zetten van DEP2 naar DW
def transfer_data(source_table, destination_table):
    dep2_query = f'SELECT * FROM DEP2.dbo.{source_table}'
    dw_query = f'INSERT INTO DW.dbo.{destination_table} SELECT * FROM DEP2.dbo.{source_table}'

    # Ophalen van DEP2
    df = pd.read_sql(dep2_query, dep2_connection)

    # Overzetten naar DW
    df.to_sql(destination_table, dw_connection, index=False, if_exists='replace')


transfer_data('Account', 'DimAccount')
transfer_data('Activiteitscode', 'DimActiviteitscode')
transfer_data('Campagne', 'DimCampagne')
transfer_data('CDI_Mailing', 'DimCDI_Mailing')
transfer_data('FactTable', 'FactTable')

dw_connection.close()
dep2_connection.close()
