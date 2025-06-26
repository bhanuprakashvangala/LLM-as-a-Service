import os
import asyncio
import httpx

INFERENCE_URL = os.getenv("INFERENCE_URL", "http://localhost:8080")

async def main():
    async with httpx.AsyncClient() as client:
        resp = await client.post(f"{INFERENCE_URL}/generate", json={"inputs": "Hello"})
        resp.raise_for_status()
        print(resp.json())

if __name__ == "__main__":
    asyncio.run(main())
