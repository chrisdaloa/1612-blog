#!/usr/bin/env python3
"""
generate_cover.py — Genera un'immagine di copertina via OpenRouter Image API
(modello: google/gemini-2.5-flash-image, ~$0.039/immagine) e la salva su disco.

Richiede la variabile d'ambiente OPENROUTER_API_KEY (la stessa già usata
per il digest AI settimanale).

Uso:
  python3 generate_cover.py --prompt "descrizione immagine" --output static/images/posts/slug.png
"""

import argparse
import base64
import os
import sys

import requests

OPENROUTER_IMAGES_URL = "https://openrouter.ai/api/v1/images"
MODEL = "google/gemini-2.5-flash-image"  # "Nano Banana" — stabile, ~$0.039/immagine


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--prompt", required=True, help="Prompt testuale per l'immagine")
    parser.add_argument("--output", required=True, help="Path di output (es. static/images/posts/slug.png)")
    parser.add_argument("--aspect-ratio", default="16:9", help="Aspect ratio (default 16:9, adatto a copertine blog)")
    args = parser.parse_args()

    api_key = os.environ.get("OPENROUTER_API_KEY")
    if not api_key:
        print("ERRORE: variabile d'ambiente OPENROUTER_API_KEY non impostata.", file=sys.stderr)
        sys.exit(1)

    payload = {
        "model": MODEL,
        "prompt": args.prompt,
        "image_config": {
            "aspect_ratio": args.aspect_ratio,
            "image_size": "2K",
        },
    }
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json",
    }

    try:
        response = requests.post(OPENROUTER_IMAGES_URL, json=payload, headers=headers, timeout=90)
    except requests.RequestException as e:
        print(f"ERRORE di rete verso OpenRouter: {e}", file=sys.stderr)
        sys.exit(1)

    if response.status_code != 200:
        print(f"ERRORE OpenRouter (HTTP {response.status_code}): {response.text[:500]}", file=sys.stderr)
        sys.exit(1)

    data = response.json()
    items = data.get("data", [])
    if not items or "b64_json" not in items[0]:
        print(f"ERRORE: risposta senza immagine. Payload: {data}", file=sys.stderr)
        sys.exit(1)

    image_bytes = base64.b64decode(items[0]["b64_json"])
    os.makedirs(os.path.dirname(args.output), exist_ok=True)
    with open(args.output, "wb") as f:
        f.write(image_bytes)

    cost = data.get("usage", {}).get("cost")
    cost_note = f" (costo: ${cost})" if cost is not None else ""
    print(f"OK: immagine salvata in {args.output}{cost_note}")


if __name__ == "__main__":
    main()
