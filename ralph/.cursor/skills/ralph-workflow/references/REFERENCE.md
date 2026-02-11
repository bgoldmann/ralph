# Ralph Workflow - Full Reference

For the main workflow steps see SKILL.md. This reference covers archive system, error handling, advanced usage, and checklist.

## Archive System

Ralph automatically archives previous runs when the branch changes:

```
archive/
└── YYYY-MM-DD-feature-name/
    ├── prd.json
    └── progress.txt
```

**When archiving happens:** New `branchName` detected in `prd.json`, different from branch in `.last-branch`.

## Completion Detection

- Ralph counts stories where `passes == false`; if 0, exits successfully.
- Manual check: `jq '[.userStories[] | select(.passes == false)] | length' prd.json`

## Error Handling

- **Missing PRD:** Create `prd.json` from `prd.json.example` or use PRD generation guides.
- **Missing template:** Ensure `.cursor/composer-prompt-template.md` exists.
- **No incomplete stories:** All complete or check `prd.json` format.

## Advanced Usage

- Custom iterations: `./ralph.sh 1` or `./ralph.sh 50`
- Ralph looks for files relative to where `ralph.sh` is located.
- Branch: Ralph respects `branchName` in `prd.json`; does not auto-checkout.

## Checklist

Before running Ralph: prd.json exists, template exists, git repo, jq installed, Cursor available, stories prioritized, branch planned.

During session: Follow Composer prompt, run quality checks, commit with `feat: US-001 - Title`, update prd.json passes, document in progress.txt, press ENTER.
