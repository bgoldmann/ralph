# Ralph Agent Instructions

## Overview

Ralph is an autonomous AI agent loop that uses Cursor IDE Composer repeatedly until all PRD items are complete. Each iteration uses Cursor Composer with clean context guided by `.cursorrules`.

## Commands

```bash
# Run the flowchart dev server
cd flowchart && npm run dev

# Build the flowchart
cd flowchart && npm run build

# Run Ralph (from your project that has prd.json)
./ralph.sh [max_iterations]
```

## Key Files

- `ralph.sh` - The bash loop that generates Composer prompts
- `.cursorrules` - Instructions for Cursor AI
- `prd.json.example` - Example PRD format
- `.cursor/` - Cursor IDE configuration and templates
- `.cursor/rules/` - Cursor Rules for various development skills
- `flowchart/` - Interactive React Flow diagram explaining how Ralph works

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
- Cursor Rules in `.cursor/rules/` guide AI behavior across all development tasks