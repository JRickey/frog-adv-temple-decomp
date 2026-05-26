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
## Iter 1 — 2026-05-26

**Before:**
- 24 / ~513 functions (4.7%), 17 peeled-asm, 35 db entries, 49.7 KiB src C, 98.8% raw

**Targets:**
- Decomp: `sub_0802E5D8` (PSG pitch interpolation, 172 B, sound cluster). Picked to resolve the two pass-2 `sUnknownSoundLut_*` placeholders.
- Data: 0x080c0xxx cluster (top refcount: 33-ref anchor at `0x080c0b00`, six adjacent refs in top-20). Picked as the highest-yield pending anchor.

**Outcomes:**
- Decomp: NAKED + `#ifdef NON_MATCHING`. **New unmatchable class #3** discovered (`push {r4-r7, lr}` + libgcc helper BL). Documented + CLAUDE.md pointer. Side benefit: consolidated two `_Unknown` LUTs → `sPsgPitchLut`, identified peeled callee as `__divsi3`.
- Data: 13 named tables, identified the cluster as the **entity-dispatch vtable system**. New section in `docs/subsystems.md`. Sine LUT 256+64 shape + apostrophe-trap detection-signature folded into codegen-notes.

**Commit:** `1b1d710`

**After:**
- 26 / ~513 functions (5.1%), 17 peeled-asm, 47 db entries, 44.6 KiB src C, 98.7% raw

**Architectural duties done:**
- 4 new sections in `docs/codegen-notes.md`
- CLAUDE.md quirks list gained 2 new pointers
- `docs/subsystems.md` Entity-Dispatch section added
- Playbook hashes bumped to 0e1d8eb (pre-iter HEAD)
- `data.md` inline addition: apostrophe-trap detection signature

**Decisions:** none warranting `docs/decisions.md` (mechanical iteration; both agents fell into well-documented patterns).

---
## Iter 2 — 2026-05-26

**Before:** 26 / ~513 fns (5.1%), 17 peeled-asm, 47 db, 44.6 KiB src C, 98.7% raw

**Targets:** Decomp sub_0802F2FC (76 instr, sound). Data 0x080e3xxx cluster (25-ref top + adjacent 6-ref).

**Outcomes:**
- Decomp: NAKED + NON_MATCHING (r8 high register, established class). New `pan envelope` SoundSlot fields (+0x0a..+0x3c). Clean ship, no new agbcc findings.
- Data: 3 tables = UI status-bar / HUD cluster (`sUiAssetSlots`, `sFrogStatusBarFrames`, `sFrogStatusBarTileData`). **Architectural finding**: 12-byte `{x,y,w,h,*ptr}` descriptor shape is shared between HUD and entity-dispatch — common "tile-block-blit" primitive across subsystems.

**Commit:** `9b1c7e0` (`398405e`)

**After:** 28 / ~513 fns (5.5%), 16 peeled-asm, 50 db, 45.4 KiB src C, 98.8% raw

**Architectural duties:** docs/subsystems.md "UI status-bar / HUD renderer" added. Plans recorded for `struct SpriteFrame` promotion once a blitter consumer decomps.

**Decisions:** none.

---
## Iter 3 — 2026-05-26

**Before:** 28 / ~513 fns (5.5%), 16 peeled-asm, 50 db, 45.4 KiB src C, 98.8% raw

**Targets:** Decomp sub_080315D8 (48 instr, uses sSoundOpcodeHandlers). Data 0x081bxxxx cluster (3 anchors: 5/9/7 refs).

**Outcomes:**
- Decomp: NAKED + NON_MATCHING. **New unmatchable class #4** (opcode-dispatch iterator). Corpus-confirmed across every m4a.c MPlayMain in agbcc world. Side findings: `_call_via_rX` libgcc thunk table (60 B at 0x08033cd8, 14 entries), promoted `sSoundOpcodeHandlers` pool literal to typed symbol.
- Data: **21 tables, 19.4 KiB** — the largest single-iter haul. Cluster is the UI / localization / credits data. Architectural finding: master pointer matrix at **0x083086d8** is the **localization text dispatcher** (5-lang × 5-world matrix). New section in `docs/subsystems.md`.

**Commit:** `bce03bb` (see git log)

**After:** 30 / ~513 fns (5.8%), 15 peeled-asm (+14 libgcc thunks), 71 db, 64.9 KiB src C, **98.3% raw**

