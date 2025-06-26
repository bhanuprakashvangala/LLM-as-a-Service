import os
import httpx
from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse, JSONResponse
from fastapi.templating import Jinja2Templates
import uvicorn

INFERENCE_URL = os.getenv("INFERENCE_URL", "http://localhost:8080")

app = FastAPI()
templates = Jinja2Templates(directory="templates")

@app.get("/", response_class=HTMLResponse)
async def index(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})

@app.post("/chat")
async def chat(payload: dict):
    prompt = payload.get("prompt", "")
    try:
        async with httpx.AsyncClient() as client:
            r = await client.post(f"{INFERENCE_URL}/generate", json={"inputs": prompt})
            r.raise_for_status()
            data = r.json()
    except Exception as e:
        return JSONResponse({"error": str(e)}, status_code=500)
    return JSONResponse(data)

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=3000)

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

