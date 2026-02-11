# Ralph – Project Instructions (agent-friendly spec)

Single reference for features, tech stack, structure, and build steps. Use this with Cursor/agents for consistent context.

## Project description

Ralph is an autonomous AI agent loop for Cursor IDE. It completes user stories from a PRD (Product Requirements Document) iteratively until all items pass. Each iteration uses Cursor Composer with clean context; state is kept in git history, `progress.txt`, and `prd.json`.

## Features

- **Agent-driven workflow** – Invoke `/ralph-workflow` in Cursor Agent chat to run the full loop (init → get next story → implement → quality checks → commit → mark complete → repeat).
- **Legacy interactive loop** – `./ralph.sh [max_iterations]` for human-in-the-loop: script generates `.cursor/composer-prompt.md`, user implements in Composer, then continues.
- **PRD generation** – Create PRDs from scratch (`/prd-generation`) or from external sites/apps (`/prd-from-external`).
- **Flowchart** – Interactive React Flow diagram in `flowchart/` explaining the Ralph workflow (for presentations).

## Tech stack

| Area | Technologies |
|------|--------------|
| Ralph core | Bash, jq (required for PRD scripts) |
| Flowchart app | React 19, TypeScript 5.9, Vite 7, React Flow (@xyflow/react) |
| Cursor | Rules: `.cursor/rules/*.mdc` (39 rules, 2026 format). Skills: `.cursor/skills/*/SKILL.md` (e.g. ralph-workflow, prd-generation). |

## Project structure

```
ralph/
├── .cursor/
│   ├── composer-instructions.md    # User guide for Composer
│   ├── composer-prompt-template.md # Template for story prompts
│   ├── composer-prompt.md          # Generated current story (gitignored)
│   ├── rules/                      # 39 .mdc rules (priority 10–100)
│   └── skills/                     # Workflow skills (ralph-workflow, prd-*, etc.)
├── .cursorignore                   # Cursor indexing exclusions
├── .cursorrules                    # Primary Cursor AI instructions
├── .github/workflows/              # CI/CD (e.g. deploy.yml)
├── flowchart/                      # React Flow visualization (Vite app)
├── ralph.sh                        # Legacy interactive loop
├── prd.json.example                # Example PRD
├── AGENTS.md                       # Agent instructions and boundaries
├── instructions.md                 # This file
├── README.md                       # Main docs
├── ORGANIZATION.md                 # Codebase organization
└── CHANGELOG.md                    # Change history
```

Generated at runtime (gitignored): `prd.json`, `progress.txt`, `.last-branch`, `.cursor/composer-prompt.md`, `archive/`.

## Build and run

**Flowchart (from repo root):**
```bash
cd flowchart && npm install && npm run dev   # Dev server
cd flowchart && npm run build                # Production build (tsc -b && vite build)
cd flowchart && npm run lint                  # ESLint
```

**Ralph workflow:** Use `/ralph-workflow` in Cursor Agent chat (no separate build). For legacy: `./ralph.sh [max_iterations]` from directory containing `prd.json`.

**Prerequisites:** `jq` installed for PRD scripts (`brew install jq` or equivalent).

## Key conventions

- One story per iteration. Stories should be completable in one context window.
- Commit message format: `feat: [Story ID] - [Story Title]`.
- Always run quality checks (typecheck, test, lint) before marking a story complete.
- Append learnings to `progress.txt`; consolidate reusable patterns in the Codebase Patterns section at the top.
- Update `AGENTS.md` when discovering reusable patterns.

## References

- [AGENTS.md](AGENTS.md) – Commands, boundaries, code style
- [.cursor/rules/README.md](.cursor/rules/README.md) – Rule format and priority
- [README.md](README.md) – User-facing quick start and docs
