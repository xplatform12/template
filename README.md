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

## Area Map

- `templates/` (Active)
  - Canonical starter kit and standards.
- `docs/` (Active)
  - Project setup runbooks and example reference docs.

## Non-Negotiables

- Add a `## Status` section near the top of each markdown document.
- Update the closest source-of-truth file first.
- Keep migration exceptions explicit in a proposal or incident note.
