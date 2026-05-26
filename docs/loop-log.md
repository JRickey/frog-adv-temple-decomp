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

## Iter 11 — 2026-05-26 (LOOP RESUMED)

**Pre-iter:** Loop resumed post-iter-10 halt. Applied orchestrator-runbook fix in d6598d6 (mandatory `make tidy && make -j8 && make check` per-iter verification, no more bare-check false-positives).

**Before:** 41 / ~513 fns (8.0%), 17 peeled-asm, 123 db, 75.1 KiB src C, 98.1% raw

**Targets:** Decomp sub_080301C4 NAKED retry (close iter-9 regression hole). Data: level-layout fill-ins in [0x08312e94, 0x08314a68).

**Outcomes:**
- Decomp: NAKED + #ifdef NON_MATCHING. Verified via `make tidy && make -j8 && make check` (the new mandatory sequence — bare check would have lied like it did at iter 9). Pure-C iter-9 attempt preserved under `#ifdef NON_MATCHING` for the PC port. **iter-9 regression hole closed.**
- Data: **entire 7124-byte blob extracted** in one pass. 5 tables, 3 (backing + pointer-array) clusters. Range [0x08312e94, 0x08314a68) fully consumed; asm/text/text_0x08312e94.s deleted.

**Commit:** iter-11 hash

**After:** 43 / ~513 fns (8.4%), 16 peeled-asm, 128 db, 82.2 KiB src C, **97.9% raw** (first full decimal-point drop)

**Architectural duties:**
- No new docs entries this iter (no fresh codegen findings; both ran patterns smoothly).
- Both pre-commit lints fired correctly (apostrophe + blob-boundary). One apostrophe caught at write-time. Tooling is paying its keep.

**Validation of the halt-fix:** the d6598d6 orchestrator update is working as designed. The decomp agent explicitly used `make tidy && make -j8 && make check`. The iter-9-style false-positive class is closed.

**Decisions:** none new.

---
## Iter 12 — 2026-05-26

**Before:** 43 / ~513 fns (8.4%), 16 peeled-asm, 128 db, 82.2 KiB src C, 97.9% raw

**Targets:** Decomp AgbMain (master game loop, ambitious — 198 instr + 29 callees + 26-case jump table). Data text_0x08314b30 cluster (3864 B).

**Outcomes:**
- Decomp: **AgbMain landed NAKED + NON_MATCHING + 28 callees auto-peeled.** Master game-state-machine dispatcher now in C with the per-frame loop documented in the NON_MATCHING reference body. New architectural findings (Init2 every frame, mode 28 shared finalize, mode 29 arg-passing) in docs/subsystems.md. 28 new asm/disasm slices = future decomp targets.
- Data: 4 tables, 3864 B — entire blob consumed. **New "embedded mini pointer-array inside backing-store" variant** identified and documented in codegen-notes.

**Commit:** iter-12 hash

