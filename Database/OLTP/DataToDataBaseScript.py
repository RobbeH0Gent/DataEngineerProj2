from dotenv import load_dotenv   #for python-dotenv method
import os
import pandas as pd
from sqlalchemy import create_engine, MetaData

load_dotenv()

csv_dir = "../../Data" #path waar de data csv files staan
SERVER = os.environ.get('SERVER')
DATABASE = os.environ.get('DATABASE')
UID = os.environ.get('USER')
PWD = os.environ.get('PASSWORD')



table_file = {
    'Account' : 'Account.csv',
    'Persoon' : 'Persoon.csv',
    'Contactfiche' : 'Contact.csv',
    'Activiteitscode' : 'Activiteitscode.csv',
    'Account_ActiviteitsCode' : 'Account_activiteitscode.csv',   
    'Account_Financiele_Data' : 'Account_financiële_data.csv',    
    'Afspraak_Alle' : 'Afspraak_alle.csv',
    'Activiteit_Vereist_Contact' : 'Activiteit_vereist_contact.csv',
    'Afspraak_Account_Gelinkt' : 'Afspraak_account_gelinkt_cleaned.csv',
    'Afspraak_Betreft_Contactfiche': 'Afspraak betreft contact_cleaned.csv',
    'Afspraak_Betreft_Account' : 'Afspraak betreft account_cleaned.csv',
    'Campagne' : 'Campagne.csv',
    'CDI_Mailing' : 'CDI_mailing.csv',
    'CDI_PageView' : 'cdi_pageviews.csv',
    'CDI_Web_Content' : 'CDI_web_content.csv', 
    'CDI_Visits' : 'CDI visits.csv',
    'CDI_Sent_Email_Clicks' : 'CDI_sent_email_clicks.csv', 
    'Functie' : 'Functie.csv',
    'ContactFunctie' : 'Contact_functie.csv', 
    'Gebruiker' : 'Gebruikers.csv',
    'Info_en_Klachten' : 'Info_en_klachten.csv',
    'Inschrijving' : 'Inschrijving.csv',
    'Lidmaatschap' : 'Lidmaatschap.csv',
    'Sessie' : 'Sessie.csv',
    'SessieInschrijving': 'Sessie_inschrijving.csv'
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
        

        if df.isnull().values.any():
            df.dropna(how='all')

        df.to_sql(table_name, con=engine, schema='dbo', if_exists='append', index=False)
        print(f"{table_name} done")
    print("Done")

except Exception as e:
    print(f"Error: {str(e)}")
