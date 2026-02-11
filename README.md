# Ralph

Autonomous AI agent loop for [Cursor IDE](https://cursor.com). Ralph completes user stories from a PRD iteratively until all items pass.

Based on [Geoffrey Huntley's Ralph pattern](https://ghuntley.com/ralph/).

## Quick Start

1. **Create a PRD** – Copy `prd.json.example` to `prd.json` and either edit it or use Cursor to generate one (see [PRD generation](#prd-generation)).
2. **Run the agent** – In Cursor Agent chat, type `/ralph-workflow`. The agent will:
   - Run init and generate prompts
   - Implement each story
   - Run quality checks, commit, and mark stories complete
   - Loop until all stories pass

## How It Works

The **ralph-workflow** skill (`/ralph-workflow`) is fully agent-driven:

1. `init.sh` – init progress, archive on branch change
2. `check-all-complete.sh` – exit if all stories complete
3. `generate-prompt.sh` – create `.cursor/composer-prompt.md` for the next story
4. Agent implements the story guided by `.cursorrules`
5. Quality checks, commit, `mark-story-complete.sh`, update `progress.txt`
6. Loop until all complete

Memory persists via git history, `progress.txt`, and `prd.json`.

## Commands

```bash
# Agent-driven: use /ralph-workflow in Agent chat

# Legacy (interactive): ./ralph.sh [max_iterations]

# Flowchart dev server
cd flowchart && npm run dev

# Flowchart build
cd flowchart && npm run build
```

## Key Files

| File | Purpose |
|------|---------|
| `.cursor/skills/ralph-workflow/scripts/` | Agent-driven workflow scripts (use `/ralph-workflow`) |
| `ralph.sh` | Legacy interactive loop (deprecated; use `/ralph-workflow`) |
| `.cursorrules` | Cursor AI instructions for the agent |
| `prd.json` | PRD with user stories and completion status |
| `progress.txt` | Append-only log of learnings and patterns |
| `.cursor/composer-prompt.md` | Generated prompt for the current story |
| `.cursor/composer-prompt-template.md` | Template used to build prompts |

## Cursor Rules & Skills

- **Rules** – 39 rules in `.cursor/rules/*.mdc` (2026 format with priority; one always-applied core rule). Use `@rule-name` in chat to apply.
- **Skills** – Workflow skills in `.cursor/skills/` (prd-generation, ralph-workflow, ios-xcode-2026, etc.). Use `/skill-name` in Agent chat.

See [`.cursor/rules/README.md`](.cursor/rules/README.md) for the full list.

## PRD Generation

Create a PRD from scratch or from an existing site/app:

- **From scratch**: Use `/prd-generation` in Agent chat or follow `.cursor/rules/prd-generation.mdc`.
- **From external**: Use `/prd-from-external` or `.cursor/rules/prd-from-external.mdc` to analyze a website or iOS app.

## Flowchart

The `flowchart/` directory has an interactive React Flow diagram of the Ralph workflow:

```bash
cd flowchart
npm install
npm run dev
```

## Patterns

- Work on **one story** per iteration.
- Keep stories small enough to finish in one Composer session.
- Update `AGENTS.md` and `progress.txt` with reusable patterns.
- Read the **Codebase Patterns** section in `progress.txt` before starting.

## Documentation

- [ORGANIZATION.md](ORGANIZATION.md) – Codebase structure
- [CHANGELOG.md](CHANGELOG.md) – Change history
- [AGENTS.md](AGENTS.md) – Agent instructions
- [.cursor/composer-instructions.md](.cursor/composer-instructions.md) – Composer workflow

## License

MIT
