# Documentation Guide

## Status

- Status: `Active`
- Role: `Repo documentation policy`
- Audience: `Maintainers and operators`

This file defines the documentation taxonomy and update rules for this repository.

## Goals

- Make source-of-truth docs easy to identify
- Reduce duplication and drift between root and area docs
- Keep archived material clearly separated from active runbooks

## Document Types (Use One Explicitly)

- `Primary runbook`
  - Operational entry point for a system area (`README.md` in that area)
- `Runbook`
  - Procedure or troubleshooting guide for a specific workflow/service
- `Reference inventory snapshot`
  - Observed state (versions, ports, IDs, resources) at a point in time
- `Architecture reference`
  - Topology, request flow, design constraints, and invariants
- `Proposal` or `Recommendations`
  - Planned changes, guidance, or templates (not necessarily live state)
- `Incident note`
  - Dated troubleshooting record with symptoms, root cause, live changes, repo changes, and validation
- `Historical / Archived`
  - Session notes, legacy systems, or deprecated workflows retained for reference

## Required Header Pattern

Add a `## Status` section near the top of every Markdown file.

Minimum fields:

- `Status:` `Active` or `Archived / Historical`
- `Role:` one of the document types above

Recommended fields (use when relevant):

- `Source of truth scope:` what belongs in this file
- `Revalidate ...` note for live snapshots
- `Maintenance:` if archived/legacy
- `Removal:` if scheduled for cleanup

## README Responsibilities

- Root `README.md`
  - Project navigation and orientation
  - Active vs archived area classification
  - High-level environment map and documentation rules
  - Do not duplicate detailed taxonomy, templates, or tooling usage from this guide
- Area `README.md` (`<area>/README.md`)
  - Primary runbook for that area or subsystem
  - Cross-service operational invariants for that area
  - Links to deeper runbooks and inventories

## Where To Put Changes

- Update the closest source-of-truth file first
- Update root `README.md` only when:
  - navigation changes
  - area status changes (active/archive)
  - cross-system guidance changes

Examples:

- Database schema/retention change -> `<area>/docs/reference/<service>-inventory.md`
- Dashboard or monitoring provisioning change -> `<area>/docs/reference/<monitoring>-inventory.md`
- Access/auth flow change -> `<area>/README.md` or `<area>/docs/runbooks/access-runbook.md`
- Infrastructure inventory refresh -> `<area>/docs/reference/inventory.md`
- Local tooling requirements or execution-mode changes -> `<tooling-area>/README.md` or `<tooling-area>/docs/proposals/<topic>.md`
- Troubleshooting session with root cause and fix -> `<area>/docs/incidents/YYYY-MM-DD-*.md`

## Naming Conventions

- Use `README.md` for directory landing pages
- Use `kebab-case.md` for other docs
- Prefer short, role-oriented names (`access-runbook.md`, `grafana-inventory.md`)

## Live Validation Rules

- Use exact UTC dates/times for validation findings
- Do not store secrets/tokens/passwords in docs
- Document secret names/locations and rotation procedures only
- Re-check live state before acting on snapshot values

## Doc Hygiene Checks

Core checks:

- `make tools-check` (if available)
  - Verifies required local commands and reports optional tooling
- `make docs-check` (if available)
  - Use after renames/moves to catch stale repo-relative `.md` links
  - Can validate backticked Markdown path references and related policy checks
- `make docs-status` (if available)
  - Use for quick orientation across active vs archived docs

Common `docs-status` views:

- Area filter: `make docs-status ARGS='--areas=<area1>,<area2>'`
- Compact counts: `make docs-status ARGS='--compact'`
- Latest incidents (text): `make docs-status ARGS='--latest-incidents'`
- Latest incidents (JSON): `tools/scripts/docs-status.sh --json --latest-incidents`
- Full layout (JSON): `tools/scripts/docs-status.sh --json`

Automation and linting:

- Optional local hook: `.pre-commit-config.yaml` can run `make docs-check`
- Local markdownlint parity with CI: `make markdownlint`
- GitHub Actions docs check template: `.github/workflows/docs-check.yml` (optional)
- GitHub Actions markdown lint template: `.github/workflows/markdownlint.yml` (optional)
- Markdownlint repo config: `.markdownlint.jsonc` (optional)

## Archive Rules

- Mark archived areas and files explicitly
- Do not present archived docs as current runbooks
- Preserve historical context, but avoid backfilling incomplete historical doc sets unless needed for recovery

## Incident Note Rules

- Write incident notes in the affected active area:
  - `<area>/docs/incidents/`
  - `<tooling-area>/docs/incidents/` (if tooling-only incident)
- Use the shared template: `docs/templates/incident-note-template.md`
- Prefer one note per resolved incident (or per session if multiple related fixes were investigated)
- Include exact validation commands and UTC timestamps
- If multiple systems were involved, link the related notes across areas

## Adoption In Existing Repositories

- Existing files are an expected case during rollout.
- Legacy files should be incrementally brought into compliance with this guide:
  - Add `## Status` with required fields.
  - Normalize names and paths where practical.
  - Fix or remove stale Markdown path references.
- Keep migration changes explicit by documenting exceptions and cleanup follow-ups in an incident note or proposal.

## Suggested Template (Active Doc)

```md
# <Title>

## Status

- Status: `Active`
- Role: `<Primary runbook | Runbook | Reference inventory snapshot | Architecture reference | Proposal>`
- Source of truth scope: `<what this file owns>`
```

## Suggested Template (Incident Note)

```md
# Incident: <short title>

## Status

- Status: `Active`
- Role: `Incident note`
- Source of truth scope: `<what this file owns>`
```

## Suggested Template (Archived Doc)

```md
# <Title>

## Status

- Status: `Archived / Historical`
- Role: `<Historical note | Archived snapshot | Legacy reference>`
- Validation: `Not maintained`
```
