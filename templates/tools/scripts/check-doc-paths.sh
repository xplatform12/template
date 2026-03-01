#!/usr/bin/env bash
set -euo pipefail

if [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]; then
  cat <<'EOF'
Usage: check-doc-paths.sh [ROOT]

Checks backticked markdown path references that end in .md.
Validation focuses on repo-relative style paths (containing '/').

Options:
  ROOT               Optional root directory to scan.
  DOCS_CHECK_ROOT    Environment variable override for root directory.
  .docs-check-ignore Optional newline-separated list of markdown file globs to skip.
EOF
  exit 0
fi

ROOT="${DOCS_CHECK_ROOT:-${1:-$(pwd)}}"
cd "$ROOT"

ignore_file=".docs-check-ignore"
ignore_patterns=()
if [[ -f "$ignore_file" ]]; then
  while IFS= read -r line; do
    line="${line%%#*}"
    line="$(printf '%s' "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    [[ -z "$line" ]] && continue
    ignore_patterns+=("$line")
  done < "$ignore_file"
fi

if ! command -v rg >/dev/null 2>&1; then
  echo "docs-check requires 'rg' (ripgrep)."
  exit 1
fi

mapfile -t md_files < <(rg --files -g '*.md' .)

missing=0
checked=0

for md in "${md_files[@]}"; do
  rel_md="${md#./}"
  skip=0
  for pat in "${ignore_patterns[@]}"; do
    if [[ "$rel_md" == $pat ]]; then
      skip=1
      break
    fi
  done
  [[ "$skip" -eq 1 ]] && continue

  md_dir="$(dirname "${md#./}")"
  while IFS= read -r token; do
    ref="${token#\`}"
    ref="${ref%\`}"

    # Ignore non-path references and template placeholders.
    if [[ "$ref" == *"://"* ]] || [[ "$ref" == *"<"* ]] || [[ "$ref" == *">"* ]]; then
      continue
    fi

    # Treat single filenames as examples, not required repo-relative paths.
    if [[ "$ref" != */* ]]; then
      continue
    fi

    # Ignore anchors and punctuation suffixes.
    ref="${ref%%#*}"
    ref="${ref%%\)*}"
    ref="${ref%%,*}"
    [[ -z "$ref" ]] && continue

    checked=$((checked + 1))

    if [[ "$ref" == /* ]]; then
      exists=0
      [[ -f "$ref" ]] && exists=1
    else
      exists=0
      [[ -f "$ref" ]] && exists=1
      [[ -f "$md_dir/$ref" ]] && exists=1
    fi

    if [[ "$exists" -eq 0 ]]; then
      printf '[MISSING] %s -> `%s`\n' "$md" "$ref"
      missing=$((missing + 1))
    fi
  done < <(rg -o --no-filename '`[^`]+\.md`' "$md" || true)
done

echo "Checked $checked markdown path references."

if [[ "$missing" -gt 0 ]]; then
  echo "docs-check failed: $missing missing path reference(s)."
  exit 1
fi

echo "docs-check passed."
