import pandas as pd

# Read the CSV file into a DataFrame
csv_dir = 'C:/Users/Eli/Desktop/DEPII/Afspraak betreft contact_cleaned.csv'
df = pd.read_csv(csv_dir)

df.rename(columns={'crm_Afspraak_BETREFT_ACCOUNT_Betreft_id': 'Contactfiche_ID'}, inplace=True)

df = df.dropna(how='all')

# Save the modified DataFrame back to the original CSV file, overwriting it
df.to_csv(csv_dir, index=False)