import pandas as pd

# Read the CSV file into a DataFrame

csv_dir ='../../Data/Persoon.csv'

df = pd.read_csv(csv_dir)

# Get the data types of columns
data_types = df.dtypes

# Print the data types
print(data_types)