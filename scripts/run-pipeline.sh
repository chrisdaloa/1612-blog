#!/usr/bin/env bash
# run-pipeline.sh
# Invocato da n8n (via SSH node o Execute Command) secondo cron settimanale.
# Lancia Claude Code in modalità headless dentro la repo del blog Hugo,
# esegue l'intera pipeline definita in CLAUDE.md, e stampa un JSON di esito
# su stdout così n8n può parsarlo per la notifica Telegram.

set -euo pipefail

# --- Config: adatta questi path al tuo homelab ---
BLOG_REPO_PATH="${BLOG_REPO_PATH:-/path/to/1612-hugo-repo}"
LOG_DIR="${LOG_DIR:-$BLOG_REPO_PATH/pipeline/logs}"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

# OPENROUTER_API_KEY: cron non carica sempre ~/.bashrc, quindi se non è già
# nell'ambiente la carichiamo esplicitamente da un file dedicato,
# NON tracciato in git (vedi .gitignore). È la stessa chiave già usata
# per il digest AI settimanale — se è già esportata altrove va bene lo stesso.
if [ -z "${OPENROUTER_API_KEY:-}" ] && [ -f "$HOME/.config/1612-blog/openrouter.env" ]; then
  export OPENROUTER_API_KEY
  OPENROUTER_API_KEY="$(cat "$HOME/.config/1612-blog/openrouter.env")"
fi

mkdir -p "$LOG_DIR"
mkdir -p "$BLOG_REPO_PATH/pipeline"
COST_LOG="$LOG_DIR/costs.csv"
if [ ! -f "$COST_LOG" ]; then
  echo "timestamp,total_cost_usd,duration_ms,num_turns,status" > "$COST_LOG"
fi

cd "$BLOG_REPO_PATH"

# --- Esecuzione headless ---
# --output-format json restituisce un JSON strutturato con l'esito della sessione
# Le regole di permesso vanno configurate in .claude/settings.json della repo
# (consigliato: permettere Bash git/hugo, WebSearch, WebFetch, Read/Write in pipeline/ e content/)
claude -p "Esegui l'intera pipeline descritta in CLAUDE.md, in ordine, rispettando tutte le regole di blocco (selector con topic null, qa-gate fallito)." \
  --output-format json \
  > "$LOG_DIR/run-$TIMESTAMP.json" 2>&1 || {
    echo "$TIMESTAMP,,,,\"invocation_error\"" >> "$COST_LOG"
    echo "{\"status\":\"error\",\"message\":\"claude code invocation failed\",\"log\":\"$LOG_DIR/run-$TIMESTAMP.json\"}"
    exit 1
  }

# --- Estrai costo e metadati per lo storico ---
RUN_JSON="$LOG_DIR/run-$TIMESTAMP.json"
TOTAL_COST=$(grep -o '"total_cost_usd":[0-9.]*' "$RUN_JSON" | cut -d':' -f2 || echo "")
DURATION_MS=$(grep -o '"duration_ms":[0-9]*' "$RUN_JSON" | head -1 | cut -d':' -f2 || echo "")
NUM_TURNS=$(grep -o '"num_turns":[0-9]*' "$RUN_JSON" | cut -d':' -f2 || echo "")

# --- Determina esito per n8n ---
if [ -f "pipeline/publish-log.json" ]; then
  PUBLISHED=$(grep -o '"published": *true' pipeline/publish-log.json || true)
  if [ -n "$PUBLISHED" ]; then
    SLUG=$(grep -o '"slug": *"[^"]*"' pipeline/publish-log.json | cut -d'"' -f4)
    URL=$(grep -o '"url": *"[^"]*"' pipeline/publish-log.json | cut -d'"' -f4)
    echo "$TIMESTAMP,$TOTAL_COST,$DURATION_MS,$NUM_TURNS,\"published\"" >> "$COST_LOG"
    echo "{\"status\":\"published\",\"slug\":\"$SLUG\",\"url\":\"$URL\",\"cost_usd\":$TOTAL_COST}"
    exit 0
  else
    echo "$TIMESTAMP,$TOTAL_COST,$DURATION_MS,$NUM_TURNS,\"blocked\"" >> "$COST_LOG"
    echo "{\"status\":\"blocked\",\"reason\":\"see pipeline/publish-log.json\",\"cost_usd\":$TOTAL_COST}"
    exit 0
  fi
elif [ -f "pipeline/qa-result.json" ]; then
  echo "$TIMESTAMP,$TOTAL_COST,$DURATION_MS,$NUM_TURNS,\"blocked_at_qa\"" >> "$COST_LOG"
  echo "{\"status\":\"blocked_at_qa\",\"detail_file\":\"pipeline/qa-result.json\",\"cost_usd\":$TOTAL_COST}"
  exit 0
elif [ -f "pipeline/selected-topic.json" ]; then
  echo "$TIMESTAMP,$TOTAL_COST,$DURATION_MS,$NUM_TURNS,\"no_topic_selected\"" >> "$COST_LOG"
  echo "{\"status\":\"no_topic_selected\",\"detail_file\":\"pipeline/selected-topic.json\",\"cost_usd\":$TOTAL_COST}"
  exit 0
else
  echo "$TIMESTAMP,$TOTAL_COST,$DURATION_MS,$NUM_TURNS,\"unknown\"" >> "$COST_LOG"
  echo "{\"status\":\"unknown\",\"log\":\"$LOG_DIR/run-$TIMESTAMP.json\",\"cost_usd\":$TOTAL_COST}"
  exit 0
fi
