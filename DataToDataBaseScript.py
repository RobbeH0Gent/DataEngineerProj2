import os
import pandas as pd
import pyodbc

db_params = {
    'server': 'DESKTOP-300DAOQ\Eli,1433',
    'database': 'DEP2',
    'user': 'sa',
    'password': 'Kaas_123',
}


csv_dir = '' #path waar de data csv files staan

csv_files = [
    # 'Account activiteitscode.csv',
    # 'Account financiële data.csv',
    'Account.csv',
    # 'Activiteit vereist contact.csv',
    # 'Activiteitscode.csv',
    # 'Afspraak alle.csv',
    # 'Afspraak betreft account_cleaned.csv',
    # 'Afspraak betreft contact_cleaned.csv',
    # 'Afspraak_account_gelinkt_cleaned.csv',
    # 'Campagne.csv',
    # 'CDI mailing.csv',
    # 'cdi pageviews.csv',
    # 'CDI sent email clicks.csv',
    # 'CDI visits.csv',
    # 'CDI web content.csv',
    # 'Contact functie.csv',
    # 'Contact.csv',
    # 'Functie.csv',
    # 'Gebruikers.csv',
    # 'Info en klachten.csv',
    # 'Inschrijving.csv',
    # 'Lidmaatschap.csv',
    # 'Persoon.csv',
    # 'Sessie inschrijving.csv',
    # 'Sessie.csv',
    # 'teams.csv',
]

table_names = [
    # 'AccountActiviteitscode',
    # 'AccountFinanciëleData',
    'Account',
    # 'ActiviteitVereistContact',
    # 'Activiteitscode',
    # 'AfspraakAlle',
    # 'AfspraakBetreftAccountCleaned',
    # 'AfspraakBetreftContactCleaned',
    # 'AfspraakAccountGelinktCleaned',
    # 'Campagne',
    # 'CDIMailing',
    # 'CDIPageviews',
    # 'CDISentEmailClicks',
    # 'CDIVisits',
    # 'CDIWebContent',
    # 'ContactFunctie',
    # 'Contact',
    # 'Functie',
    # 'Gebruikers',
    # 'InfoEnKlachten',
    # 'Inschrijving',
    # 'Lidmaatschap',
    # 'Persoon',
    # 'SessieInschrijving',
    # 'Sessie',
    # 'Teams',
]

try:


    # #Create a connection
    # conn = pyodbc.connect(
    #     f"DRIVER={{ODBC Driver 17 for SQL Server}};"
    #     f"SERVER={db_params['server']};"
    #     f"UID={db_params['user']};"
    #     f"PWD={db_params['password']}"
    # )
    # cursor = conn.cursor()

    # # Create the database if it doesn't exist
    # cursor.execute(f"IF DB_ID('{db_params['database']}') IS NULL CREATE DATABASE {db_params['database']}")
    # conn.commit()
    # conn.close()


    # Reconnect to the newly created database
    conn = pyodbc.connect(
        f"DRIVER={{ODBC Driver 17 for SQL Server}};"
        f"SERVER={db_params['server']};"
        f"DATABASE={db_params['database']};"
        f"UID={db_params['user']};"
        f"PWD={db_params['password']}"
    )
    cursor = conn.cursor()


    i = 0

    for csv_file in csv_files:
        file_path = os.path.join(csv_dir, csv_file)

        df = pd.read_csv(file_path)
        table_name = table_names[i]

        df.to_sql(table_name, conn, if_exists='append', index=False)
        print(f"Inserted data from {csv_file} into {table_name}")
        i += 1

    conn.commit()
    cursor.close()
    conn.close()
    print("Done")

except Exception as e:
    print(f"Error: {str(e)}")
