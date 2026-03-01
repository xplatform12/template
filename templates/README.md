# Repository Starter Template

## Status

- Status: `Active`
- Role: `Primary runbook`
- Source of truth scope: `How to use this template baseline in a new repository`

This directory is a drop-in starter kit for a new GitHub-hosted project. Copy all contents of `templates/` into the root of a new repository, then replace placeholder names such as `NewProjectName`.

## Create A New Project

Use this sequence when starting a new repository from this template:

1. Create the new project folder, for example `D:\dev\NewProjectName`.
2. Copy all files from `templates/` into the new project root, including dotfiles.
3. Open the new project folder in your editor.
4. Search for `NewProjectName` and replace it with the real project name.
5. Review `AGENTS.md`, `README.md`, and the GitHub connection guide for any project-specific edits.
6. Create the GitHub repository.
7. Initialize git if the folder is not already a repository:

```bash
git init -b main
git add .
git commit -m "Initialize project from template"
```

8. Add the GitHub remote and push:

```bash
git remote add origin https://github.com/Xplatform12/NewProjectName.git
git push -u origin main
```

9. Run the baseline checks:

```bash
make setup-check
```

10. Start adding project-specific code, build files, and dependencies.

## Day One Commands

Run from repository root:

```bash
make bootstrap-docs
make setup-check
make tools-check
make docs-check
make docs-status
```

## Included Structure

- `docs/`
  - `documentation-guide.md`
  - `incidents/`
  - `runbooks/`
  - `reference/`
  - `proposals/`
  - `templates/`
- `tools/`
  - `Makefile`
  - `scripts/`
- `Makefile`
- `AGENTS.md`
- `.github/workflows/` (optional)
  - `docs-check.yml`
  - `markdownlint.yml`
- `.github/` (optional)
  - `PULL_REQUEST_TEMPLATE.md`
- `.pre-commit-config.yaml` (optional)
- `.markdownlint.jsonc` (optional)
- `.editorconfig`
- `.gitignore`
- `.env.example`

## Recommended Development Project Baseline

For a new development repository, keep these files in place from day one:

- `.editorconfig`
  - Normalizes whitespace, line endings, and indentation across editors.
- `.gitignore`
  - Keeps common local caches, build output, secrets, and editor files out of Git.
- `.env.example`
  - Documents required environment variables without committing secrets.
- `AGENTS.md`
  - Defines repository-level instructions and safety rules for Codex and other AI agents.
- `.github/PULL_REQUEST_TEMPLATE.md`
  - Standardizes pull request context, testing notes, and review expectations.

Recommended directories to add when application work starts:

- `src/`
- `tests/`

## Existing Repository Adoption

If this template is applied to an existing repository, existing files may initially fail checks. That is expected.

Required migration work:

- Add `## Status` metadata to legacy markdown files.
- Fix stale markdown path references.
- Move or rename docs to match the taxonomy over time.

Track migration exceptions in an incident note or proposal.

## Rollout Notes

- Step 7 retrospective: `docs/proposals/step-7-retrospective.md`
