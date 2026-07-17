# 1612.it — Pipeline automatica articoli

Questo progetto orchestra un team di subagent per: trovare trend, scrivere un articolo nello stile di Christian, inserire link affiliati Amazon (solo su prodotti già nominati), generare la copertina, validare, e pubblicare via git push sulla repo Hugo del blog 1612.it.

## Come eseguire la pipeline (in ordine, sempre in questa sequenza)

1. `trend-scout` → produce `pipeline/candidates.json`
2. `selector` → produce `pipeline/selected-topic.json`
   - Se `topic` è `null`, FERMA la pipeline. Non c'è nulla di adatto da pubblicare oggi.
3. `writer` → produce `pipeline/draft.md`
4. `affiliate-linker` → aggiorna `pipeline/draft.md` + `pipeline/affiliate-log.json`
5. `image-creator` → aggiorna `pipeline/draft.md` (campo cover.image) + salva immagine
6. `qa-gate` → produce `pipeline/qa-result.json`
   - Se `passed` è `false`, FERMA la pipeline. Non chiamare `publisher`.
7. `publisher` → pubblica (git commit + push) e produce `pipeline/publish-log.json`

## Regole generali per tutti gli step

- Lavora sempre dentro la cartella `pipeline/` per i file intermedi (creala se non esiste); non sporcare `content/posts/` finché non è il `publisher` a farlo.
- Ogni agente legge solo l'output dello step precedente + `sources.yaml`, non improvvisare struttura dati diversa da quella documentata nel proprio file agent.
- La pipeline è FULL AUTO (nessuna revisione umana prima del push): per questo il `qa-gate` è un passaggio bloccante obbligatorio, mai da saltare.
- Se un qualunque step fallisce in modo imprevisto (errore non gestito), fermati e scrivi lo stato in `pipeline/pipeline-error.log` invece di procedere con dati parziali.

## Fine pipeline

Al termine (successo, blocco per qa-gate, o nessun topic adatto), lo script wrapper (`scripts/run-pipeline.sh`) leggerà `pipeline/publish-log.json` o `pipeline/selected-topic.json` per determinare l'esito e passarlo a n8n per la notifica Telegram.
