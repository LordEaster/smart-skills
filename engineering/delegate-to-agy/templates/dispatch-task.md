You are implementing **Phase <N> only** of a larger task in `<repo path>`. Read `<CLAUDE.md / instruction file path, if any>` first for project conventions. Do not touch files outside this phase's scope.

## Context (minimal)
<1–3 lines: what's already true / already done in prior phases — omit if this is phase 1>

## Task
<numbered, concrete steps. Name exact files, functions, components, and the exact behavior change. No background, no padding.>

## Out of scope
<bullets — explicitly what NOT to touch, only if scope creep is a real risk; omit otherwise>

## Verify
Run: `<test/typecheck/build command(s)>`
Fix failures before reporting done. Don't commit.

## Report format (required, exact — end your response with this and nothing after it)

===AGY_REPORT===
Files changed: <comma-separated paths>
Decisions: <bullets, only non-obvious choices — "none" if none>
Blockers: <bullets, or "none">
Tests: <pass/fail + command run>
===END===

Keep everything before the report brief. Do not repeat the report content elsewhere in your response.
