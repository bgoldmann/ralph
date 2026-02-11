# Changelog

All notable changes to Ralph will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Added
- **iOS rules & skills 2026 updates** – Research-based concrete updates to close gaps
  - **ios-app.mdc**: Observation framework (@Observable, @Bindable) replacing ObservableObject; Swift 6 note; NavigationSplitView; Modern SwiftUI APIs (ViewThatFits, scrollTargetBehavior, SF Symbols 5, sensoryFeedback); Accessibility section; Dependency injection; Reserved names (avoid Task); Lazy containers with stable IDs
  - **xcode-ios.mdc**: Cursor + Sweetpad + Inject/HotSwiftUI for iOS development in Cursor with hot reload
  - **ios-xcode-2026 skill**: Swift 6, Observation framework, Sweetpad/Inject workflow in Quick Reference and When to Use
- **Skills, rules, workflow gap implementation (2026 best practices)** – Implemented plan from GitHub/Cursor best-practices gap analysis
  - **AGENTS.md** – Enhanced with commands (exact flags), tech stack, three-tier boundaries (Always do / Ask first / Never do), and code style examples (commit messages, progress entries)
  - **.cursorignore** – Added to exclude archive/, node_modules/, flowchart/node_modules/, *.log, .cursor/composer-prompt.md, .last-branch, progress.txt, prd.json from Cursor indexing
  - **instructions.md** – New agent-friendly project spec (features, tech stack, structure, build steps)
  - **.github/agents/** – Added ralph-agent.md and prd-agent.md for Copilot-style agent personas (commands, boundaries, project knowledge)
  - **React rules split** – Split react.mdc into react-components.mdc, react-hooks.mdc, react-state.mdc (each under ~500 lines); react.mdc retained as index with same globs; updated `.cursor/rules/README.md` with React split section
  - **Skills verification** – Added Verification sections to ralph-workflow, prd-generation, and prd-from-external skills (concrete commands and pass/fail criteria)
  - **flowchart/AGENTS.md** – Directory-level agent instructions for the flowchart app (tech stack, commands, conventions, boundaries)
  - **roadmap.md** – Milestones and future directions for long-term planning
  - **.github/copilot-instructions.md** – Workspace instructions for GitHub Copilot users (conventions, key files, boundaries)
- **Rules, skills, and workflow conversion (2026)** – Aligned with Cursor 2026 best practices
  - Added `priority` to all rule frontmatter: 10 = core, 15 = workflow, 40 = domain, 100 = security
  - Created `core-engineering.mdc` – always-applied rule (priority 10) for maintainable code and test coverage
  - Renamed all `.cursor/rules/*.md` to `.cursor/rules/*.mdc` (Cursor 2026 rule format)
  - Added `.cursor/rules/README.md` – documents .mdc format, priority hierarchy, rule types, and skills vs rules
  - Updated `.cursor/composer-instructions.md` with Rules and Skills (2026) section
  - Updated `AGENTS.md` to reference `.mdc` rules, skills, and `/ralph-workflow`
  - Updated `README.md` and `ORGANIZATION.md` for 39 rules, `.mdc` extension, and priority hierarchy
- **iOS 26 & Xcode 26 (2026)** – Research-based updates to rules and skills
  - Updated `ios-app.md` rule with iOS 26 content: Liquid Glass design, Foundation Models (on-device AI), App Intents, Declared Age Range, Games app, Live Translation
  - Added `xcode-ios.md` rule – Xcode 26 developer tools: Coding Tools (LLM), Swift Build, Icon Composer, Instruments, testing workflow
  - Added `ios-xcode-2026` skill – iOS 26/Xcode 26 development workflow covering Foundation Models, Liquid Glass, App Intents, and Xcode tooling
- Updated `README.md`, `ORGANIZATION.md` to reflect 38 rules and new ios-xcode-2026 skill
- **Option B: Fully agent-driven Ralph** – ralph-workflow skill now runs autonomously via scripts
  - `scripts/init.sh` – archive on branch change, init progress
  - `scripts/check-all-complete.sh` – check if all stories complete
  - `scripts/get-next-story.sh` – output next story JSON
  - `scripts/generate-prompt.sh` – generate `.cursor/composer-prompt.md`
  - `scripts/mark-story-complete.sh` – set `passes: true` for a story
- Added `README.md` – main documentation for Ralph setup, workflow, rules, and skills
- Added YAML frontmatter (description, globs, alwaysApply) to all 37 Cursor rules for 2026 Apply Intelligently activation
- Added `.cursor/skills/` with five Agent Skills (prd-generation, prd-from-external, ralph-workflow, ralph-task-workflow, compound-engineering) in open Agent Skills format for portable, discoverable workflow guidance
- Updated `.cursor/rules/README.md` with full Rule Format (2026) documentation, globs, and migrate-to-skills guidance

- Added `react.md` Cursor Rule - React development guide for components, hooks, state management, patterns, and performance
- Added `tailwind-css.md` Cursor Rule - Tailwind CSS guide for utility-first styling, responsive design, and modern UI development
- Added `graphql.md` Cursor Rule - GraphQL guide for schemas, queries, mutations, subscriptions, resolvers, and best practices
- Added `postgresql.md` Cursor Rule - PostgreSQL guide for SQL queries, migrations, indexing, optimization, and transactions
- Added `e2e-testing.md` Cursor Rule - End-to-end testing guide for Playwright, Cypress, test patterns, and CI/CD integration
- Added `firebase.md` Cursor Rule - Firebase integration guide for authentication, Firestore, storage, Cloud Functions, and real-time features
- Added `mcp.md` Cursor Rule - Model Context Protocol integration guide for connecting LLMs to external tools, data sources, and prompts
- Added `mcp/SKILL.md` legacy skill file - MCP skills documentation for reference
- Added `ralph-workflow.md` Cursor Rule - Complete guide to using Ralph and understanding `ralph.sh` script functionality
- Added `prd-from-external.md` Cursor Rule - Guide for creating PRDs by analyzing websites or iOS apps
- Added `seo.md` Cursor Rule - Comprehensive SEO guide for meta tags, structured data, sitemaps, and search engine optimization
- Added `google-services.md` Cursor Rule - Google services integration guide covering GCP, OAuth, Maps, Analytics, Drive, Sheets, and more
- Added `llms.md` Cursor Rule - Large Language Models integration guide for OpenAI, Anthropic, and other providers
- Added `llm-seo.md` Cursor Rule - LLM-assisted SEO guide combining AI content generation with SEO optimization

### Changed
- **ralph-workflow** – fully agent-driven; use `/ralph-workflow` in Agent chat instead of `./ralph.sh`
- **ralph.sh** – deprecated; kept for interactive/human-in-the-loop use
- Upgraded all 37 rules with YAML frontmatter: `description`, `globs`, `alwaysApply` for 2026 Apply Intelligently activation
- Added `globs` to 32 non-workflow rules for file-pattern activation (e.g. react→**/*.tsx, testing→**/*.spec.*)
- Updated `.cursor/composer-instructions.md` with tips for `@rule-name` and `/skill-name` invocation
- Core workflow rules (prd-generation, prd-from-external, ralph-workflow, ralph-task-workflow, compound-engineering) use YAML frontmatter for Cursor 2026 Apply Intelligently activation
- Updated rule count from 32 to 37 Cursor Rules
- Updated `.cursor/rules/README.md` to include React, Tailwind CSS, GraphQL, PostgreSQL, and E2E Testing rules
- Updated `ORGANIZATION.md` to reflect Backend now has 5 rules, Frontend has 5 rules, and Testing has 3 rules

## [Unreleased] (Previous)

### Added
- Created root-level `README.md` documenting repository structure and relationship between directories
- Added `amp-skills-main/README-LEGACY.md` explaining conversion status and reference purpose

### Removed
- Deleted broken symlinks `amp-skills-main/react-best-practices` and `amp-skills-main/web-design-guidelines` (pointed to non-existent vendor directories)
- Deleted `ralph-main/prompt.md` (content fully migrated to `.cursorrules`)
- Deleted `ralph-main/skills/` directory (content fully converted to `.cursor/rules/`)

### Changed
- Organized and cleaned up codebase structure
- Updated `amp-skills-main/README.md` with legacy/reference status notice
- Updated `ralph-main/ORGANIZATION.md` to include context about `amp-skills-main/` directory
- Enhanced `.gitignore` with comprehensive patterns for Node, Python, IDEs, and build outputs
- Updated `AGENTS.md` to reflect Cursor IDE usage instead of Amp CLI
- Reorganized `.cursor/rules/README.md` with clear categorization of all 24 rules
- Updated main `README.md` to include Cursor Rules section and enhanced file table
- Added `ORGANIZATION.md` documenting the complete codebase structure
- Fixed linter warnings in `AGENTS.md`

## [Unreleased] (Earlier)

### Added
- Converted Ralph from Amp CLI to Cursor IDE integration
- Created `.cursorrules` file for Cursor AI guidance
- Added `.cursor/` directory with Composer instructions and templates
- Added 24 Cursor Rules covering comprehensive development skills:
  - Core workflow: prd-generation, ralph-task-workflow, compound-engineering
  - Design: frontend-design, ui-ux
  - Backend: backend-development, fastapi, supabase
  - Frontend: nextjs, typescript
  - Services: stripe, coinbase-commerce, vercel
  - Testing: testing, agent-browser
  - DevOps: docker, cicd, git-github
  - Security & Performance: security, performance
  - Document processing: pdf-processing, docx-processing
  - Mobile: ios-app
- Modified `ralph.sh` to generate Cursor Composer prompts instead of calling Amp CLI
- Created Composer prompt template system
- Updated README.md for Cursor IDE usage
- Created comprehensive documentation in `.cursor/rules/README.md`

### Changed
- `prompt.md` marked as legacy (converted to `.cursorrules`)
- Workflow adapted from automated Amp CLI calls to Cursor Composer sessions
- Skills converted from Amp format to Cursor Rules format

### Deprecated
- `prompt.md` - Use `.cursorrules` instead (kept for reference)

## [1.0.0] - Original Amp-based Ralph

### Added
- Initial Ralph implementation using Amp CLI
- `ralph.sh` bash script for autonomous agent loop
- `prompt.md` instructions for Amp instances
- PRD generation and conversion skills
- Interactive flowchart visualization
- Archive system for previous runs
