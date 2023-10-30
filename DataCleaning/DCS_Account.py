import pandas as pd

# Read the CSV file into a DataFrame
csv_dir = 'C:/Users/Eli/Desktop/DEPII/Account.csv'
df = pd.read_csv(csv_dir)

df = df.dropna(how='all')
df = df.drop(['crm_Account_Hoofd_NaCe_Code'], axis=1)

# Save the modified DataFrame back to the original CSV file, overwriting it
df.to_csv(csv_dir, index=False)