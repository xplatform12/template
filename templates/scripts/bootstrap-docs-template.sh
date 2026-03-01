#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/bootstrap-docs-template.sh [--check]

Initializes or validates the baseline docs/template structure for this repository.

Options:
  --check   Validate expected files/directories only; do not create anything.
  -h, --help  Show this help output.
USAGE
}

check_only=0
for arg in "$@"; do
  case "$arg" in
    --check)
      check_only=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $arg"
      usage
      exit 1
      ;;
  esac
done

ROOT="$(pwd)"

required_dirs=(
  "docs"
  "docs/incidents"
  "docs/runbooks"
  "docs/reference"
  "docs/proposals"
  "docs/templates"
  "tools"
  "tools/scripts"
  "scripts"
)

required_files=(
  "README.md"
  "Makefile"
  "docs/documentation-guide.md"
  "docs/templates/incident-note-template.md"
  "docs/README.md"
  "tools/Makefile"
  "tools/README.md"
)

missing=0

if [[ "$check_only" -eq 0 ]]; then
  echo "Bootstrapping baseline directories..."
  for d in "${required_dirs[@]}"; do
    mkdir -p "$ROOT/$d"
  done
fi

echo "Validating baseline directories..."
for d in "${required_dirs[@]}"; do
  if [[ -d "$ROOT/$d" ]]; then
    printf '  [OK] %s\n' "$d"
  else
    printf '  [MISSING] %s\n' "$d"
    missing=1
  fi
done

echo "Validating baseline files..."
for f in "${required_files[@]}"; do
  if [[ -f "$ROOT/$f" ]]; then
    printf '  [OK] %s\n' "$f"
  else
    printf '  [MISSING] %s\n' "$f"
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  echo
  echo "bootstrap-docs-template failed: baseline is incomplete."
  exit 1
fi

echo
if [[ "$check_only" -eq 1 ]]; then
  echo "bootstrap-docs-template check passed."
else
  echo "bootstrap-docs-template completed."
fi
