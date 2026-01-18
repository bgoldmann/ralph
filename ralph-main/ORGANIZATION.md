# Ralph Codebase Organization

This document outlines the organization and structure of the Ralph codebase in this directory (`ralph-main/`).

**Note:** This repository also contains `amp-skills-main/` (at the repository root), which holds the original Amp CLI skills. Those skills have been converted to Cursor Rules in `.cursor/rules/` and are kept for reference only.

## Directory Structure

```
ralph-main/
├── .cursor/                      # Cursor IDE configuration
│   ├── composer-instructions.md  # User guide for using Ralph with Composer
│   ├── composer-prompt-template.md # Template for generating story prompts
│   ├── composer-prompt.md        # Generated prompt for current story (gitignored)
│   └── rules/                    # Cursor Rules for development (31 skills)
│       ├── README.md             # Index of all rules organized by category
│       ├── prd-generation.md
│       ├── ralph-task-workflow.md
│       ├── backend-development.md
│       ├── fastapi.md
│       ├── nextjs.md
│       └── ... (19 more rules)
│
├── .cursorrules                  # Primary Cursor AI instructions
├── .gitignore                    # Git ignore patterns
│
├── ralph.sh                      # Main Ralph loop script
├── AGENTS.md                     # Agent instructions and patterns
├── README.md                     # Main documentation
├── CHANGELOG.md                  # Change history
│
├── prd.json.example              # Example PRD format
├── prd.json                      # Active PRD (gitignored, generated)
├── progress.txt                  # Progress log (gitignored, generated)
├── .last-branch                  # Last branch tracker (gitignored)
│
├── flowchart/                    # Interactive flowchart visualization
│   ├── src/
│   ├── public/
│   ├── package.json
│   └── ...
│
└── archive/                      # Archived runs (optional, gitignored)
    └── YYYY-MM-DD-feature-name/
```

## File Categories

### Core Ralph Files
- **`ralph.sh`** - Main bash script that orchestrates the Ralph loop
- **`.cursorrules`** - Instructions for Cursor AI when working on stories

### Generated Files (Gitignored)
- **`prd.json`** - Active PRD with user stories and `passes` status
- **`progress.txt`** - Append-only log of learnings and patterns
- **`.last-branch`** - Tracks last branch for archive detection
- **`.cursor/composer-prompt.md`** - Generated prompt for current story

### Documentation
- **`README.md`** - Main documentation and getting started guide
- **`CHANGELOG.md`** - Record of all changes
- **`AGENTS.md`** - Agent instructions and discovered patterns
- **`ORGANIZATION.md`** - This file

### Cursor Configuration
- **`.cursor/composer-instructions.md`** - User guide for Composer workflow
- **`.cursor/composer-prompt-template.md`** - Template for story prompts
- **`.cursor/rules/`** - 31 comprehensive development skills/rules

### Reference Material
- **`flowchart/`** - Interactive visualization source code
- **`prd.json.example`** - Example PRD format

## Cursor Rules Organization

The `.cursor/rules/` directory contains 31 rules organized by category:

### Core Workflow (5 rules)
- `prd-generation.md`
- `prd-from-external.md`
- `ralph-workflow.md`
- `ralph-task-workflow.md`
- `compound-engineering.md`

### Design & UX (2 rules)
- `frontend-design.md`
- `ui-ux.md`

### Backend (3 rules)
- `backend-development.md`
- `fastapi.md`
- `supabase.md`

### Frontend (3 rules)
- `nextjs.md`
- `typescript.md`
- `seo.md`

### Services (7 rules)
- `stripe.md`
- `coinbase-commerce.md`
- `vercel.md`
- `google-services.md`
- `llms.md`
- `llm-seo.md`
- `mcp.md`

### Testing & Quality (2 rules)
- `testing.md`
- `agent-browser.md`

### DevOps (3 rules)
- `docker.md`
- `cicd.md`
- `git-github.md`

### Security & Performance (2 rules)
- `security.md`
- `performance.md`

### Document Processing (2 rules)
- `pdf-processing.md`
- `docx-processing.md`

### Mobile (1 rule)
- `ios-app.md`

See `.cursor/rules/README.md` for detailed descriptions and usage.

## Workflow Files

### Input
- `prd.json` - Contains user stories with priorities and `passes` status

### Processing
- `ralph.sh` - Generates prompts based on `prd.json`
- `.cursorrules` - Guides Cursor AI behavior
- `.cursor/rules/*.md` - Provides context for specific domains

### Output
- `progress.txt` - Learnings and patterns discovered
- `AGENTS.md` - Reusable patterns for future work
- Git commits - Code changes

## Archive System

Ralph automatically archives previous runs when the branch changes:
- Archives stored in `archive/YYYY-MM-DD-feature-name/`
- Contains `prd.json` and `progress.txt` from previous run
- Optional to commit (commented in `.gitignore`)

## Maintenance

### Adding New Cursor Rules
1. Create `.cursor/rules/[skill-name].md`
2. Update `.cursor/rules/README.md` to include the new rule
3. Categorize appropriately in the README

### Updating Core Workflow
- Update `.cursorrules` for general behavior changes
- Update `ralph.sh` for script logic changes
- Update `CHANGELOG.md` for all significant changes

### Documentation Updates
- Update `README.md` for user-facing changes
- Update `AGENTS.md` for pattern/instruction changes
- Update `CHANGELOG.md` for all changes
