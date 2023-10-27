import pandas as pd

# Read the CSV file into a DataFrame
csv_dir = 'C:/Users/Eli/Desktop/DATA/Activiteit vereist contact.csv'
df = pd.read_csv(csv_dir)

new_columns = {'crm_ActiviteitVereistContact_ActivityId' : 'Activity_ID',
               'crm_ActiviteitVereistContact_ReqAttendee' : 'ReqAttendee',
                }
df.columns = [new_columns.get(col,col) for col in df.columns]

df = df.dropna(how='all')

# Save the modified DataFrame back to the original CSV file, overwriting it
df.to_csv(csv_dir, index=False)