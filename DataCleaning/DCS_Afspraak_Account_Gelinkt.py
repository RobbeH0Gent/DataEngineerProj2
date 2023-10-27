import pandas as pd

# Read the CSV file into a DataFrame
csv_dir = 'C:/Users/Eli/Desktop/DATA/Afspraak_account_gelinkt_cleaned.csv'
df = pd.read_csv(csv_dir)

new_columns = {'crm_Afspraak_ACCOUNT_GELINKT_Afspraak' : 'Afspraak_ID',
               'crm_Afspraak_ACCOUNT_GELINKT_Thema' : 'Thema',
               'crm_Afspraak_ACCOUNT_GELINKT_Subthema' : 'Subthema',
               'crm_Afspraak_ACCOUNT_GELINKT_Onderwerp' : 'Onderwerp',
               'crm_Afspraak_ACCOUNT_GELINKT_Eindtijd' : 'Eindtijd',
               'crm_Afspraak_ACCOUNT_GELINKT_Account' : 'Account_ID',
               'crm_Afspraak_ACCOUNT_GELINKT_KeyPhrases' : 'KeyPrhases',
                }
df.columns = [new_columns.get(col,col) for col in df.columns]

df = df.dropna(how='all')

# Save the modified DataFrame back to the original CSV file, overwriting it
df.to_csv(csv_dir, index=False)