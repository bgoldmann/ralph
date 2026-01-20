#!/bin/bash
# Generate PRD from project-config.json
# Usage: ./generate-prd-from-config.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/project-config.json"
PRD_FILE="$SCRIPT_DIR/prd.json"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

print_header() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    print_error "jq is required but not installed."
    exit 1
fi

# Check if config exists
if [ ! -f "$CONFIG_FILE" ]; then
    print_error "project-config.json not found!"
    print_info "Please run ./init-ralph.sh first to create a project configuration."
    exit 1
fi

print_header "Generating PRD from Configuration"

# Read configuration
PROJECT_NAME=$(jq -r '.projectName' "$CONFIG_FILE")
PROJECT_TYPE=$(jq -r '.projectType' "$CONFIG_FILE")
PROJECT_DESC=$(jq -r '.description' "$CONFIG_FILE")
BRANCH_NAME=$(jq -r '.branchName // "ralph/'$PROJECT_NAME'"' "$CONFIG_FILE")
FRONTEND=$(jq -r '.techStack.frontend' "$CONFIG_FILE")
BACKEND=$(jq -r '.techStack.backend' "$CONFIG_FILE")
DATABASE=$(jq -r '.techStack.database' "$CONFIG_FILE")
FEATURES=$(jq -r '.features[]?' "$CONFIG_FILE" 2>/dev/null || echo "")
TESTING=$(jq -r '.testing[]?' "$CONFIG_FILE" 2>/dev/null || echo "")

# Generate initial user stories based on project type
STORIES_JSON="[]"

# Function to add a story
add_story() {
    local id="$1"
    local title="$2"
    local desc="$3"
    local criteria="$4"
    local priority="$5"
    
    local story=$(jq -n \
        --arg id "$id" \
        --arg title "$title" \
        --arg desc "$desc" \
        --arg priority "$priority" \
        --argjson criteria "$criteria" \
        '{
            id: $id,
            title: $title,
            description: $desc,
            acceptanceCriteria: $criteria,
            priority: ($priority | tonumber),
            passes: false,
            notes: ""
        }')
    
    STORIES_JSON=$(echo "$STORIES_JSON" | jq --argjson story "$story" '. + [$story]')
}

# Generate stories based on project type
PRIORITY=1

# Project setup story
case "$PROJECT_TYPE" in
    "website"|"webapp")
        CRITERIA=$(jq -n '["Project structure initialized", "Dependencies installed", "Development server runs successfully", "npm run typecheck passes"]')
        add_story "US-001" "Set up project structure and dependencies" \
            "As a developer, I need the project structure and dependencies set up so I can start development." \
            "$CRITERIA" "$PRIORITY"
        PRIORITY=$((PRIORITY + 1))
        ;;
    "ios")
        CRITERIA=$(jq -n '["Xcode project created", "Project builds successfully", "App runs on simulator", "Basic app structure in place"]')
        add_story "US-001" "Set up iOS project structure" \
            "As a developer, I need the iOS project set up so I can start development." \
            "$CRITERIA" "$PRIORITY"
        PRIORITY=$((PRIORITY + 1))
        ;;
    "android")
        CRITERIA=$(jq -n '["Android project created", "Project builds successfully", "App runs on emulator", "Basic app structure in place"]')
        add_story "US-001" "Set up Android project structure" \
            "As a developer, I need the Android project set up so I can start development." \
            "$CRITERIA" "$PRIORITY"
        PRIORITY=$((PRIORITY + 1))
        ;;
    "api")
        CRITERIA=$(jq -n '["API project structure created", "Dependencies installed", "Server starts successfully", "Basic health endpoint works"]')
        add_story "US-001" "Set up API project structure" \
            "As a developer, I need the API project set up so I can start development." \
            "$CRITERIA" "$PRIORITY"
        PRIORITY=$((PRIORITY + 1))
        ;;
esac

# Database setup story
if [ "$DATABASE" != "none" ] && [ -n "$DATABASE" ]; then
    CRITERIA=$(jq -n '["Database connection configured", "Migrations system set up", "Connection test passes", "npm run typecheck passes"]')
    add_story "US-00$PRIORITY" "Set up database connection and migrations" \
        "As a developer, I need database connectivity configured so I can store data." \
        "$CRITERIA" "$PRIORITY"
    PRIORITY=$((PRIORITY + 1))
fi

# Authentication story
if echo "$FEATURES" | grep -q "auth"; then
    CRITERIA=$(jq -n '["Authentication system implemented", "User registration works", "User login works", "Session management functional", "npm run typecheck passes"]')
    add_story "US-00$PRIORITY" "Implement user authentication" \
        "As a user, I want to register and log in so I can access my account." \
        "$CRITERIA" "$PRIORITY"
    PRIORITY=$((PRIORITY + 1))
fi

# Payments story
if echo "$FEATURES" | grep -q "payments"; then
    CRITERIA=$(jq -n '["Payment integration configured", "Payment form implemented", "Test payment succeeds", "npm run typecheck passes"]')
    add_story "US-00$PRIORITY" "Implement payment system" \
        "As a user, I want to make payments so I can purchase items/services." \
        "$CRITERIA" "$PRIORITY"
    PRIORITY=$((PRIORITY + 1))
fi

# Testing setup story
if echo "$TESTING" | grep -q "unit"; then
    CRITERIA=$(jq -n '["Testing framework configured", "Example test written", "Tests run successfully", "npm test passes"]')
    add_story "US-00$PRIORITY" "Set up unit testing" \
        "As a developer, I need unit tests set up so I can ensure code quality." \
        "$CRITERIA" "$PRIORITY"
    PRIORITY=$((PRIORITY + 1))
fi

if echo "$TESTING" | grep -q "e2e"; then
    CRITERIA=$(jq -n '["E2E testing framework configured", "Example E2E test written", "E2E tests run successfully", "npm run test:e2e passes"]')
    add_story "US-00$PRIORITY" "Set up end-to-end testing" \
        "As a developer, I need E2E tests set up so I can test user flows." \
        "$CRITERIA" "$PRIORITY"
    PRIORITY=$((PRIORITY + 1))
fi

# Default feature story if no specific stories were added
if [ "$(echo "$STORIES_JSON" | jq 'length')" -eq 0 ]; then
    CRITERIA=$(jq -n '["Project is ready for feature development", "Basic structure in place", "Development environment works"]')
    add_story "US-001" "Initialize project" \
        "As a developer, I need the project initialized so I can start building features." \
        "$CRITERIA" "1"
fi

# Generate PRD JSON
jq -n \
    --arg name "$PROJECT_NAME" \
    --arg branch "$BRANCH_NAME" \
    --arg desc "$PROJECT_DESC" \
    --argjson stories "$STORIES_JSON" \
    '{
        project: $name,
        branchName: $branch,
        description: $desc,
        userStories: $stories
    }' > "$PRD_FILE"

print_success "PRD generated: $PRD_FILE"
echo ""
print_info "Generated $(echo "$STORIES_JSON" | jq 'length') user stories"
echo ""
print_info "To start working with Ralph, run:"
echo -e "${GREEN}  ./ralph.sh${NC}"
echo ""
