---
description: Write session handoff
---

# UADF Session Handoff

Time to write a handoff before ending this session.

## Gather Information

Check the current state:
```bash
git status
git log --oneline -5
```

Review what we accomplished this session (scan recent conversation).

## Write Handoff

**Overwrite** `SESSION-HANDOFF.md` with the current state. This is the ONLY file the next session reads at startup.

Use this template:

```markdown
# Session Handoff

> This file is overwritten each session. For stable project knowledge, see MEMORY.md (auto-loaded).
> For full project history, see JOURNAL.md.

## Last Session: [TODAY'S DATE]

### What Was Done
- [List what was accomplished]
- [Include any commits made]

### Current State
- **Branch:** `[current branch]`
- **Last commit:** `[hash + message]`
- **Pushed:** [Yes/No]
- **Tests:** [All passing / N failing / Not run]

### Next Steps
1. [Immediate next action - be specific]
2. [Following action]

### Open Questions / Blockers
- [Anything unresolved]
```

## Append Summary to JOURNAL.md

Also append a **one-line summary** to `JOURNAL.md` for the archive:

```markdown
## Session [DATE] — [brief title]
[1-2 sentence summary. Branch: X. Commits: Y.]
```

Keep it brief — details live in SESSION-HANDOFF.md and git history.

## Update MEMORY.md if Needed

If stable project knowledge changed this session (new file paths, build rules, architecture decisions), update MEMORY.md. Don't put session-specific state there.

## Confirm

After writing the handoff, confirm what was written and say:
"Handoff complete. Run `/uadf-start` in your next session to resume."
