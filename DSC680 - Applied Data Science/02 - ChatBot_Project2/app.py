from flask import Flask, render_template
from flask_socketio import SocketIO, send
import json
import numpy as np
import tensorflow as tf
from sklearn.preprocessing import LabelEncoder

app = Flask(__name__)
app.config['SECRET_KEY'] = '1212'
socketio = SocketIO(app)

# Load model and metadata
model = tf.keras.models.load_model('C:\\Users\\abedt\\OneDrive\\Desktop\\Desktop_V2\\PyCharm Projects\\DSC_680\\ChatBot\\Program\\App\\chatbot_model.h5')
with open('C:\\Users\\abedt\\OneDrive\\Desktop\\Desktop_V2\\PyCharm Projects\\DSC_680\\ChatBot\\Program\\App\\tokenizer.json', 'r') as file:
    tokenizer = tf.keras.preprocessing.text.tokenizer_from_json(json.load(file))
with open('C:\\Users\\abedt\\OneDrive\\Desktop\\Desktop_V2\\PyCharm Projects\\DSC_680\\ChatBot\\Program\\App\\label_encoder.json', 'r') as file:
    label_encoder = LabelEncoder()
    label_encoder.classes_ = np.array(json.load(file))

# Load intents data
with open('C:\\Users\\abedt\\OneDrive\\Desktop\\Desktop_V2\\PyCharm Projects\\DSC_680\\ChatBot\\Program\\App\\data.json', 'r') as file:
    data = json.load(file)

def predict_response(input_text):
    input_sequence = tokenizer.texts_to_sequences([input_text])
    input_sequence = tf.keras.preprocessing.sequence.pad_sequences(input_sequence, maxlen=model.input_shape[1])
    prediction = model.predict(input_sequence)
    response_tag = label_encoder.inverse_transform([np.argmax(prediction)])[0]

    for intent in data['intents']:
        if intent['tag'] == response_tag:
            return np.random.choice(intent['responses'])

@app.route('/')
def index():
    return render_template('index.html')

@socketio.on('message')
def handleMessage(msg):
    response = predict_response(msg)
    send(response, broadcast=True)

if __name__ == '__main__':
    socketio.run(app)