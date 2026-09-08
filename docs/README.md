# Agent notes — `docs/`

The active workflow is `AGENTS.md` and [matching-workflow.md](matching-workflow.md).
Reusable claims now live in `evidence/*.json`, with source/commit provenance.
Existing topic notes remain detailed references; retrieve relevant sections
instead of loading them all. `CLAUDE.md` is preserved unchanged.

## Files

| File | Scope | What to add |
|---|---|---|
| `matching-workflow.md` | Active campaign workflow | Evidence, interface review, model routing |
| `evidence/*.json` | Reviewable knowledge graph | Claims, provenance, relations, prerequisites |
| `campaigns/` | Accepted campaign reports | Actual outcomes, checks, routing observations |
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
- The fact is ephemeral session state: keep raw trials in ignored scratch;
  preserve only reusable findings and concise campaign outcomes in Git.

## Conventions

- Lead with the address/symbol/pattern, then context.
- Quote actual bytes / instructions when relevant.
- Cross-link with relative paths: `see [memory-map.md](memory-map.md)`.
- Each file should stay ≤ ~400 lines. When one balloons, split into a
  sub-topic file and update the table above.
- No dates in entries — `git log` is authoritative for chronology.

## Retrieval

```sh
python3 tools/agent/evidence.py validate
python3 tools/agent/evidence.py brief EntityHitbox_RegisterGridPoints --limit 8
python3 tools/agent/evidence.py plan hitbox --json
```

A verified historical claim must cite its matching commit. Mark disproved
claims superseded and link the replacement; never convert a failed experiment
into a universal compiler limitation. Knowledge relations may cycle; explicit
prerequisites must be acyclic. See the workflow for the record schema.
