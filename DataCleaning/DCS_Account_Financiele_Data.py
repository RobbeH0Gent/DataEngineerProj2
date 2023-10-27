import pandas as pd

# Read the CSV file into a DataFrame
csv_dir = 'C:/Users/Eli/Desktop/DATA/Account financiële data.csv'
df = pd.read_csv(csv_dir)

new_columns = {'crm_FinancieleData_OndernemingID' : 'Account_ID',
               'crm_FinancieleData_Boekjaar' : 'Boekjaar',
               'crm_FinancieleData_Aantal_maanden' : 'Aantal_maanden',
               'crm_FinancieleData_Toegevoegde_waarde' : 'Toegevoegde_waarde',
               'crm_FinancieleData_FTE' : 'FTE',
               'crm_FinancieleData_Gewijzigd_op' : 'Gewijzigd_op',
                }
df.columns = [new_columns.get(col,col) for col in df.columns]

df = df.dropna(how='all')

# Save the modified DataFrame back to the original CSV file, overwriting it
df.to_csv(csv_dir, index=False)