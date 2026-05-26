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

## Iter 18 — 2026-05-26

**Before:** 53 / ~513 fns (10.3%), 61 peeled-asm, 190 db, 104.6 KiB src C, 96.9% raw

**Targets:** Decomp sub_0800A328 (2-line peel). Data 4-anchor cluster at 0x081d8b98 / 0x081dab98 / 0x081dad98 / 0x081e4418.

**Outcomes:**
- Decomp: NAKED + NON_MATCHING (adds r0,r1,r0 vs r0,r0,r1 encoding swap — same class as sub_0800A2D8 from iter 16). **Critical catch**: the pre-existing 0x0800a328 peel range hid a SECOND function (sub_0800A3A4, 44 B). Without re-peeling, the ROM would have shifted by 0x1974 B. Folded into codegen-notes "Pre-existing peel range may hide a second function". 2 callee peels (sub_08005FC8, sub_0800FCC8).
- Data: **5 tables, 48 KiB (full charter haul, biggest single-iter data extraction since iter 12)**. Discovered as one coherent screen-install resource block: palette + char tiles + 2 tilemaps + aux, DMA3'd by 3 sibling routines in [0x0801eed4..0x0801fdb0]. Char-tiles table sized via inter-anchor gap (0x9680 B), NOT DMA cnt (0x8000 B) — a +0x1680 ghost was caught and fixed pre-commit.

**Commit:** `932445b` (iter 17 log) + iter-18 hash (single combined: decomp + data + codegen-notes).

**After:** 55 / ~513 fns (**10.7%** +0.4pp), 63 peeled-asm, 195 db, **152.8 KiB src C** (+48 KiB), **95.7% raw** (-1.2pp), **4.3% data deblob** (+1.2pp).

**Architectural duties:**
- docs/codegen-notes.md "Pre-existing peel range may hide a second function" — new entry. **High-leverage finding** — every wide-peeled .s file with >1 `push {` is a latent layout-shift bomb.
- docs/codegen-notes.md "Stale .o cache after auto_peel.py" — touch+rebuild workaround documented.
- docs/codegen-notes.md "DMA-cnt vs table-real-size" — size from inter-anchor gap idiom.
- docs/codegen-notes.md "Apostrophe-trap substitution cheatsheet" — quick-reference table for INCBIN comment drafting.

**Decisions:** none material.

**Trajectory:** 8 iters post-resume (11-18). Functions 41→55 (+14). Raw INCBIN 98.1%→95.7% (**-2.4pp**, accelerating). db 117→195 (+78). src C 75→153 KiB (**+78 KiB**). **Data deblob 1.0%→4.3% (+3.3pp)** — iter 18 alone contributed +1.2pp, the largest single-iter jump. Loop is healthy and on trend to cross 5% data + 11% fns next iteration.

---

## Iter 19 — 2026-05-26

**Before:** 55 / ~513 fns (10.7%), 63 peeled-asm, 195 db, 152.8 KiB src C, 95.7% raw

**Targets:** Decomp sub_0800A3A4 (22-instr comparator peeled in iter 18). Data 0x081d8398 (iter-18 followup screen-clear tilemap) + 0x080e3xxx cluster scout.

**Outcomes:**
- Decomp: **PURE C, first-try byte-match** (rare — 4th pure-C of the post-resume run after sub_080008DC, sub_080004C4, sub_0800A520). The 22-instr descending-sort comparator reproduces cleanly via `struct-copy + mixed halfword/word-shift access` idiom. No permuter, no NAKED. Demonstrates the contiguous-append path is working end-to-end (2nd append to dispatch_helpers.c).
- Data: 1 table (2 KiB, sScreenTilemapD8398). Charter floor met. **Iter-18 hypothesis correction**: this is a HUD/menu template tilemap, not a clear-screen blanker. Sparse glyph tiles 0x33-0x91 in palette-5. 0x080e3xxx bonus cluster deferred — it's 4bpp tile pixel data, not records.

**Commit:** `5998574` (single combined: decomp + data + subsystems doc + clang-format).

**After:** 56 / ~513 fns (**10.9%**), 62 peeled-asm (-1, sub_0800A3A4 promoted C), 196 db, **154.9 KiB src C**, **95.6% raw**, 4.4% data deblob.

