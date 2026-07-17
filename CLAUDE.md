# 1612.it — Pipeline automatica articoli (doppia pubblicazione settimanale)

Questo progetto orchestra un team di subagent per: trovare trend, scrivere DUE articoli a settimana nello stile di Christian (uno scelto per qualità/rilevanza, uno scelto per potenziale di monetizzazione affiliata), inserire link affiliati Amazon (solo su prodotti già nominati), generare le copertine, validare, e pubblicare via git push sulla repo Hugo del blog 1612.it.

## Struttura cartelle pipeline

```
pipeline/
├── candidates.json          # condiviso, generato una sola volta da trend-scout
├── content/                 # articolo scelto per qualità (comportamento storico)
│   ├── selected-topic.json
│   ├── draft.md
│   ├── affiliate-log.json
│   ├── qa-result.json
│   └── publish-log.json
└── affiliate/                # articolo scelto per potenziale affiliato
    ├── selected-topic.json
    ├── draft.md
    ├── affiliate-log.json
    ├── qa-result.json
    └── publish-log.json
```

## Come eseguire la pipeline (in ordine, sempre in questa sequenza)

### Fase 1 — Ricerca e selezione (una sola volta, condivisa)

1. `trend-scout` → produce `pipeline/candidates.json` (candidati sia "news" che "evergreen_guide", ognuno con `score` e `product_potential`)
2. `selector` → produce DUE file:
   - `pipeline/content/selected-topic.json` (pick per qualità)
   - `pipeline/affiliate/selected-topic.json` (pick per potenziale affiliato, con soglia minima di qualità)
   - Se uno dei due ha `topic: null`, prosegui comunque con l'altro — sono indipendenti.

### Fase 2 — Produzione articolo (esegui in sequenza per ARTICLE_DIR = `pipeline/content`, POI per ARTICLE_DIR = `pipeline/affiliate`)

Per ciascun ARTICLE_DIR, SE il relativo `selected-topic.json` ha un `topic` non null:

3. `writer` (con ARTICLE_DIR indicato esplicitamente nell'istruzione) → produce `{ARTICLE_DIR}/draft.md`
4. `affiliate-linker` (stesso ARTICLE_DIR) → aggiorna `{ARTICLE_DIR}/draft.md` + `{ARTICLE_DIR}/affiliate-log.json`
5. `image-creator` (stesso ARTICLE_DIR) → aggiorna `{ARTICLE_DIR}/draft.md` (cover.image) + salva immagine in `static/images/posts/`
6. `qa-gate` (stesso ARTICLE_DIR) → produce `{ARTICLE_DIR}/qa-result.json`
   - Se `passed: false`, FERMATI per QUESTO ARTICLE_DIR (non chiamare `publisher` per questo), ma continua comunque con l'altro ARTICLE_DIR se non ancora processato.
7. `publisher` (stesso ARTICLE_DIR) → pubblica (git commit + push) e produce `{ARTICLE_DIR}/publish-log.json`

**Importante**: esegui la Fase 2 SEMPRE in sequenza (prima tutto `pipeline/content`, poi tutto `pipeline/affiliate`), mai in parallelo — evita conflitti su git commit/push e sullo slug.

## Regole generali per tutti gli step

- Lavora sempre dentro `pipeline/` (o la sua sottocartella ARTICLE_DIR) per i file intermedi; non sporcare `content/posts/` finché non è il `publisher` a farlo.
- Ogni agente legge solo l'output dello step precedente nello stesso ARTICLE_DIR + `sources.yaml`, non improvvisare struttura dati diversa da quella documentata nel proprio file agent.
- La pipeline è FULL AUTO (nessuna revisione umana prima del push): per questo il `qa-gate` è un passaggio bloccante obbligatorio per ENTRAMBI gli articoli, mai da saltare.
- Un fallimento (topic null, qa-gate fallito) su un ARTICLE_DIR non deve mai bloccare l'altro ARTICLE_DIR.
- Se un qualunque step fallisce in modo imprevisto (errore non gestito), fermati per quell'ARTICLE_DIR e scrivi lo stato in `{ARTICLE_DIR}/pipeline-error.log` invece di procedere con dati parziali, ma prova comunque a completare l'altro ARTICLE_DIR.

## Fine pipeline

Al termine, lo script wrapper (`scripts/run-pipeline.sh`) leggerà `pipeline/content/publish-log.json` e `pipeline/affiliate/publish-log.json` (o i rispettivi `selected-topic.json`/`qa-result.json` se bloccati) per determinare l'esito di ENTRAMBI gli articoli e passarli a n8n per la notifica Telegram.
