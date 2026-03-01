#!/usr/bin/env bash
set -euo pipefail

areas_filter=""
compact=0
json=0
latest_incidents=0
root_override="${DOCS_STATUS_ROOT:-}"

for arg in "$@"; do
  case "$arg" in
    -h|--help)
      cat <<'EOF'
Usage: docs-status.sh [--areas=a,b] [--compact] [--json] [--latest-incidents]

Summarizes markdown document status by top-level area.

Options:
  --areas=a,b         Restrict output to specific top-level areas.
  --compact           Print one-line summary per area.
  --json              Emit JSON output.
  --latest-incidents  Include latest incident per area in text output.
  DOCS_STATUS_ROOT    Environment variable override for scan root.
EOF
      exit 0
      ;;
    --areas=*)
      areas_filter="${arg#--areas=}"
      ;;
    --compact)
      compact=1
      ;;
    --json)
      json=1
      ;;
    --latest-incidents)
      latest_incidents=1
      ;;
    *)
      echo "Unknown argument: $arg"
      exit 1
      ;;
  esac
done

ROOT="${root_override:-$(pwd)}"
cd "$ROOT"

is_area_allowed() {
  local area="$1"
  if [[ -z "$areas_filter" ]]; then
    return 0
  fi
  IFS=',' read -r -a selected <<< "$areas_filter"
  for s in "${selected[@]}"; do
    [[ "$area" == "$s" ]] && return 0
  done
  return 1
}

mapfile -t md_files < <(rg --files -g '*.md' .)

declare -A area_active=()
declare -A area_archived=()
declare -A area_other=()

declare -A latest_incident_by_area=()

for md in "${md_files[@]}"; do
  rel="${md#./}"
  area="${rel%%/*}"
  [[ "$area" == "$rel" ]] && area="root"

  if ! is_area_allowed "$area"; then
    continue
  fi

  if rg -q '^- Status:\s*`Archived / Historical`' "$md"; then
    area_archived["$area"]=$(( ${area_archived["$area"]:-0} + 1 ))
  elif rg -q '^- Status:\s*`Active`' "$md"; then
    area_active["$area"]=$(( ${area_active["$area"]:-0} + 1 ))
  else
    area_other["$area"]=$(( ${area_other["$area"]:-0} + 1 ))
  fi

  if [[ "$md" == *"/incidents/"*".md" ]]; then
    base="$(basename "$md")"
    current="${latest_incident_by_area["$area"]:-}"
    if [[ -z "$current" || "$base" > "$current" ]]; then
      latest_incident_by_area["$area"]="$base"
    fi
  fi
done

mapfile -t all_areas < <(
  {
    printf "%s\n" "${!area_active[@]}"
    printf "%s\n" "${!area_archived[@]}"
    printf "%s\n" "${!area_other[@]}"
  } | rg -v '^$' | sort -u
)

if [[ "$json" -eq 1 ]]; then
  printf '{\n  "areas": [\n'
  for i in "${!all_areas[@]}"; do
    a="${all_areas[$i]}"
    active="${area_active[$a]:-0}"
    archived="${area_archived[$a]:-0}"
    other="${area_other[$a]:-0}"
    inc="${latest_incident_by_area[$a]:-}"
    printf '    {"area":"%s","active":%d,"archived":%d,"other":%d' "$a" "$active" "$archived" "$other"
    if [[ -n "$inc" ]]; then
      printf ',"latest_incident":"%s"' "$inc"
    fi
    printf '}'
    if [[ "$i" -lt $((${#all_areas[@]} - 1)) ]]; then
      printf ','
    fi
    printf '\n'
  done
  printf '  ]\n}\n'
  exit 0
fi

if [[ "$compact" -eq 0 ]]; then
  echo "Documentation Status"
  echo "Repository: $ROOT"
  echo
fi

if [[ "${#all_areas[@]}" -eq 0 ]]; then
  echo "No markdown files found for selected scope."
  exit 0
fi

for a in "${all_areas[@]}"; do
  active="${area_active[$a]:-0}"
  archived="${area_archived[$a]:-0}"
  other="${area_other[$a]:-0}"

  if [[ "$compact" -eq 1 ]]; then
    echo "$a active=$active archived=$archived other=$other"
  else
    echo "- $a"
    echo "  Active: $active"
    echo "  Archived: $archived"
    echo "  Other/Unclassified: $other"
    if [[ "$latest_incidents" -eq 1 ]]; then
      if [[ -n "${latest_incident_by_area[$a]:-}" ]]; then
        echo "  Latest incident: ${latest_incident_by_area[$a]}"
      else
        echo "  Latest incident: none"
      fi
    fi
  fi
done
