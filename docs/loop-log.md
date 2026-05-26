# Autonomous decomp+data loop — per-iteration log

Append-only log of each loop iteration's actions and outcomes. New entries
go at the **bottom**. The user reads top-down on wake to reconstruct what
the loop did overnight.

Each iteration records:
- Timestamp + scoreboard snapshot (before, after)
- Targets dispatched (decomp + data)
- Agent outcomes (matched / NAKED-fallback / reverted)
- Commits landed (hashes)
- Any decisions taken that warranted a separate `docs/decisions.md` entry
- Notes on friction points or new patterns surfaced

Loop semantics: one decomp agent + one data agent dispatched per iteration,
both running in parallel. Iteration completes when both notifications fire
and any resulting commits land (or the orchestrator reverts on failure).
Long fallback `ScheduleWakeup` (1800s) keeps the loop alive if an agent
hangs without notifying.

Stop conditions the orchestrator honors:
- 3 consecutive iterations with zero useful work committed → halt + report.
- 2 consecutive `make check` failures the orchestrator can't auto-revert → halt + report.
- `asm_funcs_remaining` reaches 0 → success, halt.
- raw INCBIN drops below 50% of ROM → milestone, halt + request human review.
- User wakes up and interrupts.

---

## Loop seeded 2026-05-26

Scoreboard at seed:

- Functions decomp'd to C: 24 / ~513 estimated total (**4.7%**)
- peeled-but-still-asm: 17
- estimate range (lower / upper): 335 / 1140
- Data deblobbed: 49.7 KiB of 4.00 MiB (**1.21%**)
- raw INCBIN bytes: 3.95 MiB (98.8% of ROM)
- `database.json` entries: 35

Last 5 commits before loop start:

```
0e1d8eb Data pass 4 — DMA records continuation + level-layout anchors
8cb4125 Decompile sub_0802EA80 — NAKED + NON_MATCHING + new quirk
cbf342a Add decomp + data agent-dispatch playbooks
de99d1d tools/agent/refcount_pool_loads.py — rank ROM addresses
e34fe59 CLAUDE.md: note NAKED + .syntax divided requirement
```

---
