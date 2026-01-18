# Ralph Codebase

This repository contains Ralph, an autonomous AI agent loop for Cursor IDE, along with reference materials from the original Amp CLI implementation.

## Repository Structure

```
.
├── ralph-main/          # Main Ralph codebase (Cursor IDE version)
│   ├── .cursor/         # Cursor IDE configuration and rules
│   ├── ralph.sh         # Main Ralph loop script
│   ├── .cursorrules     # Cursor AI instructions
│   └── ...              # See ralph-main/README.md for details
│
└── amp-skills-main/     # Legacy Amp CLI skills (reference only)
    ├── ralph/           # Original Ralph skill
    ├── prd/             # PRD generation skill
    ├── agent-browser/   # Browser automation skill
    └── ...              # See amp-skills-main/README.md for details
```

## Quick Start

**For Ralph (Cursor IDE version):**

See [ralph-main/README.md](ralph-main/README.md) for setup and usage instructions.

**For reference materials:**

The `amp-skills-main/` directory contains the original Amp CLI skills that have been converted to Cursor Rules in `ralph-main/.cursor/rules/`. These are kept for reference only.

## What is Ralph?

Ralph is an autonomous AI agent loop that uses [Cursor IDE](https://cursor.sh) Composer repeatedly until all PRD items are complete. Each iteration uses Cursor Composer guided by `.cursorrules` with clean context. Memory persists via git history, `progress.txt`, and `prd.json`.

Based on [Geoffrey Huntley's Ralph pattern](https://ghuntley.com/ralph/).

## Main Directory

- **[ralph-main/](ralph-main/)** - The active Ralph codebase for Cursor IDE
  - Contains the main `ralph.sh` script
  - Includes 24 Cursor Rules for development
  - Ready to use with Cursor IDE

## Reference Directory

- **[amp-skills-main/](amp-skills-main/)** - Original Amp CLI skills (legacy)
  - Contains original Amp skill definitions
  - These skills have been converted to Cursor Rules
  - Kept for historical reference and conversion examples

## Documentation

- **Main documentation**: [ralph-main/README.md](ralph-main/README.md)
- **Organization guide**: [ralph-main/ORGANIZATION.md](ralph-main/ORGANIZATION.md)
- **Changelog**: [ralph-main/CHANGELOG.md](ralph-main/CHANGELOG.md)
- **Cursor Rules**: [ralph-main/.cursor/rules/README.md](ralph-main/.cursor/rules/README.md)

## Migration Notes

This codebase has been migrated from Amp CLI to Cursor IDE:

- **Original**: Used Amp CLI to execute AI agents
- **Current**: Uses Cursor IDE Composer with Cursor Rules
- **Skills**: Converted from Amp skills to Cursor Rules format
- **Workflow**: Adapted for Cursor's Composer interface

See `ralph-main/CHANGELOG.md` for detailed migration history.

## License

MIT
