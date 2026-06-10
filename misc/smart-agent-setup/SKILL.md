---
name: smart-agent-setup
description: Use when setting up a new project with agent config files (CLAUDE.md, symlinks), git rules, planning doc structure, and per-service instruction files — or when auditing an existing project for missing pieces.
---

# Smart Agent Setup

Wizard-style project scaffolding. **Ask ONE question, wait for the answer, then ask the next.** Execute everything only after all questions are answered and the user confirms.

---

## Phase 1 — Detection

Run these checks in the current working directory:

| Check | Command |
|-------|---------|
| `.claude/CLAUDE.md` exists | `ls .claude/` |
| `AGENTS.md`, `GEMINI.md`, `.cursorrules` — symlinks? | `ls -la` and check symlink targets |
| `docs/plans/`, `docs/plans/done/`, `docs/specs/`, `docs/requirements/` | `ls docs/` |
| `.claude/` numbered service files (`01-*.md`, `02-*.md`, …) | `ls .claude/*.md` |

Print a status report before asking any questions:

```
Status
──────────────────────────────────────
.claude/CLAUDE.md      ✓ found  / ✗ missing
AGENTS.md              ✓ symlink / ✗ missing / ⚠ not a symlink
GEMINI.md              ✓ symlink / ✗ missing / ⚠ not a symlink
.cursorrules           ✓ symlink / ✗ missing / ⚠ not a symlink
docs/plans/            ✓ found  / ✗ missing
docs/plans/done/       ✓ found  / ✗ missing
docs/specs/            ✓ found  / ✗ missing
docs/requirements/     ✓ found  / ✗ missing
.claude/ service files  N found  / ✗ none
```

Skip items that already exist and are correct — only scaffold what is missing or broken.

---

## Phase 2 — Wizard (one question at a time)

### Q1 — Symlink targets

```
Which agent files should point to CLAUDE.md?
(all pre-selected — uncheck any you don't need, or add custom names)

  [✓] AGENTS.md
  [✓] GEMINI.md
  [✓] .cursorrules
  [ ] Other: ___
```

### Q2 — Sections

```
Generate all CLAUDE.md sections, or pick which ones?
  A) All sections
  B) Pick-and-choose
```

### Q3 — Project name

```
What is your project name?
```

### Q4 — Description

```
One sentence: what does this project do?
```

### Q5 — Tech stack

```
What's your tech stack? (e.g. React + Bun + Elysia)
```

### Q6 — Team size

```
Team size?
  A) Solo
  B) Small team (2–5)
  C) Large team (6+)
```

### Q7 — Extra rules

```
Any other rules to capture? (package manager, DB constraints, API rules, etc.)
Type them out, or say "no".
```

### Q8 — Section picker *(skip if "All sections" chosen in Q2)*

```
Which sections to include? (select all that apply)
  [ ] Hard Rules
  [ ] Before Implementing
  [ ] Git
  [ ] Planning (docs structure + naming conventions)
  [ ] Instruction Files (per-service stubs)
```

### Q9 — Git details *(if Git selected; ask each sub-question one at a time)*

1. `Branch strategy? A) main/development/feat…/fix…  B) main/feature/*  C) describe yours`
2. `Commit style? A) imperative ≤72 chars  B) conventional commits feat:/fix:  C) describe yours`
3. `Protected branches — never commit directly to? (e.g. "main development")`
4. `Where do feat/fix branches PR into? (e.g. "development")`
5. `Release strategy? A) manual  B) auto-tag on merge to main  C) describe yours`

### Q10 — Services *(if Instruction Files selected; ask each sub-question one at a time)*

1. `How many services or layers does your project have?`
2. For each: `Name for service N? (e.g. backend-api, frontend, worker)`

---

## Phase 3 — Summary & Execute

List everything that will be created/updated, for example:

```
Will create:
  .claude/CLAUDE.md              (new)
  AGENTS.md → .claude/CLAUDE.md  (symlink)
  GEMINI.md → .claude/CLAUDE.md  (symlink)
  .cursorrules → .claude/CLAUDE.md (symlink)
  docs/plans/_styles.css         (template)
  docs/plans/_template.html      (template)
  docs/plans/done/.gitkeep
  docs/specs/.gitkeep
  docs/requirements/.gitkeep
  .claude/01-backend-api.md      (stub)
  .claude/02-frontend.md         (stub)
```

