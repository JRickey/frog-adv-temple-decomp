# Orchestrator decisions log

Decisions the autonomous loop took **without** user input that the user
should know about on wake. The loop appends here when it makes a call
that's defensible under project guidelines but isn't obviously the only
option. Each entry stays short — one paragraph of WHY, plus a pointer to
the commit/file that records the WHAT.

The guidelines the loop weighs every decision against:

1. **Decomp the entire game** — every function, every data table. Not a
   selective subset. Skipping a target is OK if blocked, never if just
   hard.
2. **Right way, not hacky** — pure C wherever the corpus/compiler permits;
   NAKED + `#ifdef NON_MATCHING` only when the codegen-notes-documented
   classes apply (high registers, two-stage-loop-shared-cache, etc.).
   Anonymous `Foo_3953c8` data symbols forbidden.
3. **Human + PC-port-agent readable** — every NAKED function has a
   `#ifdef NON_MATCHING` reference body that compiles cleanly under
   `-DNON_MATCHING`. Every typed data symbol has a name that's at worst
   a `_Unknown` placeholder + TODO comment with consumer-code citation.

The decision-log entries skew toward NEW kinds of judgment calls. Routine
"agent shipped X, X matched, committed" doesn't need an entry — that's
the loop-log's job. This file is for: "the obvious move was Y; I went Z
because A; that may need revisiting."

---

(Entries will be appended below as the loop runs.)

## Linker-blob boundary lint — deferred tool build (iter 4)

Three iterations have now seen friction around `linker.ld` blob splits:
the apostrophe trap (e3bf8d5, iter pre-loop), the parallel-agent
layout-shift signal noise (iter 1, iter 2), and now (iter 4) a
near-incident where a wrong INCBIN size in an upstream blob caused
a 16 KiB shift + 757 KiB cascading diff. The data agent caught it
self-verify but flagged that a lint of the form
`incbin_offset + incbin_size == next_linker.ld_address` would catch
this class mechanically.

This passes the orchestrator runbook's "friction triples → build a
tool" threshold. **Why I'm deferring**: forward momentum in the
overnight loop matters more than perfect infra. Each completed iter
yields one decomp + one data extraction (~5-30 KB of progress); a
30-minute tool-build pause costs about one iter's worth of progress
in stop-the-world time. The lint can be a quick task whenever the
loop hits an idle tick (e.g., a no-op iteration, or an agent that
returns very fast). Logged here so the user sees it on wake.

Sketch of the tool (`tools/agent/lint_blob_boundaries.py`, ~80 lines):
1. Parse `linker.ld` for the ordered list of `.text` entries and
   their range comments.
2. For each `asm/text/text_0x*.s` entry, open the .s file, find the
   `.incbin "frog_us_baserom.gba", <skip>, <count>` line.
3. Assert `<skip>` matches the entry's start-address-relative offset
   AND `<skip> + <count>` matches the end-address.
4. Same check for any `asm/text/text_*.s` that has manual extents.
5. Exit 1 on any mismatch with the offending file + actual vs expected
   numbers. Wire into pre-commit step 4 (after the apostrophe guard).

Recommend the user run it via `python3 tools/agent/lint_blob_boundaries.py`
at any wake-up to catch any lurking blob-boundary issues from
overnight commits.
