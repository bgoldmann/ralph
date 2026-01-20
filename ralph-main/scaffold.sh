#!/bin/bash
# Ralph Project Scaffolding Engine
# Reads project-config.json and scaffolds project structure
# Usage: ./scaffold.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/project-config.json"
TEMPLATES_DIR="$SCRIPT_DIR/templates"
RULE_SELECTOR="$SCRIPT_DIR/rule-selector.json"

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

# Read configuration
PROJECT_NAME=$(jq -r '.projectName' "$CONFIG_FILE")
PROJECT_TYPE=$(jq -r '.projectType' "$CONFIG_FILE")
FRONTEND=$(jq -r '.techStack.frontend' "$CONFIG_FILE")
BACKEND=$(jq -r '.techStack.backend' "$CONFIG_FILE")
DATABASE=$(jq -r '.techStack.database' "$CONFIG_FILE")

print_header "Ralph Project Scaffolding"
print_info "Project: $PROJECT_NAME"
print_info "Type: $PROJECT_TYPE"
echo ""

# Determine template to use
TEMPLATE_NAME=""
case "$PROJECT_TYPE" in
    "website")
        if [ "$FRONTEND" == "nextjs" ]; then
            TEMPLATE_NAME="website-nextjs"
        else
            TEMPLATE_NAME="website"
        fi
        ;;
    "webapp")
        if [ "$FRONTEND" == "nextjs" ]; then
            TEMPLATE_NAME="webapp-nextjs"
        elif [ "$FRONTEND" == "react" ]; then
            TEMPLATE_NAME="webapp-react"
        else
            TEMPLATE_NAME="webapp"
        fi
        ;;
    "ios")
        TEMPLATE_NAME="ios-app"
        ;;
    "android")
        TEMPLATE_NAME="android-app"
        ;;
    "desktop")
        TEMPLATE_NAME="desktop-electron"
        ;;
    "cli")
        TEMPLATE_NAME="cli-tool"
        ;;
    "api")
        TEMPLATE_NAME="api-backend"
        ;;
    "fullstack")
        TEMPLATE_NAME="fullstack"
        ;;
    *)
        print_error "Unknown project type: $PROJECT_TYPE"
        exit 1
        ;;
esac

TEMPLATE_DIR="$TEMPLATES_DIR/$TEMPLATE_NAME"

# Check if template exists
if [ ! -d "$TEMPLATE_DIR" ]; then
    print_error "Template not found: $TEMPLATE_DIR"
    print_info "Creating minimal template structure..."
    mkdir -p "$TEMPLATE_DIR"
fi

print_info "Using template: $TEMPLATE_NAME"

# Create project directory if it doesn't exist
PROJECT_DIR="$SCRIPT_DIR/$PROJECT_NAME"
if [ -d "$PROJECT_DIR" ]; then
    print_error "Directory $PROJECT_NAME already exists!"
    read -p "$(echo -e "${YELLOW}Remove and recreate? [y/N]:${NC} ")" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$PROJECT_DIR"
    else
        exit 1
    fi
fi

mkdir -p "$PROJECT_DIR"

