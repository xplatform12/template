# Step 7 Retrospective

## Status

- Status: `Active`
- Role: `Proposal`
- Source of truth scope: `Lessons learned from proving template adoption in an existing repository`

## Outcome

Template adoption in an existing repository succeeded.

Core contract passed after adoption work:

- `make tools-check`
- `make docs-check`
- `make docs-status`

## What Worked

- The template structure was usable when copied into repository root.
- Bootstrap and setup checks provided a clear first-run path.
- Existing-file migration was handled without blocking core checks.

## What We Changed During Step 7

- Added configurable ignore support to `tools/scripts/check-doc-paths.sh` via `.docs-check-ignore`.
- Added a temporary ignore entry for legacy example docs with intentionally non-local sample references.

## What We Would Do Differently Next Time

- Add `.docs-check-ignore` support earlier (during tooling hardening) before proving in a live repo.
- Tighten incident detection in `docs-status.sh` so non-incident files in incident folders are excluded.

## Future Notes

- Existing files are expected in real adoption scenarios.
- Keep `.docs-check-ignore` temporary and minimal.
- Track each ignore entry in a migration backlog and remove entries as files are remediated.
- Require `## Status` metadata on legacy docs as an early migration action.
- Keep automation templates GitHub Actions-first.