Ask: **"Confirm? (yes / no)"** — do not create any files until the user says yes.

### Execution order

1. `mkdir -p .claude docs/plans/done docs/specs docs/requirements`
2. Write `.claude/CLAUDE.md` (see template below)
3. Create symlinks: `ln -sf .claude/CLAUDE.md AGENTS.md` (repeat for each chosen target)
4. Read templates from `{skill_base_dir}/templates/` and write to `docs/plans/`
5. Write `.gitkeep` in each empty folder
6. Write stub service files (see stub template below)

**`skill_base_dir`** is shown at the top of the skill output when invoked: `Base directory for this skill: /path/to/skill` — use that path to read the template files.

---

## CLAUDE.md Content Template

Fill in from the answers collected. Omit sections not chosen in Q8.

```markdown
# {Project Name} — Claude Instructions

{Description}. {Solo dev / Small team / Large team}. **Maintainability over cleverness.**

## Hard Rules

{user's rules from Q7, one bullet per rule}
{if none: - TODO: add architectural constraints}

## Before Implementing

1. Identify affected service: {service names joined with ·}
2. Read the relevant instruction file below.
3. Keep service boundaries clear.

## Planning

**Locations (never place files elsewhere):**
- `docs/plans/` — active/upcoming (`.html`)
- `docs/plans/done/` — completed, move here after implementation
- `docs/specs/` — design specs (`.html`)
- `docs/requirements/` — requirement group files (`.html`), one per role/category

**After finishing a feature:** move the plan file from `docs/plans/` → `docs/plans/done/`.
After moving, update the CSS link from `href="_styles.css"` → `href="../_styles.css"`.

**Format:** `.html` files using `docs/plans/_template.html`.
CSS lives in `docs/plans/_styles.css` (linked, not inline).

### Naming conventions

| Type | Pattern | Example |
|------|---------|---------|
| Spec | `S{NNN}-{YYYY-MM-DD}-{title}.html` | `S001-2026-01-01-name.html` |
| Plan | `P{NNN}-{YYYY-MM-DD}-{title}.html` | `P001-2026-01-01-name.html` |
| Requirement group | `{group}.html` | `FR-admin.html`, `NFR.html` |

- `NNN` is sequential and global.
- Assign numbers by date order (older = lower).
- Plans in `done/` keep their original P-number.

### When writing a plan

- File goes in `docs/plans/` with the `P{NNN}` prefix.
- Required `<head>` meta tags: `tasks`, `spec`, `requirements`.
- Code examples = type signatures + pseudocode only. No full implementations.
- No `Self-Review` section. Max ~6 tasks per file.

### Requirements files (`docs/requirements/`)

Starting groups: `FR-general.html` · `NFR.html`

## Instruction files

| File | Read when working on… |
|------|----------------------|
{row per service: | [{NN}-{service}.md]({NN}-{service}.md) | {service} — TODO: describe when to read | }

## Git

Commit messages: {commit style}. Don't commit `dist/`, `node_modules/`, `.env`.

**Branches:**
- `{main}` — stable releases only; never commit directly
- `{integration}` — integration branch; never commit directly
- `feat/…` / `fix/…` — branch from `{integration}` (default)

**PR targets:** `feat/fix` → `{integration}`.

**Release:** {release strategy}
```

---

## Service Instruction File Stub

For each service, write `.claude/{NN}-{service-name}.md` (NN = zero-padded index starting at 01):

```markdown
# {NN} — {Service Name}

## Overview

TODO: describe this service's responsibilities.

## Key files

TODO: list important files and directories.

## Patterns

TODO: add service-specific patterns, conventions, and anti-patterns.
```

---

## Rules

- Never overwrite an existing `.claude/CLAUDE.md` — if it exists, only add missing sections.
- Never overwrite existing symlinks that already point to the correct target.
- Never overwrite existing template files in `docs/plans/`.
- Always confirm before writing any file.
