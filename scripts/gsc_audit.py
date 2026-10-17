#!/usr/bin/env python3
"""
gsc_audit.py — Controlla lo stato di indicizzazione di 1612.it con le API di Google Search Console.

Ispeziona ogni URL della sitemap (URL Inspection API, limite ~2000/giorno), legge le sitemap
inviate e le performance degli ultimi 90 giorni, poi stampa un riepilogo e salva il dettaglio in JSON.
Sola lettura: non invia richieste di indicizzazione né modifica la proprietà.

Richiede un service account aggiunto come utente della proprietà in Search Console
(chiave JSON in ~/.config/gsc/sa.json) e le librerie google-auth e google-api-python-client
(venv in ~/.config/gsc/venv).

Uso:
  ~/.config/gsc/venv/bin/python scripts/gsc_audit.py
  ~/.config/gsc/venv/bin/python scripts/gsc_audit.py --output tmp/gsc_out.json
"""

import argparse
import collections
import datetime
import json
import os
import re
import time
import urllib.request

from google.oauth2 import service_account
from googleapiclient.discovery import build

SITE = "sc-domain:1612.it"
SITEMAP_URL = "https://1612.it/sitemap.xml"
KEY_FILE = os.path.expanduser("~/.config/gsc/sa.json")
SCOPES = ["https://www.googleapis.com/auth/webmasters.readonly"]


def perf(service, dimension, start, end, limit=1000):
    body = {"startDate": start, "endDate": end, "dimensions": [dimension], "rowLimit": limit}
    return service.searchanalytics().query(siteUrl=SITE, body=body).execute()


def main():
    ap = argparse.ArgumentParser(description="Audit indicizzazione 1612.it via Search Console")
    ap.add_argument("--output", default="tmp/gsc_out.json", help="file JSON con il dettaglio")
    ap.add_argument("--days", type=int, default=90, help="finestra per le performance")
    args = ap.parse_args()

    creds = service_account.Credentials.from_service_account_file(KEY_FILE, scopes=SCOPES)
    service = build("searchconsole", "v1", credentials=creds, cache_discovery=False)

    end = datetime.date.today() - datetime.timedelta(days=2)  # i dati recenti non sono ancora consolidati
    start = end - datetime.timedelta(days=args.days)
    out = {"generated": datetime.datetime.now().isoformat(timespec="seconds")}

    out["sitemaps"] = service.sitemaps().list(siteUrl=SITE).execute()
    out["perf_pages"] = perf(service, "page", str(start), str(end))
    out["perf_queries"] = perf(service, "query", str(start), str(end), 50)

    sitemap = urllib.request.urlopen(SITEMAP_URL).read().decode()
    urls = re.findall(r"<loc>([^<]+)", sitemap)
    out["inspect"] = {}
    for url in urls:
        try:
            body = {"inspectionUrl": url, "siteUrl": SITE, "languageCode": "it"}
            out["inspect"][url] = service.urlInspection().index().inspect(body=body).execute()["inspectionResult"]
        except Exception as e:
            out["inspect"][url] = {"error": str(e)[:200]}
        time.sleep(0.2)

    os.makedirs(os.path.dirname(os.path.abspath(args.output)), exist_ok=True)
    with open(args.output, "w") as f:
        json.dump(out, f, indent=1)

    # Riepilogo
    states = collections.Counter()
    for res in out["inspect"].values():
        idx = res.get("indexStatusResult", {})
        states[idx.get("coverageState") or res.get("error", "errore")] += 1
    rows = out["perf_pages"].get("rows", [])
    print(f"URL in sitemap: {len(urls)}")
    for state, n in states.most_common():
        print(f"  {n:3d}  {state}")
    print(f"Performance {start} -> {end}: {sum(r['clicks'] for r in rows)} clic, "
          f"{sum(r['impressions'] for r in rows)} impressioni su {len(rows)} pagine")
    for sm in out["sitemaps"].get("sitemap", []):
        c = sm.get("contents", [{}])[0]
        print(f"Sitemap {sm['path']}: inviati {c.get('submitted')}, indicizzati {c.get('indexed')}, "
              f"errori {sm.get('errors')}")
    print(f"Dettaglio in {args.output}")


if __name__ == "__main__":
    main()
