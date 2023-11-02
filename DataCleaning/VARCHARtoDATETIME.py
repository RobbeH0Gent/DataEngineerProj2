import pyodbc
import datetime
import os

SERVER = os.environ.get('SERVER')
DATABASE = os.environ.get('DATABASE')
UID = os.environ.get('USER')
PWD = os.environ.get('PASSWORD')

table_columns = {
    #Format staat ernaast om te weten welke mogelijkheiden er allemaal moeten geformateerd worden 
    'Account': 'Oprichtingsdatum',  #8-9-2013
    'Account_Financiele_Data': 'Gewijzigd_op', #15-10-2018 08:21:37 
    'Afspraak_Account_Gelinkt': 'Eindtijd', #18-4-2023
    'Afspraak_Betreft_Account': 'Eindtijd', #3-2-2021
    'Afspraak_Betreft_Contactfiche': 'Eindtijd', #19-10-2022
    'Campagne': 'Einddatum', #16-9-2019 15:00:00
    'Campagne': 'Startdatum', #16-9-2019 14:00:00
    'CDI_Mailing': 'Mailing_Sent_On', #8-2-2022
    'CDI_PageView': 'PageView_Time', #01-16-2023 09:16:07 (UTC)
    'CDI_PageView': 'Viewed_On', #16/01/2023
    'CDI_PageView': 'Made_On', #17/01/2023
    'CDI_PageView': 'Edited_On', #17/01/2023
    'CDI_Visits':'Ended_On', #10-11-2021 14:58:29
    'CDI_Visits':'Started_On', #10-11-2021 14:58:29
    'CDI_Visits':'Visit_Time', #11-10-2021 14:58:29 (UTC)
    'CDI_Visits':'Aangemaakt_op', #10-11-2021 16:02:52
    'CDI_Visits':'Gewijzigd_op', #15-6-2022 16:52:49
    'CDI_Web_Content':'Created_On', #18-9-2020 10:27:22
    'CDI_Web_Content':'Modified_On', #2-10-2020 10:18:43
    'Info_en_Klachten':'Datum', #25-2-2019 00:00:00
    'Info_en_Klachten':'Datum_afsluiting', #25-2-2019 00:00:00
    'Inschrijving':'Datum', #11-5-2021
    'Lidmaatschap':'Opzeg', #31-12-2013
    'Lidmaatschap':'Start_Datum', #1-1-2013
    'Sessie':'Einddatum', #25-11-2021 12:00:00
    'Sessie':'Startdatum', #25-11-2021 11:00:00
}
connection = pyodbc.connect(f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={SERVER};DATABASE={DATABASE};UID={UID};PWD={PWD}')
cursor = connection.cursor()

for table, varchar_date_column in table_columns.items():
    cursor.execute(f"SELECT {varchar_date_column} FROM {table}")
    varchar_dates = cursor.fetchall()

    datetime_dates = []

    for row in varchar_dates:
        varchar_date = row[0]
        #try:
            #Moet nog aangepast worden
            #datetime_date = datetime.datetime.strptime(varchar_date, "%Y-%m-%d")
            #datetime_dates.append(datetime_date)
        #except ValueError:
        #    print(f"Error: Unable to convert '{varchar_date}' to DateTime")


    #update de database met de nieuwe DATETIME waarden
    for i, datetime_date in enumerate(datetime_dates):
        cursor.execute(f"UPDATE {table} SET {varchar_date_column} = ? WHERE id = ?", (datetime_date, i + 1))  # Adjust the WHERE condition as needed

    connection.commit()
connection.close()
