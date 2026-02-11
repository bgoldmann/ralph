# Flowchart – Agent Instructions

Module-specific patterns for the Ralph flowchart app (React Flow diagram of the Ralph workflow).

## Purpose

The `flowchart/` app is an interactive React Flow visualization for presentations. It explains how Ralph works step-by-step with click-through animations.

## Tech Stack

- **React** 19, **TypeScript** 5.9, **Vite** 7
- **@xyflow/react** (React Flow) for the diagram
- **ESLint** for linting

## Commands (run from `flowchart/`)

```bash
npm install      # First time or after dependency changes
npm run dev      # Dev server
npm run build    # Production build (tsc -b && vite build)
npm run lint     # ESLint
```

## Structure

- `src/App.tsx` – Main app and React Flow setup
- `src/main.tsx` – Entry point
- `public/` – Static assets
- `index.html` – HTML entry

## Conventions

- Keep the diagram focused on the Ralph loop: init → get next story → implement → quality checks → commit → mark complete → repeat.
- Use existing React Flow patterns (nodes, edges, layout) already in the codebase.
- After editing, run `npm run build` and `npm run lint` to verify.

## Boundaries

- **Do:** Edit only under `flowchart/` for this app; follow existing component and styling patterns.
- **Ask first:** Adding new npm dependencies or changing the build setup.
- **Never:** Modify parent Ralph scripts (e.g. `ralph.sh`) or `.cursor/` from this directory without explicit scope.
