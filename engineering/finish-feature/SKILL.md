---
name: finish-feature
description: Use when the user wants to ship a completed fix or feature branch to development — runs tests, creates branch, commits, pushes, and opens a PR targeting development.
---

# Finish Feature / Fix

Ship completed work to `development`. Follow every step in order.

**Step 0 — Confirm first**
Ask: "Are you done and ready to ship?" Stop if no.

**Step 1 — Run tests**
```bash
bun test
```
Stop and show failures if any.

**Step 2 — Pick branch name** from `git diff --stat HEAD`:
- Bug fix → `fix/<3-5-word-description>`
- Feature → `feature/<3-5-word-description>`

**Step 3 — Create branch from development**
```bash
git checkout development && git pull origin development
git checkout -b <branch-name>
```

**Step 4 — Stage and commit** (only files for this fix — no `.claude/`, no stray configs)
```bash
git add <specific files>
git commit -m "$(cat <<'EOF'
<fix|feat>: <imperative summary, max 72 chars>

<2-3 lines: root cause and approach>

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
EOF
)"
```

**Step 5 — Push**
```bash
git push -u origin <branch-name>
```

**Step 6 — Open PR**
```bash
gh pr create --base development \
  --title "<commit subject>" \
  --body "$(cat <<'EOF'
## Summary
- <bullet>

## Test Plan
- [ ] <manual step>
- [ ] `bun test` passes

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

**Step 7 — Switch back**
```bash
git checkout -   # falls back to: git checkout development
```

Report PR URL and current branch.
