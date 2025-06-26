import os
import requests

INFERENCE_URL = os.getenv("INFERENCE_URL", "http://localhost:8080")

code_snippet = """
def add(a, b):
    return a + b

print(add("1", 2))
"""

prompt = f"Debug this Python code and explain the fix:\n\n{code_snippet}"
response = requests.post(f"{INFERENCE_URL}/generate", json={"inputs": prompt})
response.raise_for_status()
print(response.json())
