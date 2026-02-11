# Cursor Rules (2026)

Rules in this directory follow Cursor's 2026 conventions for Apply Intelligently, priorities, and scoping.

## File Format (.mdc)

Each rule file uses YAML frontmatter and Markdown body:

```yaml
---
description: Brief description (used for agent selection when alwaysApply is false)
globs: "**/*.ts, **/*.tsx"   # optional; file patterns for auto-apply
alwaysApply: false           # true = applied to every chat
priority: 40                 # 10–20 global/core, 30–60 domain, 100 security
---

# Rule Title

Content in Markdown...
```

## Priority Hierarchy

| Priority | Use for |
|----------|--------|
| 10 | Core always-applied standards (e.g. `core-engineering.mdc`) |
| 15 | Workflow rules (Ralph, PRD, compound engineering) |
| 40 | Domain rules (backend, frontend, testing, frameworks) |
| 100 | Security and overrides (takes precedence) |

## Rule Types

- **Always** – `alwaysApply: true`. Applied to every chat. Keep short (e.g. core-engineering).
- **Auto (globs)** – `globs` set, `alwaysApply: false`. Applied when open file matches.
- **Agent-selected** – No globs, `alwaysApply: false`. Agent applies when description matches.
- **Manual** – Invoke with `@rule-name` in chat.

## Skills vs Rules

- **Rules** – Short, scoped instructions (this directory). Stored in `.cursor/rules/` as `.mdc`.
- **Skills** – Portable workflows and domain knowledge. Stored in `.cursor/skills/` as `SKILL.md`. Use `/skill-name` or agent discovery.

Workflow automation (Ralph, PRD generation) lives in **skills**; coding standards and framework guidance live in **rules**.

## React rules (split)

The React guide is split into four rules for smaller, composable scope (each under ~500 lines):

- **react.mdc** – Index; points to the three below. Same globs (`**/*.tsx`, `**/*.jsx`) so all apply when working in React files.
- **react-components.mdc** – Components, composition, conditional rendering, lists & keys, best practices, common patterns, checklist.
- **react-hooks.mdc** – useState, useEffect, useContext, useReducer, useMemo, useCallback, custom hooks, useRef.
- **react-state.mdc** – State management, event handling, forms, performance (memo, code splitting), error boundaries, testing.

Use `@react-components`, `@react-hooks`, or `@react-state` for targeted context.

## Indexing

Ensure **Settings → Indexing** includes `.cursor/rules` so Cursor applies rules correctly.