# Copy template files
if [ -d "$TEMPLATE_DIR" ] && [ "$(ls -A $TEMPLATE_DIR)" ]; then
    print_info "Copying template files..."
    cp -r "$TEMPLATE_DIR"/* "$PROJECT_DIR/" 2>/dev/null || true
    print_success "Template files copied"
else
    print_info "Template is empty, creating basic structure..."
fi

# Generate .cursorrules based on selected rules
print_info "Generating .cursorrules..."

# Get rules from rule-selector.json
PROJECT_RULES=$(jq -r ".projectTypes.$PROJECT_TYPE // {}" "$RULE_SELECTOR")
REQUIRED_RULES=$(echo "$PROJECT_RULES" | jq -r '.required[]? // empty' 2>/dev/null || echo "")
RECOMMENDED_RULES=$(echo "$PROJECT_RULES" | jq -r '.recommended[]? // empty' 2>/dev/null || echo "")

# Build rules array
ALL_RULES=()
while IFS= read -r rule; do
    [ -n "$rule" ] && ALL_RULES+=("$rule")
done <<< "$REQUIRED_RULES"

while IFS= read -r rule; do
    [ -n "$rule" ] && ALL_RULES+=("$rule")
done <<< "$RECOMMENDED_RULES"

# Generate .cursorrules content
CURSORRULES_FILE="$PROJECT_DIR/.cursorrules"
cat > "$CURSORRULES_FILE" <<EOF
# Ralph Agent Instructions for Cursor IDE - $PROJECT_NAME

You are an autonomous coding agent working on the $PROJECT_NAME project using the Ralph workflow.

## Project Configuration
- **Type:** $PROJECT_TYPE
- **Platform:** $(jq -r '.platform' "$CONFIG_FILE")
- **Tech Stack:** $(jq -r '.techStack | to_entries | map("\(.key)=\(.value)") | join(", ")' "$CONFIG_FILE")

## Cursor Rules

When working on this project, reference the following Cursor Rules:

EOF

for rule in "${ALL_RULES[@]}"; do
    RULE_FILE="$SCRIPT_DIR/.cursor/rules/${rule}.md"
    if [ -f "$RULE_FILE" ]; then
        echo "- **${rule}**: See \`.cursor/rules/${rule}.md\`" >> "$CURSORRULES_FILE"
    fi
done

cat >> "$CURSORRULES_FILE" <<EOF

## Core Workflow

1. Read the PRD at \`prd.json\` (in the same directory as this file)
2. Read the progress log at \`progress.txt\` (check Codebase Patterns section first)
3. Check you're on the correct branch from PRD \`branchName\`. If not, check it out or create from main.
4. Pick the **highest priority** user story where \`passes: false\`
5. Implement that single user story
6. Run quality checks (e.g., typecheck, lint, test - use whatever your project requires)
7. Update AGENTS.md files if you discover reusable patterns
8. If checks pass, commit ALL changes with message: \`feat: [Story ID] - [Story Title]\`
9. Update the PRD to set \`passes: true\` for the completed story
10. Append your progress to \`progress.txt\`

## Quality Requirements

- ALL commits must pass your project's quality checks (typecheck, lint, test)
- Do NOT commit broken code
- Keep changes focused and minimal
- Follow existing code patterns

## Browser Testing (Required for Frontend Stories)

For any story that changes UI, you MUST verify it works in the browser. Use Cursor's built-in browser capabilities or navigate to the page and verify the UI changes work as expected.

A frontend story is NOT complete until browser verification passes.

EOF

print_success ".cursorrules generated"

# Copy ralph.sh and other necessary files
print_info "Setting up Ralph workflow files..."
cp "$SCRIPT_DIR/ralph.sh" "$PROJECT_DIR/" 2>/dev/null || true
cp "$SCRIPT_DIR/.cursor/composer-prompt-template.md" "$PROJECT_DIR/.cursor/" 2>/dev/null || mkdir -p "$PROJECT_DIR/.cursor" && cp "$SCRIPT_DIR/.cursor/composer-prompt-template.md" "$PROJECT_DIR/.cursor/" 2>/dev/null || true

# Copy project-config.json
cp "$CONFIG_FILE" "$PROJECT_DIR/"

# Create initial progress.txt
cat > "$PROJECT_DIR/progress.txt" <<EOF
# Ralph Progress Log
Started: $(date)

## Codebase Patterns
(Add reusable patterns discovered during development here)

---
EOF

print_success "Ralph workflow files set up"

# Summary
print_header "Scaffolding Complete"
print_success "Project scaffolded in: $PROJECT_DIR"
echo ""
print_info "Next steps:"
echo "  1. cd $PROJECT_NAME"
echo "  2. Run: ./generate-prd-from-config.sh (if not done already)"
echo "  3. Run: ./ralph.sh to start development"
echo ""
