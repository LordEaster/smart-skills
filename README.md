# smart-skills

**Smart's** personal agent skills — "smart" is my name, not a description of the skills.

Inspired by [9arm-skills](https://github.com/9arm/9arm-skills).

---

## Layout

Skills live under bucket folders:

- `engineering/` — daily code work
- `productivity/` — daily non-code workflow tools
- `misc/` — kept around but rarely used
- `personal/` — tied to my own setup, not promoted
- `in-progress/` — drafts not yet ready to ship
- `deprecated/` — no longer used

Each skill is its own directory containing a `SKILL.md` (with YAML frontmatter — `name` and `description`) and any bundled scripts or reference files.

---

## Install

### Link (local)

Symlinks every shippable skill into `~/.claude/skills/` (Claude Code) and `~/.codex/skills/` (Codex). Skips any tool that isn't installed.

```bash
./scripts/link-skills.sh
```

Re-run this whenever you add or rename a skill.

### Via npx (global)

Install globally across all agents (Claude Code, Codex, Antigravity, Gemini CLI, GitHub Copilot, etc.) with the [skills CLI](https://skills.sh/):

```bash
npx skills add LordEaster/smart-skills -g
```

> Repo is currently private — requires GitHub access. Will be public once stable.

---

## Scripts

```bash
./scripts/list-skills.sh   # list all shippable skills with descriptions
./scripts/link-skills.sh   # symlink skills into installed agent dirs
```

---

## Skills

### Engineering

- **[address-pr-review](./engineering/address-pr-review/SKILL.md)** — Address, respond to, or action bot/AI review comments (Copilot, CodeRabbit, etc.) on a GitHub PR.
- **[finish-feature](./engineering/finish-feature/SKILL.md)** — Ship a completed fix or feature branch to development: runs tests, creates branch, commits, pushes, and opens a PR.

### Productivity

_(none yet)_

### Misc

_(none yet)_

---

## Adding a skill

1. Create `engineering/<skill-name>/SKILL.md` (or the appropriate bucket).
2. Add a frontmatter block with `name` and `description`.
3. Run `./scripts/link-skills.sh` to activate it.
4. Add an entry to the **Skills** section above.
