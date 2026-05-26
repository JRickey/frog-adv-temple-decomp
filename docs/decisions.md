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

## Iter-9 false-positive verification → loop halt (iter 10)

### What happened

Iter 9 (commit `2300fa1`) landed `sub_080301C4` as a pure-C decomp in
`src/system/sound_period.c`. At commit time, the loop's pre-flight
verification reported all-green:

  - `make check` → `frog_us.gba: OK`
  - `python3 tools/agent/compile_and_view_assembly.py sub_080301C4 --human`
    → `byte_diff: 0 / MATCH ✓`

Iter 10's decomp agent (`sub_080325B0`) flagged that **clean rebuild
shows iter-9 is non-matching**: `sub_080301C4` byte_diff 136 on a
fresh build. Verified by orchestrator after stash-pop testing at
iter-9 HEAD: confirmed; `src/system/sound_period.o` is `0xa4` bytes
vs the expected `0xa0` (4 bytes too big — an extra `.short 0x0000`
agbcc emits before a pool word at a different relative offset than
baserom).

### Root cause

Most likely: the loop's pre-flight `make check` saw a cached
`frog_us.gba` built from the in-flight agent's intermediate state
(their compiled .o files in place) rather than from a clean
re-build. `make check` only verifies the SHA1 of the existing
`frog_us.gba`, not that source-to-build reproduces it.
`compile_and_view_assembly.py` uses the same cached `.o`s and
inherited the lie.

When the iter-10 decomp agent did `make tidy && make -j8` to start
its work, the rebuild from clean source revealed the mismatch.

### Action taken (this commit)

**Reverted** `src/system/sound_period.c` and the linker.ld slot
swap (restored `asm/disasm_0x080301c4.s` and the
`asm/disasm_0x080301c4.o(.text)` entry). `make check` now exits 0
on clean rebuild. Iter-10's `sub_080325B0` NAKED decomp + 6
level-layout fill-ins committed on the corrected base; both verify
byte-perfect after the revert.

What stays from iter 9: the `__udivsi3` peel (independent libgcc
finding), 5 `sLevelLayout_310EB4` fill-in tables, the
`refcount_pool_loads.py --data-only` flag (all orthogonal to the
broken decomp).

### Tooling fix recommended

The orchestrator's per-iter verification step should be:

```sh
make tidy && make -j8 && make check
```

(i.e., **always tidy first**) — not the current `make check`-only
check that trusts the existing `frog_us.gba`. The make-tidy cost is
~30s per iter; well worth the trade against an iter-9-style
silent regression.

The loop's `docs/loop-orchestrator.md` pre-flight section needs
updating with this. Suggest the user review and update in the same
session as the post-loop debrief.

### Why I halted the loop

Two things converged:

1. **A foundational verification gap surfaced** (the iter-9
   false-positive). Continuing the loop without fixing the
   verification step would risk more silent regressions — and the
   loop's whole value depends on each iter's verification being
   trustworthy. Better to halt, get user direction on the
   verification fix, and resume cleanly.

2. **Cheap-data-anchor exhaustion** across iters 8-10. ≥3-ref data
   anchors are now all graphics (out of scope without an
   encoder/decoder workflow). Level-layout fill-ins yield ~1 KB per
   pass at growing per-table reasoning cost. The loop's data half
   needs strategic redirection — graphics workflow? Switch to
   typed-promotion / rename pass on already-extracted `_Unknown`?
   Decomp-only iters for the remaining sound mixer + non-sound
   functions?

Per the user's directive — "If there is anything you feel you need
to report to the user about a difficult decision that might break
the loop, write a note about it, save the note in docs and make
the best decision that follows the overall project guidelines" —
this is exactly that situation. The decision: **halt, write this
note, do not dispatch iter 11.**

### Scoreboard at halt (commit hash this commit)

- Functions decomp'd to C: 41 / ~513 estimated (8.0%)
- asm_funcs_remaining: 17 (sub_080301C4 returned; sub_080325B0
  landed; 4 mixer-callee peels still asm; 4 libgcc thunks
  permanent-asm; bootstrap functions all permanent-asm)
- database.json: 123 entries
- src C .text: 75.1 KiB
- Raw INCBIN: 98.1% of ROM
- Data deblob: 1.9%

### Recommended next steps for the user

1. **Update `docs/loop-orchestrator.md`** to require `make tidy &&
   make -j8 && make check` as the per-iter verification.
