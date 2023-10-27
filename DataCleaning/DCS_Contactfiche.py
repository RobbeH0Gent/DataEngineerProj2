import pandas as pd

# Read the CSV file into a DataFrame
csv_dir = 'C:/Users/Eli/Desktop/DATA/Contact.csv'
df = pd.read_csv(csv_dir)

new_columns = {'crm_Contact_Persoon_ID' : 'Persoon_ID',
               'crm_Contact_Contactpersoon' : 'Contactfiche_ID',
               'crm_Contact_Account' : 'Account_ID',
               'crm_Contact_Functietitel' : 'Functie_title',
               'crm_Contact_Status' : 'Status',
               'crm_Contact_Voka_medewerker' : 'Voka_medewerker',
                }
df.columns = [new_columns.get(col,col) for col in df.columns]

df = df [['Persoon_ID','Contactfiche_ID', 'Account_ID','Functie_title','Status','Voka_medewerker']]

df = df.dropna(how='all')

# Save the modified DataFrame back to the original CSV file, overwriting it
df.to_csv(csv_dir, index=False)