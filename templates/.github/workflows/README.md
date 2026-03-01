# GitHub Actions Templates

## Status

- Status: `Active`
- Role: `Runbook`
- Source of truth scope: `Optional CI workflow templates for GitHub repositories`

Use these workflow files when adding GitHub Actions checks to a repository.

## Files

- `docs-check.yml`
  - Runs `make tools-check`, `make docs-check`, and compact `docs-status` output.
- `markdownlint.yml`
  - Installs `markdownlint-cli` via npm and runs markdown lint on `*.md` files.

## Suggested Usage

- Add one GitHub Actions workflow for docs checks using `.github/workflows/docs-check.yml`.
- Add a second optional GitHub Actions workflow for markdown linting using `.github/workflows/markdownlint.yml`.