2. **Decide data strategy**: graphics workflow setup, `_Unknown`
   typed-promotion pass, or decomp-only iters?
3. **Decide on sound_period.c retry**: it was the only attempted
   pure-C-on-a-pure-divider function so far. The asm shape (load,
   shift, BL `__udivsi3`, store) might match in C if rewritten
   with explicit register pinning and the libgcc-helper-aware
   prologue form. Worth one focused decomp-only iter to try, or
   leave NAKED+NON_MATCHING.
4. **Investigate `compile_and_view_assembly.py`** — why did it
   report `byte_diff: 0` on a function that doesn't actually
   match? Either the tool is using a stale baseline or its build
   step is incremental.

Loop is paused. Resume by re-running `/loop ...` whenever ready.

## In-ROM libgcc cluster `[0x08033cd8, 0x0803401c)` — Option B (permanent-asm) is the final state

A dispatch brief landed targeting the libgcc helper cluster
(`_call_via_r0`..`_call_via_lr` at 0x08033cd8, `__divsi3` at 0x08033d14,
`__udivsi3` at 0x08033ee4, `__umodsi3` at 0x08033f5c). The brief offered
three options: (A) scaffold `src/libgcc/libgcc.c` with `.thumb_set`
aliases over libgcc.a-extracted symbols, (B) keep the in-place asm
slices with proper `thumb_func_start` labels, (C) NAKED inline-asm
wrappers in C around the original bytes.

**Outcome on inspection**: Option B was already done in prior loop
iters (1–3 era). All four ranges are peeled into
`asm/disasm_0x080339xx.s` / `asm/disasm_0x080340xx.s` slices with the
canonical libgcc symbol names declared via `thumb_func_start`, wired
into `linker.ld` at the correct positions. `make check` exits 0. BL
relocations from project code (`bl __divsi3` etc.) resolve cleanly
through the linker to the in-ROM bytes.

Byte-match verification against `tools/agbcc/lib/libgcc.a`:

- `_call_via_rX.o`: 60 B, identical to ROM 0x33cd8..0x33d14.
- `_divsi3.o`: 148 B, 4 bytes differ at offsets 0x8a..0x8d — the
  internal `bl __divsi3_help` relocation, resolved to the in-ROM
  helper at 0x08033da8 in the baserom but left as `R_ARM_THM_CALL`
  placeholder in the .a member. Expected.
- `_udivsi3.o`: 120 B, 1 byte differs at 0x72 — same relocation
  pattern.
- `_umodsi3.o`: 192 B, 2 bytes differ at 0xba..0xbb — same.

All four cluster slices use `.incbin` from the baserom, which already
has correct relocations applied. So the source-rom bytes are exactly
the libgcc bytes with the project-specific BL targets baked in. No
further work needed to make the symbols resolvable.

**Why not scaffold a C file anyway**: The brief leaned toward
scaffolding for picker hygiene (`pick_target.py --all` listed the
libgcc symbols as "blocked: no src/*.c adjacent — scaffold a new C
file"). A `src/libgcc/libgcc.c` with NAKED `asm(".incbin ...")` stubs
would satisfy the picker but adds zero matching value:

1. The bytes don't change — `.incbin` either way.
2. libgcc helpers aren't "decompiled" in any useful sense; they're
   library code byte-for-byte.
3. Empty C scaffolds for non-decomp-targets pollute `src/` and
   misrepresent project progress (would inflate the
   "functions decompiled" count without doing any decomp work).
4. The cluster spans 4 disasm slices interleaved with text buckets;
   making the C file the picker's adjacent neighbour would require
   either 4 separate stub files or absorbing the intervening text
   buckets — both bad options.

**Picker fix instead** (this commit's only change):
`tools/agent/pick_target.py` now classifies the 18 libgcc symbols as
`skipped: in-ROM libgcc helper (permanent-asm)` via a `LIBGCC_SYMBOLS`
frozenset checked first in `classify()`. They no longer appear as
"needs scaffolding" entries in `--all` output, which removes the
false signal that drove this brief. The asm slices stay exactly as
they are.

If a future agent needs to add a libgcc helper that isn't in the
current set (`__mulsi3`, `__ashldi3`, etc.), append it to
`LIBGCC_SYMBOLS` after peeling and verifying byte-match against
`tools/agbcc/lib/libgcc.a`.
