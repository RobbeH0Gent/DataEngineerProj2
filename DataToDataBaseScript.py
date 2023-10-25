from dotenv import load_dotenv   #for python-dotenv method
import os
import pandas as pd
from sqlalchemy import create_engine, Table, MetaData
from sqlalchemy.orm import declarative_base

load_dotenv()

csv_dir = 'Data/' #path waar de data csv files staan
SERVER = os.environ.get('SERVER')
DATABASE = os.environ.get('DATABASE')
UID = os.environ.get('USER')
PWD = os.environ.get('PASSWORD')

# NOT EVERY CSV IS IN THIS DICT

table_file = {
    # 'Account' : 'Account.csv', # DONE
    # 'Activiteitscode' : 'Activiteitscode.csv', # DONE
    # 'Account_ActiviteitsCode' : 'Account_activiteitscode.csv',  # DONE  
    # 'Account_Financiele_Data' : 'Account_financiele_data.csv',     # DUPLICATES  
    # 'Activiteit_Vereist_Contact' : 'Activiteit_vereist_contact.csv', # DUPLICATES
    # 'Afpsraak_Alle' : 'Afspraak_alle.csv', # DONE
    # 'Afspraak_Account_Gelinkt' : 'Afspraak_account_gelinkt_cleaned.csv', # FK PROBLEM
    # 'Afspraak_Betreft_Account' : 'Afspraak betreft account_cleaned.csv', # FK PROBLEM
    # 'Afspraak_Betreft_Contactfiche': 'Afspraak betreft contact_cleaned.csv', # FK PROBLEM
    # 'Afspraak_Vereist_Contact' : 'Activiteit_vereist_contact.csv',   # FK PROBLEM  
    # 'Campagne' : 'Campagne.csv', # DONE
    # 'CDI_Mailing' : 'CDI_mailing.csv', # DONE
    # 'CDI_PageView' : 'cdi_pageviews.csv', # PROBLEM WITH ';' 
    # 'CDI_Sent_Email_Clicks' : 'CDI_sent_email_clicks.csv',  # DUPLICATES
    # 'CDI_Visits' : 'CDI_visits.csv', # FK PROBLEM
    # 'CDI_Web_Content' : 'CDI_web_content.csv',  # DONE
    # 'Contactfiche' : 'Contact.csv', # DUPLICATES
    # 'ContactFunctie' : 'Contact_functie.csv',  # FK PROBLEM
    # 'Gebruiker' : 'Gebruikers.csv', # DONE
    # 'Info_en_Klachten' : 'Info_en_klachten.csv', # FK PROBLEM
    # 'Lidmaatschap' : 'Lidmaatschap.csv', # FK PROBLEM
    # 'Persoon' : 'Persoon.csv', # ALOT OF COLUMNS NOT IN OLTP - TEAM
    # 'Sessie' : 'Sessie.csv' # FK PROBLEM
}


try:
    connection_string = f'mssql+pyodbc://{UID}:{PWD}@{SERVER}/{DATABASE}?driver=ODBC+Driver+17+for+SQL+Server'
    engine = create_engine(connection_string)

    metadata = MetaData()
    metadata.reflect(engine)    

    
    for table_name, file_name in table_file.items():
        table_columns = metadata.tables[table_name].columns.keys()
        file_path = os.path.join(csv_dir, file_name)

        df = pd.read_csv(file_path, on_bad_lines='skip')
        df = df.rename(columns={csv_col: sql_col for csv_col, sql_col in zip(df.columns, table_columns)})
        df.to_sql(table_name, con=engine, schema='dbo', if_exists='append', index=False)

    print("Done")

except Exception as e:
    print(f"Error: {str(e)}")
