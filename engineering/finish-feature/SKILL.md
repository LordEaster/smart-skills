---
name: finish-feature
description: Use when the user wants to ship a completed fix or feature branch — detects package manager and default branch, runs tests, commits, pushes, and opens a PR.
---

# Finish Feature / Fix

Ship completed work. Follow every step in order.

**Step 0 — Confirm first**
Ask: "Are you done and ready to ship?" Stop if no.

**Step 1 — Detect package manager** from lockfiles in the repo root:

| Lockfile | Command |
|----------|---------|
| `bun.lock` / `bun.lockb` | `bun test` |
| `pnpm-lock.yaml` | `pnpm test` |
| `yarn.lock` | `yarn test` |
| `package-lock.json` | `npm test` |
| none of the above | `npm test` |

Run the detected test command. Stop and show failures if any.

If no `package.json` exists (non-Node project), skip this step.

**Step 2 — Detect default branch**
```bash
git remote show origin | grep "HEAD branch" | awk '{print $NF}'
```
Use this as `<base-branch>`. Falls back to checking for `main`, then `master`, then `development` if the remote command fails.

**Step 3 — Pick branch name** from `git diff --stat HEAD`:
- Bug fix → `fix/<3-5-word-description>`
- Feature → `feature/<3-5-word-description>`

**Step 4 — Create branch from base**
```bash
git checkout <base-branch> && git pull origin <base-branch>
git checkout -b <branch-name>
```

**Step 5 — Stage and commit** (only files for this fix — no `.claude/`, no stray configs)
```bash
git add <specific files>
git commit -m "$(cat <<'EOF'
<fix|feat>: <imperative summary, max 72 chars>

<2-3 lines: root cause and approach>

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
EOF
)"
```

**Step 6 — Push**
```bash
git push -u origin <branch-name>
```

**Step 7 — Open PR**
```bash
gh pr create --base <base-branch> \
  --title "<commit subject>" \
  --body "$(cat <<'EOF'
## Summary
- <bullet>

## Test Plan
- [ ] <manual step>
- [ ] Tests pass

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

**Step 8 — Switch back**
```bash
git checkout -   # falls back to: git checkout <base-branch>
```

Report PR URL and current branch.
