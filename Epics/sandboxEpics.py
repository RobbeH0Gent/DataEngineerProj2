import os
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.metrics import accuracy_score
from keras.models import Sequential
from keras.layers import Dense

# Dit is mijn lokaal pad!!!! de juiste CSV ZIT NOG NIET IN ONZE GITHUB
file_path = os.path.join('..', '..', '..', 'DEPII', 'Contact.csv')

data = pd.read_csv(file_path)

# De relevante functies?
features = data[['crm_Contact_Functietitel', 'crm_Contact_Status', 'crm_Contact_Voka_medewerker']]

# Aannemen dat 'crm_Contact_Status' een soort indicatie is van inschrijvingswaarschijnlijkheid, pas dit aan als het nodig is
labels = data['crm_Contact_Status']

X_train, X_test, y_train, y_test = train_test_split(features, labels, test_size=0.2, random_state=42)

categorical_cols = ['crm_Contact_Functietitel', 'crm_Contact_Status', 'crm_Contact_Voka_medewerker']

preprocessor = ColumnTransformer(
    transformers=[
        ('num', StandardScaler(), ['crm_Contact_Status']),  # Schaal numerieke kolommen
        ('cat', OneHotEncoder(), categorical_cols)  # One-hot encode categorische kolommen
    ])

model = Sequential()
model.add(Dense(32, input_dim=X_train.shape[1], activation='relu'))
model.add(Dense(16, activation='relu'))
model.add(Dense(1, activation='sigmoid'))

model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])

pipeline = Pipeline([
    ('preprocessor', preprocessor),
    ('model', model)
])

pipeline.fit(X_train, y_train, model__epochs=10, model__batch_size=32, model__validation_split=0.2)

predictions = pipeline.predict(X_test)
predictions_binary = [1 if pred >= 0.5 else 0 for pred in predictions]

accuracy = accuracy_score(y_test, predictions_binary)
print(f'Nauwkeurigheid testset bedraagt: {accuracy}')

output_data = pd.DataFrame({
    'Status': X_test['crm_Contact_Status'],
    'Voka_medewerker': X_test['crm_Contact_Voka_medewerker'],
    'Voorspelling': predictions_binary
})

output_data.to_csv('output_predictions.csv', index=False)
