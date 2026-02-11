# Ralph Composer Prompt - Story US-001

## Current Story

**ID:** US-001
**Title:** Add priority field to database
**Priority:** 1

**Description:**
As a developer, I need to store task priority so it persists across sessions.

## Acceptance Criteria

- Add priority column to tasks table: 'high' | 'medium' | 'low' (default 'medium')
- Generate and run migration successfully
- Typecheck passes

## Instructions

You are working on a Ralph story. Please follow these steps:

1. **Read the context:**
   - Review `.cursorrules` for workflow guidelines
   - Check `progress.txt` for Codebase Patterns (top section)
   - Review `AGENTS.md` files in relevant directories

2. **Check the branch:**
   - Ensure you're on the branch specified in `prd.json` (field: `branchName`)
   - If not, check it out or create it from main

3. **Implement the story:**
   - Work on ONLY this story (US-001)
   - Follow all acceptance criteria listed above
   - Keep changes focused and minimal

4. **Run quality checks:**
   - Typecheck: Run your project's typecheck command
   - Tests: Run tests if applicable
   - Lint: Run linter if applicable
   - Browser verification: If this is a UI story, verify in browser

5. **Update AGENTS.md** (if applicable):
   - If you discover reusable patterns, update relevant AGENTS.md files
   - Only add general, reusable knowledge

6. **Commit:**
   - Commit message: `feat: US-001 - Add priority field to database`
   - Only commit if all quality checks pass

7. **Update progress:**
   - Append to `progress.txt` following the format in `.cursorrules`
   - Include what was implemented, files changed, and learnings

8. **Update PRD:**
   - Set `passes: true` for story US-001 in `prd.json`

## Project Context

**Project:** MyApp
**Branch:** ralph/task-priority
**Feature:** Task Priority System - Add priority levels to tasks

## Notes

- Work on ONE story only
- Do not start another story until this one is complete
- If you encounter issues, document them in progress.txt learnings section
