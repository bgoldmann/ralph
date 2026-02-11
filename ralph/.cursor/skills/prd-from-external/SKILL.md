---
name: prd-from-external
description: Create PRDs by analyzing existing websites or iOS apps. Use when reverse-engineering features, replicating an app, or extracting requirements from external sources.
---

# PRD from External Sources

Guide for generating Product Requirements Documents by analyzing existing websites or iOS apps. Use when you need to reverse-engineer or replicate features from external applications.

## When to Use

- Analyzing a website to replicate its features
- Creating a PRD from an iOS/App Store product
- Extracting requirements from a competitor or reference app
- Documenting observed UI/UX and flows for implementation

## Workflow Summary

### 1. Gather Information

**Websites:** Use browser automation (e.g. agent-browser or Cursor browser) to explore the site. Analyze homepage, user flows (signup, login, main features), navigation, forms. Capture screenshots and snapshots.

**iOS Apps:** Review App Store listing (description, screenshots, videos, reviews). If you have the app, document screens, navigation flow, and data patterns.

### 2. Extract Features

Organize into: Core Features, User Flows, UI/UX Patterns, Technical Observations (APIs, data models, auth if visible).

### 3. Generate PRD Structure

Use the standard PRD structure (see `.cursor/rules/prd-generation.md`), adapted for reverse engineering:

- Introduction/Overview (source, analysis date)
- Observed Features
- Goals (replicate, improve, adapt)
- User Stories (with **Observed Behavior** and Acceptance Criteria)
- Functional Requirements (exact behaviors from source)
- UI/UX Requirements (navigation, layout, components, interactions)
- Technical Considerations (inferred data models, API needs)
- Adaptations & Improvements (what to keep, improve, change, omit)
- Open Questions

### 4. Create User Stories

Convert observations to implementable stories. Each story should include:
- Description (As a [user]...)
- **Observed Behavior** (what you saw, how it worked)
- Acceptance Criteria (verifiable; include typecheck and browser verification for UI)

### 5. Validate & Refine

Cross-reference for completeness, prioritize MVP vs nice-to-haves, clarify unknowns, adapt for your context.

## Best Practices

- **Be systematic:** Homepage → main flows → key interactions; document thoroughly.
- **Capture visuals:** Screenshots and (if possible) recordings.
- **Infer, don't assume:** Clearly label Observed vs Inferred vs Unknown.
- **Focus on behavior:** What the app does (actions, responses, data, errors), not only appearance.
- **Adapt:** Adjust for your tech stack, user base, and constraints; improve where the source is weak.

## Output

Save to `tasks/prd-[feature-name].md`. Then use `prd-generation` and `ralph-task-workflow` to convert to `prd.json` and run Ralph.

## Verification

| Check | Action | Pass criteria |
|-------|--------|---------------|
| PRD file | Confirm file at `tasks/prd-[feature-name].md` | File exists, valid Markdown |
| Observed vs inferred | Review sections | Observed behavior labeled; inferred/unknown called out |
| User stories | Each story | Has Observed Behavior and verifiable acceptance criteria |
| UI stories | Any story with UI | Acceptance criteria include browser verification |

## Full Guide

For step-by-step analysis techniques, browser/iOS commands, and detailed templates, see the project rule: `.cursor/rules/prd-from-external.md`.
