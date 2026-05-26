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
