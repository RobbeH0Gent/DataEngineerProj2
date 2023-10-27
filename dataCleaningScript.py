import pandas as pd

# Read the CSV file into a DataFrame
csv_dir = 'C:/Users/Eli/Desktop/DATA/Persoon.csv'
df = pd.read_csv(csv_dir)

# List of columns that represent one-hot encoded categories
one_hot_columns = [
    'crm_Persoon_Mail_regio_Antwerpen_Waasland',
    'crm_Persoon_Mail_regio_Brussel_Hoofdstedelijk_Gewest',
    'crm_Persoon_Mail_regio_Limburg',
    'crm_Persoon_Mail_regio_Mechelen_Kempen',
    'crm_Persoon_Mail_regio_Oost_Vlaanderen',
    'crm_Persoon_Mail_regio_Vlaams_Brabant',
    'crm_Persoon_Mail_regio_Voka_nationaal',
]  # Add all relevant column names

# Create a new column 'Regio' with the name of the category where 'ja' is present
def find_selected_category(row):
    for column in one_hot_columns:
        if row[column] == 'Ja':
            return column.replace('Ja', column).replace('crm_Persoon_Mail_regio_', '').replace('_' , ' ')
    return 'Geen Regio'  # Default value if no 'ja' is found

df['Regio'] = df.apply(find_selected_category, axis=1)

# Drop the original one-hot encoded columns
df.drop(one_hot_columns, axis=1, inplace=True)

# Save the modified DataFrame back to the original CSV file, overwriting it
df.to_csv(csv_dir, index=False)

# Display the modified DataFrame
print(df.iloc[5])
print(df.iloc[6])
print(df.iloc[7])
