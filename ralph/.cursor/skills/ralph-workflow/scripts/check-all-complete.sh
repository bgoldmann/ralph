#!/usr/bin/env bash
# Exit 0 if all stories have passes=true, else 1.
# Run from project root.

set -e
ROOT="${PROJECT_ROOT:-.}"
PRD_FILE="$ROOT/prd.json"

if [ ! -f "$PRD_FILE" ]; then
  echo "Error: prd.json not found" >&2
  exit 2
fi

INCOMPLETE=$(jq '[.userStories[] | select(.passes == false)] | length' "$PRD_FILE" 2>/dev/null || echo "1")
if [ "$INCOMPLETE" = "0" ]; then
  echo "All stories complete"
  exit 0
else
  echo "$INCOMPLETE story/stories remaining"
  exit 1
fi
