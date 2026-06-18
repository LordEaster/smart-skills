After agy returns from a phase dispatch:

1. **Extract the report** (if not already isolated):
   `awk '/===AGY_REPORT===/,/===END===/' /tmp/agy-phase-N.log`
   Empty output? Don't guess — check the tail of the log to see what actually happened (crash, timeout, or agy just skipped the contract), then re-dispatch or treat as blocked.

2. **Cross-check the file list** — `git diff --stat`. Flag anything agy touched but didn't report, or reported but didn't actually touch.

3. **Read the real diff for touched files only** — `git diff -- <files from report>`. Don't `cat` whole files; the diff is enough unless something looks wrong.

4. **Re-run verification yourself** — don't trust agy's "Tests: pass" line. Run the same command and confirm; if there's no test suite, actually run the app (don't settle for "it compiles").

5. **Decide:**
   - Clean + verified → mark phase done, move to `templates/next-phase.md`
   - Small defect → send a follow-up dispatch (`templates/dispatch-task.md`) scoped to just the fix, defect described in 1–3 lines, no need to re-explain the whole phase
   - Wrong approach / genuinely blocked → stop, report to the user, don't auto-retry blindly
