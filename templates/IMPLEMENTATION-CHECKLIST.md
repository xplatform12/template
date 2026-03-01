# Templates Rollout Checklist

## Status

- Status: `Active`
- Role: `Proposal`
- Source of truth scope: `Implementation checklist to make templates/ a drop-in starter kit`

## Goal

Copy everything from `templates/` into the root of a new repository and be ready to start immediately.

## Working Assumptions

- Existing files in target repositories are expected.
- Existing files must be brought into compliance with the template standards over time.
- The rollout should prefer additive changes first, then remediation of legacy docs.

## Checklist

1. Define the drop-in contract
- [x] Finalize required "day one" commands that must pass:
  - `make tools-check`
  - `make docs-check`
  - `make docs-status`
- [x] Decide if CI and pre-commit are default or optional.

2. Finalize generic documentation guide
- [x] Remove or replace any remaining placeholders that block first use.
- [x] Ensure all referenced template files are present in `templates/`.
- [x] Add a short "adopting in existing repos" migration note.

3. Provide root-level starter files in `templates/`
- [x] Add `README.md` for first-run instructions.
- [x] Add `Makefile` that wires docs/tooling commands directly.
- [x] Add baseline docs folders expected by policy:
  - `docs/incidents/`
  - `docs/runbooks/`
  - `docs/reference/`
  - `docs/proposals/`
  - `docs/templates/`

4. Harden tooling for real-world repos
- [x] Add `--help` output to each script.
- [x] Add configurable ignore patterns for `docs-check`.
- [x] Confirm `docs-status` behavior for empty and mixed-state repos.
- [x] Keep JSON output stable for automation use.

5. Add optional automation templates
- [x] Add `.pre-commit-config.yaml` template.
- [x] Add `.github/workflows/docs-check.yml` template.
- [x] Add `.github/workflows/markdownlint.yml` template.
- [x] Add `.markdownlint.jsonc` baseline template.

6. Add bootstrap and self-check workflow
- [x] Add `scripts/bootstrap-docs-template.sh`.
- [x] Add a `setup-check` make target that runs core checks.
- [x] Document first-run and migration commands in template README.

7. Prove in this repository (not a blank repo)
- [x] Apply templates here as if this were a target repo.
- [x] Identify all existing-file gaps against standard.
- [x] Remediate or catalog exceptions with follow-up tasks.
- [x] Re-run checks until core contract passes.

## Notes

- Existing/legacy files are expected to fail initially.
- Initial failures should be treated as migration backlog, not template failure, unless new template files are invalid.
