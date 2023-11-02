import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Load the "Account.csv" dataset
data = pd.read_csv('Account.csv')

# Display basic statistics of numerical columns
print("Basic Statistics:")
print(data.describe())

# Calculate the correlation matrix for numerical columns
correlation_matrix = data.corr()

# Create a heatmap for numerical correlations
plt.figure(figsize=(12, 10))
sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm', linewidths=0.5)
plt.title('Correlation Matrix for Numerical Columns')
plt.show()

# Visualize relationships between specific columns
sns.pairplot(data, diag_kind='kde')
plt.suptitle('Pairplot for Selected Columns')
plt.show()

# Explore categorical columns
categorical_columns = data.select_dtypes(include=['object'])
for column in categorical_columns:
    print(f"Unique values in {column}:")
    print(data[column].value_counts())
    print()

# Explore relationships between categorical and numerical columns
for categorical_column in categorical_columns:
    if categorical_column != 'crm_Account_Account':  # Replace with the appropriate column name
        sns.boxplot(x=categorical_column, y='crm_Account_Account', data=data)
        plt.xticks(rotation=45)
        plt.title(f'Boxplot for {categorical_column} vs. crm_Account_Account')
        plt.show()

# Example: use hypothesis tests or regression models for in-depth analysis

