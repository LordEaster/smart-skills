---
name: smart-agent-setup
description: Use when setting up a new project with agent config files (CLAUDE.md, symlinks), git rules, planning doc structure, and per-service instruction files — or auditing an existing project for missing pieces.
---

# Smart Agent Setup

One question at a time. Execute only after user confirms.

## Phase 1 — Detect

```bash
ls -la && ls .claude/ 2>/dev/null && ls docs/ 2>/dev/null
```

Print status — ✓ ok / ✗ missing / ⚠ wrong — for each:
- `.claude/CLAUDE.md`
- `AGENTS.md`, `GEMINI.md`, `.cursorrules` (must be symlinks → `.claude/CLAUDE.md`)
- `docs/plans/`, `docs/plans/done/`, `docs/specs/`, `docs/requirements/`
- `.claude/01-*.md` service files

Only scaffold missing or broken items.

## Phase 2 — Wizard

Ask each question, wait for answer, then ask the next.

1. **Symlinks** — which files should point to CLAUDE.md? Default: `AGENTS.md` `GEMINI.md` `.cursorrules` — keep all, remove some, or add custom names?
2. **Sections** — all CLAUDE.md sections, or pick? Options: Hard Rules / Before Implementing / Git / Planning / Instruction Files
3. **Project name**
4. **Description** — one sentence
5. **Tech stack** — e.g. `React + Bun + Elysia`
6. **Team size** — A) Solo  B) Small (2–5)  C) Large (6+)
7. **Extra rules** — any architectural/package-manager/DB constraints? Or "no"
8. *(If pick-and-choose in Q2)* **Which sections?** — select from the list above
9. *(If Git chosen)* ask one at a time: branch strategy · commit style · protected branches · PR target · release strategy
10. *(If Instruction Files chosen)* how many services? name each one.

After Q7, ask: "Anything else to add to CLAUDE.md?" before moving on.

## Phase 3 — Confirm & Execute

Show full list of files to be created. Ask **"Confirm? (yes/no)"** — write nothing until yes.

Execution order:
1. `mkdir -p .claude docs/plans/done docs/specs docs/requirements`
2. Write `.claude/CLAUDE.md` — read `{skill_base_dir}/templates/CLAUDE.md.template`, substitute variables
3. Symlinks: `ln -sf .claude/CLAUDE.md AGENTS.md` (repeat per chosen target)
4. Copy `{skill_base_dir}/templates/_styles.css` → `docs/plans/_styles.css`
5. Copy `{skill_base_dir}/templates/_template.html` → `docs/plans/_template.html`
6. Write `.gitkeep` in `docs/plans/done/`, `docs/specs/`, `docs/requirements/`
7. Write service stubs (see below)

`skill_base_dir` = the path on the first line of skill output: `Base directory for this skill: /path/to/skill`

## CLAUDE.md Template Variables

Fill these when writing from `CLAUDE.md.template`:

| Variable | Source |
|----------|--------|
| `{PROJECT_NAME}` | Q3 |
| `{DESCRIPTION}` | Q4 |
| `{TEAM_SIZE}` | Q6 → "Solo dev" / "Small team" / "Large team" |
| `{HARD_RULES}` | Q7 bullets, or `- TODO: add architectural constraints` |
| `{SERVICES_LIST}` | Q10 names joined with ` · ` |
| `{INSTRUCTION_FILES_TABLE}` | One row per service: `\| [NN-name.md](NN-name.md) \| name — TODO: describe \|` |
| `{COMMIT_STYLE}` | Q9 commit answer |
| `{MAIN_BRANCH}` | Q9 branch answer |
| `{INTEGRATION_BRANCH}` | Q9 branch answer |
| `{RELEASE_STRATEGY}` | Q9 release answer |

Omit sections not chosen in Q2/Q8.

## Service Stub

Write `.claude/{NN}-{service}.md` per service (NN = zero-padded, starting at 01):

```markdown
# {NN} — {Service Name}

## Overview
TODO: describe responsibilities.

## Key files
TODO: list important paths.

## Patterns
TODO: conventions and anti-patterns.
```

## Safety

- Existing `.claude/CLAUDE.md` → only add missing sections, never overwrite.
- Existing symlink pointing to correct target → skip.
- Existing `docs/plans/` template files → skip.
- Always confirm before any write.
