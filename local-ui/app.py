import os
from flask import Flask, render_template, request, jsonify
import requests

INFERENCE_URL = os.environ.get("INFERENCE_URL", "http://localhost:8080")

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.post('/chat')
def chat():
    prompt = request.json.get('prompt', '')
    try:
        r = requests.post(f"{INFERENCE_URL}/generate", json={"inputs": prompt})
        r.raise_for_status()
        data = r.json()
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    return jsonify(data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)
