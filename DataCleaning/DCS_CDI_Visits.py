import pandas as pd

# Read the CSV file into a DataFrame
csv_dir = 'C:/Users/Eli/Desktop/DEPII/CDI visits.csv'
df = pd.read_csv(csv_dir)

df = df.drop(['crm_CDI_Visit_Campagne_Code'], axis=1)
df = df.dropna(how='all')



# Save the modified DataFrame back to the original CSV file, overwriting it
df.to_csv(csv_dir, index=False)