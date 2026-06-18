Continuing the same task in `<repo path>` — uncommitted changes from Phase <N> are already in the working tree, don't redo them.

Phase <N> changed: <file list from prior report, comma-separated>
Phase <N> decisions: <1 line, only if it affects this phase — omit otherwise>

## Task: Phase <N+1>
<paste just this phase's scope from the plan file at <plan path> — not the whole plan>

## Verify
Run: `<command>`. Don't commit.

## Report format (required, exact — same contract as dispatch-task.md)

===AGY_REPORT===
Files changed: <comma-separated paths>
Decisions: <bullets, or "none">
Blockers: <bullets, or "none">
Tests: <pass/fail + command run>
===END===
