#!/usr/bin/env bash
# Session end logger: captures daily learning log and updates session-context.json
# Runs on SessionEnd to feed the nightly consolidation pipeline.

set -euo pipefail

INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"')
TRANSCRIPT=$(echo "$INPUT" | jq -r '.transcript_path // empty')

if [[ -z "$CWD" ]]; then
  exit 0
fi

TODAY=$(date +%Y-%m-%d)
NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
LEARNINGS_DIR="$HOME/.claude/learnings"
LEARNINGS_FILE="${LEARNINGS_DIR}/${TODAY}.json"

mkdir -p "$LEARNINGS_DIR"

# Gather git context from the working directory
RECENT_COMMITS=""
UNCOMMITTED=""
if [[ -d "${CWD}/.git" ]]; then
  RECENT_COMMITS=$(cd "$CWD" && git log --oneline -5 2>/dev/null | head -5) || true
  UNCOMMITTED=$(cd "$CWD" && git diff --stat HEAD 2>/dev/null | tail -1) || true
fi

# Build learning entry
ENTRY=$(jq -n \
  --arg sid "$SESSION_ID" \
  --arg cwd "$CWD" \
  --arg ts "$NOW" \
  --arg commits "$RECENT_COMMITS" \
  --arg uncommitted "$UNCOMMITTED" \
  --arg transcript "$TRANSCRIPT" \
  '{
    session_id: $sid,
    project_path: $cwd,
    timestamp: $ts,
    recent_commits: ($commits | split("\n") | map(select(. != ""))),
    uncommitted_changes: $uncommitted,
    transcript_path: $transcript
  }')

# Append to today's learning log (one JSON object per line)
echo "$ENTRY" >> "$LEARNINGS_FILE"

# Update session-context.json
SESSION_CTX="$HOME/.claude/session-context.json"

# Read existing or start fresh
if [[ -f "$SESSION_CTX" ]]; then
  EXISTING=$(cat "$SESSION_CTX")
else
  EXISTING='{}'
fi

# Derive project key
PROJECT_KEY=$(echo "$CWD" | sed 's|/|-|g')

# Merge this session's info into the context file
UPDATED=$(echo "$EXISTING" | jq \
  --arg key "$PROJECT_KEY" \
  --arg cwd "$CWD" \
  --arg ts "$NOW" \
  --arg sid "$SESSION_ID" \
  '.[$key] = {
    project_path: $cwd,
    last_session_id: $sid,
    last_active: $ts
  }')

echo "$UPDATED" > "$SESSION_CTX"

# Clean learning logs older than 7 days
find "$LEARNINGS_DIR" -name "*.json" -mtime +7 -delete 2>/dev/null || true
