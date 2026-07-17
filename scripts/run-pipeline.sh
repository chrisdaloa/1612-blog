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

mkdir -p "$LOG_DIR"
mkdir -p "$BLOG_REPO_PATH/pipeline"

cd "$BLOG_REPO_PATH"

# --- Esecuzione headless ---
# --output-format json restituisce un JSON strutturato con l'esito della sessione
# Le regole di permesso vanno configurate in .claude/settings.json della repo
# (consigliato: permettere Bash git/hugo, WebSearch, WebFetch, Read/Write in pipeline/ e content/)
claude -p "Esegui l'intera pipeline descritta in CLAUDE.md, in ordine, rispettando tutte le regole di blocco (selector con topic null, qa-gate fallito)." \
  --output-format json \
  > "$LOG_DIR/run-$TIMESTAMP.json" 2>&1 || {
    echo "{\"status\":\"error\",\"message\":\"claude code invocation failed\",\"log\":\"$LOG_DIR/run-$TIMESTAMP.json\"}"
    exit 1
  }

# --- Determina esito per n8n ---
if [ -f "pipeline/publish-log.json" ]; then
  PUBLISHED=$(grep -o '"published": *true' pipeline/publish-log.json || true)
  if [ -n "$PUBLISHED" ]; then
    SLUG=$(grep -o '"slug": *"[^"]*"' pipeline/publish-log.json | cut -d'"' -f4)
    URL=$(grep -o '"url": *"[^"]*"' pipeline/publish-log.json | cut -d'"' -f4)
    echo "{\"status\":\"published\",\"slug\":\"$SLUG\",\"url\":\"$URL\"}"
    exit 0
  else
    echo "{\"status\":\"blocked\",\"reason\":\"see pipeline/publish-log.json\"}"
    exit 0
  fi
elif [ -f "pipeline/qa-result.json" ]; then
  echo "{\"status\":\"blocked_at_qa\",\"detail_file\":\"pipeline/qa-result.json\"}"
  exit 0
elif [ -f "pipeline/selected-topic.json" ]; then
  echo "{\"status\":\"no_topic_selected\",\"detail_file\":\"pipeline/selected-topic.json\"}"
  exit 0
else
  echo "{\"status\":\"unknown\",\"log\":\"$LOG_DIR/run-$TIMESTAMP.json\"}"
  exit 0
fi
