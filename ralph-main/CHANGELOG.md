# Changelog

All notable changes to Ralph will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Added
- **Universal Template System** - Interactive CLI to scaffold projects for any platform
  - `init-ralph.sh` - Interactive CLI tool for project initialization
  - `scaffold.sh` - Project scaffolding engine
  - `generate-prd-from-config.sh` - PRD generator from project configuration
  - `project-config.schema.json` - Configuration schema for projects
  - `rule-selector.json` - Maps project types and tech stacks to Cursor Rules
  - `UNIVERSAL-TEMPLATE.md` - Comprehensive documentation for universal template system
  - Template directory structure supporting websites, web apps, iOS, Android, desktop, CLI, API, and full stack projects
  - Automatic rule selection based on project type and tech stack
  - Project templates with starter code and configurations
- Added `react.md` Cursor Rule - React development guide for components, hooks, state management, patterns, and performance
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
- Updated main `README.md` to include Universal Template quick start guide
- Created `ralph-main/README.md` with comprehensive documentation
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