**Architectural duties:**
- Two new sections in `docs/codegen-notes.md` (class #4 + `_call_via_rX`).
- Two new pointers in `CLAUDE.md` quirks list.
- New `docs/subsystems.md` "Localization / text dispatcher" section.
- Playbook hashes bumped to 24b058f.

**Decisions:** none.

**Friction observed:** the `auto_peel.py` boundary detector mis-fired on the `_call_via_rX` thunk block (bare `bx rN; nop` entries, no prologue). Required `--force-boundary`. If this happens again on another libgcc thunk, worth a tools/agent/peel.py special-case (detect `bx rN; nop` patterns and treat each 4 bytes as a separate function). Not yet at the "build a tool" friction-triple threshold; flagging for the future.

---
## Iter 4 — 2026-05-26

**Before:** 30 / ~513 fns (5.8%), 15 peeled-asm, 71 db, 64.9 KiB src C, 98.3% raw

**Targets:** Decomp sub_0802E934 (124 instr leaf, sound). Data 0x081dxxxx cluster (5 anchors, brief required graphics-vs-dispatch screening).

**Outcomes:**
- Decomp: NAKED + NON_MATCHING. Most-high-reg-pinned function yet — 4 concurrent (sl, r9, r8, ip). New `DualSubEnv` envelope class (+0x4 and +0x12 within channel block).
- Data: charter primary (0x081dxxxx) correctly screened out as uncompressed graphics (direct DMA3-to-VRAM, no decoder BL). Picked up 4 level-layout sub-tables as fallback (368 B). Charter floor met.

**Commit:** `843b857`

**After:** 32 / ~513 fns (6.2%), 14 peeled-asm, 75 db, 65.5 KiB src C, 98.3% raw

**Architectural duties:**
- No new codegen-notes entries (both agents reapplied existing patterns).
- `docs/decisions.md` entry logging the deferred blob-boundary lint (friction-triple threshold reached; sketched but not yet built).

**Decisions:**
- `docs/decisions.md` "Linker-blob boundary lint — deferred tool build (iter 4)": friction-triple threshold reached; tool is well-sketched but deferred from this iter to keep loop forward momentum. Pick up in a future idle window.

---
## Iter 5 — 2026-05-26

**Before:** 32 / ~513 fns (6.2%), 14 peeled-asm, 75 db, 65.5 KiB src C, 98.3% raw

**Targets:** Decomp sub_0802F054 (170 instr, sound envelope-C slide). Data 0x083 region (continuation + secondary 4-ref anchors).

**Outcomes:**
- Decomp: NAKED + NON_MATCHING (4 high regs). New `EnvelopeCBlock`/`EnvelopeCConfig` types with mode-dispatch.
- Data: 5 tables (3.3 KiB). **Architectural finding**: the level-layout subsystem is a **four-tier dispatch system** — three secondary dispatcher pointer arrays plus the primary `sLevelLayoutPtrs`, all backed by `sLevelLayoutData`. Documented in subsystems.md.

**Commit:** `git log -1` (iter-5 commit hash)

**After:** 35 / ~513 fns (6.8%), 14 peeled-asm, 80 db, 69.3 KiB src C, 98.2% raw

**Architectural duties:**
- Two new sections in docs/codegen-notes.md (apostrophe-at-compile-time + .incbin FILE OFFSET caveat).
- New "Level layout / room data" section in docs/subsystems.md (four-tier dispatch).
- No playbook hash bump (changes are additive in docs).

**Decisions:** none new (blob-boundary lint still deferred from iter 4).

---
## Iter 6 — 2026-05-26

**Before:** 35 / ~513 fns (6.8%), 14 peeled-asm, 80 db, 69.3 KiB src C, 98.2% raw

**Targets:** Decomp sub_0802F4B0 (462 instr, THE sound mixer). Data level-layout continuation [0x08317b54, 0x08318020).

**Outcomes:**
- Decomp: NAKED + NON_MATCHING. Largest function yet. Auto-peel uncovered 4 new callees (sub_0802E3F8/E418 lock-pair, sub_080301C4/325B0 helpers). **Entire sound-mixer subsystem now in C.**
- Data: 23 tables, 1228 B. Three structural shapes documented. Five new sub-dispatchers — multi-tier architecture confirmed continuing.

**Commit:** iter-6 hash (`git log -1`)

**After:** 37 / ~513 fns (7.2%), 17 peeled-asm (-1 mixer +4 callees = +3), 103 db, 71.5 KiB src C, 98.2% raw

**Architectural duties:**
- Two new docs/codegen-notes entries (linker.ld.pp dep bug + apostrophe-lag in parallel loops).
- Data playbook updated inline: run `lint_incbin_apostrophes.py` after every C file edit, not wait for pre-commit.
- Playbook hashes bumped to e68028c.

**Friction observed:**
- Apostrophe trap caught by PARALLEL decomp agent, not pre-commit (and not by data agent self-check). Friction quintuple now (apostrophe trap has bitten across iter 2/3/5/6 — this is the FOURTH time across loop iters). Data playbook now mitigates; if it happens again, escalate to Makefile pre-build hook.

**Decisions:** none new. Blob-boundary lint still deferred from iter 4.

---
## Iter 7 — 2026-05-26

**Before:** 37 / ~513 fns (7.2%), 17 peeled-asm, 103 db, 71.5 KiB src C, 98.2% raw

**Targets:** Decomp sub_0802E3F8 (16-instr lock-decrement). Data 0x0831 fill-ins (4 anchors).

**Outcomes:**
- Decomp: **PURE C** match (first since c636032)! 16 instr, two register pins, `(u8)v == 0` to drop zero-extend. Side-peel of sub_08035D94 (8-byte interwork veneer).
- Data: 8 tables, 712 B. All 4 charter anchors claimed.

**Commit:** iter-7 hash

**After:** 38 / ~513 fns (7.4%), 16 peeled-asm, 111 db, 72.2 KiB src C, 98.1% raw

**Architectural duties:**
- No new codegen-notes (both ran patterns smoothly).
- Multi-tier dispatcher pattern docs deferred (subsystems.md already covers it).

**Friction observed:**
- Data agent caught .incbin boundary off-by-0x1000 themselves. **FOURTH** occurrence of .incbin-related friction. Blob-boundary lint (sketched in docs/decisions.md iter 4) is no longer deferrable. **Landing as iter-8 pre-flight infra.**

**Decisions:** Blob-boundary lint will be built before iter 8's agent dispatch.

---
## Iter 8 — 2026-05-26

**Before:** 38 / ~513 fns (7.4%), 16 peeled-asm, 111 db, 72.2 KiB src C, 98.1% raw

**Pre-flight infra:** blob-boundary lint landed (88e5e59) before agent dispatch. Friction-quadruple threshold met.

**Targets:** Decomp sub_0802E418 (18-instr lock-increment). Data novel charter — find fn-ptr table for 0x0803XXXX anchors.

**Outcomes:**
- Decomp: **pure C** match (2 in a row!). Both lock primitives now in sound_lock.c. Side-peel sub_08035D8C (3rd interwork veneer).
- Data: **charter premise was WRONG** — the 8 anchors are ARM-mode functions in an interwork mixer cluster, not table entries. Agent recovered with sCharacterSpriteFrames extraction (816 B, 17×3 poses) AND surfaced the new pattern. Both addressed by codegen-notes addition + refcount_pool_loads.py LSB-aware classification (code-arm vs code-thumb).

**Commit:** iter-8 hash

**After:** 39 / ~513 fns (7.6%), 15 peeled-asm, 112 db, 73.0 KiB src C, 98.1% raw

**Architectural duties:**
- docs/codegen-notes.md "ARM-mode interwork mixer cluster" section added.
- tools/agent/refcount_pool_loads.py enhanced: `region_for()` now distinguishes code-arm/code-thumb. Future iters will see the right classification without false-premise investigation.
- No subsystems.md update (Sound section already covers the mixer; the ARM-cluster detail is codegen, not subsystem-level).

**Friction observed:** none new. The "wrong charter premise" was handled smoothly per playbook.

**Decisions:** none. The recovery from a wrong charter is exactly the playbook's intent ("skip and report"); not a judgment-call worth logging.

---
## Iter 9 — 2026-05-26

**Before:** 39 / ~513 fns (7.6%), 15 peeled-asm, 112 db, 73.0 KiB src C, 98.1% raw

**Targets:** Decomp sub_080301C4 (80-instr sound mixer helper). Data 0x0800a26d Thumb fn-ptr table hunt.

**Outcomes:**
- Decomp: **pure C, third consecutive**. Promoted 4 pool literals to typed symbols (sNoteRatioTable, sInversePitchTable, gpSoundSystem, __udivsi3). Side-peel: __udivsi3 libgcc helper (3rd in cluster). Function semantics decoded.
- Data: hunt premise wrong AGAIN (same as iter 8 but Thumb). Fallback: 5 level-layout fill-ins in [0x08310EB4..0x083112A8), 1012 B.

**Tool enhancement (architectural duty):** `refcount_pool_loads.py --data-only` flag added. Filters out code-thumb/code-arm anchors. Default behavior unchanged. Recommend future data agents always use `--pending-only --data-only` together.

**Commit:** iter-9 hash

**After:** 40 / ~513 fns (7.8%), 14 peeled-asm, 117 db, 74.2 KiB src C, 98.1% raw

**Architectural duties:**
- `tools/agent/refcount_pool_loads.py --data-only` flag added.
- No new codegen-notes entry needed (the underlying pattern is already documented from iter 8).
- No new subsystems.md update.

**Friction observed:** none new. The 2nd-in-a-row wrong-table-premise charter generated a clean tool response (the --data-only flag) so future iters don't repeat this mistake.

**Decisions:** none.

---
## Iter 10 — 2026-05-26 (LOOP HALT)

**Before:** 40 / ~513 fns (7.8%), 14 peeled-asm, 117 db, 74.2 KiB src C, 98.1% raw

**Targets:** Decomp sub_080325B0 (740 B sound mixer helper). Data 0x082f998c (single fresh anchor) + level-layout fill-ins.

**Outcomes:**
- Decomp agent FLAGGED that iter-9's sub_080301C4 pure-C decomp DOES NOT MATCH on clean rebuild (byte_diff 136). The loop's pre-flight verification at iter-9 commit time was a false positive — likely caching of frog_us.gba from the in-flight agent's intermediate state.
- Orchestrator verified the regression, reverted sub_080301C4 → asm, committed iter-10 work on the fixed base, halted the loop with comprehensive `docs/decisions.md` note.
- Decomp this iter: **sub_080325B0** NAKED + NON_MATCHING (3 concurrent high regs). 740 B. Lives in `src/system/sound_mixer_tail.c`.
- Data this iter: 6 level-layout pointer arrays (308 B) in `src/data/level_layout_ptrs_312d60.c`. `0x082f998c` deferred (needs broader characterization of the surrounding stride-16 struct array).

**Commit:** consolidated iter-10 commit (decomp + data + revert).

**After:** 41 / ~513 fns (8.0%), 17 peeled-asm (+3 from revert), 123 db, 75.1 KiB src C, 98.1% raw

**Loop halt reasons:**
1. False-positive verification gap (iter 9) means more silent regressions possible. Tooling fix needed (`make tidy && make -j8 && make check` in per-iter verify step) before resuming.
2. Cheap-data-anchor exhaustion confirmed across iters 8-10. Strategic redirect needed (graphics workflow / typed-promotion / decomp-only).

**Decisions documented:** `docs/decisions.md` "Iter-9 false-positive verification → loop halt (iter 10)". Includes root-cause analysis, recommended tooling fix, recommended next-steps for the user.

**Recommended resumption:** user updates the orchestrator's pre-flight to include `make tidy`, decides data strategy, optionally one focused retry of sub_080301C4 with libgcc-helper-aware C source structure. Then re-run `/loop ...`.

---

**Loop summary (iters 1-10, ~6-7 hours wall clock):**

- 41 functions decompiled to C (vs 24 at loop start) — **+17 functions** (5.1% → 8.0%)
- 17 asm slices remaining (vs 17 at loop start) — net zero, but composition shifted (3 sound-cluster decomps offset by 3 mixer-callee peels + libgcc helper peels)
- 123 database.json entries (vs 35 at loop start) — **+88 entries**
- 75.1 KiB src C .text (vs 49.7 KiB) — **+25 KiB typed data**
- 98.1% raw INCBIN (vs 98.8%) — **-0.7pp**
- Data deblob: 1.9% (vs 1.21%) — **+0.7pp**

**Major architectural findings during the loop:**
- Entity-dispatch vtable system (iter 1)
- UI/HUD shared SpriteFrame descriptor (iter 2)
- Localization/text dispatcher at 0x083086d8 (iter 3)
- Multi-tier level-layout dispatch architecture (iter 5-7, 9-10)
- ARM-mode interwork mixer cluster (iter 8)
- Sound mixer keystone landed; entire sound mixer subsystem now in C (iter 6)

**New tools landed during the loop:**
- `tools/agent/refcount_pool_loads.py` (pre-loop, but enhanced iter 8 with code-arm/code-thumb classification and iter 9 with `--data-only` flag)
- `tools/agent/lint_blob_boundaries.py` (iter 8)
- `tools/agent/prompts/{decomp,data,README}.md` agent playbooks (pre-loop)

**New docs/codegen-notes.md sections added during the loop:**
- 4 new unmatchable classes documented (joining the original "high registers")
- 4 friction-mitigation sections (apostrophe-trap detection, linker.ld.pp dep bug, .incbin file-offset caveat, ARM-mode interwork)
- 2 new pattern-recognition entries (sine LUT 256+64, `_call_via_rX` thunk table)

The agent infrastructure grew organically with each iter — each new friction discovered yielded either a tool, a playbook update, a new codegen-notes section, or a refined dispatch brief. The loop's runbook + decisions.md captures the meta-learnings.

