---
name: ralph-workflow
description: Fully agent-driven Ralph loop: implement PRD stories iteratively using scripts. Use when the user wants to run Ralph, complete PRD stories, or implement the next story. Replaces the interactive ralph.sh script.
disable-model-invocation: false
---

# Ralph Workflow (Agent-Driven)

Autonomous agent loop to complete user stories from `prd.json`. The agent runs scripts and implements each story until all pass.

## Prerequisites

- `prd.json` in project root (see `prd.json.example`)
- `.cursor/composer-prompt-template.md` exists
- `jq` installed (`brew install jq` or `choco install jq`)

## Scripts

All scripts run from **project root** (directory containing `prd.json`):

| Script | Purpose |
|--------|---------|
| `scripts/init.sh` | Archive on branch change, init progress.txt |
| `scripts/check-all-complete.sh` | Exit 0 if all stories complete, else 1 |
| `scripts/get-next-story.sh` | Output next incomplete story as JSON |
| `scripts/generate-prompt.sh` | Generate `.cursor/composer-prompt.md` |
| `scripts/mark-story-complete.sh` | Set `passes: true` for a story |

## Agent Workflow

Execute this loop until all stories complete:

### 1. Initialize (once)

```bash
bash .cursor/skills/ralph-workflow/scripts/init.sh
```

### 2. Check completion

```bash
bash .cursor/skills/ralph-workflow/scripts/check-all-complete.sh
```

If exit 0: **All stories complete.** Stop and inform the user.

### 3. Generate prompt for next story

```bash
bash .cursor/skills/ralph-workflow/scripts/generate-prompt.sh
```

This creates `.cursor/composer-prompt.md` with the current story.

### 4. Implement the story

- Read `.cursor/composer-prompt.md` for the story ID, title, description, and acceptance criteria
- Read `progress.txt` Codebase Patterns (top section)
- Ensure you're on the branch in `prd.json` (`branchName`)
- Implement **only** this story and fulfill all acceptance criteria
- Keep changes focused and minimal

### 5. Quality checks

- Run typecheck (e.g. `npm run typecheck` or `tsc --noEmit`)
- Run tests
- Run linter
- For UI stories: verify in browser

Do **not** proceed if any check fails.

### 6. Commit

```bash
git add -A
git commit -m "feat: [STORY_ID] - [STORY_TITLE]"
```

Use the actual story ID and title from the prompt.

### 7. Mark story complete

```bash
bash .cursor/skills/ralph-workflow/scripts/mark-story-complete.sh [STORY_ID]
```

### 8. Update progress

Append to `progress.txt`:

```
## [Date/Time] - [STORY_ID]
- What was implemented
- Files changed
- **Learnings for future iterations:**
  - Patterns discovered
  - Gotchas encountered
---
```

### 9. Loop

Return to step 2. Repeat until `check-all-complete.sh` exits 0.

## Optional: Update AGENTS.md

If you discover reusable patterns, add them to `AGENTS.md` in relevant directories.

## Verification

After each story implementation, confirm success with:

| Check | Command / action | Pass criteria |
|-------|------------------|---------------|
| Typecheck | `npm run typecheck` or `tsc --noEmit` | Exit 0 |
| Tests | `npm test` (or project equivalent) | All tests pass |
| Lint | `npm run lint` | No errors (or auto-fix applied) |
| Story complete | `bash .cursor/skills/ralph-workflow/scripts/mark-story-complete.sh [STORY_ID]` | `prd.json` has `passes: true` for that story |
| All complete | `bash .cursor/skills/ralph-workflow/scripts/check-all-complete.sh` | Exit 0 when no stories left with `passes: false` |

Do not commit or mark a story complete if any of typecheck, tests, or lint fails.

## Completion

When all stories have `passes: true`, inform the user that the Ralph workflow is complete.

## Reference

- `.cursorrules` – agent instructions
- `prd.json.example` – PRD format
- [references/REFERENCE.md](references/REFERENCE.md) – full guide
