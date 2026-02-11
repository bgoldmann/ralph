#!/usr/bin/env bash
# Set passes=true for a story in prd.json.
# Usage: mark-story-complete.sh <STORY_ID>
# Run from project root.

set -e
ROOT="${PROJECT_ROOT:-.}"
PRD_FILE="$ROOT/prd.json"

if [ $# -lt 1 ]; then
  echo "Usage: mark-story-complete.sh <STORY_ID>" >&2
  exit 2
fi
STORY_ID="$1"

if [ ! -f "$PRD_FILE" ]; then
  echo "Error: prd.json not found" >&2
  exit 2
fi

jq '(.userStories[] | select(.id == "'"$STORY_ID"'") | .passes) = true' "$PRD_FILE" > "$PRD_FILE.tmp"
mv "$PRD_FILE.tmp" "$PRD_FILE"
echo "Marked $STORY_ID complete"