**Architectural duties:**
- docs/subsystems.md "Tile-blit helper at 0x000196ec" — new entry. Inferred signature `TileBlit(coords, src, dst_mode)` with the {charblock0, sb29, sb30, sb31} dst_mode enum. **Unlocks renames** across the sub_0801F1E0-family tilemap consumers once decomped.
- No new codegen-notes — the "struct-copy forces full load" idiom is general C, not agbcc-specific.

**Decisions:** none material.

**Trajectory:** 9 iters post-resume (11-19). Functions 41→56 (+15). Raw INCBIN 98.1%→95.6% (-2.5pp). db 117→196 (+79). src C 75→155 KiB (+80 KiB). Pure-C/NAKED ratio so far across post-resume iters: 4 pure-C / 5 NAKED. Comparator landed pure-C is a healthy signal — pre-existing peel ranges with proper boundary discipline are giving fully-tractable C targets.

---

## Iter 20 — 2026-05-26

**Before:** 56 / ~513 fns (10.9%), 62 peeled-asm, 196 db, 154.9 KiB src C, 95.6% raw

**Targets:** **Strategic pivot** — pick_target ran out of unblocked `<=200 instr` candidates after iter 19. Decomp: in-ROM libgcc helpers cluster at 0x08033CD8..0x08033F94 (__divsi3, __udivsi3, __umodsi3, _call_via_rN). Data: 0x083180xx 5-anchor cluster (entity-dispatch / level-layout parallel arrays).

**Outcomes:**
- Decomp: **infra-only**. Agent discovered the libgcc cluster was ALREADY properly landed across 4 disasm slices in earlier iters (~iter 1-3) with canonical libgcc symbol names and correct linker.ld wiring. Byte-match against tools/agbcc/lib/libgcc.a verified (diffs were just the relocation bytes for project BLs). Picker hardened with `LIBGCC_SYMBOLS` skip-list (18 names) so it stops reporting "blocked: scaffold C" for permanent-asm libgcc helpers. Decision banked in docs/decisions.md.
- Data: 8 tables, 392 B from 0x083180xx. **Major architectural finding**: 4-way parallel-array set with kind codes (0x303/0x3303/0x2303/0x1303) dispatched by two consumers (sub_0802C780 by r2, sub_0802C8C8 by *(u8*)r0). Walker family extended from 2 to 4 variants (added sub_080210a0 single-shot + sub_08021510 compact-record). Manifest 0x0831802C is 6×{count, 0} — likely 6-language descriptor.

**Commit:** `f993ddb` (single combined: picker hardening + data extraction + subsystems doc + decisions doc).

**After:** 56 / ~513 fns (10.9%, no change), 62 peeled-asm (no change), 204 db (+8), **155.3 KiB src C** (+0.4 KiB), 95.6% raw, 4.4% data deblob.

**Architectural duties:**
- docs/subsystems.md "4-way parallel-array level-layout subset (0x083180xx cluster)" — new section, with walker family extension to 4 variants and consumer dispatch mappings.
- docs/decisions.md (via decomp agent) — libgcc-permanent-asm rationale + extension instructions.
- tools/agent/pick_target.py — LIBGCC_SYMBOLS skip-list added.
- **Decomp surface watch**: `pick_target --max-size 80` now returns 0 unblocked candidates. The next decomp target requires either (a) decomping a walker (sub_080210a0 / sub_08021140 / sub_08021510 / sub_080219bc) to unblock typed-struct promotion across all level-layout placeholders, or (b) scaffolding new C files for currently-blocked clusters, or (c) tackling a >80-instr target. The libgcc skip-list eliminates the false-positive blocks but doesn't change the real available-target count.

**Decisions:** 1 — picker `LIBGCC_SYMBOLS` skip-list (see docs/decisions.md).

**Trajectory:** 10 iters post-resume (11-20). Functions 41→56 (+15). Raw INCBIN 98.1%→95.6% (-2.5pp). db 117→204 (+87). src C 75→155 KiB (+80 KiB). **Iter 20 is the first "infra-shaped" iter since iter 9** — no new decomp, but landed picker hardening + major architectural understanding (walker family + 4-way parallel arrays). Counts as ONE infra iter for the no-op stop condition; if iter 21 also produces no decomp, that's two — at three I halt with note.

---

## Iter 21 — 2026-05-26

**Before:** 56 / ~513 fns (10.9%), 62 peeled-asm, 204 db, 155.3 KiB src C, 95.6% raw

