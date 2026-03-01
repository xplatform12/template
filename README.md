# Project Template Session Guide

## Status

- Status: `Active`
- Role: `Primary runbook`
- Source of truth scope: `Session-start orientation and top-level navigation`

## Read First

Read this file at the start of every new prompt before making changes.

## Session Start Checklist

1. Confirm task scope and target area (`templates/` or `docs/`).
2. If touching docs, follow `templates/docs/documentation-guide.md`.
3. Prefer updating the closest source-of-truth file before summary/index files.
4. If working in an existing/legacy area, treat migration gaps as expected and document exceptions.
5. Run relevant checks before finishing:
   - `make tools-check`
   - `make docs-check`
   - `make docs-status`

## Primary Entry Points

- Primary documentation policy: `templates/docs/documentation-guide.md`
- Template starter kit: `templates/README.md`
- AI collaboration guide template: `templates/AGENTS.md`
- GitHub connection guide: `docs/github-new-project-connection.md`

## Create A New Project

Use this repository as the source template for a new project:

1. Create a new local folder, for example `D:\dev\NewProjectName`.
2. Copy all contents of `templates/` into the new project root.
3. Replace `NewProjectName` in the copied files with the real project name.
4. Create the GitHub repository for the new project.
5. Initialize git in the new project if needed, add the GitHub remote, and push.
6. Run `make setup-check` in the new project root.
7. Start adding application code and project-specific build/test files.

For the detailed project setup flow, use `templates/README.md` and `docs/github-new-project-connection.md`.

## Area Map

- `templates/` (Active)
  - Canonical starter kit and standards.
- `docs/` (Active)
  - Project setup runbooks and example reference docs.

## Non-Negotiables

- Add a `## Status` section near the top of each markdown document.
- Update the closest source-of-truth file first.
- Keep migration exceptions explicit in a proposal or incident note.
