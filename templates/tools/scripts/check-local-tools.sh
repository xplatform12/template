#!/usr/bin/env bash
set -euo pipefail

if [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]; then
  cat <<'EOF'
Usage: check-local-tools.sh

Checks required and optional local commands used by docs tooling.
EOF
  exit 0
fi

required=(bash make rg)
optional=(pre-commit node npx markdownlint)

missing=0

echo "Checking required tools..."
for cmd in "${required[@]}"; do
  if command -v "$cmd" >/dev/null 2>&1; then
    printf "  [OK] %s\n" "$cmd"
  else
    printf "  [MISSING] %s\n" "$cmd"
    missing=1
  fi
done

echo
echo "Checking optional tools..."
for cmd in "${optional[@]}"; do
  if command -v "$cmd" >/dev/null 2>&1; then
    printf "  [OK] %s\n" "$cmd"
  else
    printf "  [OPTIONAL] %s (not installed)\n" "$cmd"
  fi
done

if [[ "$missing" -ne 0 ]]; then
  echo
  echo "tools-check failed: one or more required tools are missing."
  exit 1
fi

echo
echo "tools-check passed."
