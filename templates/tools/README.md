# Documentation Tooling Template

## Status

- Status: `Active`
- Role: `Runbook`
- Source of truth scope: `Reusable local docs-quality tooling for new repositories`

This folder provides a generic docs tooling baseline intended to be copied into a project repository.

## Included Commands

- `make tools-check`
  - Verifies required local commands and reports optional tools.
- `make docs-check`
  - Checks backticked Markdown `.md` path references and reports missing files.
- `make docs-status`
  - Summarizes active/archive doc counts and incident notes.

## Quick Start

From your project root:

```bash
make tools-check
make docs-check
make docs-status
```

Top-level `Makefile` integration:

```make
include tools/Makefile
```

## Notes

- Scripts assume they are run inside a Git working tree.
- `docs-check` validates only backticked path references ending in `.md`.
- Placeholder paths like `<area>/docs/...` are ignored by `docs-check`.
- Add `.docs-check-ignore` (newline-separated globs) to skip known legacy docs during migration.
