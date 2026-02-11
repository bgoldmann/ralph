# Ralph Agent Instructions

## Overview

Ralph is an autonomous AI agent loop that uses Cursor IDE Composer repeatedly until all PRD items are complete. Each iteration uses Cursor Composer with clean context guided by `.cursorrules`.

## Commands (run from project root unless noted)

Put these first; the agent references them often. Include exact flags.

```bash
# Agent-driven workflow: use /ralph-workflow in Agent chat (no CLI needed)

# Legacy interactive loop (human-in-the-loop)
./ralph.sh [max_iterations]

# Flowchart: dev server
cd flowchart && npm run dev

# Flowchart: typecheck and build
cd flowchart && npm run build

# Flowchart: lint
cd flowchart && npm run lint

# Quality checks (when implementing stories; use your project's commands)
npm run typecheck   # or: tsc --noEmit
npm test            # or: npm test -- --coverage
npm run lint        # or: npm run lint -- --fix
```

## Tech Stack

- **Flowchart app:** React 19, TypeScript 5.9, Vite 7, React Flow (@xyflow/react)
- **Ralph core:** Bash, jq (required for PRD scripts)
- **Cursor:** Rules in `.cursor/rules/*.mdc`, skills in `.cursor/skills/*/SKILL.md`

## Key Files

- `ralph.sh` – Legacy bash loop that generates Composer prompts (human-in-the-loop)
- `.cursorrules` – Instructions for Cursor AI
- `prd.json.example` – Example PRD format
- `.cursor/` – Cursor IDE configuration and templates
- `.cursor/rules/*.mdc` – Cursor Rules (2026 format with priority; one always-applied core rule)
- `.cursor/skills/` – Agent Skills; use `/ralph-workflow` in Agent chat for agent-driven loop
- `flowchart/` – Interactive React Flow diagram explaining how Ralph works

## Boundaries

- **Always do:** Work on one story per iteration; run quality checks before commit; update `progress.txt` with learnings; use commit message `feat: [Story ID] - [Story Title]`; read Codebase Patterns in `progress.txt` before starting.
- **Ask first:** Changing database schema or CI/CD config; adding dependencies; major refactors across multiple modules.
- **Never do:** Commit secrets or API keys; edit `node_modules/` or `vendor/`; remove failing tests to make CI pass; skip quality checks before marking a story complete.

## Code Style (examples)

Prefer concrete examples over long prose.

**Commit messages – good:**
```bash
feat: US-001 - Add priority field to tasks table
feat: US-002 - Expose priority in API response
```

**Commit messages – avoid:**
```bash
fix stuff
WIP
```

**Progress entry – good:**
```
## 2026-02-11 - US-001
- Added `priority` column to tasks table; migration and API updated.
- **Learnings for future iterations:**
  - Use `IF NOT EXISTS` for migrations in this codebase.
  - Export types from `actions.ts` for UI components.
---
```

**Progress entry – avoid:** Story-only notes with no reusable learnings.

## Flowchart

The `flowchart/` directory contains an interactive visualization built with React Flow. It's designed for presentations - click through to reveal each step with animations.

To run locally:
```bash
cd flowchart
npm install
npm run dev
```

## Patterns

- Each iteration uses Cursor Composer with clean context
- Memory persists via git history, `progress.txt`, and `prd.json`
- Stories should be small enough to complete in one context window
- Always update AGENTS.md with discovered patterns for future iterations
- Rules (`.cursor/rules/*.mdc`) and Skills (`.cursor/skills/*/SKILL.md`) guide AI behavior; prefer `/ralph-workflow` for the full Ralph loop
