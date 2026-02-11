# Ralph Repository Organization

This document describes the overall structure of the Ralph repository.

## Repository Layout

```
ralph/                          # Repository root
├── README.md                   # Main documentation and quick start
├── CHANGELOG.md                # Project-level changelog
├── ORGANIZATION.md             # This file – repository structure
│
└── ralph/                      # Main Ralph project
    ├── .cursor/                # Cursor IDE configuration
    │   ├── composer-instructions.md
    │   ├── composer-prompt-template.md
    │   ├── rules/              # 39 .mdc rules (2026 format)
    │   └── skills/             # Agent skills (ralph-workflow, prd-*, etc.)
    ├── .cursorrules            # Primary Cursor AI instructions
    ├── flowchart/              # React Flow visualization app
    ├── ralph.sh                # Legacy interactive loop
    ├── prd.json.example        # Example PRD format
    ├── AGENTS.md               # Agent instructions
    ├── instructions.md         # Agent-friendly project spec
    ├── README.md               # (referenced via root README)
    ├── ORGANIZATION.md         # Detailed project organization
    ├── CHANGELOG.md            # Full change history
    └── roadmap.md              # Milestones and future directions
```

## Key Directories

| Path | Purpose |
|------|---------|
| `ralph/` | Main Ralph project – workflow, rules, skills, flowchart |
| `ralph/.cursor/rules/` | 39 Cursor Rules (.mdc) – coding standards, frameworks |
| `ralph/.cursor/skills/` | Agent Skills – ralph-workflow, prd-generation, prd-from-external, etc. |
| `ralph/flowchart/` | Interactive React Flow diagram of the Ralph workflow |

## Documentation Index

| Document | Location | Purpose |
|----------|----------|---------|
| Quick start & overview | [README.md](README.md) | Getting started, commands, key files |
| Repository structure | [ORGANIZATION.md](ORGANIZATION.md) | This file |
| Project changelog | [CHANGELOG.md](CHANGELOG.md) | Project-level changes |
| Detailed project org | [ralph/ORGANIZATION.md](ralph/ORGANIZATION.md) | File categories, rules, workflow |
| Full Ralph history | [ralph/CHANGELOG.md](ralph/CHANGELOG.md) | Rules, skills, features history |
| Agent instructions | [ralph/AGENTS.md](ralph/AGENTS.md) | Commands, boundaries, code style |
| Roadmap | [ralph/roadmap.md](ralph/roadmap.md) | Milestones and future ideas |

## Skills Hierarchy

- **Cursor skills** (`ralph/.cursor/skills/`) – Primary workflow skills; use `/ralph-workflow`, `/prd-generation`, etc. in Agent chat.
- **Legacy/reference skills** (`ralph/ralph/`, `ralph/prd/`, etc.) – Alternative formats; some reference task-list based workflows.

For current usage, use the skills in `.cursor/skills/`.
