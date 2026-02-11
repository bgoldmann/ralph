# Ralph Flowchart

Interactive [React Flow](https://reactflow.dev/) diagram that visualizes the Ralph workflow. Built for presentations – click through to reveal each step with animations.

## Tech Stack

- React 19, TypeScript 5.9, Vite 7
- [@xyflow/react](https://reactflow.dev/) – React Flow

## Commands

```bash
# From ralph/ directory
cd flowchart

# Install dependencies
npm install

# Dev server
npm run dev

# Typecheck and build
npm run build

# ESLint
npm run lint
```

## Purpose

The flowchart illustrates how Ralph works:

1. **Init** – Archive on branch change, init progress
2. **Check completion** – Exit if all stories pass
3. **Generate prompt** – Create `.cursor/composer-prompt.md` for next story
4. **Implement** – Agent implements the story
5. **Quality checks** – Typecheck, test, lint
6. **Commit & mark complete** – Update PRD, append to progress
7. **Loop** – Repeat until all stories complete

## Related

- [ralph/AGENTS.md](../AGENTS.md) – Flowchart-specific agent instructions
- [ralph/ralph-flowchart.png](../ralph-flowchart.png) – Static diagram (if present)
