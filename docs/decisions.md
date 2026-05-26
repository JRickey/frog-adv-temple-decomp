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
