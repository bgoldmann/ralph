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
│   └── rules/                    # Cursor Rules 2026 (.mdc; React split into react, react-components, react-hooks, react-state)
│       ├── README.md             # Rule format, priority hierarchy, usage
│       ├── core-engineering.mdc # Always-applied (priority 10)
│       ├── prd-generation.mdc
│       ├── ralph-workflow.mdc
│       ├── backend-development.mdc
│       ├── fastapi.mdc
│       ├── nextjs.mdc
│       └── ... (other .mdc rules)
│
├── .cursorrules                  # Primary Cursor AI instructions
├── .cursorignore                 # Cursor indexing exclusions
├── .gitignore                    # Git ignore patterns
│
├── ralph.sh                      # Main Ralph loop script
├── AGENTS.md                     # Agent instructions (commands, boundaries, code style)
├── instructions.md               # Agent-friendly project spec (features, tech stack, structure)
├── roadmap.md                    # Milestones and future directions
├── README.md                     # Main documentation
├── CHANGELOG.md                  # Change history
│
├── .github/
│   ├── agents/                   # Optional agent personas (ralph-agent, prd-agent)
│   ├── copilot-instructions.md   # Workspace instructions for Copilot users
│   └── workflows/
│
├── prd.json.example              # Example PRD format
├── prd.json                      # Active PRD (gitignored, generated)
├── progress.txt                  # Progress log (gitignored, generated)
├── .last-branch                  # Last branch tracker (gitignored)
│
├── flowchart/                    # Interactive flowchart visualization
│   ├── AGENTS.md                 # Module-specific agent instructions
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
- **`.cursor/rules/*.mdc`** - 39 rules (2026 format; priority 10–100)

### Reference Material
- **`flowchart/`** - Interactive visualization source code
- **`prd.json.example`** - Example PRD format

## Cursor Rules Organization

The `.cursor/rules/` directory contains 39 rules (`.mdc` format, 2026) with priority hierarchy (10 = core, 15 = workflow, 40 = domain, 100 = security):

### Always-applied (1)
- `core-engineering.mdc` (priority 10)

### Core Workflow (5, priority 15)
- `prd-generation.mdc`, `prd-from-external.mdc`, `ralph-workflow.mdc`, `ralph-task-workflow.mdc`, `compound-engineering.mdc`

### Design & UX, Backend, Frontend, Services, Testing, DevOps, Security & Performance, Document Processing, Mobile
- Remaining rules use priority 40 (domain) or 100 (security). See `.cursor/rules/README.md` for format and `.cursor/rules/` for the full list.

## Workflow Files

### Input
- `prd.json` - Contains user stories with priorities and `passes` status

### Processing
- `ralph.sh` - Generates prompts based on `prd.json`
- `.cursorrules` - Guides Cursor AI behavior
- `.cursor/rules/*.mdc` - Rules (2026 format) for specific domains; one always-applied core rule

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
1. Create `.cursor/rules/[rule-name].mdc` with frontmatter (description, globs, alwaysApply, priority)
2. See `.cursor/rules/README.md` for format and priority hierarchy
3. Categorize appropriately in the README

### Updating Core Workflow
- Update `.cursorrules` for general behavior changes
- Update `ralph.sh` for script logic changes
- Update `CHANGELOG.md` for all significant changes

### Documentation Updates
- Update `README.md` for user-facing changes
- Update `AGENTS.md` for pattern/instruction changes
- Update `CHANGELOG.md` for all changes
