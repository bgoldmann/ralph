# GitHub Copilot workspace instructions

This file provides workspace-level guidance for GitHub Copilot so that suggestions stay consistent with Ralph and this repo. For Cursor IDE, primary instructions live in `.cursorrules` and `.cursor/rules/*.mdc`.

## Project

Ralph is an autonomous AI agent loop for Cursor that completes user stories from a PRD (`prd.json`) iteratively. The agent-driven workflow uses scripts under `.cursor/skills/ralph-workflow/scripts/`.

## Conventions

- **One story per iteration** – Work on a single user story; commit with `feat: [Story ID] - [Story Title]`.
- **Quality first** – Run typecheck, tests, and lint before marking a story complete. Do not commit failing code.
- **Progress** – Append learnings to `progress.txt`; keep a Codebase Patterns section at the top for reusable patterns.
- **PRD** – User stories live in `prd.json` with `id`, `title`, `description`, `acceptanceCriteria`, `priority`, `passes`.

## Key files

- `prd.json` – Product requirements and story completion status
- `.cursorrules` – Cursor AI instructions for story implementation
- `.cursor/rules/*.mdc` – Cursor rules (2026 format)
- `.cursor/skills/` – Workflow skills (e.g. ralph-workflow)
- `AGENTS.md` – Commands, boundaries, code style
- `instructions.md` – Project spec (features, tech stack, structure)

## Tech stack (this repo)

- Ralph core: Bash, jq
- Flowchart app: React 19, TypeScript 5.9, Vite 7, React Flow

## Boundaries

- Do not commit secrets or API keys.
- Do not remove or skip failing tests to pass CI.
- When changing schema or CI/CD, prefer asking for confirmation.

For full agent behavior and workflow details, see `AGENTS.md` and `.cursorrules`.
