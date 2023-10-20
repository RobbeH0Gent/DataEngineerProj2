from dotenv import load_dotenv   #for python-dotenv method
import os
import pandas as pd
from sqlalchemy import create_engine

load_dotenv()

csv_dir = 'Data/' #path waar de data csv files staan
SERVER = os.environ.get('SERVER')
DATABASE = os.environ.get('DATABASE')
UID = os.environ.get('USER')
PWD = os.environ.get('PASSWORD')

table_file = {
    'Account' : 'Account.csv',
    'Account_Activiteitscode' : 'Account activiteitscode.csv',    
    'Account_Financiele_Data' : 'Account financiële data.csv',       
    'Activiteitscode' : 'Activiteitscode.csv',
    'Activiteit_Vereist_Contact' : 'Activiteit vereist contact.csv',     
    'Afpsraak_Alle' : 'Afspraak alle.csv',
    'Afspraak_Account_Gelinkt' : 'Afspraak_account_gelinkt_cleaned.csv',
    'Afspraak_Betreft_Account' : 'Afspraak betreft account_cleaned.csv', 
    'Afspraak_Betreft_Contactfiche': 'Afspraak betreft contact_cleaned.csv',
    'Afspraak_Vereist_Contact' : 'Activiteit vereist contact.csv',     
    'Campagne' : 'Campagne.csv',
    'CDI_Mailing' : 'CDI mailing.csv',
    'CDI_Page_View' : 'cdi pageviews.csv',
    'CDI_Sent_Email_Clicks' : 'CDI sent email clicks.csv', 
    'CDI_Visits' : 'CDI visits.csv',
    'CDI_Web_Content' : 'CDI web content.csv',
    'Contactfiche' : 'Contact.csv',
    'ContactFunctie' : 'Contact functie.csv', 
    'Gebruiker' : 'Gebruikers.csv',
    'Info_en_Klachten' : 'Info en klachten.csv',
    'Lidmaatschap' : 'Lidmaatschap.csv',
    'Persoon' : 'Persoon.csv',
    'Sessie' : 'Sessie.csv'
}

try:
    connection_string = f'mssql+pyodbc://{UID}:{PWD}@{SERVER}/{DATABASE}?driver=ODBC+Driver+17+for+SQL+Server'
    engine = create_engine(connection_string)

    for table_name, file_name in table_file.items():
        file_path = os.path.join(csv_dir, file_name)
        df = pd.read_csv(file_path)
        df.to_sql(table_name, con=engine, schema='dbo', if_exists='append', index=False)

    print("Done")

except Exception as e:
    print(f"Error: {str(e)}")
