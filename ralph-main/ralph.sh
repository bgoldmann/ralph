#!/bin/bash
# Ralph Wiggum - Long-running AI agent loop for Cursor IDE
# Usage: ./ralph.sh [max_iterations]

set -e

MAX_ITERATIONS=${1:-10}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRD_FILE="$SCRIPT_DIR/prd.json"
PROGRESS_FILE="$SCRIPT_DIR/progress.txt"
ARCHIVE_DIR="$SCRIPT_DIR/archive"
LAST_BRANCH_FILE="$SCRIPT_DIR/.last-branch"
CURSOR_DIR="$SCRIPT_DIR/.cursor"
COMPOSER_PROMPT_FILE="$CURSOR_DIR/composer-prompt.md"
COMPOSER_TEMPLATE="$CURSOR_DIR/composer-prompt-template.md"

# Archive previous run if branch changed
if [ -f "$PRD_FILE" ] && [ -f "$LAST_BRANCH_FILE" ]; then
  CURRENT_BRANCH=$(jq -r '.branchName // empty' "$PRD_FILE" 2>/dev/null || echo "")
  LAST_BRANCH=$(cat "$LAST_BRANCH_FILE" 2>/dev/null || echo "")
  
  if [ -n "$CURRENT_BRANCH" ] && [ -n "$LAST_BRANCH" ] && [ "$CURRENT_BRANCH" != "$LAST_BRANCH" ]; then
    # Archive the previous run
    DATE=$(date +%Y-%m-%d)
    # Strip "ralph/" prefix from branch name for folder
    FOLDER_NAME=$(echo "$LAST_BRANCH" | sed 's|^ralph/||')
    ARCHIVE_FOLDER="$ARCHIVE_DIR/$DATE-$FOLDER_NAME"
    
    echo "Archiving previous run: $LAST_BRANCH"
    mkdir -p "$ARCHIVE_FOLDER"
    [ -f "$PRD_FILE" ] && cp "$PRD_FILE" "$ARCHIVE_FOLDER/"
    [ -f "$PROGRESS_FILE" ] && cp "$PROGRESS_FILE" "$ARCHIVE_FOLDER/"
    echo "   Archived to: $ARCHIVE_FOLDER"
    
    # Reset progress file for new run
    echo "# Ralph Progress Log" > "$PROGRESS_FILE"
    echo "Started: $(date)" >> "$PROGRESS_FILE"
    echo "---" >> "$PROGRESS_FILE"
  fi
fi

# Track current branch
if [ -f "$PRD_FILE" ]; then
  CURRENT_BRANCH=$(jq -r '.branchName // empty' "$PRD_FILE" 2>/dev/null || echo "")
  if [ -n "$CURRENT_BRANCH" ]; then
    echo "$CURRENT_BRANCH" > "$LAST_BRANCH_FILE"
  fi
fi

# Initialize progress file if it doesn't exist
if [ ! -f "$PROGRESS_FILE" ]; then
  echo "# Ralph Progress Log" > "$PROGRESS_FILE"
  echo "Started: $(date)" >> "$PROGRESS_FILE"
  echo "---" >> "$PROGRESS_FILE"
fi

# Ensure .cursor directory exists
mkdir -p "$CURSOR_DIR"

# Check if prd.json exists
if [ ! -f "$PRD_FILE" ]; then
  echo "Error: prd.json not found in $SCRIPT_DIR"
  echo "Please create a PRD first. See README.md for instructions."
  exit 1
fi

# Check if composer template exists
if [ ! -f "$COMPOSER_TEMPLATE" ]; then
  echo "Error: Composer template not found: $COMPOSER_TEMPLATE"
  echo "Please ensure .cursor/composer-prompt-template.md exists."
  exit 1
fi

# Function to check if all stories are complete
check_all_complete() {
  local incomplete=$(jq '[.userStories[] | select(.passes == false)] | length' "$PRD_FILE" 2>/dev/null || echo "1")
  if [ "$incomplete" = "0" ]; then
    return 0
  else
    return 1
  fi
}

# Function to get next story
get_next_story() {
  jq -c '.userStories[] | select(.passes == false) | sort_by(.priority) | .[0]' "$PRD_FILE" 2>/dev/null
}

