#!/usr/bin/env bash
# Generate .cursor/composer-prompt.md from template and next story.
# Run from project root. Reads story from stdin or calls get-next-story.sh.
# Requires: jq

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="${PROJECT_ROOT:-.}"
PRD_FILE="$ROOT/prd.json"
PROGRESS_FILE="$ROOT/progress.txt"
CURSOR_DIR="$ROOT/.cursor"
COMPOSER_PROMPT="$CURSOR_DIR/composer-prompt.md"
COMPOSER_TEMPLATE="$ROOT/.cursor/composer-prompt-template.md"

if [ ! -f "$PRD_FILE" ]; then
  echo "Error: prd.json not found" >&2
  exit 2
fi
if [ ! -f "$COMPOSER_TEMPLATE" ]; then
  echo "Error: .cursor/composer-prompt-template.md not found" >&2
  exit 2
fi

# Get story: from stdin if piped with data, else run get-next-story
export PROJECT_ROOT="$ROOT"
if [ ! -t 0 ]; then
  STORY=$(cat)
fi
if [ -z "$STORY" ] || [ "$STORY" = "null" ]; then
  STORY=$(bash "$SCRIPT_DIR/get-next-story.sh")
fi

if [ -z "$STORY" ] || [ "$STORY" = "null" ]; then
  echo "No incomplete story to generate prompt for" >&2
  exit 1
fi

STORY_ID=$(echo "$STORY" | jq -r '.id')
STORY_TITLE=$(echo "$STORY" | jq -r '.title')
STORY_PRIORITY=$(echo "$STORY" | jq -r '.priority')
STORY_DESC=$(echo "$STORY" | jq -r '.description')
CRITERIA_FILE=$(mktemp)
trap "rm -f $CRITERIA_FILE" EXIT
echo "$STORY" | jq -r '.acceptanceCriteria[] | "- " + .' > "$CRITERIA_FILE"

PROJECT_NAME=$(jq -r '.project' "$PRD_FILE")
BRANCH_NAME=$(jq -r '.branchName' "$PRD_FILE")
FEATURE_DESC=$(jq -r '.description' "$PRD_FILE")

mkdir -p "$CURSOR_DIR"

# Replace placeholders; use awk for multiline acceptance criteria
awk -v id="$STORY_ID" -v title="$STORY_TITLE" -v pri="$STORY_PRIORITY" \
    -v desc="$STORY_DESC" -v proj="$PROJECT_NAME" -v branch="$BRANCH_NAME" \
    -v feat="$FEATURE_DESC" -v critfile="$CRITERIA_FILE" \
    '
    /\[ACCEPTANCE_CRITERIA_LIST\]/ {
      while ((getline line < critfile) > 0) print line
      close(critfile)
      next
    }
    {
      gsub(/\[STORY_ID\]/, id); gsub(/\[STORY_TITLE\]/, title)
      gsub(/\[STORY_PRIORITY\]/, pri); gsub(/\[STORY_DESCRIPTION\]/, desc)
      gsub(/\[PROJECT_NAME\]/, proj); gsub(/\[BRANCH_NAME\]/, branch)
      gsub(/\[FEATURE_DESCRIPTION\]/, feat)
      print
    }
    ' "$COMPOSER_TEMPLATE" > "$COMPOSER_PROMPT"

echo "Generated: $COMPOSER_PROMPT"
echo "Story: $STORY_ID - $STORY_TITLE"
