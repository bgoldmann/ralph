#!/usr/bin/env bash
# Output next incomplete story as JSON (sorted by priority).
# Run from project root. Exit 1 if none or error.

set -e
ROOT="${PROJECT_ROOT:-.}"
PRD_FILE="$ROOT/prd.json"

if [ ! -f "$PRD_FILE" ]; then
  echo "Error: prd.json not found" >&2
  exit 2
fi

STORY=$(jq -c '[.userStories[] | select(.passes == false)] | sort_by(.priority) | .[0]' "$PRD_FILE" 2>/dev/null || true)
if [ -z "$STORY" ] || [ "$STORY" = "null" ]; then
  echo "No incomplete stories" >&2
  exit 1
fi
echo "$STORY"
