#!/usr/bin/env bash
set -euo pipefail

# Links all skills in smart-skills to each installed agent's skills dir.
# Skips targets whose tool is not installed (no binary and no existing skills dir).

REPO="$(cd "$(dirname "$0")/.." && pwd)"

# Parallel arrays: destination dir and binary name
DEST_DIRS=(
  "$HOME/.claude/skills"
  "$HOME/.codex/skills"
  "$HOME/.gemini/config/skills"
  "$HOME/.gemini/antigravity-cli/skills"
)
BINARIES=(
  "claude"
  "codex"
  "antigravity"
  "antigravity"
)

# Collect bucket dirs that actually exist
BUCKETS=()
for bucket in engineering productivity misc research; do
  [ -d "$REPO/$bucket" ] && BUCKETS+=("$REPO/$bucket")
done

if [ ${#BUCKETS[@]} -eq 0 ]; then
  echo "error: no skill buckets found under $REPO" >&2
  exit 1
fi

link_skills_to_dir() {
  local DEST="$1" label="$2"
  mkdir -p "$DEST"
  find "${BUCKETS[@]}" -name SKILL.md \
    -not -path '*/node_modules/*' \
    -not -path '*/deprecated/*' \
    -not -path '*/in-progress/*' \
    -not -path '*/personal/*' \
    -print0 |
  while IFS= read -r -d '' skill_md; do
    src="$(dirname "$skill_md")"
    name="$(basename "$src")"
    target="$DEST/$name"
    if [ -e "$target" ] && [ ! -L "$target" ]; then rm -rf "$target"; fi
    ln -sfn "$src" "$target"
    echo "linked [$label] $name"
  done
}

i=0
while [ $i -lt ${#DEST_DIRS[@]} ]; do
  DEST="${DEST_DIRS[$i]}"
  BINARY="${BINARIES[$i]}"
  i=$((i + 1))

  if ! command -v "$BINARY" &>/dev/null && [ ! -d "$DEST" ]; then
    echo "skip [$BINARY] not installed and $DEST does not exist"
    continue
  fi

  if [ -L "$DEST" ]; then
    resolved="$(readlink -f "$DEST")"
    case "$resolved" in
      "$REPO"|"$REPO"/*)
        echo "error: $DEST is a symlink into this repo ($resolved)." >&2
        echo "Remove it (rm \"$DEST\") and re-run." >&2
        exit 1
        ;;
    esac
  fi

  link_skills_to_dir "$DEST" "$BINARY"
done

# Also keep the Claude plugin namespace (smart-skills:*) in sync
PLUGIN_SKILLS_DIR="$HOME/.claude/plugins/cache/local/smart-skills/1.0.0/skills"
link_skills_to_dir "$PLUGIN_SKILLS_DIR" "smart-skills plugin"
