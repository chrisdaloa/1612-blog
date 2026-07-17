# 1612.it — Team di agenti per articoli automatici

Pipeline full-auto, **due articoli a settimana**: uno scelto per qualità/rilevanza (come prima), uno scelto per potenziale di monetizzazione affiliata (guide/confronti che nominano naturalmente più prodotti). Stessa catena per entrambi: trend → selezione → scrittura → link affiliati Amazon → immagine → QA → publish (git push, autodeploy Hugo).

La scelta "affiliata" NON inserisce link diversi da quelli già nominati nel testo — cambia solo *quale argomento* viene scelto (preferendo guide/confronti a notizie pure), rispettando comunque una soglia minima di qualità editoriale (`affiliate_strategy.min_quality_score` in `sources.yaml`).

## Struttura

```
.claude/agents/       # i 7 subagent (trend-scout, selector, writer, affiliate-linker, image-creator, qa-gate, publisher)
CLAUDE.md              # istruzioni orchestrator: ordine di esecuzione e regole di blocco
sources.yaml            # topic monitorati, fonti seed, config affiliazione Amazon
scripts/run-pipeline.sh # wrapper per invocazione headless, da chiamare via n8n
```

## Setup

1. **Copia questa cartella dentro la repo del blog Hugo** (o clona la repo dentro questa struttura — l'importante è che `.claude/`, `CLAUDE.md` e `sources.yaml` stiano nella root della repo git, così Claude Code ha accesso diretto a `content/posts/` e `static/images/posts/`).

2. **Configura `sources.yaml`**:
   - Sostituisci `TUO-TAG-QUI-21` con il tuo tag associati Amazon reale.
   - Rivedi seed/topic se vuoi aggiustare le fonti.

3. **Permessi Claude Code**: crea `.claude/settings.json` nella repo con i permessi necessari (git, hugo, accesso a `pipeline/`, `content/`, `static/images/posts/`), così l'esecuzione headless (`claude -p`) non si blocca su richieste di conferma interattive.

4. **Script wrapper**: modifica `BLOG_REPO_PATH` in `scripts/run-pipeline.sh` (o passalo come env var).

5. **Generazione immagini (OpenRouter)**: l'agente `image-creator` usa `scripts/generate_cover.py`, che chiama l'Image API di OpenRouter (modello `google/gemini-2.5-flash-image`, ~$0.039/immagine) riusando la stessa `OPENROUTER_API_KEY` già in uso per il digest AI settimanale.
   ```bash
   pip install requests --break-system-packages   # probabilmente già presente
   ```
   Se `OPENROUTER_API_KEY` non è già esportata nell'ambiente dove gira `claude -p`, salvala in `~/.config/1612-blog/openrouter.env` (permessi 600) — lo script wrapper la carica da lì automaticamente, utile per l'esecuzione da cron.

## Integrazione n8n

- **Trigger**: nodo Cron (es. ogni domenica mattina, come il tuo digest AI).
- **Esecuzione**: nodo SSH (o Execute Command se n8n gira sulla stessa macchina) che lancia:
  ```bash
  bash /path/to/1612-blog-agents/scripts/run-pipeline.sh
  ```
- **Parsing esito**: lo script stampa un JSON su stdout con lo stato aggregato e il dettaglio di entrambi gli articoli:
  ```json
  {
    "status": "both_published",
    "cost_usd": 5.2,
    "content_article": {"status": "published", "slug": "...", "url": "..."},
    "affiliate_article": {"status": "published", "slug": "...", "url": "..."}
  }
  ```
  `status` aggregato può essere `both_published`, `one_published`, `none_published`. Usa un nodo Code/Set per estrarre `content_article` e `affiliate_article` separatamente.
- **Notifica**: nodo Telegram con un messaggio che riporta entrambi gli esiti, es. "Questa settimana: 2/2 pubblicati" oppure "1/2 pubblicati — l'articolo affiliato è bloccato al qa-gate, motivo: ...".

## Test manuale (prima di automatizzare)

Prima di collegare il cron, esegui a mano dentro la repo:

```bash
cd /path/to/1612-hugo-repo
claude -p "Esegui l'intera pipeline descritta in CLAUDE.md: fase 1 (trend-scout + selector), poi fase 2 in sequenza per pipeline/content e pipeline/affiliate." --output-format json
```

Controlla i file in `pipeline/content/` e `pipeline/affiliate/` dopo ogni run per verificare che ogni agente produca l'output atteso per ENTRAMBI gli articoli, prima di fidarti del full-auto.

## Tracking costi/consumo

`scripts/run-pipeline.sh` ora tiene uno storico persistente in `pipeline/logs/costs.csv` (una riga per ogni run: timestamp, costo stimato in USD, durata, numero di turni, esito). Utile anche con Claude Pro per capire quanto "varrebbe" l'utilizzo se fosse a consumo, e per accorgerti se ti stai avvicinando ai limiti di utilizzo del piano.

```bash
column -s, -t pipeline/logs/costs.csv | less
```

**Limite noto**: il costo in `costs.csv` copre solo l'esecuzione di Claude Code. Il costo delle immagini (~$0.039 x2 = ~$0.08/settimana, fatturato su OpenRouter) non è incluso in questo CSV — lo trovi nel log completo del run (`pipeline/logs/run-<timestamp>.json`) oppure direttamente nella dashboard di OpenRouter.

**Nota**: con due articoli a settimana il costo di Claude Code circa raddoppia rispetto alla versione a singolo articolo (atteso: ~$5-6/settimana invece di ~$2.8, in base ai test fatti finora). Tienilo d'occhio nelle prime settimane con `costs.csv`.

Questo file non è tracciato in git (`pipeline/logs/` è in `.gitignore`), resta solo in locale sulla macchina che esegue la pipeline.

## Note importanti

- **Full-auto = qa-gate critico**: essendo pubblicazione senza revisione umana, il `qa-gate` è l'unica rete di sicurezza. Non rimuoverlo e non allentarne i controlli senza motivo.
- **Link affiliati**: l'agente linka SOLO prodotti già nominati nel testo dal writer, mai suggerimenti aggiuntivi. La disclosure è inserita automaticamente ed è obbligatoria per legge (AGCM) quando sono presenti link Amazon.
- **Amazon PA-API**: questa pipeline NON usa la PA-API (che richiede storico vendite minimo), ma costruisce i link via ricerca web + estrazione ASIN dall'URL. Meno dati (niente prezzo live), ma nessun requisito di accesso.
