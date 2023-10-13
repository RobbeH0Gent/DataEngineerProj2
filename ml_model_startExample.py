import mysql.connector
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

# database parameters
db_params = {
    'host': 'your_host',
    'database': 'your_database',
    'user': 'your_user',
    'password': 'your_password',
}

# Deze query gaat afhangen van de data die we nodig hebben
query = "SELECT * FROM YourTableName"

try:
    # Verbinden met de db
    conn = mysql.connector.connect(**db_params)

    # inlezen data in dataframe
    df = pd.read_sql(query, conn)

    # close connection voor de safety
    conn.close()

    # data preprocessing (Dit deel gaat nog veranderen als de database er effectief is en
    #  als we een duidelijker beeld hebben van wat we willen doen en welk model we willen gebruiken)

    # Dit is nu een voorbeeld dat je een kolomm dropt om deze te gaan voorspellen
 
    target_column = 'target_column'
    X = df.drop(columns=[target_column])
    y = df[target_column]

    # Split the data in training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Create and train a machine learning model (Random Forest Classifier als voorbeeld!!!!)
    model = RandomForestClassifier()
    model.fit(X_train, y_train)

    # Make predictions on the test set
    y_pred = model.predict(X_test)

    # Evaluate the model's accuracy
    accuracy = accuracy_score(y_test, y_pred)
    print(f"Model Accuracy: {accuracy}")

    # Finetuning komt nog hierna.

except Exception as e:
    print(f"Error: {str(e)}")