# Function to generate composer prompt
generate_composer_prompt() {
  local story_id=$(echo "$1" | jq -r '.id')
  local story_title=$(echo "$1" | jq -r '.title')
  local story_priority=$(echo "$1" | jq -r '.priority')
  local story_description=$(echo "$1" | jq -r '.description')
  local acceptance_criteria=$(echo "$1" | jq -r '.acceptanceCriteria[] | "- " + .' | sed 's/"/\\"/g')
  local project_name=$(jq -r '.project' "$PRD_FILE")
  local branch_name=$(jq -r '.branchName' "$PRD_FILE")
  local feature_desc=$(jq -r '.description' "$PRD_FILE")
  
  # Build acceptance criteria list
  local criteria_list=""
  while IFS= read -r criterion; do
    if [ -n "$criteria_list" ]; then
      criteria_list="${criteria_list}"$'\n'
    fi
    criteria_list="${criteria_list}${criterion}"
  done <<< "$acceptance_criteria"
  
  # Read template and replace placeholders
  sed \
    -e "s|\[STORY_ID\]|${story_id}|g" \
    -e "s|\[STORY_TITLE\]|${story_title}|g" \
    -e "s|\[STORY_PRIORITY\]|${story_priority}|g" \
    -e "s|\[STORY_DESCRIPTION\]|${story_description}|g" \
    -e "s|\[ACCEPTANCE_CRITERIA_LIST\]|${criteria_list}|g" \
    -e "s|\[PROJECT_NAME\]|${project_name}|g" \
    -e "s|\[BRANCH_NAME\]|${branch_name}|g" \
    -e "s|\[FEATURE_DESCRIPTION\]|${feature_desc}|g" \
    "$COMPOSER_TEMPLATE" > "$COMPOSER_PROMPT_FILE"
}

echo "Starting Ralph - Max iterations: $MAX_ITERATIONS"
echo ""

# Check if all stories are already complete
if check_all_complete; then
  echo "All stories are already complete!"
  exit 0
fi

for i in $(seq 1 $MAX_ITERATIONS); do
  echo ""
  echo "═══════════════════════════════════════════════════════"
  echo "  Ralph Iteration $i of $MAX_ITERATIONS"
  echo "═══════════════════════════════════════════════════════"
  echo ""
  
  # Check if all stories are complete before starting iteration
  if check_all_complete; then
    echo "All stories are complete!"
    echo "Completed at iteration $i of $MAX_ITERATIONS"
    exit 0
  fi
  
  # Get next story
  NEXT_STORY=$(get_next_story)
  if [ -z "$NEXT_STORY" ] || [ "$NEXT_STORY" = "null" ]; then
    echo "No incomplete stories found!"
    exit 0
  fi
  
  STORY_ID=$(echo "$NEXT_STORY" | jq -r '.id')
  STORY_TITLE=$(echo "$NEXT_STORY" | jq -r '.title')
  
  echo "Next story: $STORY_ID - $STORY_TITLE"
  echo ""
  
  # Generate composer prompt
  generate_composer_prompt "$NEXT_STORY"
  
  echo "Composer prompt generated: $COMPOSER_PROMPT_FILE"
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "INSTRUCTIONS:"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  echo "1. Open Cursor Composer (Ctrl+I or Cmd+I)"
  echo "2. Open the generated prompt: $COMPOSER_PROMPT_FILE"
  echo "3. Copy the prompt content or reference it in Composer"
  echo "4. Cursor will implement the story guided by .cursorrules"
  echo "5. After implementation:"
  echo "   - Run quality checks (typecheck, tests, lint)"
  echo "   - Commit changes: git commit -m 'feat: $STORY_ID - $STORY_TITLE'"
  echo "   - Update prd.json: Set passes: true for $STORY_ID"
  echo "   - Update progress.txt: Add your learnings"
  echo ""
  echo "6. Press ENTER when story is complete, or Ctrl+C to exit"
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  
  # Wait for user to complete the story
  read -p "Press ENTER after completing the story... " || true
  echo ""
  
  # Check completion status
  if check_all_complete; then
    echo ""
    echo "Ralph completed all tasks!"
    echo "Completed at iteration $i of $MAX_ITERATIONS"
    exit 0
  fi
  
  echo "Continuing to next story..."
  sleep 1
done

echo ""
echo "Ralph reached max iterations ($MAX_ITERATIONS) without completing all tasks."
echo "Check $PROGRESS_FILE for status."
echo ""
echo "To continue, run: ./ralph.sh [remaining_iterations]"
exit 1