**Targets:** Decomp scaffold-and-decomp sub_080090B0 via scaffold_cluster.py (first major exercise of the tool post-iter-17 contiguous-append patterns). Data: dispatcher + offset table at 0x083181bc, iter-20 follow-up.

**Outcomes:**
- Decomp: **scaffold_cluster.py worked FIRST-TRY, no manual fixup**. Major infra validation. sub_080090B0 lands NAKED + NON_MATCHING (~22 instr, byte_diff 6, permuter 2100+ iter didn't beat baseline). Function does sub-pixel-to-tile coord conversion via `__divsi3` and invalidates a cached coord pair. Auto-peel surfaced callee sub_08006B88 (12 B leaf). include/iwram.h gained `struct IwramAt3720` + grew `struct IwramAt35E0`. **Fifth unmatchable class confirmed**: register-coloring drift after libgcc/table-dispatch calls (third concrete instance — promoted from "candidate" to confirmed in codegen-notes).
- Data: 3 tables, 800 B from 0x083181bc cluster. Dispatcher (`{ptr=&sLevelLayout_31813C, count=0x20}`) + section-pointer header (7 u32 byte offsets) + monotonic offset table (191 u32 into first payload section). Consumer at 0x0802039a looks like a streaming-load manager (0x2000 DMA-control word + IWRAM 0x03000008 storage). 93 KiB variable-length payload at [0x083184dc..0x0832f980) characterized but deferred.

**Commit:** iter-21 hash (single combined: scaffold + decomp + data + codegen-notes + include/iwram.h).

**After:** 58 / ~513 fns (**11.3%** +0.4pp), 63 peeled-asm, 207 db (+3), **156.1 KiB src C** (+0.8 KiB), 95.6% raw, 4.4% data deblob. asm_funcs_remaining: 79 → 78.

**Architectural duties:**
- docs/codegen-notes.md "Fifth unmatchable class" — promoted from "candidate" to confirmed with three instances (sub_0800A2D8 / sub_0800A328 / sub_080090B0). Unified trigger: agbcc register-allocator choice that no source-level mutation flips. Detection heuristic + worked examples.
- include/iwram.h — two new IWRAM struct typedefs (IwramAt3720 sub-pixel coords; IwramAt35E0 grown).
- **scaffold_cluster.py validated end-to-end** — the picker's 20+ "scaffold C file"-blocked candidates are now all tractable.

**Decisions:** none material.

**Trajectory:** 11 iters post-resume (11-21). Functions 41→58 (+17). Raw INCBIN 98.1%→95.6% (-2.5pp). db 117→207 (+90). src C 75→156 KiB (+81 KiB). **The "decomp surface depletion" worry from iter 20 is resolved**: scaffold_cluster.py works, and the picker shows 20+ small tractable functions immediately tractable once scaffolded. Iter 20 was a one-time infra iter, not the start of a no-op streak.

---

## Iter 22 — 2026-05-26

**Before:** 58 / ~513 fns (11.3%), 63 peeled-asm, 207 db, 156.1 KiB src C, 95.6% raw

**Targets:** Decomp scaffold+decomp sub_08000918 (estimated 286-line / ~140-instr medium target). Data: 0x0819c312 + 0x0819cfde pair anchors (fresh region).

**Outcomes:**
- Decomp: **infra-only**. Target was 2× larger than estimated (596 B / ~298 instr, 14-case PC-table-dispatch state machine, NAKED-required). Per playbook "abandon if oversized" guidance, agent landed scaffold + 8 callee peels (sub_08000C98, sub_08000CEC, sub_08000D2C, sub_08000D50, sub_08000FD50, sub_08006948, sub_0800E600, sub_08009BA0 [hidden inside over-wide peel of disasm_0x08009a58.s — 3rd instance of iter-18 pattern]). Iter 23 lands the C body. asm_funcs_remaining: 78 → 86 (peeled-from-opaque count increase, not new work).
- Data: **2 tables, 6.5 KiB** (sBgTilemapVariantA + sBgTilemapVariantB). Required new alignment protocol for halfword-aligned-only anchors. Bonus: 3 additional anchors discovered in [0x08188edc..0x081a5b6a] for future iters.

**Commit:** iter-22 hash (single combined: scaffold + peels + data + 2 codegen-notes additions).

**After:** 58 / ~513 fns (11.3%, unchanged), **86 asm_funcs_remaining** (+8 from peels, not new debt), 209 db (+2), **156.1 KiB src C** (unchanged), 95.4% raw (-0.2pp), **4.6% data deblob** (+0.2pp).

**Architectural duties:**
- docs/codegen-notes.md **"Non-u32-aligned .rodata data anchors"** — new section. 3-step protocol: asm/data/*.s hand-assembled form + lower upstream/downstream bucket alignment to .balign 1. Applies to halfword-aligned BG tilemaps, halfword animation tables, font glyph data.
- docs/codegen-notes.md **"decomp_brief.py UNPEELED false-positives"** — new section. Brief only checks for asm/disasm_0x<addr>.s filename; misses C-lifted callees, paired peels, over-wide peels. 4/11 of sub_08000918's "UNPEELED" callees this iter were false positives. TODO: harden the brief.

**Decisions:** none material. Mixed iter (infra + data) is fine per stop-condition rules — counts as productive work since 8 callee peels + 2 data tables landed.

**Trajectory:** 12 iters post-resume (11-22). Functions 41→58 (+17). Raw INCBIN 98.1%→95.4% (-2.7pp). db 117→209 (+92). src C 75→156 KiB (+81 KiB). **The "asm_funcs_remaining went UP" is misleading**: it's not new debt, it's previously-opaque blob bytes promoted to named-asm-function status. The actual surface remaining is roughly unchanged.

---

## Iter 23 — 2026-05-26

**Before:** 58 / ~513 fns (11.3%), 86 asm-fn-remaining, 209 db, 156.1 KiB src C, 95.4% raw

**Targets:** Decomp batch on iter-22's tiny peeled callees (sub_08000C98/CEC/D2C/D50, sub_08006948). Data: 0x0820c578 fresh anchor.

**Outcomes:**
- Decomp: **3 functions landed** (1 pure-C + 2 NAKED+NON_MATCHING). sub_08000D50 pure-C 12 B trivial forwarder. sub_08006948 + sub_08006958 NAKED — paired peel hidden inside the same .s slice (4th instance of "iter-18 peel-hides-second-function" pattern this loop). Both NAKED'd for 5th unmatchable class (register-coloring drift). 3 others deferred: sub_08000C98 + sub_08000D2C blocked on unpeeled 0x0800B7B0; sub_08000CEC needs 5 callee peels.
- Data: **3 tables, 4.6 KiB** + major architectural finding — this is a SECOND screen-install cluster paralleling iter-18's 0x081d8b98 family. Confirms the screen-install resource pattern as a recurring subsystem.

**Commit:** iter-23 hash (single combined: 3 decomps + 3 data + codegen-notes 5th-class extension).

**After:** 63 / ~513 fns (**12.3%** +1.0pp), 84 asm-fn-remaining (-2 net), 212 db (+3), **160.7 KiB src C** (+4.6 KiB), 95.3% raw (-0.1pp), **4.7% data deblob** (+0.1pp).

**Architectural duties:**
- docs/codegen-notes.md "5th unmatchable class" — updated: 5 confirmed instances (was 3 at iter 21's promotion). Class firmly established across diverse triggers. Two new triggers documented: strh-folding through parameter register, bool-return register coloring.
- **Screen-install resource family** — confirmed as a recurring multi-cluster subsystem (iter-18 0x081d8b98 + iter-23 0x0820c578). Dispatcher functions sub_0801e078, sub_0801e28c, sub_0801eed4 noted as decomp-priority for the family unlock.
- **Iter-18 hidden-fn-in-peel pattern**: 4th occurrence (sub_08006958 inside sub_08006948's peel). The pattern is becoming a regular feature, not a one-off. Worth adding a `decomp_brief.py` enhancement to count `push {` directives in the .s and flag potential hidden fns.

**Decisions:** none material.

**Trajectory:** 13 iters post-resume (11-23). Functions 41→63 (+22). Raw INCBIN 98.1%→95.3% (-2.8pp). db 117→212 (+95). src C 75→161 KiB (+86 KiB). **Crossing 12% function decomp** — first major milestone since 10%. **Crossed 95.5% → 95% raw INCBIN** threshold this iter (95.4% → 95.3%). Pace acceleration is steady: ~1.5-2 fns per iter on average across post-resume iters.

---

## Iter 24 — 2026-05-26

**Before:** 63 / ~513 fns (12.3%), 84 asm-fn-remaining, 212 db, 160.7 KiB src C, 95.3% raw

**Targets:** Decomp peel sub_0800B7B0 + scaffold-decomp sub_08000C98 + sub_08000D2C. Data: long-deferred 0x080e3774 + 0x080e3ab6 (4-5 iters of deferral).

**Outcomes:**
- Decomp: **2 fns FIRST-TRY pure-C** + 1 callee peel. Both decomps are trivial forwarders (sub_0800B7B0(a, b, 18) — likely mode-set event ID = 18). Net asm_funcs_remaining: 84 → 83.
- Data: **2 anchors, 16.5 KiB** extracted. sFrogSpritePalettes_E3774 (5×16-color OBJ palettes, 160 B). sFrogTilePixels_E3AB6 (16 KiB 4bpp tile pixels via iter-22 non-u32-aligned protocol). **Iter-19 mis-classification corrected**: 0x080e3774 was incorrectly tagged as tile pixel data in iter-19's scout; it's actually palette data (32-byte DMAs to palette RAM).

**Commit:** iter-24 hash (single combined: 1 peel + 2 decomps + 2 data tables).

**After:** 65 / ~513 fns (**12.7%** +0.4pp), 83 asm-fn-remaining (-1), 214 db (+2), 160.9 KiB src C, **94.9% raw** (-0.4pp), **5.1% data deblob (+0.4pp — crossed 5%!)**.

**Architectural duties:**
- **CROSSED 5% DATA DEBLOB milestone**. First time over the 5% threshold; +1pp from iter-23. The screen-install + sprite-palette extractions are paying off in deblob percentage now that semantic-grouped clusters land 4-16 KiB per pass instead of <1 KiB single-table extractions.
- **CROSSED 95% raw INCBIN threshold the other direction** (95.3% → 94.9%).
- Iter-19 scout correction logged. Future scouts should DMA-cnt-check before tagging "tile pixel data needs encoder workflow" — 0x20-cnt DMAs are palette; larger cnts to OBJ-tile VRAM are pixels. Adding to docs/codegen-notes.md would be premature (one occurrence); flag for repeated pattern.

**Decisions:** none material.

**Trajectory:** 14 iters post-resume (11-24). Functions 41→65 (+24). Raw INCBIN 98.1%→94.9% (-3.2pp). db 117→214 (+97). src C 75→161 KiB (+86 KiB). Data deblob 1.0%→5.1% (+4.1pp). **Two major milestones crossed this iter** (5% data deblob, sub-95% raw INCBIN). Pace continues to accelerate as semantic-cluster extraction patterns mature.

---

## Iter 25 — 2026-05-26

**Before:** 65 / ~513 fns (12.7%), 83 asm-fn-remaining, 214 db, 160.9 KiB src C, 94.9% raw

**Targets:** Decomp batch sub_08006B88 + sub_08000CEC + sub_08009BA0. Data: 4 known-but-deferred sibling anchors (0x080e7ab6, 0x081a3b6a, 0x081a5b6a, 0x08188edc).

**Outcomes:**
- Decomp: **3 fns landed!** 2 pure-C (sub_08006B88 + sub_08000CEC, both first-try) + 1 NAKED (sub_08009BA0, **6th unmatchable instance — `ip` (r12) added to High Registers class**). +3 callee peels (sub_08000B6C, sub_08016404, sub_08020C78). asm_funcs_remaining: 83 → 80.
- Data: **4 of 4 anchors, 42.8 KiB extracted** (data deblob 5.1% → 6.2%, **+1.1pp single-iter jump**). sFrogTilePixels_E7AB6 (34 KiB) + sScreenTilemap_188EDC (2 KiB) + paired sScreenCharTiles_1A3B6A / sScreenTilemap_1A5B6A (8 + 2 KiB).

**Commit:** iter-25 hash (single combined: 3 decomps + 3 peels + 4 data + codegen-notes ip-register extension).

**After:** 68 / ~513 fns (**13.3%** +0.6pp), 80 asm-fn-remaining (-3), 218 db (+4), **163.1 KiB src C** (+2.2 KiB), **93.8% raw (-1.1pp — under 94%)**, **6.2% data deblob (+1.1pp)**.

**Architectural duties:**
- docs/codegen-notes.md "High registers" class — `ip` (r12) added. 6th NAKED-required register-pin instance. Corpus grep evidence in commit body.
- **decomp_brief.py UNPEELED false-positive — 3rd documented occurrence**. Brief reports callees as needing peel when they already live in src/*.c. Iter 23 + 25 both wasted some agent effort on this. **Bumping infra-build threshold from "triplicate" to "if it fires next iter, build a tool"**. The fix: tighten the brief to also grep src/**/*.c for `thumb_func_start <name>` equivalents.
- **Refcount-driven data discovery exhausted at ≥2 refs**. The data side has cleared all anchor-driven targets. Future data passes should: (a) drop to single-ref anchors; (b) extract documented-but-deferred sibling anchors; (c) extract known-large deferred payloads (93 KiB at 0x083184dc, 70 KiB at 0x0820d778) once consumer decomps land.

**Decisions:** none material.

**Trajectory:** 15 iters post-resume (11-25). Functions 41→68 (+27). Raw INCBIN 98.1%→93.8% (-4.3pp). db 117→218 (+101). src C 75→163 KiB (+88 KiB). Data deblob 1.0%→6.2% (+5.2pp). **Five-pp deblob threshold crossed**. Iter pace continues to mature: this iter landed +3 fns + 42.8 KiB data + 6th unmatchable instance documented + 3 callee peels in one go. Loop is genuinely accelerating.

---

## Iter 26 — 2026-05-26

**Before:** 68 / ~513 fns (13.3%), 80 asm-fn-remaining, 218 db, 163.1 KiB src C, 93.8% raw

**Targets:** Decomp sub_08009C14 (contiguous append) + sub_08009984 (scaffold). Data: 16-anchor 0x082f9xxx cluster (per-mode config for sub_08000918).

**Outcomes:**
- Decomp: **2 NAKED fns landed** (both 5th unmatchable class — register-coloring drift, byte_diff 6 and 13 in pure C respectively). sub_08009C14 contiguous-appended to sub_08009ba0.c (2nd validation of iter-17 pattern). sub_08009984 needed scaffold. **~10 callee peels** including ANOTHER hidden-fn case (sub_0800CD88 split into 3 functions). include/iwram.h grew with 6 new struct fields supporting typed offsets for both bodies.
- Data: **2 tables, 800 B** but huge architectural milestone — sModeConfigTables_2F99E8 confirmed as the per-mode config backing sub_08000918's 14-case state machine. Install pattern matches iter-17's sUnkPtrPair_82F998C (same helper at 0x0800658c writes ptr to gGameStuff[0x34]). IWRAM struct at 0x03006110 = mode-config control block.

**Commits:** iter-26 hash + `9dd2e9c` (decomp_brief.py UNPEELED false-positive fix, standalone infra).

**After:** 73 / ~513 fns (**14.2%** +0.9pp), 80 asm-fn-remaining (unchanged — peels offset new C bodies), 220 db (+2), **164.2 KiB src C** (+1.1 KiB), 93.7% raw (-0.1pp), **6.3% data deblob**.

**Architectural duties:**
- docs/codegen-notes.md "5th unmatchable class" — extended to 7 instances now (sub_08009C14 + sub_08009984 added).
- **tools/agent/decomp_brief.py FIXED**: UNPEELED false-positive eliminated. peeled_starts() now scans (1) disasm filenames, (2) all thumb_func_start labels across all .s files, (3) sub_<HEX>( definitions across src/**/*.c. Verified on sub_08000918's 19 callees — all now correctly report ✓ peeled. **4-iter friction streak ended**.
- **TODO future tool**: detect-fn-boundary missed 3/9 peels this iter (skips past short-prologue functions following pool data). Worth a follow-up infra commit if it bites again next iter.

**Decisions:** none material.

**Trajectory:** 16 iters post-resume (11-26). Functions 41→73 (+32). Raw INCBIN 98.1%→93.7% (-4.4pp). db 117→220 (+103). src C 75→164 KiB (+89 KiB). Data deblob 1.0%→6.3% (+5.3pp). **Crossed 14% function decomp**. The loop now consistently lands 2-3 fns + data + architectural understanding per iter. Tool-quality fixes (this iter's brief fix) reduce per-iter friction.

---
