import pandas as pd

# Read the CSV file into a DataFrame
csv_dir = 'C:/Users/Eli/Desktop/DATA/Account.csv'
df = pd.read_csv(csv_dir)

new_columns = {'crm_Account_Account' : 'Account_ID',
                'crm_Account_Adres_Geografische_regio':'Adres_Geografische_regio',
                'crm_Account_Adres_Geografische_subregio':'Adres_Geografische_subregio',
                'crm_Account_Adres_Plaats':'Plaats',
                'crm_Account_Adres_Postcode':'Postcode',
                'crm_Account_Adres_Provincie' : 'Provincie',
                'crm_Account_Industriezone_Naam_' : 'Industriezone_Naam_',
                'crm_Account_Is_Voka_entiteit' : 'Is_Voka_entiteit',
                'crm_Account_Ondernemingsaard' : 'Ondernemingsaard',
                'crm_Account_Ondernemingstype' : 'Ondernemingstype',
                'crm_Account_Oprichtingsdatum' : 'Oprichtingsdatum',
                'crm_Account_Primaire_activiteit' : 'Primaire_activiteit',
                'crm_Account_Reden_van_status' : 'Reden_van_status',
                'crm_Account_Status' : 'Status',
                'crm_Account_Voka_Nr_' : 'Voka_Nr_',
                'crm_Account_Hoofd_NaCe_Code' : 'Hoofd_NaCe_Code',
                'crm_Account_Adres_Land' : 'Adres_Land',}
df.columns = [new_columns.get(col,col) for col in df.columns]

df = df.dropna(how='all')

# Save the modified DataFrame back to the original CSV file, overwriting it
df.to_csv(csv_dir, index=False)