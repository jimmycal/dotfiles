#!/usr/bin/env bash
# Pre-compact snapshot: saves recent-memory.md before context compaction
# so the nightly consolidation can recover context that gets compressed away.

set -euo pipefail

INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')

if [[ -z "$CWD" ]]; then
  exit 0
fi

# Derive the project memory path from cwd
PROJECT_KEY=$(echo "$CWD" | sed 's|/|-|g')
MEMORY_DIR="$HOME/.claude/projects/${PROJECT_KEY}/memory"
SNAPSHOTS_DIR="${MEMORY_DIR}/.snapshots"
RECENT="${MEMORY_DIR}/recent-memory.md"

if [[ ! -f "$RECENT" ]]; then
  exit 0
fi

mkdir -p "$SNAPSHOTS_DIR"

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
cp "$RECENT" "${SNAPSHOTS_DIR}/pre-compact-${TIMESTAMP}.md"

# Clean snapshots older than 7 days
find "$SNAPSHOTS_DIR" -name "pre-compact-*.md" -mtime +7 -delete 2>/dev/null || true
