#!/usr/bin/env bash
set -euo pipefail

REPO="$(cd "$(dirname "$0")/.." && pwd)"

# Collect bucket dirs that actually exist
BUCKETS=()
for bucket in engineering productivity misc research; do
  [ -d "$REPO/$bucket" ] && BUCKETS+=("$REPO/$bucket")
done

if [ ${#BUCKETS[@]} -eq 0 ]; then
  echo "no skill buckets found under $REPO" >&2
  exit 1
fi

find "${BUCKETS[@]}" -name SKILL.md \
  -not -path '*/node_modules/*' \
  -not -path '*/deprecated/*' \
  -not -path '*/in-progress/*' \
  -not -path '*/personal/*' \
  -print0 |
sort -z |
while IFS= read -r -d '' skill_md; do
  skill_dir="$(dirname "$skill_md")"
  name="$(basename "$skill_dir")"
  bucket="$(basename "$(dirname "$skill_dir")")"

  # Extract description from SKILL.md frontmatter
  desc="$(awk '/^---/{f++; next} f==1 && /^description:/{sub(/^description:[[:space:]]*/, ""); print; exit}' "$skill_md")"

  printf "%-12s  %-30s  %s\n" "$bucket" "$name" "$desc"
done
