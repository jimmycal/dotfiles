#!/usr/bin/env bash
# Compact logger: records compaction events to compact-log.json
# Runs on PreCompact alongside the snapshot hook.

set -euo pipefail

INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"')

if [[ -z "$CWD" ]]; then
  exit 0
fi

NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
COMPACT_LOG="$HOME/.claude/compact-log.json"

# Read existing or start fresh
if [[ -f "$COMPACT_LOG" ]]; then
  EXISTING=$(cat "$COMPACT_LOG")
else
  EXISTING='[]'
fi

# Append compaction event
UPDATED=$(echo "$EXISTING" | jq \
  --arg ts "$NOW" \
  --arg cwd "$CWD" \
  --arg sid "$SESSION_ID" \
  '. + [{
    timestamp: $ts,
    project_path: $cwd,
    session_id: $sid
  }] | .[-50:]')

echo "$UPDATED" > "$COMPACT_LOG"
