import json
import numpy as np
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Embedding, LSTM, Dropout, Bidirectional
from sklearn.preprocessing import LabelEncoder

# Load data from JSON file
with open('C:\\Users\\abedt\\OneDrive\\Desktop\\Desktop_V2\\PyCharm Projects\\DSC_680\\ChatBot\\Program\\App\\data.json', 'r') as file:
    data = json.load(file)

# Preprocess data
input_texts, target_labels = [], []
for intent in data['intents']:
    for pattern in intent['patterns']:
        input_texts.append(pattern)
        target_labels.append(intent['tag'])

label_encoder = LabelEncoder()
target_labels = label_encoder.fit_transform(target_labels)

# Tokenize and pad input sequences
tokenizer = tf.keras.preprocessing.text.Tokenizer()
tokenizer.fit_on_texts(input_texts)
input_sequences = tokenizer.texts_to_sequences(input_texts)
input_sequences = tf.keras.preprocessing.sequence.pad_sequences(input_sequences)

# Model parameters
vocab_size = len(tokenizer.word_index) + 1
embedding_dim = 256
lstm_units = 128
output_size = len(label_encoder.classes_)

# Create the model
model = Sequential()
model.add(Embedding(vocab_size, embedding_dim, input_length=len(input_sequences[0])))
model.add(Bidirectional(LSTM(lstm_units, return_sequences=True)))
model.add(Dropout(0.5))
model.add(LSTM(lstm_units))
model.add(Dense(output_size, activation='softmax'))

# Compile and train the model
model.compile(optimizer='adam', loss='sparse_categorical_crossentropy', metrics=['accuracy'])
model.fit(input_sequences, target_labels, epochs=40, batch_size=32)

# Save the model and metadata
model.save('C:\\Users\\abedt\\OneDrive\\Desktop\\Desktop_V2\\PyCharm Projects\\DSC_680\\ChatBot\\Program\\App\\chatbot_model.h5')
with open('C:\\Users\\abedt\\OneDrive\\Desktop\\Desktop_V2\\PyCharm Projects\\DSC_680\\ChatBot\\Program\\App\\tokenizer.json', 'w') as file:
    json.dump(tokenizer.to_json(), file)
with open('C:\\Users\\abedt\\OneDrive\\Desktop\\Desktop_V2\\PyCharm Projects\\DSC_680\\ChatBot\\Program\\App\\label_encoder.json', 'w') as file:
    json.dump(label_encoder.classes_.tolist(), file)