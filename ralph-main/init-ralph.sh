#!/bin/bash
# Ralph Universal Template Initializer
# Interactive CLI to scaffold projects for websites, web apps, mobile apps, desktop apps, CLI tools, and more
# Usage: ./init-ralph.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/project-config.json"
SCHEMA_FILE="$SCRIPT_DIR/project-config.schema.json"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
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

# Function to prompt for input with validation
prompt_input() {
    local prompt="$1"
    local default="$2"
    local validation="$3"
    local value=""
    
    while true; do
        if [ -n "$default" ]; then
            read -p "$(echo -e "${YELLOW}$prompt${NC} ${BLUE}[$default]:${NC} ")" value
            value="${value:-$default}"
        else
            read -p "$(echo -e "${YELLOW}$prompt${NC}: ")" value
        fi
        
        if [ -z "$value" ] && [ -z "$default" ]; then
            print_error "This field is required. Please enter a value."
            continue
        fi
        
        if [ -n "$validation" ]; then
            if ! eval "$validation '$value'"; then
                print_error "Invalid input. Please try again."
                continue
            fi
        fi
        
        echo "$value"
        break
    done
}

# Function to prompt for selection
prompt_select() {
    local prompt="$1"
    shift
    local options=("$@")
    local selected=""
    
    echo -e "${YELLOW}$prompt${NC}"
    for i in "${!options[@]}"; do
        echo "  $((i+1)). ${options[$i]}"
    done
    
    while true; do
        read -p "$(echo -e "${YELLOW}Select option [1-${#options[@]}]:${NC} ")" choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#options[@]}" ]; then
            selected="${options[$((choice-1))]}"
            echo "$selected"
            break
        else
            print_error "Invalid selection. Please enter a number between 1 and ${#options[@]}."
        fi
    done
}

# Function to prompt for multiple selections
prompt_multiselect() {
    local prompt="$1"
    shift
    local options=("$@")
    local selected=()
    
    echo -e "${YELLOW}$prompt${NC}"
    echo -e "${YELLOW}(Enter numbers separated by spaces, e.g., '1 3 5')${NC}"
    for i in "${!options[@]}"; do
        echo "  $((i+1)). ${options[$i]}"
    done
    
    while true; do
        read -p "$(echo -e "${YELLOW}Select options:${NC} ")" choices
        if [ -z "$choices" ]; then
            break
        fi
        
        local valid=true
        for choice in $choices; do
            if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt "${#options[@]}" ]; then
                print_error "Invalid selection: $choice. Please enter valid numbers separated by spaces."
                valid=false
                break
            fi
        done
        
        if [ "$valid" = true ]; then
            for choice in $choices; do
                selected+=("${options[$((choice-1))]}")
            done
            break
        fi
    done
    
    printf '%s\n' "${selected[@]}"
}

# Function to validate project name
validate_project_name() {
    if [[ "$1" =~ ^[a-zA-Z0-9-_]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Main initialization
main() {
    print_header "Ralph Universal Template Initializer"
    
    print_info "This tool will guide you through setting up a new project."
    print_info "You can press Ctrl+C at any time to cancel."
    echo ""
    
    # Check if jq is installed
    if ! command -v jq &> /dev/null; then
        print_error "jq is required but not installed."
        echo "Please install jq: https://stedolan.github.io/jq/download/"
        exit 1
    fi
    
    # Check if project-config.json already exists
    if [ -f "$CONFIG_FILE" ]; then
        read -p "$(echo -e "${YELLOW}A project-config.json already exists. Overwrite? [y/N]:${NC} ")" -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Aborted."
            exit 0
        fi
    fi
    
    # Start collecting configuration
    local config={}
    
    # Project name
    print_header "Project Information"
    PROJECT_NAME=$(prompt_input "Project name (alphanumeric, dashes, underscores only)" "" "validate_project_name")
    
    # Project description
    PROJECT_DESC=$(prompt_input "Project description" "")
    
    # Project type
    print_header "Project Type"
    PROJECT_TYPE=$(prompt_select "What type of project are you building?" \
        "Website (static/marketing site)" \
        "Web App (interactive web application)" \
        "iOS App (native iOS application)" \
        "Android App (native Android application)" \
        "Desktop App (cross-platform desktop)" \
        "CLI Tool (command-line application)" \
        "API Backend (REST/GraphQL API)" \
        "Full Stack (frontend + backend)")
    
    # Map selection to config value
    case "$PROJECT_TYPE" in
        "Website"*) PROJECT_TYPE_VALUE="website" PLATFORM="web" ;;
        "Web App"*) PROJECT_TYPE_VALUE="webapp" PLATFORM="web" ;;
        "iOS App"*) PROJECT_TYPE_VALUE="ios" PLATFORM="ios" ;;
        "Android App"*) PROJECT_TYPE_VALUE="android" PLATFORM="android" ;;
        "Desktop App"*) PROJECT_TYPE_VALUE="desktop" PLATFORM="desktop" ;;
        "CLI Tool"*) PROJECT_TYPE_VALUE="cli" PLATFORM="cli" ;;
        "API Backend"*) PROJECT_TYPE_VALUE="api" PLATFORM="web" ;;
        "Full Stack"*) PROJECT_TYPE_VALUE="fullstack" PLATFORM="web" ;;
    esac
    
    # Tech stack questions
    print_header "Technology Stack"
    
    FRONTEND="none"
    BACKEND="none"
    DATABASE="none"
    MOBILE="none"
    
    if [[ "$PROJECT_TYPE_VALUE" == "website" ]] || [[ "$PROJECT_TYPE_VALUE" == "webapp" ]] || [[ "$PROJECT_TYPE_VALUE" == "fullstack" ]]; then
        FRONTEND=$(prompt_select "Frontend framework?" \
            "Next.js (recommended for websites)" \
            "React (SPA)" \
            "Vue.js" \
            "Angular" \
            "Vanilla JS" \
            "None")
        
        case "$FRONTEND" in
            "Next.js"*) FRONTEND="nextjs" ;;
            "React"*) FRONTEND="react" ;;
            "Vue.js"*) FRONTEND="vue" ;;
            "Angular"*) FRONTEND="angular" ;;
            "Vanilla JS"*) FRONTEND="vanilla" ;;
            *) FRONTEND="none" ;;
        esac
    fi
    
    if [[ "$PROJECT_TYPE_VALUE" == "api" ]] || [[ "$PROJECT_TYPE_VALUE" == "fullstack" ]] || [[ "$PROJECT_TYPE_VALUE" == "webapp" ]]; then
        BACKEND=$(prompt_select "Backend framework?" \
            "FastAPI (Python)" \
            "Node.js" \
            "Express.js" \
            "Django (Python)" \
            "None")
        
        case "$BACKEND" in
            "FastAPI"*) BACKEND="fastapi" ;;
            "Node.js"*) BACKEND="nodejs" ;;
            "Express.js"*) BACKEND="express" ;;
            "Django"*) BACKEND="django" ;;
            *) BACKEND="none" ;;
        esac
    fi
    
    if [[ "$PROJECT_TYPE_VALUE" == "api" ]] || [[ "$PROJECT_TYPE_VALUE" == "fullstack" ]] || [[ "$BACKEND" != "none" ]]; then
        DATABASE=$(prompt_select "Database?" \
            "PostgreSQL" \
            "MongoDB" \
            "Supabase (PostgreSQL + services)" \
            "Firebase (NoSQL + services)" \
            "None")
        
        case "$DATABASE" in
            "PostgreSQL"*) DATABASE="postgresql" ;;
            "MongoDB"*) DATABASE="mongodb" ;;
            "Supabase"*) DATABASE="supabase" ;;
            "Firebase"*) DATABASE="firebase" ;;
            *) DATABASE="none" ;;
        esac
    fi
    
    if [[ "$PROJECT_TYPE_VALUE" == "ios" ]] || [[ "$PROJECT_TYPE_VALUE" == "android" ]]; then
        MOBILE=$(prompt_select "Mobile framework?" \
            "Native (Swift/Kotlin)" \
            "React Native" \
            "Flutter" \
            "None")
        
        case "$MOBILE" in
            "Native"*) MOBILE="native" ;;
            "React Native"*) MOBILE="react-native" ;;
            "Flutter"*) MOBILE="flutter" ;;
            *) MOBILE="none" ;;
        esac
    fi
    
    # Features
    print_header "Features"
    FEATURES=$(prompt_multiselect "Select features to include:" \
        "Authentication" \
        "Payments (Stripe/Coinbase)" \
        "Real-time updates" \
        "Analytics" \
        "Push Notifications" \
        "File Storage")
    
    FEATURES_JSON="[]"
    if [ ${#FEATURES[@]} -gt 0 ]; then
        FEATURES_JSON="["
        for i in "${!FEATURES[@]}"; do
            local feature="${FEATURES[$i]}"
            case "$feature" in
                "Authentication"*) feature="auth" ;;
                "Payments"*) feature="payments" ;;
                "Real-time updates"*) feature="realtime" ;;
                "Analytics"*) feature="analytics" ;;
                "Push Notifications"*) feature="notifications" ;;
                "File Storage"*) feature="storage" ;;
            esac
            if [ $i -gt 0 ]; then
                FEATURES_JSON+=","
            fi
            FEATURES_JSON+="\"$feature\""
        done
        FEATURES_JSON+="]"
    fi
    
    # Deployment
    print_header "Deployment"
    DEPLOYMENT=$(prompt_select "Deployment platform?" \
        "Vercel (recommended for Next.js)" \
        "AWS" \
        "Docker" \
        "Netlify" \
        "Heroku" \
        "None / Manual")
    
    case "$DEPLOYMENT" in
        "Vercel"*) DEPLOYMENT="vercel" ;;
        "AWS"*) DEPLOYMENT="aws" ;;
        "Docker"*) DEPLOYMENT="docker" ;;
        "Netlify"*) DEPLOYMENT="netlify" ;;
        "Heroku"*) DEPLOYMENT="heroku" ;;
        *) DEPLOYMENT="none" ;;
    esac
    
    # Testing
    print_header "Testing"
    TESTING=$(prompt_multiselect "Select testing approaches:" \
        "Unit Tests" \
        "E2E Tests" \
        "Browser Testing")
    
    TESTING_JSON="[]"
    if [ ${#TESTING[@]} -gt 0 ]; then
        TESTING_JSON="["
        for i in "${!TESTING[@]}"; do
            local test="${TESTING[$i]}"
            case "$test" in
                "Unit Tests"*) test="unit" ;;
                "E2E Tests"*) test="e2e" ;;
                "Browser Testing"*) test="browser" ;;
            esac
            if [ $i -gt 0 ]; then
                TESTING_JSON+=","
            fi
            TESTING_JSON+="\"$test\""
        done
        TESTING_JSON+="]"
    fi
    
    # Branch name
    BRANCH_NAME=$(prompt_input "Git branch name" "ralph/$PROJECT_NAME")
    
    # Generate project-config.json
    print_header "Generating Configuration"
    
    jq -n \
        --arg name "$PROJECT_NAME" \
        --arg type "$PROJECT_TYPE_VALUE" \
        --arg platform "$PLATFORM" \
        --arg frontend "$FRONTEND" \
        --arg backend "$BACKEND" \
        --arg database "$DATABASE" \
        --arg mobile "$MOBILE" \
        --argjson features "$FEATURES_JSON" \
        --arg deployment "$DEPLOYMENT" \
        --argjson testing "$TESTING_JSON" \
        --arg desc "$PROJECT_DESC" \
        --arg branch "$BRANCH_NAME" \
        '{
            projectName: $name,
            projectType: $type,
            platform: $platform,
            techStack: {
                frontend: $frontend,
                backend: $backend,
                database: $database,
                mobile: $mobile
            },
            features: $features,
            deployment: $deployment,
            testing: $testing,
            description: $desc,
            branchName: $branch
        }' > "$CONFIG_FILE"
    
    print_success "Configuration saved to project-config.json"
    
    # Summary
    print_header "Configuration Summary"
    cat "$CONFIG_FILE" | jq .
    echo ""
    
    # Next steps
    print_header "Next Steps"
    print_info "Configuration has been saved to project-config.json"
    echo ""
    print_info "To scaffold your project, run:"
    echo -e "${GREEN}  ./scaffold.sh${NC}"
    echo ""
    print_info "Or to generate a PRD from this config, run:"
    echo -e "${GREEN}  ./generate-prd-from-config.sh${NC}"
    echo ""
}

# Run main function
main "$@"
