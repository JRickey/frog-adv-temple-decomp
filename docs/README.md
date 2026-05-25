# Agent notes — `docs/`

Topic-specific notes live here so `CLAUDE.md` stays small enough to load
into every agent context. Each file is a focused, append-only log on one
topic. Add to these as you learn; don't expand `CLAUDE.md`.

## Files

| File | Scope | What to add |
|---|---|---|
| `codegen-notes.md` | agbcc / Thumb / ARM codegen behavior | New compiler quirks, fold-prevention patterns, encoding gotchas, flag findings |
| `memory-map.md` | EWRAM / IWRAM / MMIO / ROM-data addresses | Newly-named addresses, struct layouts, gIntrTable entries, register usage |
| `subsystems.md` | Game-engine structure & call graph | New subsystems identified (audio, render, input), state-machine layouts, dispatcher patterns |
| `unknowns.md` | Open questions & hypotheses | Things you can't name yet, hypotheses to test, suspicious patterns |

## When to write

The bar is: **would a future agent benefit from knowing this without
re-deriving it?** If yes, add a short entry. If no, leave it in the
commit message (where it belongs).

- **Compiler quirk** that wasted ≥10 min → `codegen-notes.md`
- **Address** that got a semantic name → `memory-map.md`
- **Subsystem** boundary or call cluster discovered → `subsystems.md`
- **Hypothesis** about an unnamed function/value → `unknowns.md`

## When NOT to write

- The fact lives in the code/headers already (read the file instead).
- The fact is in `git log` (the commit message is the right place).
- The fact is ephemeral session state (use task tools, not docs).

## Conventions

- Lead with the address/symbol/pattern, then context.
- Quote actual bytes / instructions when relevant.
- Cross-link with relative paths: `see [memory-map.md](memory-map.md)`.
- Each file should stay ≤ ~400 lines. When one balloons, split into a
  sub-topic file and update the table above.
- No dates in entries — `git log` is authoritative for chronology.
