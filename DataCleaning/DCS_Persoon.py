import pandas as pd

# Read the CSV file into a DataFrame
csv_dir = 'C:/Users/Eli/Desktop/DATA/Persoon.csv'
df = pd.read_csv(csv_dir)

# List of columns that represent one-hot encoded categories
regios = [
    'crm_Persoon_Mail_regio_West_Vlaanderen',
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
    for column in regios:
        if row[column] == 'Ja':
            return column.replace('Ja', column).replace('crm_Persoon_Mail_regio_', '').replace('_' , ' ')
    return 'Geen Regio'  # Default value if no 'ja' is found

df['Regio'] = df.apply(find_selected_category, axis=1)

# Drop the original one-hot encoded columns
df.drop(regios, axis=1, inplace=True)

# List of columns that represent one-hot encoded categories
themas = [
    'crm_Persoon_Mail_thema_duurzaamheid',
    'crm_Persoon_Mail_thema_financieel_fiscaal',
    'crm_Persoon_Mail_thema_innovatie',
    'crm_Persoon_Mail_thema_internationaal_ondernemen',
    'crm_Persoon_Mail_thema_mobiliteit',
    'crm_Persoon_Mail_thema_omgeving',
    'crm_Persoon_Mail_thema_sales_marketing_communicatie',
    'crm_Persoon_Mail_thema_strategie_en_algemeen_management',
    'crm_Persoon_Mail_thema_talent',
    'crm_Persoon_Mail_thema_welzijn',
]  # Add all relevant column names

# Create a new column 'Regio' with the name of the category where 'ja' is present
def find_selected_category(row):
    for column in themas:
        if row[column] == 'Ja':
            return column.replace('Ja', column).replace('crm_Persoon_Mail_thema_', '').replace('_' , ' ')
    return 'Geen Thema'  # Default value if no 'ja' is found

df['Thema'] = df.apply(find_selected_category, axis=1)

# Drop the original one-hot encoded columns
df.drop(themas, axis=1, inplace=True)

# List of columns that represent one-hot encoded categories
types = [
    'crm_Persoon_Mail_type_Bevraging',
    'crm_Persoon_Mail_type_communities_en_projecten',
    'crm_Persoon_Mail_type_netwerkevenementen',
    'crm_Persoon_Mail_type_nieuwsbrieven',
    'crm_Persoon_Mail_type_opleidingen',
    'crm_Persoon_Mail_type_persberichten_belangrijke_meldingen',
]  # Add all relevant column names

# Create a new column 'Regio' with the name of the category where 'ja' is present
def find_selected_category(row):
    for column in types:
        if row[column] == 'Ja':
            return column.replace('Ja', column).replace('crm_Persoon_Mail_type_', '').replace('_' , ' ')
    return 'Geen Type'  # Default value if no 'ja' is found

df['Type_Persoon'] = df.apply(find_selected_category, axis=1)

# Drop the original one-hot encoded columns
df.drop(types, axis=1, inplace=True)

new_columns = {'crm_Persoon_persoon' : 'Persoon_ID',
                'crm_Persoon_Persoonsnr_':'Persoonnr',
                'crm_Persoon_Reden_van_status':'Status_Persoon',
                'crm_Persoon_Web_Login':'Email',
                'crm_Persoon_Marketingcommunicatie':'Marketing_Communicatie'}
df.columns = [new_columns.get(col,col) for col in df.columns]

df = df [['Persoon_ID','Persoonnr', 'Status_Persoon','Email','Regio','Thema','Type_Persoon','Marketing_Communicatie']]

# Save the modified DataFrame back to the original CSV file, overwriting it
df.to_csv(csv_dir, index=False)
