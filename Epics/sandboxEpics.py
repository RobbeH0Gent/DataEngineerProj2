import os
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.metrics import accuracy_score
from keras.models import Sequential
from keras.layers import Dense

# Dit is mijn lokaal pad!!!! de juiste CSV ZIT NOG NIET IN ONZE GITHUB
file_path = os.path.join('..', '..', '..', 'DEPII', 'Contact.csv')

data = pd.read_csv(file_path)

# Use LE for 'crm_Contact_Functietitel' en 'crm_Contact_Status' -> anders foutmelding
label_encoder = LabelEncoder()
data['crm_Contact_Functietitel'] = label_encoder.fit_transform(data['crm_Contact_Functietitel'])
data['crm_Contact_Status'] = label_encoder.fit_transform(data['crm_Contact_Status'])

features = data[['crm_Contact_Functietitel', 'crm_Contact_Status', 'crm_Contact_Voka_medewerker']]
# Assuming 'Campagne' is the column to predict -> this is not the case.
labels = data['Campagne']

X_train, X_test, y_train, y_test = train_test_split(features, labels, test_size=0.2, random_state=42)

scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

model = Sequential()
model.add(Dense(32, input_dim=X_train.shape[1], activation='relu'))
model.add(Dense(16, activation='relu'))
model.add(Dense(1, activation='sigmoid'))

model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])

model.fit(X_train, y_train, epochs=10, batch_size=32, validation_split=0.2)

predictions = model.predict(X_test)
predictions_binary = [1 if pred >= 0.5 else 0 for pred in predictions]

accuracy = accuracy_score(y_test, predictions_binary)
print(f'Nauwkeurigheid testset bedraagt: {accuracy}')

output_data = pd.DataFrame({
    'Functietitel': label_encoder.inverse_transform(X_test['crm_Contact_Functietitel']),
    'Status': label_encoder.inverse_transform(X_test['crm_Contact_Status']),
    'Voka_medewerker': X_test['crm_Contact_Voka_medewerker'],
    'Voorspelling': predictions_binary
})

output_data.to_csv('output_predictions.csv', index=False)
