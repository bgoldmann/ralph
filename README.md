# Ralph

Autonomous AI agent loop for [Cursor IDE](https://cursor.com). Ralph completes user stories from a PRD iteratively until all items pass.

Based on [Geoffrey Huntley's Ralph pattern](https://ghuntley.com/ralph/).

## Quick Start

1. **Create a PRD** – Copy `ralph/prd.json.example` to `ralph/prd.json` and either edit it or use Cursor to generate one (see [PRD generation](#prd-generation)).
2. **Run the agent** – In Cursor Agent chat, type `/ralph-workflow`. The agent will:
   - Run init and generate prompts
   - Implement each story
   - Run quality checks, commit, and mark stories complete
   - Loop until all stories pass

## How It Works

The **ralph-workflow** skill (`/ralph-workflow`) is fully agent-driven:

1. `init.sh` – init progress, archive on branch change
2. `check-all-complete.sh` – exit if all stories complete
3. `generate-prompt.sh` – create `ralph/.cursor/composer-prompt.md` for the next story
4. Agent implements the story guided by `ralph/.cursorrules`
5. Quality checks, commit, `mark-story-complete.sh`, update `ralph/progress.txt`
6. Loop until all complete

Memory persists via git history, `ralph/progress.txt`, and `ralph/prd.json`.

## Commands

```bash
# Agent-driven: use /ralph-workflow in Agent chat

# Legacy (interactive): cd ralph && ./ralph.sh [max_iterations]

# Flowchart dev server
cd ralph/flowchart && npm run dev

# Flowchart build
cd ralph/flowchart && npm run build
```

## Key Files

| File | Purpose |
|------|---------|
| `ralph/.cursor/skills/ralph-workflow/scripts/` | Agent-driven workflow scripts (use `/ralph-workflow`) |
| `ralph/ralph.sh` | Legacy interactive loop (deprecated; use `/ralph-workflow`) |
| `ralph/.cursorrules` | Cursor AI instructions for the agent |
| `ralph/prd.json` | PRD with user stories and completion status |
| `ralph/progress.txt` | Append-only log of learnings and patterns |
| `ralph/.cursor/composer-prompt.md` | Generated prompt for the current story |
| `ralph/.cursor/composer-prompt-template.md` | Template used to build prompts |

## Cursor Rules & Skills

- **Rules** – 39 rules in `ralph/.cursor/rules/*.mdc` (2026 format with priority; one always-applied core rule). Use `@rule-name` in chat to apply.
- **Skills** – Workflow skills in `ralph/.cursor/skills/` (prd-generation, ralph-workflow, ios-xcode-2026, etc.). Use `/skill-name` in Agent chat.

See [ralph/.cursor/rules/README.md](ralph/.cursor/rules/README.md) for the full list.

## PRD Generation

Create a PRD from scratch or from an existing site/app:

- **From scratch**: Use `/prd-generation` in Agent chat or follow `ralph/.cursor/rules/prd-generation.mdc`.
- **From external**: Use `/prd-from-external` or `ralph/.cursor/rules/prd-from-external.mdc` to analyze a website or iOS app.

## Flowchart

The `ralph/flowchart/` directory has an interactive React Flow diagram of the Ralph workflow:

```bash
cd ralph/flowchart
npm install
npm run dev
```

## Patterns

- Work on **one story** per iteration.
- Keep stories small enough to finish in one Composer session.
- Update `ralph/AGENTS.md` and `ralph/progress.txt` with reusable patterns.
- Read the **Codebase Patterns** section in `progress.txt` before starting.

## Documentation

- [ORGANIZATION.md](ORGANIZATION.md) – Repository structure
- [CHANGELOG.md](CHANGELOG.md) – Change history
- [ralph/ORGANIZATION.md](ralph/ORGANIZATION.md) – Project organization (files, rules, workflow)
- [ralph/AGENTS.md](ralph/AGENTS.md) – Agent instructions
- [ralph/.cursor/composer-instructions.md](ralph/.cursor/composer-instructions.md) – Composer workflow

## License

MIT
