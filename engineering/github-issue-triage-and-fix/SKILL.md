---
name: github-issue-triage-and-fix
description: Use when the user wants to inspect, triage, prioritize, group, or fix open GitHub issues — or when asked to work through a repo's issue backlog, fix bugs from issues, or implement issue-driven features.
---

# GitHub Issue Triage and Fix

## 0. Confirm Repo
**Hard rule:** Never guess. If no repo given, stop and ask: "Please provide the GitHub repository URL, owner/repo, or local path."
If in a git repo with a remote, infer owner/repo from `git remote -v`.

## 1. Discover Issues
```bash
gh issue list --repo owner/repo --state open --limit 100 --json number,title,body,labels,assignees,milestone,createdAt,updatedAt
gh issue view <N> --repo owner/repo --comments
```
Fallback: GitHub API. Neither available → tell user, ask for exported data.
Classify each: bug / feature / refactor / docs / test / infra / design.

## 2. Prioritize

| P | Criteria |
|---|----------|
| **P0** | Production-breaking, security, data loss, build/login broken, core workflow blocked |
| **P1** | Major user-facing bug, milestone feature, broken common-flow layout, incorrect data, stale cache, API failure on dashboard/map/panel/auth/admin |
| **P2** | Medium bug, UX improvement, partial feature, refactor blocker, test coverage |
| **P3** | Nice-to-have, minor visual, docs, non-blocking cleanup |

Respect existing priority labels but verify against content.

## 3. Group Issues
**Group when:** same feature area, files, root cause, UI/API flow, test setup, or deploy area.
**Don't group when:** unrelated modules, high conflict risk, bug fix + large feature, scope too large, different target branch.

## 4. Triage Report (output before any code)
```
# GitHub Issue Triage Report
Repository: owner/repo | Base branch: TBD

## Priority Order
P0: #N Title — reason
P1: #N Title — reason
P2/P3: #N Title — reason

## Fix Groups
Group 1: <name> | Issues: #N #N | Branch: fix/<name> | Risk: Low/Med/High
Why: ... | Area: ... | Notes: ...

## Recommended Order
1. Group 1 — reason

Running /grill-me next to clarify assumptions before implementation.
```

## 5. Mandatory /grill-me
**Do not write any code before this.** Before asking anything, read relevant source files to answer what you can yourself — only ask what the code cannot answer. Focus on: expected vs actual behavior, reproduction steps, affected users, acceptance criteria, urgency, group-or-separate, patch-or-refactor. Proceed only after answers or explicit "assume and continue."

## 6. Branch Selection
Default base: `development`. Before creating a branch, check topology:
```bash
git log --oneline -5 origin/development
git log --oneline -3 main
```
If `development` is ahead of `main`, always base off `development`:
```bash
git stash  # if you have uncommitted work
git fetch origin
git checkout -b fix/<name> origin/development
git stash pop  # re-apply work on top of the correct base
```

## 7. Working Branch Naming
`fix/` · `feature/` · `refactor/` · `docs/` · `test/` · `chore/` + `<number-or-short-topic>`
Multi-issue: `fix/<topic1-and-topic2>`. Keep names short.

## 8. Implement
1. Inspect related files — understand architecture first.
2. Smallest safe change that satisfies the issue.
3. Add/update tests where appropriate.
4. Run checks (use `bunx tsc --noEmit` if `bun run typecheck` fails due to missing global tsc):
   - `bunx tsc --noEmit` (typecheck)
   - `bun test` (tests)
   - `bun run build` (bundler)
5. Unrelated failures → report separately, don't fix silently.

## 9. Ship the Group
After all checks pass, commit and open a PR, then immediately switch back to `development` to continue the next group:
```bash
# stage only changed files by name — never git add -A
git add <specific files>
git commit -m "fix: <description>\n\nFixes #N, #M\n\nCo-Authored-By: ..."
git push -u origin <branch>
gh pr create --base development --title "..." --body "..."
git checkout development
# → continue next group
```

## 10. Sub-Agents (optional)
Triage · Codebase Mapper · Implementation · Test · Review — main agent owns all final decisions.

## 11. Final Summary
```
# Issue Fix Summary | Status: Done/Blocked/Needs Clarification
Repository: | Base branch: | Working branch:
Issues: #N Title
Changed: <what changed>
Files: path/to/file
Checks: typecheck ✓/✗ · tests ✓/✗ · build ✓/✗
PR: <url>
Next: continue next group on development
```

## Safety Rules
- Never push to `main`/`master`/`development` without explicit permission.
- Never force-push, delete branches, or rewrite history without explicit confirm.
- Never expose secrets or credentials.
- Never make unrelated refactors while fixing a scoped issue.
- Never close issues or assume deploy permission automatically.
- **Auth / permissions / DB migration / payments / security / data deletion → stop and confirm first.**
