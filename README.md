# LLM-as-a-Service

This repository provides a Helm chart for deploying Hugging Face text-generation models in Kubernetes. Edit `values.yaml` to configure the model and deployment options, then install with:

```bash
helm install <release-name> .
```

## Local Chat UI

<<<<<<< cs00i9-codex/use-code-with-llm-for-debugging
`local-ui/` contains a small web interface built with FastAPI so you can chat with the deployed model from your PC.
=======
A minimal Flask-based UI is included in `local-ui/` to interact with the running model from your PC.
>>>>>>> main

### Run the UI
1. Install dependencies:
   ```bash
<<<<<<< cs00i9-codex/use-code-with-llm-for-debugging
   pip install fastapi uvicorn httpx jinja2
=======
   pip install flask requests
>>>>>>> main
   ```
2. Set the model endpoint (default `http://localhost:8080`):
   ```bash
   export INFERENCE_URL=http://<model-service-host>:<port>
   ```
3. Start the server:
   ```bash
   python local-ui/app.py
   ```
4. Open `http://localhost:3000` in your browser.

Update the `INFERENCE_URL` environment variable or edit `local-ui/app.py` if your service runs on a different address.

<<<<<<< cs00i9-codex/use-code-with-llm-for-debugging
## Deploying the chart with a chat UI

The Helm chart ships with an optional web interface. To deploy it alongside the
inference server, edit `values.yaml` and set:

```yaml
chat:
  enabled: true
```

Install (or upgrade) the chart after modifying your values:

```bash
helm upgrade --install <release-name> .
```

When enabled, the UI listens on port 3000 and can be exposed externally via the
`chat.ingress` settings.

=======
>>>>>>> main
## Simple API example
You can also interact with the model using plain HTTP requests. A Python example is provided in `examples/api_example.py`:

```bash
python examples/api_example.py
```

Set `INFERENCE_URL` if your model endpoint uses a different address.

## Debugging with the API
Use the model as a coding assistant by sending code snippets to the inference
server. The script `examples/debugging_demo.py` shows a simple workflow:

```bash
python examples/debugging_demo.py
```

This posts a short Python program to the `/generate` endpoint and prints the
model's analysis. Replace the snippet in the script with your own code to get
help identifying errors and potential fixes.
