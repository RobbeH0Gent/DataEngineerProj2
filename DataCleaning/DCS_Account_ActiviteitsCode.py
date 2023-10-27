import pandas as pd

# Read the CSV file into a DataFrame
csv_dir = 'C:/Users/Eli/Desktop/DATA/Account activiteitscode.csv'
df = pd.read_csv(csv_dir)

new_columns = {'crm_Account_ActiviteitsCode_Account' : 'Activiteits_Code',
               'crm_Account_ActiviteitsCode_Activiteitscode' : 'Activiteitscode_ID',
               'crm_Account_ActiviteitsCode_inf_account_inf_activiteitscodeId' : 'inf_account_inf_activiteitscodeId',
                }
df.columns = [new_columns.get(col,col) for col in df.columns]

df = df.dropna(how='all')

# Save the modified DataFrame back to the original CSV file, overwriting it
df.to_csv(csv_dir, index=False)