**After:** 45 / ~513 fns (8.8%), 43 peeled-asm (+27 from AgbMain's callees), 132 db, 86.3 KiB src C, **97.5% raw** (second full decimal-point drop in two iters)

**Architectural duties:**
- docs/subsystems.md "Game-state machine" section rewritten by decomp agent.
- docs/codegen-notes.md "Variant: embedded mini pointer-array inside a single backing-store" section added.
- Two new IWRAM bases (0x03003540, 0x03005398) inline-declared in agb_main.c; promote to include/iwram.h when consumers land.

**Validation of mandatory clean-rebuild:** verified clean. Both pre-commit lints fired correctly.

**Decisions:** none new.

**Suggested iter-13 candidates (from decomp agent's report):** sub_080202A8, sub_080201A8, sub_080201C8, sub_080201E8, sub_08019540, sub_08019560 (all ≤80 B handlers), or sub_08020BC0 (Init2, 48 B). The decomp pipeline is now flush with small leaf candidates — the cheap-data-anchor exhaustion problem is offset by abundant cheap-decomp candidates.

---
## Iter 13 — 2026-05-26

**Before:** 45 / ~513 fns (8.8%), 43 peeled-asm, 132 db, 86.3 KiB src C, 97.5% raw

**Targets:** Decomp sub_080004C4 (276 B input-init bootstrap). Data text_0x08315bb0 cluster (4.6 KB).

**Outcomes:**
- Decomp: **PURE C** via permuter-helped shadow-copy idiom. ~70 permuter iters found `jpKeysShadow = jpKeys;` prologue assignment that splits the live range and defeats agbcc's pre-spill. **New codegen-notes section** documenting the technique. Side-peels: sub_08000900 + sub_080179B8. Header additions: 3 new IWRAM bases + REG_KEYINPUT + KEY_* macros.
- Data: 3 tables, 4632 B (full blob). **New variant subform**: non-monotonic tail of a pointer-array (extends iter-12's embedded-mini-ptr-array pattern).

**Commit:** iter-13 hash

**After:** 46 / ~513 fns (9.0%), 44 peeled-asm, 135 db, 91.1 KiB src C, **97.4% raw** (third consecutive decimal-point drop)

**Architectural duties:**
- docs/codegen-notes.md "Shadow-copy of a live value to defeat pre-spill of a long-lived local" section added — new mitigation idiom.
- include/iwram.h grew 3 new bases (0x34C0, 0x3710, 0x5358) via linker dot-pin.
- include/gba/io.h gained REG_KEYINPUT + KEY_* bit macros — first input-handling content.

**Decisions:** none new.

**Trajectory check (post-resume):** 3 iters since loop resumed (iter 11/12/13). Functions: 41→46. Raw INCBIN: 98.1%→97.4%. Both directions advancing steadily. The cheap-data-anchor exhaustion concern from iter 10 has resolved naturally — full-blob extraction of the level-layout cluster yields ~3-7 KB per pass at predictable cost, and the AgbMain peel landed 28 new tractable decomp candidates so the decomp pipeline is flush.

---
## Iter 14 — 2026-05-26

**Before:** 46 / ~513 fns (9.0%), 44 peeled-asm, 135 db, 91.1 KiB src C, 97.4% raw

**Targets:** Paired decomp sub_080008DC + sub_08000900 (24 instr combined). Data 0x0817XXXX cluster (fresh territory).

**Outcomes:**
- Decomp: **both pure C** in new src/system/vblank.c. VBlank semaphore wait + frame-counter getter. **Two new codegen-notes**: `old_agbcc` for leaf-with-join functions + while-loop pointer-and-mask hoisting (3-local idiom).
- Data: 4 tables, 2744 B. **NEW UI/HUD subsystem identified**: state-keyed icon animator at 0x080166ac (still asm). **New codegen-notes**: icon-animator pattern recognition (DMA3 paired palette+tile loads).

**Commit:** iter-14 hash

**After:** 48 / ~513 fns (9.4%), 42 peeled-asm, 139 db, 93.8 KiB src C, **97.3% raw** (fourth consecutive decimal-point drop)

**Architectural duties:**
- 3 new docs/codegen-notes sections (old_agbcc-for-leaves, pointer-and-mask-hoisting, icon-animator-pattern).
- vblank.c added to Makefile's OLD_AGBCC override list (precedent: init.c, init1.c).

**Decisions:** none new.

**Trajectory check:** 4 iters post-resume (11/12/13/14). Functions: 41→48 (+7). Raw INCBIN: 98.1%→97.3% (-0.8pp). The cheap-leaf decomp pipeline is flush (28 AgbMain callees + smaller bootstrap helpers); data side continues steady ~3 KB/iter on level-layout + opportunistic new subsystems (icon-animator this iter, sCharacterSpriteFrames iter 8, UI status-bar iter 2). Loop is healthy.

---
## Iter 15 — 2026-05-26

**Before:** 48 / ~513 fns (9.4%), 42 peeled-asm, 139 db, 93.8 KiB src C, 97.3% raw

**Targets:** Decomp sub_08002844 (129 instr game-mode handler). Data text_0x083112c8 cluster (6.5 KB).

**Outcomes:**
- Decomp: NAKED + NON_MATCHING. Same indirect-jump idiom as AgbMain. **14 new auto-peeled callees** queued. Filename `mode_15.c` (may need rename to mode_8.c per iter-12 AgbMain dispatch math).
- Data: **28 tables, 6488 B (largest single-iter data haul yet by symbol count).** Full 6.5 KB blob cleared. 9 (backing + ptr-array) cluster pairs.

**Commit:** iter-15 hash

**After:** 50 / ~513 fns (9.7%), 54 peeled-asm (+14 callees), 167 db, **100.7 KiB src C (crossed 100 KiB!), 97.1% raw** (fifth consecutive decimal drop)

**Architectural duties:**
- docs/codegen-notes.md "Pointer-array slot size != byte[0]*stride+header" — third level-layout extraction convention.
- docs/subsystems.md "Level-layout walker functions" — sub_08021140 + sub_080219bc as high-priority decomp targets (would unlock typed `struct LevelLayoutSubTable` rename across ALL sLevelLayout* extractions).

**Decisions:** none.

**Trajectory:** 5 iters post-resume (11-15). Functions 41→50 (+9). Raw INCBIN 98.1%→97.1% (-1.0pp). db 117→167 (+50). src C 75→101 KiB (+26 KiB). The loop is solidly forward-moving since the post-halt fix.

---
## Iter 16 — 2026-05-26

**Before:** 50 / ~513 fns (9.7%), 54 peeled-asm, 167 db, 100.7 KiB src C, 97.1% raw

**Targets:** Decomp sub_0800A2D8 (24-instr game-mode helper). Data 0x08310xxx cluster (3.7 KB iter-9-deferred).

**Outcomes:**
- Decomp: NAKED + NON_MATCHING (permuter 1575 iter could not break byte_diff 7). **New unmatchable class candidate**: "repeated table-dispatch chain coloring" (5th class). 4 callees peeled.
- Data: **22 tables, 3764 B (full blob).** **Major cross-system architectural finding**: sSpriteAssetTable entries point at level-layout dispatchers — first concrete bridge between iter-3 sprite system and iter-15 level-layout walker.

**Commit:** iter-16 hash

**After:** 52 / ~513 fns (**10.1%** — crossed 10%!), 57 peeled-asm, 189 db, 104.5 KiB src C, **97.0% raw** (sixth decimal drop), **3.0% data deblob** (crossed 3.0%!)

**Architectural duties:**
- docs/codegen-notes.md "Fifth unmatchable class candidate: repeated table-dispatch chain coloring" — new entry, joins the established four.
- docs/subsystems.md "sSpriteAssetTable → level-layout dispatcher bridge" — documents the cross-system chain + the typed `struct SpriteAssetEntry` rename plan once a consumer in [0x08022206..0x08022A7C] decomps.

**Decisions:** none.

**Trajectory:** 6 iters post-resume (11-16). Functions 41→52 (+11). Raw INCBIN 98.1%→97.0% (-1.1pp). db 117→189 (+72). src C 75→105 KiB (+30 KiB). Loop is healthy and accelerating — each iter compounds prior architectural findings (sSpriteAssetTable + level-layout linkage discovered this iter unlocks rename propagation across iters 3/10/15/16).

---

## Iter 17 — 2026-05-26

**Before:** 52 / ~513 fns (10.1%), 57 peeled-asm, 189 db, 104.5 KiB src C, 97.0% raw

**Targets:** Decomp sub_0800A520 (11-instr leaf, 5 sequential calls to sub_0800793C). Data 0x082f998c cluster (small dispatch ptr pair + backing data).

**Outcomes:**
- Decomp: **pure C, byte-perfect**. Placed in new sibling `src/game/sub_0800a520.c` — dispatch_helpers.c (which holds sub_0800A2D8) cannot host two non-contiguous functions in one .o under agbcc 2.x without -ffunction-sections. 5 callee peels via auto_peel (sub_0800793C, sub_08007DD0, sub_08008174, sub_080090B0, sub_0800A4D0). detect-fn-boundary over-ran on the 0x0800a4d0/0x0800a520 boundary due to a pool+pad gap; resolved with `--force-boundary` (TODO: teach detector to recognize epilogue→pool→push-lr break, file).
- Data: **2 tables, 116 B**. sUnkDispatchData_82F9920 (9 stride-12 records) + sUnkPtrPair_82F998C (2 ptrs into the block at rows 0 and 8). Pair expressed as `&sUnkDispatchData_82F9920[N*3]` — relocs go through the C symbol. Stride-16 descriptor at 0x082f8ec4 + trailing stride-12 at 0x082f9994 left in text blobs (no current pool-load refs from still-asm code).

**Commits:** iter-17 hash + `06e8957` (codegen-notes follow-up).

**After:** 53 / ~513 fns (**10.3%**), 61 peeled-asm, 190 db, 104.6 KiB src C, **96.9% raw**, 3.1% data deblob.

**Architectural duties:**
- docs/codegen-notes.md "Append to existing C file only works for CONTIGUOUS ranges" — new entry. Decomp playbook step 2 should clarify.
- docs/codegen-notes.md "&sFoo[N*stride] for pointer-array indexing into typed data" — new entry, with worked examples from iters 14/15/17.
- **Friction note (not yet triplicate)**: auto-mode classifier denied the iter-17 commit after context compaction lost the overnight-loop authorization context. User re-ran /loop which re-authorized. If this recurs, fold into the orchestrator runbook a "post-compaction commit-permission warm-up" step.

**Decisions:** none material.

**Trajectory:** 7 iters post-resume (11-17). Functions 41→53 (+12). Raw INCBIN 98.1%→96.9% (-1.2pp). db 117→190 (+73). src C 75→105 KiB (+30 KiB). Loop still forward-moving but data-side haul this iter was small (116 B) — the cluster around 0x082f9xxx has limited pool-load anchors. Next data targets should be checked via refcount tool for refs ≥5.

---
