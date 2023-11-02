import pandas as pd

# Define a function to clean each CSV file
def clean_csv_file(file_path, date_columns=None):
    # Load the CSV file into a DataFrame
    df = pd.read_csv(file_path)

    # Handling duplicates
    df.drop_duplicates(inplace=True)

    # Handling missing values
    df.fillna(value='', inplace=True)

    # Date column conversion to VARCHAR
    if date_columns:
        for col in date_columns:
            df[col] = df[col].astype(str)

    # Save the cleaned DataFrame back to the CSV file
    df.to_csv(file_path, index=False)

# List of CSV file paths
csv_files = [
    "Activiteit_vereist_contact.csv",
    "crm_Account_ActiviteitsCode_Account.csv",
    "Account.csv",
    "Activiteitscode.csv",
    "Afspraak_alle.csv",
    "Campagne.csv",
    "CDI_mailing.csv",
    "CDI_sent_email_clicks.csv",
    "CDI_visits.csv",
    "CDI_web_content.csv",
    "Contact.csv",
    "Functie.csv",
    "Gebruikers.csv",
    "Info_en_klachten.csv",
    "Inschrijving.csv",
    "Lidmaatschap.csv",
    "Persoon.csv",
    "Sessie.csv",
    "teams.csv"
]

# Define date columns for each CSV (customize as needed)
date_columns = {
    "Activiteit_vereist_contact.csv": [],  # No date columns in this file
    "crm_Account_ActiviteitsCode_Account.csv": [],
    "Account.csv": ["crm_Account_Oprichtingsdatum"],
    "Activiteitscode.csv": [],
    "Afspraak_alle.csv": ["crm_Afspraak_ALLE_Afspraak"],
    "Campagne.csv": ["crm_Campagne_Startdatum", "crm_Campagne_Einddatum"],
    "CDI_mailing.csv": ["crm_CDI_Mailing_Sent_On"],
    "CDI_sent_email_clicks.csv": [],
    "CDI_visits.csv": ["crm_CDI_Visit_Ended_On", "crm_CDI_Visit_Started_On"],
    "CDI_web_content.csv": [],
    "Contact.csv": [],
    "Functie.csv": [],
    "Gebruikers.csv": [],
    "Info_en_klachten.csv": ["crm_Info_en_Klachten_Datum", "crm_Info_en_Klachten_Datum_afsluiting"],
    "Inschrijving.csv": [],
    "Lidmaatschap.csv": ["crm_Lidmaatschap_Startdatum", "crm_Lidmaatschap_Datum_Opzeg"],
    "Persoon.csv": [],
    "Sessie.csv": ["crm_Sessie_Start_Datum_Tijd", "crm_Sessie_Eind_Datum_Tijd"],
    "teams.csv": []
}

# Clean each CSV file
for csv_file in csv_files:
    date_cols = date_columns.get(csv_file, [])
    clean_csv_file(csv_file, date_cols)
