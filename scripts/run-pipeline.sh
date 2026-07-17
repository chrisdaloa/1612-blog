#!/usr/bin/env bash
# run-pipeline.sh
# Invocato da n8n (via SSH node o Execute Command) secondo cron settimanale.
# Lancia Claude Code in modalità headless dentro la repo del blog Hugo,
# esegue l'intera pipeline (2 articoli: content + affiliate) definita in
# CLAUDE.md, e stampa un JSON di esito su stdout così n8n può parsarlo
# per la notifica Telegram.

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
mkdir -p "$BLOG_REPO_PATH/pipeline/content" "$BLOG_REPO_PATH/pipeline/affiliate"
COST_LOG="$LOG_DIR/costs.csv"
if [ ! -f "$COST_LOG" ]; then
  echo "timestamp,total_cost_usd,duration_ms,num_turns,status" > "$COST_LOG"
fi

cd "$BLOG_REPO_PATH"

# --- Esecuzione headless ---
# --output-format json restituisce un JSON strutturato con l'esito della sessione
# Le regole di permesso vanno configurate in .claude/settings.json della repo
# (consigliato: permettere Bash git/hugo, WebSearch, WebFetch, Read/Write in pipeline/ e content/)
claude -p "Esegui l'intera pipeline descritta in CLAUDE.md: fase 1 (trend-scout + selector, una sola volta), poi fase 2 in sequenza per pipeline/content e poi per pipeline/affiliate (writer, affiliate-linker, image-creator, qa-gate, publisher), rispettando tutte le regole di blocco per-articolo (topic null, qa-gate fallito non deve bloccare l'altro articolo)." \
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

# --- Determina esito per ciascun articolo ---
describe_article() {
  local dir="$1"
  if [ -f "$dir/publish-log.json" ]; then
    if grep -q '"published": *true' "$dir/publish-log.json"; then
      local slug url
      slug=$(grep -o '"slug": *"[^"]*"' "$dir/publish-log.json" | cut -d'"' -f4)
      url=$(grep -o '"url": *"[^"]*"' "$dir/publish-log.json" | cut -d'"' -f4)
      echo "{\"status\":\"published\",\"slug\":\"$slug\",\"url\":\"$url\"}"
    else
      echo "{\"status\":\"blocked\",\"reason\":\"see $dir/publish-log.json\"}"
    fi
  elif [ -f "$dir/qa-result.json" ]; then
    echo "{\"status\":\"blocked_at_qa\",\"detail_file\":\"$dir/qa-result.json\"}"
  elif [ -f "$dir/selected-topic.json" ]; then
    echo "{\"status\":\"no_topic_selected\",\"detail_file\":\"$dir/selected-topic.json\"}"
  else
    echo "{\"status\":\"unknown\"}"
  fi
}

CONTENT_RESULT=$(describe_article "pipeline/content")
AFFILIATE_RESULT=$(describe_article "pipeline/affiliate")

# Stato aggregato per il CSV: "published" se almeno uno è pubblicato, altrimenti il peggiore dei due
OVERALL_STATUS="mixed"
if echo "$CONTENT_RESULT" | grep -q '"published"' && echo "$AFFILIATE_RESULT" | grep -q '"published"'; then
  OVERALL_STATUS="both_published"
elif echo "$CONTENT_RESULT" | grep -q '"published"' || echo "$AFFILIATE_RESULT" | grep -q '"published"'; then
  OVERALL_STATUS="one_published"
else
  OVERALL_STATUS="none_published"
fi

echo "$TIMESTAMP,$TOTAL_COST,$DURATION_MS,$NUM_TURNS,\"$OVERALL_STATUS\"" >> "$COST_LOG"

echo "{\"status\":\"$OVERALL_STATUS\",\"cost_usd\":$TOTAL_COST,\"content_article\":$CONTENT_RESULT,\"affiliate_article\":$AFFILIATE_RESULT}"
exit 0
