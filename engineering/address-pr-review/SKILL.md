---
name: address-pr-review
description: Use when asked to address, respond to, or action bot/AI review comments (Copilot, CodeRabbit, etc.) on a GitHub PR. Requires an explicit PR URL or number — if not provided, ask for it.
---

# Address PR Review Comments

**Hard rule:** Never guess the PR. If no URL or number is given, ask before doing anything.

## Steps

**1. Fetch PR + diff**
```bash
gh pr view <N> --repo <owner/repo> --json title,body,headRefName,state
gh pr diff <N> --repo <owner/repo>
```

**2. Fetch bot comments**
```bash
gh api repos/<owner>/<repo>/pulls/<N>/comments | jq '[.[] | {id,path,line,body,user:.user.login}]'
gh api repos/<owner>/<repo>/issues/<N>/comments | jq '[.[] | {id,body,user:.user.login}]'
```
Filter to bot authors: `Copilot`, `coderabbitai`, `github-advanced-security`.

**3. Read full source files** — not just the diff. Bots often cite issues already handled by the framework or a newer language version.
```bash
gh api "repos/<owner>/<repo>/contents/<path>?ref=<sha>" | jq -r '.content' | base64 -d
```

**4. Classify each comment**

| Valid? | When |
|--------|------|
| Yes | Concern is reproducible in this codebase's actual setup |
| No | Wrong TS version assumption, library already handles it, `void` is intentional |

Common false positives:
- TS narrowing via `x?.y` in ternary — valid in TS 4.4+
- `void prefetchQuery(...)` unhandled rejection — TanStack Query catches internally
- `.catch()` suggestions when framework already swallows errors

**5. Fix valid comments** — minimum change, then commit + push to the PR branch.

**6. Reply to every comment**
```bash
# Inline reply
gh api repos/<owner>/<repo>/pulls/<N>/comments \
  --method POST --field body="Fixed — <one sentence>." --field in_reply_to=<id>

# Issue-level reply
gh api repos/<owner>/<repo>/issues/<N>/comments \
  --method POST --field body="Won't fix — <one sentence reason>."
```

Template: `Fixed — …` or `Won't fix — …`
