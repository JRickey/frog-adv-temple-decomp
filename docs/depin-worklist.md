# De-pin / NAKED-reaping worklist (task #14)

## Session 2026-06-07 progress (read this first)

**Landed reaps (all clean-rebuild verified, `make check` OK):**
- `17c09c9a` — 3 free wins (Display_ResetLayers, Entity_MoveToEntry,
  Tilemap_DispatchPendingBlits): the worklist's byte_diff-0 redundant pins.
- `6c5db1b0` — `Blend_StepFade`: reaped the literal-16 pin by splitting
  `*p = 16 - *c` into `n = 16; n -= *c; *p = n;` (3 pins → 2).
- `b498acdd` — `Entity_UpdateHitboxSlots` (**owner priority #1**): reaped
  BOTH r8/r9 high-reg struct-pointer pins by making the spare `typeStack`
  spill non-volatile. Found via decomp-permuter (perm_randomize_internal_type).

**Method that works** (see memory `depin-methodology`): de-pin → permuter
(run LONG, 35k+) → extract the *minimal* winning mutation → apply cleanly →
clean-rebuild verify. Manual structural insight + permuter combo beats either
alone (Blit went 1635→70 score once the records-spill was added by hand).

**Confirmed RESISTANT this session (attempted, reverted, pins kept):**
- `Scene_EntityTick` (#4): all 4 pins interdependent; sceneType→r2 is pure
  low-reg coloring the permuter can't flip. **STALE — reaped 2026-09-07**
  (`f495c5a8`): it was a combine fold blocked by the CONST_INT base, not
  coloring. See the 2026-09-07 sub_08009ba0.c entry at the end.
- `Blit_ApplyFlaggedRecords` (#32, priority): the romTable(r9) reap needs a
  hand-added `volatile recordsStack` spill to match the baserom's stack spill
  (got byte_diff 114→27), but the residual rec→r5/r4 coloring + spill-position
  plateaus the permuter at score 70 over 36k+ iters across 2 base improvements.
- `BlitSpriteRect` (#40, priority): 11-pin tangle; minimal r8/r9 removal
  plateaus the permuter at 750.
- `EntityHitbox_RegisterHitPoint` (#14), `Mode4_BlitRect` (#8): pure low-reg
  coloring; permuter plateaus (120, 30) at 24–30k iters.

**KEY FINDING — the free-win vein is exhausted.** Batch-tested ALL 37 LIVE
single-pin functions (the 1-pin long tail the original pass left unmeasured):
**0 / 37 redundant** — every single pin is load-bearing (e.g. FrogOam_Init's
one r0 pin = byte_diff 155 when removed). Prior agents only added pins when
needed, so the remaining pin forest is genuinely load-bearing agbcc coloring
(confirms [[pin-forest-not-data-model]]). Reaping now REQUIRES the
permuter/structural work, which: **works** for high-reg permutations (Entity)
and structural spills (Blend); **resists** pure low-reg coloring (Scene,
EntityHitbox, Mode4 all plateau). The 2-pin tail was not batch-tested but is
expected load-bearing for the same reason.

**Next-session leverage:** the remaining tractable value is (a) other
high-reg-permutation functions amenable to the typeStack/spill-pressure trick,
and (b) large structural cases via manual-insight-seeded permuter runs. Pure
low-reg coloring (most of the mid tier) is a permuter dead-end here — don't
burn budget on it. `nonmatchings/<fn>/` scratch dirs (gitignored) hold the
permuter setups for Blit/BlitSpriteRect/Scene/EntityHitbox/Mode4 if resuming.

---


The ROM is 100% byte-matched, but many functions reach that match only because
they carry `register T x asm("rN")` **pins** that force agbcc's register
allocator to colour the way the baserom did. Task #14 removes those pins and
recovers the match with `vendor/decomp-permuter`. This doc ranks every pinned
function by the **actual byte_diff after pin removal** so the permuter budget
goes to the easiest-first, and tags the **struct high-register** class the
owner wants run first.

This is a measurement artifact — no source was changed to produce it. Every
function was de-pinned, measured, and reverted; `make check` is green.

## Method

For each function: strip the `asm("rN")` annotation from its `register` decls
(turn `register T x asm("r8");` into `T x;`), leaving everything else
identical, then **clean-rebuild** (`make tidy && make -j8`) and read the
per-function diff from `tools/agent/compile_and_view_assembly.py <fn> --human`.
Revert with `git checkout -- <file>` before the next.

**Why clean rebuild, not incremental:** an incremental `make` after a pin
strip *false-greens* (stale `.o` reuse) — `CollisionTable_ScanForPlayer` and
four blit functions reported `byte_diff=0 / MATCH` incrementally but `53`,
`158`, `200`, … on a clean build. Trust only `make tidy && make -j8`. (Same
hazard the handoff calls out: incremental check false-greens, a failed build
leaves stale `.o`s that false-RED.)

**Columns:**
- `byte_diff` — total mismatching bytes for the function on a clean rebuild
  (the project oracle's number, drift-free). Scales with function size, so
  read it together with ARG.
- `ARG / nonARG` — count of mismatching instructions that are pure
  register-operand differences (`ARGUMENT_MISMATCH`) vs. opcode/structural
  differences. **`nonARG == 0` ⇒ the de-pin is pure register colouring — the
  permuter's exact domain.** `nonARG > 0` ⇒ there's a structural delta the
  permuter (which only reorders statements/scopes) is less likely to recover.
  (ARG is the displayed count and is capped by the tool; `byte_diff` is the
  true total.)
- `size_delta` — change in the function's own size after de-pin. `0` ⇒ the
  pin only recoloured registers; `≠ 0` ⇒ the pin was forcing an
  encoding/size choice (a harder, often-structural case).
- `struct-high-reg` — the priority class: a **typed struct pointer** pinned
  into a **high callee-saved register (r8/r9/sl)**.

## How to run the permuter (per function, easiest byte_diff first)

1. Remove the `asm("rN")` pins in the target function (plain locals).
2. `python3 tools/agent/make_permuter_target.py <fn>` — **regenerate
   `target.o`**. Without `$t/$d` mapping symbols the permuter scores ~100x too
   high (the `permuter_target_bug`). Confirm `vendor/decomp-permuter` venv
   exists (`scripts/setup-decomp-permuter.sh`; it was once a broken
   self-symlink, now restored). All prerequisites are present in-tree as of
   this writing.
3. Run the permuter from the near-matching base; in parallel try the corpus
   history idiom search (CLAUDE.md "Stuck on a fold? Search the corpus
   FIRST") — agbcc colouring idioms are usually already solved in pret/cvaos.
4. **Match** ⇒ drop the pins, `make tidy && make -j8 && make check` (exit 0),
   commit, decrement the pin count. **Genuine residue** (matches one of the
   four hard classes in `docs/codegen-notes.md` AND ~0% permuter improvement
   over ~10k+ iters) ⇒ restore the pins, keep the `#ifdef NON_MATCHING`
   shape, and log the class + iter count/score in the commit (the
   "Permuter convergence audit" in codegen-notes is the precedent).

**Discipline:** the only matching oracle is `make tidy && make -j8 &&
make check`. These functions touch shared files (Entity / the IWRAM structs);
run them **serially or in non-overlapping worktrees** — never a pin-edit and
another agent's `git checkout` on the same file concurrently.

**Calibration anchors:** `Entity_UpdateHitboxSlots` is the known-good
sweet-spot (pure colouring; the handoff cites ~10 after a partial strip —
full strip measured 65 here, all ARG). `sub_080210A0` is the documented
resistant case: a prior 17-pin wholesale removal "failed badly"
(`docs/register-pin-cleanup-handoff.md`) — high-register lifetime + stack-arg
colouring; ~124 structural.

## Start here — struct-high-reg, low byte_diff (run first)

The priority class is only **5 LIVE functions** (a typed struct pointer pinned
into r8/r9/sl, in a real compiled body). Run them in this order:

1. **`Tilemap_DispatchPendingBlits`** (`src/engine/sub_08015930.c`, `sl =
   struct TilemapTableEntry *`) — **byte_diff 0: the pin is already
   REDUNDANT.** Drop it, rebuild, commit. No permuter needed. (Despite a
   loop-constant-across-inner-BL shape, the comment's premise no longer holds
   for the current source.)
2. **`Entity_UpdateHitboxSlots`** (`src/engine/sub_0800b7b0.c`, `r8 = const
   EntityHitbox *`) — byte_diff 65, **21 ARG / 0 nonARG**, pure colouring.
   The reference sweet-spot; best permuter candidate.
3. **`Blit_ApplyFlaggedRecords`** (`src/engine/sub_080113e8.c`, `r9 = struct
   BlitRecord *`) — byte_diff 114, **15 ARG / 0 nonARG**, pure colouring.
4. **`BlitSpriteRect`** (`src/engine/sub_08015b6c.c`, `r8 = struct
   BlitSource_15B6C *`, `r9 = struct BgScrollState *`) — byte_diff 158, **15
   ARG / 0 nonARG**, pure colouring but 11 pins / 180 B; longer permuter run.
5. **`sub_080210A0`** (`src/engine/sub_080210a0.c`, `sl = const volatile
   SpawnRecord *`) — byte_diff 136. **Documented resistant** (17-pin wholesale
   removal failed; stack-arg + high-reg colouring). Attempt last, expect to
   restore + keep NON_MATCHING.

Beyond the strict struct-high-reg class, the **lowest-friction wins overall**
(any reg, `nonARG == 0`) are the rest of the top of the table — start the
non-priority work here:

| function | file | byte_diff | why |
|---|---|--:|---|
| `Display_ResetLayers` | src/engine/sub_08014ea8.c | 0 | redundant pin — free |
| `Entity_MoveToEntry` | src/game/sub_0802cdd0.c | 0 | redundant pin — free |
| `Scene_EntityTick` | src/game/sub_08009ba0.c | 2 | trivial coloring (`GameStuff *` in r4) |
| `EntityDispatch_RunFrame` | src/game/sub_08009ba0.c | 11 | trivial coloring |
| `Blend_StepFade` | src/engine/sub_080106b8.c | 11 | trivial coloring |
| `sub_0800D9C8` | src/engine/sub_0800d8a0.c | 16 | `struct Entity *` in r2 (low reg) |
| `Mode4_BlitRect` | src/engine/sub_0801621c.c | 22 | trivial coloring |
| `TileBlit_DrawEntry` | src/engine/sub_08016824.c | 22 | `struct TileBlitRecord *` x3 (low regs) |
| `Credits_InitStateA` / `Credits_InitStateB` | src/engine/sub_0801ac84.c | 24 | shared file — measure both per-symbol |
| `EntityHitbox_RegisterHitPoint` | src/engine/sub_0800c2a8.c | 37 | `const EntityHitbox *` in r4 |

## Ranked worklist (all measured, byte_diff ascending)

53 functions: the 51 `function_status.py --status register-heavy` (≥3 pins)
plus the 2 struct-high-reg priority functions that sit below that threshold
(`Tilemap_DispatchPendingBlits`, `Blit_ApplyFlaggedRecords`). Sorted
most-tractable first.

| # | function | file | pinned reg(s) | pin var type(s) | struct-high-reg | byte_diff | ARG/nonARG | size_delta | classification | notes |
|---|---|---|---|---|:-:|--:|--:|--:|---|---|
| 1 | `Display_ResetLayers` | src/engine/sub_08014ea8.c | r3, r1, r2 | r3:u8 *a, r1:u8 one, r2:u8 *b |  | 0 | 0/0 | 0 | REDUNDANT (free) |  |
| 2 | `Entity_MoveToEntry` | src/game/sub_0802cdd0.c | r3, r1, r4 | r3:u32 off1, r1:u32 off2, r4:s8 *outY |  | 0 | 0/0 | 0 | REDUNDANT (free) |  |
| 3 | `Tilemap_DispatchPendingBlits` | src/engine/sub_08015930.c | sl | sl:struct TilemapTableEntry *table16 | YES | 0 | 0/0 | 0 | REDUNDANT (free) | priority class; pin already redundant |
| 4 | `Scene_EntityTick` | src/game/sub_08009ba0.c | r4, r1, r2, r0 | r4:GameStuff *game, r1:const u32 *procA, r2:u8 sceneType, r0:u32 offset |  | 2 | 2/0 | 0 | PERMUTER-TRACTABLE (easy) | shared file w/ EntityDispatch_RunFrame |
| 5 | `EntityDispatch_RunFrame` | src/game/sub_08009ba0.c | r1, r2, r0, r0, r1, r1 | r1:u8 idx1, r2:u8 idx2, r0:u32 offset, r0:const u8 *lut, r1:const u32 *procA, r1:const u32 *procB |  | 11 | 11/0 | 0 | PERMUTER-TRACTABLE (easy) | shared file w/ Scene_EntityTick |
| 6 | `Blend_StepFade` | src/engine/sub_080106b8.c | r2, r0, r1 | r2:vu8 *countdown, r0:vu16 *bldcnt, r1:int n |  | 11 | 7/0 | 0 | PERMUTER-TRACTABLE (easy) |  |
| 7 | `sub_0800D9C8` | src/engine/sub_0800d8a0.c | r2, r4, r5, r3, r1 | r2:struct Entity *dst, r4:struct IwramAt35E0 *src, r5:u32 offset, r3:u32 offset2, r1:u32 addrOrValue |  | 16 | 10/0 | 0 | PERMUTER-TRACTABLE (easy) | shared file w/ SpawnControl_Dispatch |
| 8 | `Mode4_BlitRect` | src/engine/sub_0801621c.c | r2, r0, r7 | r2:u8 *dst, r0:u32 rowOff, r7:u32 x |  | 22 | 20/0 | 0 | PERMUTER-TRACTABLE (easy) |  |
| 9 | `TileBlit_DrawEntry` | src/engine/sub_08016824.c | r2, ip, r3 | r2:struct TileBlitRecord *entry, ip:struct TileBlitRecord *loopBase, r3:struct TileBlitRecord *p |  | 22 | 22/0 | 0 | **REAPED 2026-09-07** (was: PERMUTER-TRACTABLE (easy)) | symbol-form record accesses + fold association; see the 2026-09-07 sub_08016824.c entry |
| 10 | `Credits_InitStateB` | src/engine/sub_0801ac84.c | r4, r5, r1, r1 | r4:u8 arg, r5:u8 b1, r1:u32 sum, r1:const u8 *p |  | 24 | 10/0 | 0 | PERMUTER-TRACTABLE (easy) | shared file w/ Credits_InitStateA |
| 11 | `Credits_InitStateA` | src/engine/sub_0801ac84.c | r5, r2, r2 | r5:u8 b1, r2:u32 sum, r2:const u8 *p |  | 24 | 10/0 | 0 | PERMUTER-TRACTABLE (easy) | shared file w/ Credits_InitStateB |
| 12 | `FrogSelect_ClearInputState` | src/engine/sub_080199e4.c | r2, r4, r1, r3, r1, r0 | r2:u32 i, r4:u8 *base, r1:u8 *dst, r3:u8 zero, r1:u8 *ptr, r0:u32 next |  | 36 | 3/0 | -12 | PERMUTER-TRACTABLE | size_delta -12: clear-loop unrolling may shift |
| 13 | `BgScroll_TileWipeTransition` | src/engine/sub_0801da1c.c | r9, sl, r1 | r9:u32 d, sl:u32 e, r1:vu16 *palReg |  | 36 | 7/2 | 0 | MIXED (has structural diff) | nonARG=2 |
| 14 | `EntityHitbox_RegisterHitPoint` | src/engine/sub_0800c2a8.c | r4, r1, r0 | r4:const EntityHitbox *table, r1:u32 offset, r0:u32 pa |  | 37 | 30/0 | 0 | PERMUTER-TRACTABLE |  |
| 15 | `CollisionTable_ScanForPlayer` | src/game/sub_08007138.c | sl, r6, r1, r4, r5, r1, r2, r3, r0 | sl:u32 maskHi, r6:s32 tailBound, r1:u8 stateByte, r4:union PackedPointUnion07138 point, r5:union …, r1:u32 r1v, r2:u32 r2v, r3:u32 r3v, r0:struct Entity *callPlayer |  | 53 | 16/0 | 0 | PERMUTER-TRACTABLE | sl is a scalar, not a struct ptr |
| 16 | `BlitTilesRect` | src/engine/sub_08015c24.c | r1, r0, r0, r0, r1, r0 | r1:s32 x, r0:s32 y, r0:s32 xScratch, r0:u32 row, r1:u8 nextRow, r0:s32 off |  | 53 | 11/0 | 0 | PERMUTER-TRACTABLE |  |
| 17 | `Entity_UpdateHitboxSlots` | src/engine/sub_0800b7b0.c | r8, r9, r1, r4, r2, r7, r2 | r8:const EntityHitbox *table, r9:const u8 *points, r1:u32 r1v, r4:s32 typeIndex, r2:s32 slotShift, r7:u32 slotsBase, r2:u32 *out | YES | 65 | 21/0 | -4 | PERMUTER-TRACTABLE | **priority class; calibration sweet-spot** |
| 18 | `Entity_UpdateFrame` | src/game/sub_08009d9c.c | r0, r3, r1 | r0:u8 nextState, r3:u8 stateByte, r1:vu16 *dst |  | 65 | 23/1 | 0 | LIKELY-RESISTANT (documented) | permuter audit -5.4% (codegen-notes "Permuter convergence audit"); far from 0 |
| 19 | `Gate_OnTileStep` | src/engine/sub_0800ab84.c | r4, r5, r5 | r4:u8 *spawn, r5:u8 *spawn5, r5:struct IwramAt6110 *base6110 |  | 66 | 8/3 | 0 | MIXED (has structural diff) | nonARG=3 |
| 20 | `BgScrollAnim_Update` | src/engine/sub_08012cac.c | r5, r4, r0, r1, r2, r6, r3 | r5:u8 *scrollState, r4:GameStuff *gs, r0:u32 prev, r1:u32 elapsed, r2:u8 *anim0, r6:struct IwramAt3550 *bg2, r3:u32 newCurB |  | 71 | 27/0 | -4 | PERMUTER-TRACTABLE |  |
| 21 | `Scroll_UpdateCamera` | src/engine/sub_0800f24c.c | r2, r1, r0, r3 | r2:s32 r2v, r1:s32 targetY, r0:u32 rawX, r3:u32 rawY |  | 73 | 17/0 | 4 | PERMUTER-TRACTABLE | new-agbcc exception file (Makefile) |
| 22 | `ScrollCamera_Update` | src/engine/sub_0801a6d4.c | r8, r2, r1, r0, r3 | r8:u32 count, r2:s32 r2v, r1:s32 targetY, r0:u32 rawX, r3:u32 rawY |  | 74 | 12/0 | 4 | PERMUTER-TRACTABLE | r8 is a scalar count, not a struct ptr |
| 23 | `ScriptStep_Advance` | src/engine/sub_0801a614.c | r4, r0, r1, r0, r0 | r4:int op, r0:u8 cursor, r1:u8 c1, r0:u32 idx, r0:int z |  | 75 | 23/0 | 0 | PERMUTER-TRACTABLE |  |
| 24 | `Array_ThrottledRotate` | src/engine/sub_08013908.c | r2, r6, r1 | r2:u16 prev, r6:u16 cur, r1:GameStuff *gsEp |  | 75 | 11/0 | 2 | PERMUTER-TRACTABLE |  |
| 25 | `HUD_DrawStampIcons` | src/engine/sub_0801c464.c | ip, r6, r0 | ip:u32 ipBase, r6:volatile struct BgScreenblock *screenblock, r0:u32 row2 |  | 81 | 15/0 | 4 | PERMUTER-TRACTABLE |  |
| 26 | `EntityHitbox_RegisterGridPoints` | src/engine/sub_0800a83c.c | r9, r8, r1, r5, r3, r7, r3 | r9:u32 gridIdReg, r8:u32 gridPlaneReg, r1:u32 r1v, r5:s32 savedTypeIndex, r3:s32 y, r7:u32 useAlternateFlagsTest, r3:const s8 *countBase |  | 85 | 21/0 | -4 | PERMUTER-TRACTABLE | 7 pins remain; r0v binding removed with reversed equality operands (c9f57c15, integrated first evidence campaign) |
| 27 | `ScriptTick` | src/engine/sub_080179b8.c | r4, r2, r0, r1, r0, r1 | r4:int op, r2:GameStuff *gs, r0:u8 cursor, r1:u8 c1, r0:int idx, r1:const u16 *const *tbl |  | 85 | 28/0 | -6 | PERMUTER-TRACTABLE |  |
| 28 | `BgScrollDmaUpdate` | src/engine/sub_08013aac.c | r4, r0, r6 | r4:struct Queue_64C0 *queue, r0:u8 cursor, r6:u8 wrapCursor |  | 92 | 14/0 | -4 | PERMUTER-TRACTABLE |  |
| 29 | `Icon_DmaUpdateSprite` | src/engine/sub_08016824.c | ip, r1, r0, r1 | ip:u32 gs, r1:u32 r1val, r0:u32 r0r, r1:u32 r1r |  | 102 | 16/0 | 0 | **REAPED 2026-09-07** (was: PERMUTER-TRACTABLE) | inlined u8 selector + symbol-form gGameStuff PRE copy; see the 2026-09-07 sub_08016824.c entry |
| 30 | `sub_0800BE18` | src/engine/sub_0800be18.c | r9, r6, r0, r1 | r9:u32 shiftedType, r6:s32 typeIndex, r0:s32 typeIndex, r1:u32 pointsBase |  | 104 | 14/0 | 0 | PERMUTER-TRACTABLE | r9 is a scalar |
| 31 | `SpawnControl_Dispatch` | src/engine/sub_0800d8a0.c | r4, r5, r6, r3 | r4:u8 *base, r5:u8 *saved6110, r6:u8 *entry, r3:u32 mask |  | 109 | 23/0 | 4 | PERMUTER-TRACTABLE | shared file w/ sub_0800D9C8 |
| 32 | `Blit_ApplyFlaggedRecords` | src/engine/sub_080113e8.c | sl, r9 | sl:u8 idx, r9:struct BlitRecord *romTable | YES | 114 | 15/0 | 0 | PERMUTER-TRACTABLE | **priority class** |
| 33 | `ModeControl_GetFlag` | src/game/sub_0800679c.c | r0, r0, r2, r3, r1 | r0:u32 r, r0:u8 *p, r2:u32 lo, r3:u32 hi, r1:s32 signExt |  | 122 | 10/0 | 6 | **REAPED 2026-09-07** (was: LIKELY-RESISTANT) | regmove 2-address fold; see the 2026-09-07 sub_0800679c.c entry |
| 34 | `Entity_LerpPosition` | src/game/sub_080087b4.c | r2, r1, r0, r1 | r2:u8 *gB2, r1:u8 *e, r0:s32 num, r1:s32 ref |  | 122 | 17/0 | 6 | LIKELY-RESISTANT (size) |  |
| 35 | `PollInputAndAttract` | src/system/init1.c | r3, r1, r0 | r3:u16 prevKeys, r1:u16 keyB, r0:GameStuff *gs |  | 134 | 14/0 | -4 | LIKELY-RESISTANT (size) |  |
| 36 | `sub_080210A0` | src/engine/sub_080210a0.c | sl, r6, r8, r9, r5, r2, r0, r1, r2 | sl:const volatile SpawnRecord *recVol, r6:u32 field14Reg, r8:u32 field16Reg, r9:u32 matchKeyReg, r5:u32 field17Reg, r2:const SpawnRecord *rec2, r0:u32 byteScratch0, r1:u32 byteScratch1, r2:const u8 *paramRec | YES | 136 | 2/0 | -20 | LIKELY-RESISTANT (documented) | **priority class; KNOWN RESISTANT** — 17-pin wholesale removal failed (register-pin-cleanup-handoff.md); high-reg lifetime + stack-arg colouring |
| 37 | `Entity12_TickStateMachine` | src/engine/sub_0802a9fc.c | r4, r1, r2, r0, r2, r3 | r4:u16 *statusPtr, r1:u16 status, r2:u16 queued, r0:u16 newStatus, r2:u16 *sp, r3:u16 *sp |  | 140 | 26/2 | 4 | MIXED (has structural diff) | nonARG=2 |
| 38 | `ScaleAnim_TickFrames` | src/engine/sub_08013040.c | r8, r5, r1, r7, r0, r2, r9, r7, ip, r0, r5, r4, r0 | (13 pins; high-regs are scalars: r8:u8 *counterRef, r9:u32 dst) |  | 149 | 14/0 | 4 | LIKELY-RESISTANT (size) | new-agbcc exception file (Makefile) — harder |
| 39 | `EntityMover_Tick` | src/engine/sub_08020f3c.c | r3, r6, r1, r0, r1 | r3:EntityMover *base, r6:u32 argReg, r1:s32 dy, r0:u32 finalOff, r1:u8 *stampBase |  | 149 | 17/1 | -12 | MIXED (has structural diff) | nonARG=1; struct ptr in low reg r3 |
| 40 | `BlitSpriteRect` | src/engine/sub_08015b6c.c | r8, r6, r0, r1, r5, r4, ip, r9, r3, r2, r7 | r8:struct BlitSource_15B6C *srcp, r6:u16 *dst, r0:u32 row, r1:u32 r1slot, r5:u32 width, r4:u32 height, ip:u32 dyh, r9:struct BgScrollState *loopState, r3:u16 dstStride, r2:s32 dx, r7:u32 earlyScratch | YES | 158 | 15/0 | -4 | LIKELY-RESISTANT (size) | **priority class** — pure coloring but 11 pins / large; long permuter run |
| 41 | `BlitEntityTileFrame1` | src/engine/sub_0801288c.c | r0, r5, r6, r2, r8, ip, r9, r1, r4, r1, r3 | (11 pins; high-regs scalars: r8:u32 x, r9:u32 height) |  | 184 | 9/0 | -4 | LIKELY-RESISTANT (size) |  |
| 42 | `GameMode_SceneTick` | src/game/sub_08003254.c | r2, r0, r4, r3, r0, r4 | r2:u8 id, r0:u32 offset, r4:GameStuff *g, r3:u8 id, r0:u32 offset, r4:struct IwramAt35E0 *ent |  | 198 | 17/1 | 4 | MIXED (has structural diff) | nonARG=1; uses statement-expression arg pinning (codegen-notes) |
| 43 | `sub_08012BC4` | src/engine/sub_08012bc4.c | ip, r9, r6, r8, r1, r5, r2, r3, r0, r4, ip, r1, r0 | (13 pins; high-regs scalars: r9:u32 x, r8:u32 index) |  | 200 | 18/0 | -20 | LIKELY-RESISTANT (size) |  |
| 44 | `BlitEntityTileFrame0` | src/engine/sub_08012664.c | r2, r8, ip, r3, r4, r9, r6, r1, r0, r5, r1, r4, r5, r6, r3, r0 | (16 pins; high-regs scalars: r8:u32 x, r9:u32 rows) |  | 214 | 5/0 | -16 | LIKELY-RESISTANT (size) | most-pinned function |
| 45 | `Entity_InitHitboxSlots` | src/engine/sub_0800af50.c | r0, r5, r9 | r0:u32 r0v, r5:s32 type, r9:s32 i |  | 223 | 14/0 | -32 | LIKELY-RESISTANT (size) | r9 is loop counter scalar across bl |
| 46 | `BlitFrameCell` | src/engine/sub_080112c0.c | r8, ip, sl, r1, r3, r7, r4 | r8:u32 rows, ip:u32 cols, sl:u32 dstY, r1:struct BgScrollState *state, r3:u16 stride, r7:u16 *vram, r4:struct BgScrollState *loopState |  | 237 | 24/0 | 4 | LIKELY-RESISTANT (size) | struct ptrs in low regs r1/r4 |
| 47 | `DrawTilemapString` | src/engine/sub_0801c078.c | sl, r6, r0 | sl:u16 palBits, r6:u16 *base, r0:u16 *digitDst |  | 409 | 14/0 | -14 | LIKELY-RESISTANT (size) | shares code shape w/ Credits_DrawLine |
| 48 | `Scene15_Main` | src/game/mode_15.c | r0, r3, r1, r0 | r0:u8 *statepInit, r3:u32 nextState, r1:u8 *acceptp, r0:u8 *acceptDst |  | 446 | 15/0 | -12 | LIKELY-RESISTANT (size) | 536 B scene loop |
| 49 | `Credits_DrawLine` | src/engine/sub_0801dbb4.c | sl, r6, r0 | sl:u16 palBits, r6:u16 *base, r0:u16 *digitDst |  | 482 | 23/0 | 8 | LIKELY-RESISTANT (size) | 746 B |
| 50 | `SceneLoop_14` | src/game/sub_08002524.c | r0, r3, r1, r0 | r0:u8 *statepInit, r3:u32 nextState, r1:u8 *acceptp, r0:u8 *acceptDst |  | 483 | 15/0 | -8 | LIKELY-RESISTANT (size) | 572 B scene loop |
| 51 | `Scene13_Update` | src/game/sub_08002184.c | r1, r1, r1, r1, r0 | r1:u8 zero, r1:GameStuff *game, r1:GameStuff *game, r1:u32 localZero, r0:u32 localZero |  | 589 | 18/0 | -8 | LIKELY-RESISTANT (size) | 704 B |
| 52 | `Entity_WalkCompactRecords` | src/engine/sub_08021510.c | r2, r1, r0, r1, r0 | r2:u16 status, r1:u32 shift, r0:s32 caseSlot, r1:u16 caseStatus, r0:u16 tailStatus |  | 612 | 23/0 | 4 | LIKELY-RESISTANT (size) | 708 B walker |
| 53 | `SceneLoop_21` | src/game/sub_08004938.c | r1, r0, r3 | r1:u8 zero, r0:u32 partId, r3:u32 nextState |  | 634 | 21/0 | -8 | LIKELY-RESISTANT (size) | 716 B scene loop |

## Probably resistant — deprioritize

These have either a **documented hard class**, a **`nonARG > 0` structural
delta**, or **large size** (>~120 B byte_diff) that makes permuter convergence
slow and uncertain. Run them only after the tractable tail is exhausted; expect
several to restore-pins + keep `NON_MATCHING`.

**Documented hard class (cite the note on defer):**
- `sub_080210A0` (#36) — `register-pin-cleanup-handoff.md` "Failed probe":
  wholesale pin removal failed; high-register lifetime + stack-arg colouring.
- `Entity_UpdateFrame` (#18) — codegen-notes "Permuter convergence audit":
  11,952 iters, -5.4%, far from 0. Also matches the `sTable[gStruct.field]()`
  repeated-dispatch resistant pattern.

**Has a structural (non-coloring) delta — permuter weak here:**
- `Gate_OnTileStep` (#19, nonARG 3), `BgScroll_TileWipeTransition` (#13,
  nonARG 2), `Entity12_TickStateMachine` (#37, nonARG 2),
  `EntityMover_Tick` (#39, nonARG 1), `GameMode_SceneTick` (#42, nonARG 1).

**Large / many-pin (pure colouring but slow to converge):** every entry
#40–#53, plus the 13-/16-pin blit functions `ScaleAnim_TickFrames`,
`sub_08012BC4`, `BlitEntityTileFrame0/1`, `BlitFrameCell`. These are
`nonARG == 0` (no structural impossibility) so they are *theoretically*
recoverable, but a 200–700 B function with 10+ tangled pins is exactly where
the "Permuter convergence audit" plateaus (`sub_08000918`: 49k iters, -1.5%).

**New-agbcc exception files** (`docs/register-pin-cleanup-handoff.md`): three
of these compile under the non-default `agbcc`, not `old_agbcc` —
`Scroll_UpdateCamera` (#21), `ScaleAnim_TickFrames` (#38). Treat the compiler
as a fixed input; do not flip it to chase a de-pin.

## NAKED struct-high-reg functions — NOT de-pin candidates (separate task)

These functions ship as `NAKED` inline asm with a readable `#ifdef
NON_MATCHING` C body. The high-reg struct-pointer pins live **inside the dead
NON_MATCHING branch**, so removing them changes nothing in the build — they
are not pin-removal candidates. They belong to the `reclaim-naked` / codex
reclamation track (re-derive the C from scratch), not task #14:

`EntityPool_UpdateOwned` (sub_0802c200), `EntityScript_BuildSlotData` /
`Entity_TickCells` / `Entity_ApplyScrollStep` (sub_08006b88), `SaveLoad`
(sub_08017364), `ScaleAnim_SyncSelectors` (sub_0801310c), `ModeChannel_Apply`
(sub_08010958), `FrogStatusBar_Update` (sub_08017000). (Plus a dozen more
NAKED functions with scalar high-reg pins in dead code.)

## Measured vs estimated — coverage

- **Measured: 53 / 53** of the target population. The target population is the
  51 functions `function_status.py --status register-heavy` (≥3 pins, default
  `--pin-threshold 3`) reports, **plus** the 2 struct-high-reg priority
  functions that fall below that threshold
  (`Tilemap_DispatchPendingBlits`, `Blit_ApplyFlaggedRecords`). **Nothing
  was estimated** — every row is a clean-rebuild measurement.
- **Struct-high-reg priority class (typed struct ptr in r8/r9/sl, LIVE):
  5 functions, all measured** — #3, #17, #32, #36, #40.
- An exhaustive `grep -rnE 'register [^;]*asm\("(r[0-9]+|sl|lr|ip)"\)' src/`
  finds **556 pin lines across ~140 files**. The 53 measured here are the
  ones the picker flags as register-heavy (or struct-high-reg). The remaining
  ~90 files each carry 1–2 pins on a single function below the threshold; they
  were **not individually measured** (out of scope for this pass, which
  prioritized the heavy + struct-high-reg classes per the task). A future pass
  can sweep the 1–2-pin long tail the same way — most are expected to be
  redundant or trivially tractable like #1–#11 here.
- The high-reg (r8/r9/sl) pin census (LIVE + DEAD, all 38 functions with any
  high-reg pin) was fully enumerated to separate the 5 LIVE struct-high-reg
  candidates from the ~13 DEAD-in-NON_MATCHING ones (the NAKED list above).

### byte_diff distribution (53 measured)

| bucket | count |
|---|--:|
| 0 (redundant) | 3 |
| 1–30 | 8 |
| 31–80 | 13 |
| 81–160 | 16 |
| >160 | 13 |

A `byte_diff == 0` (3 functions) means the pin is already redundant — drop it
and commit, no permuter. The 1–30 bucket (8) is the next-easiest tier.
**Every measured function has `nonARG == 0` except 6** (the MIXED rows above),
i.e. de-pinning is almost always pure register recolouring — the permuter's
exact domain — so byte_diff magnitude (a size proxy) is the right
budget-allocation knob.

## 2026-09-07 — ScaleAnim_SyncSelectors (src/engine/sub_0801310c.c): 35 pins -> 0, NAKED reclaimed

Re-derived from the asm instead of nudging the pinned reference (which itself
was byte_diff 37 against the ROM). Structure: `do { } while (i <= 7)` u8 loop,
`switch (on)` two-case body, constant state pointer for the loop stores,
struct overlay for the gEntities frame counter, and a no-op
`anim->state = anim->state;` self-store in the loop body to keep the state
address pseudo live across the case-0 compare (reload spill pick r6 vs r4).
Permuter hint (score 120 -> 100 at ~10k iters) supplied the last lever. See
docs/codegen-notes.md "No-op self-store keeps an address pseudo live".

## Session 2026-09-07 — src/game/sub_08006b88.c (de-pin agent)

**Landed:** `aacba802` — `Entity_ApplyScrollStep`: was an auto-peeled asm slice
with a 2-pin (`game` r8, `mask` r9) NON_MATCHING reference; now pure C, 0 pins,
byte match. Structural levers (all source-shape, no flags):
- `gIwram_5330` linker symbol instead of the `gGameStuff` cast: gcse PRE copies
  the guard's base load into r8 for the in-loop stamp store (`mov r8, r2`).
- `entries[i]` indexing (no bumped pointer): loop.c's giv init shares the
  guard's `&entries[first]` via cse2 (`adds r3, r5, #0`).
- The whole `active`/`mask` test is written INSIDE the loop; loop.c hoists the
  35E0 load, the shared `u16 mask = 2` (-> r9) and the u16 and/extend (-> ip)
  into the preheader. The prior note's "mask must be assigned after active"
  rule was an artifact of computing `active` before the loop.
- Hoist ORDER is loop-body insn order: `struct IwramAt35E0 *iw = &gIwram_35E0;`
  declared before `u16 mask = 2;` puts the pool load ahead of `movs #2`, and
  keeping the field read inline (`iw->_field_10 & mask`, one extra loop insn:
  45 vs 44) keeps loop.c's `threshold*savings*lifetime >= insn_count` test
  from hoisting the gEntities pool load on the FIRST loop pass, so it lands
  after the entry-pointer copy (rerun-loop-opt hoists it on pass 2).
- `(s8)dy` at both uses of an `s32 dy = entries[i].deltaY`: combine folds the
  redundant re-extension of the ldrsb into the baserom's `adds r1, r0, #0`
  copy (a plain `s8` local gives ldrb+lsls/asrs because Thumb PROMOTE_MODE is
  unsigned; `s32` alone gives ldrsb with no copy).

**Resistant (pins live only in dead NON_MATCHING bodies; NAKED kept as-is):**

- `EntityScript_BuildSlotData` (11 pins in the reference). Fresh unpinned C
  (for-loop over a `struct { struct SrcRec s; s32 i; }` frame, const-cast
  table base): byte_diff 326/130 diffs; with a `table` pointer local 313/120
  (partId -> ip correct); explicit guard + do-while 303/136; de-pinned prior
  reference 322/169. The frame layout, `mov r5, sp` scratch pointer, ldmia/stmia
  record copy, layout arms and the switch all match. The residual is one
  pseudo: the baserom keeps `partId << 24` in r1 with TWO sets (pre-loop guard
  and mid-loop, before the entry computation) and reuses it at the loop top and
  loop end; agbcc instead PREs the mid/end occurrences (`PRE: redundant insn 32
  (expression 2) in bb 24, reaching reg 173; PRE/HOIST: end of bb 4, copying
  expression 2`) and emits a `adds r2, r1, #0` copy at the loop end, and loop.c
  reports the table constant loads "not desirable" (lifetime 1, insn_count 161)
  where the baserom has them hoisted into r8/r9/sl. Tried: symbol vs const
  base, `s8 id`/`s32 idx` locals, a separate records-column constant, table
  pointer local, for vs guard+do-while. Not tried: permuter (structural score
  dominated by the high-reg pseudo split; not a coloring plateau).
- `Entity_TickCells` (4 pins in the reference). De-pinned reference measured
  LIVE (the `--non-matching` oracle is unusable here: activating NON_MATCHING
  swaps BuildSlotData's NAKED body too and shifts the address): byte_diff
  240/83 — all four pins are REDUNDANT (sl=base, r9=i, r8=recOff, r6=cellReg
  colour correctly unpinned). Residual classes: (a) `cell->counter`
  read/++/re-read idiom — baserom shares one ldrb between `frame.counter =`
  and the increment yet RE-READS after the strb for `& 3` / `-= 4`; our cse
  either re-reads for the increment (volatile frame or two source reads) or
  forwards the stored value (`subs r0, r2, #3`) — every ordering of
  `counter = cell->counter; frame.counter = counter; cell->counter = counter+1`
  tested (C1/C2/C4/C5); only a frame store placed AFTER the strb blocks
  forwarding, and the baserom has it before. (b) `sub = (u8)(frame.counter+8)`
  wants a promoted `u8 sub` (`lsls #24; movs #128; lsls #20; adds; lsrs #24`).
  (c) the gIwram_35E0 field reads precede the rec/cell computation and
  `frame.rowByte` is re-read from the stack for arg1 (volatile-frame shape).
  (b)/(c) are untested source fixes; (a) looks like the cse store-forwarding
  delta of the "third SDK snapshot" note.

## Session 2026-09-07 — src/engine/sub_0800d8a0.c (de-pin agent): 14 pins -> 0

All three functions re-derived from the asm, first-try byte match each,
no permuter, no flags:

- `PadGrid_RandomizeAndSyncEntityCoords` (`79e1067a`, 5 pins -> 0). Every
  pseudo in the baserom sits one register above agbcc's choice and r0 is
  never touched: GenRandomTileMask's return value IS FilterValidBits' `u32`
  argument (the pinned body dropped it and relied on r0 surviving).
  `u32 mask = GenRandomTileMask(); ... return FilterValidBits(mask);` with
  plain `gEntities[30].x = gIwram_35E0._field_8;` stores. Array indexing a
  typed extern already gives the `ldr =gEntities; ldr =0x692; adds` shape.
- `SpawnControl_Dispatch` (`2a93ba46`, 4 pins -> 0). Plain `s8` for-loop
  over `gEntities[i + 3].status |= 8` + `switch (gIwram_6110.spawnMask)`;
  the `adds r5, r4, #0` base copy is gcse PRE sharing the call argument's
  symbol load with the switch block's field read.
- `PadGrid_ScanMaskToCoord` (`b529c302`, 5 pins -> 0). `while ((i <= 24) &
  (found < limit))` — a bitwise `&` of two comparisons (each expands to
  `movs #0 / cmp / b / movs #1`), `s8` counters, and a
  `struct { s16 x, y; } result` in a register so `result.x = -3; result.y
  = -3` emits the and/or halfword-field stores; `result = coord` from the
  stack struct is the `ldr r4, [sp]`.

Lesson: when a de-pinned body colours every pseudo exactly one register
low, look for a value the pinned reference silently dropped (a call result
consumed by a later call is the classic).

## Session 2026-09-07 — src/game/sub_08009ba0.c (de-pin agent): 10 pins -> 0

Both pinned functions re-derived from the asm, no permuter, no flags,
no Makefile change. The TU is now pin-free.

- `Scene_EntityTick` (`f495c5a8`, 4 pins -> 0). The June "resistant /
  pure low-reg coloring" verdict was wrong: plain unpinned C was already
  byte_diff 2 (`ldrb r0` + `lsls r0, r0` where the ROM has `ldrb r2` +
  `lsls r0, r2`), and the ldrb/lsls tie is a COMBINE decision, not an
  allocator one. With the `gGameStuff` address macro (CONST_INT base) combine
  leaves `zero_extend(mem)` and `ashift` as two insns, local-alloc ties them
  (source dies at the shift), one pseudo -> r0. With the base read through
  the linker symbol `gIwram_5330` combine folds the load into the shift
  (`ashift (subreg (mem))`), and the ldrb becomes reload's spill pick (r2).
  Dispatch is the plain `sEntityProcA[game->sceneType]()`. The pointer is
  block-scoped after the lives test so its pool load is not hoisted above the
  branch (function-scoped: byte_diff 30+, one base for both arms).
- `EntityDispatch_RunFrame` (`41430b9f`, 6 pins -> 0). Same lever; two
  block-scoped `game` pointers (first half / second half) — the calls between
  them keep gcse from merging the two symbol loads, so the ROM's two `ldr r4,
  =gGameStuff` come out with one pool word. `procsC` declared before `game`
  orders the r5/r4 loads. The old `p = (GameStuff *)(u32)p->sceneType` reuse
  hack is gone; the `volatile` cast on the `!= 16` read stays (it defeats cse
  across the const `__umodsi3` libcall, unrelated to the pins; a macro read
  there adds a second pool word instead).
- `Player_CheckSpecialTileMatch` had no pins.

Lesson: an "ldrb rX / lsls rY, rX" pair where agbcc gives "ldrb r0 / lsls
r0, r0" is not coloring — check whether combine folded the load into the
shift (`.combine` dump: `ashift (subreg (mem ...))` vs a separate
`zero_extendqisi2_insn`). See docs/codegen-notes.md "CONST_INT base blocks
combine's load-into-shift fold".

## 2026-09-07 — ScaleAnim_TickFrames (src/engine/sub_08013040.c): 12 pins -> 0, old_agbcc

Re-derived from the asm (the pinned form, byte-matched on the newer agbcc, was
not a useful base). Levers, in the order they were found: `u8 useAlt = bank & 1`
(QImode const-1 pseudo: no cse merge, no loop.c hoist, reload reuses r1);
`(d->bank & 0xf0) >> 4` (SImode load pseudo, no r0 spill; +2 loop insns);
`counter = &pool.frameCounter` after `i = 0` (cse copy `mov r8, r1` instead of a
loop.c hoist, loop stays at 53 insns >= the 52 hoist score of the gIwram pair);
`table` pointer local for the descriptor base; `frames` declared before `dst`
(reload spill-retry order -> frames=ip, dst=r9). Per-TU `CC = $(AGBCC_BIN)`
override dropped. See docs/codegen-notes.md "loop.c hoist threshold arithmetic".

## Session 2026-09-07 — src/game/sub_08007138.c (de-pin agent): 8 pins -> 0

- `CollisionTable_ScanForPlayer` (8 pins -> 0, first unpinned attempt
  byte_diff 1, second 0; no permuter, no flags). The June row (#15,
  "PERMUTER-TRACTABLE, sl is a scalar") mis-read the shape: the pinned body
  hand-expanded the r4/r5 halfword-masked struct packing, the `ip = 0` stack
  arg and the sl/r9 mask constants as if they were coloring. They are the
  RTL inline expansion of the sibling `Rect_PointInCenterRectEx` (the 4-arg
  form in src/game/sub_080076a4.c, called with `(player, &entry->rect, 0, 0)`).
  Written as a `static inline` in the TU, integrate.c copies the `0` args
  into pseudos before the inlined null checks (the `mov ip, r1` / `str
  [sp]`), the `struct PackedRect` local lives in r4/r5 as two halfword-masked
  registers, and loop.c hoists the 0xFFFF0000 / 0x0000FFFF constants to
  sl/r9 for free because the packing sits inside the entry loop. The entry's
  first 8 bytes are a `struct CenterRect` (y, x, height, width), not the
  width/x/y/height the pinned struct named. The one residual (`adds r6, r0,
  r1` vs `adds r6, r1, r0`) is the documented index-first cast:
  `(T *)(i * sizeof(T) + (u32)table)` instead of `&table[i]`.

Lesson: when a pinned body reproduces a struct-by-value call site whose
NULL checks precede the packing, it is an inlined helper — find the
out-of-line sibling in the ROM and `static inline` it instead of pinning the
packing registers.

## Session 2026-09-07 — src/engine/sub_080210a0.c (de-pin agent): 8 pins -> 0

- `Entity_InitSlotFromRecord` (8 pins: sl/r6/r8/r9/r5/r2/r0/r1 -> 0, pure C,
  no permuter, no flags). The "documented resistant" verdict (June: 17-pin
  wholesale removal failed; "agbcc emits tighter 132 B code") was a parameter
  TYPE problem: the pinned TU declared the four stack-passed args `u32`, so
  each pseudo kept a `REG_EQUIV [sp]` note and reload re-read it at its use
  (`mov r0, sp; ldrh r0, [r0, #24]`). With the callers' prototype types
  (`u16 flags, u8 kind, u16 field14, u8 field16, u8 matchKey, u8 field17`)
  the SI->QI/HI parm conversion drops the REG_EQUIV note and global alloc
  hoists all four into r6/r8/r9/r5 at entry, exactly the baserom prologue.
  Remaining shape: `u8 state = rec->state;` first, `struct Entity *pool =
  gEntities; entity = &pool[idx];` (pool load before the index math takes r4
  and pushes `rec` to sl), two-variable `initDir = 2; if (dir) initDir = dir`.
  Naive clean C with the right types was byte_diff 135; with the three shape
  levers byte_diff 0 first try. See docs/codegen-notes.md "Narrow (u8/u16)
  stack parameters are register-hoisted".

Lesson: a de-pinned body that loads stack args at their use with
`ldrb`/`ldrh` via `mov rN, sp` where the ROM does `ldr rX, [sp, #N]` at entry
is a parameter-type mismatch, not an allocator limit.

## Session 2026-09-07 — src/game/sub_0800679c.c (de-pin agent): 5 pins -> 0

- `ModeControl_GetFlag` (5 pins r0/r0/r2/r3/r1 + one `asm volatile` barrier
  -> 0, pure C, no permuter, no flags; the June row #33 "LIKELY-RESISTANT
  (size)" was wrong). Re-derived from the asm: plain `switch` with
  `struct IwramAt6110` field reads, `if ((flags64 & (1 << bit)) == 0) goto
  ret_zero; return 1;` for the 64-bit lane (the expander already emits the
  baserom's sign-extended-mask / two-`ands` / `orrs` shape), and a `u32 mask`
  that is set both in selector 3 (`mask = 1; mask <<= bit;`) and in the common
  tail (`mask = 1; r &= mask;`). The only real divergence was regmove folding
  the tail's shift/and back into `r` (so `r` stayed live while the block-local
  `movs #1` took r0); making the constant a two-block global pseudo with
  lower priority than `r` gives r0/r1 with no pin. See docs/codegen-notes.md
  "regmove folds a dying source into a 2-address result".
- `CtrlFlags_ReadBitRange` had no pins. TU is pin-free.

## 2026-09-07 — BlitEntityTileFrame0 (src/engine/sub_08012664.c): 16 pins -> 15, RESISTANT (structure solved, colouring + one cse artefact remain)

Partial reap only: the `srcBase asm("r6")` pin is redundant (clean rebuild
byte_diff 0 without it); every other single pin removal from the pinned body
costs 80–237 bytes. The readable 0-pin re-derivation is kept under
`#ifdef NON_MATCHING` in the TU (byte_diff 147, 64 diffs, structurally
identical). PickEntitySpawnPos in the same TU has no pins (the task brief's
"15 pins across both" was the 16 in this one function).

**Structural findings (pure C, verified by oracle):**
- `x` must be born AFTER `y`: the baserom has `x*3<<16` early and the `>>16`
  late. Only `u32 xw = e->x*3; xw <<= 16; y = (u16)(e->y*3); u32 x = xw >> 16;`
  reproduces it; with `u16 x` combine folds `(ashift (lshiftrt (ashift t 16)
  16) 16)` into a late single lsl (v4: 163 -> v5: 150). `s16` temps collapse
  too (the `(lshiftrt (ashift ..))` pair is placed at the LAST insn).
- Flush tail = if/else setting `flushSrc/flushDst` locals + ONE shared call
  after the join (`bank &= 1; Scroll_FlushTilemapWindow(bank, ...)`); calls in
  both arms let cse fold the arm's `bank & 1` into the test's `bit` (`mov r0,#0`
  in the else arm).
- The two `& 1` tests are `movs r1,#1; adds r0,rB,#0; ands r0,r1` in the
  baserom = a mask pseudo NOT tied to the result. Any block-local `one = 1`
  gets tied by local-alloc (`mov r0,#1; and r0,r0,rB`); the `static inline`
  generic-body form (`u8 flags` param, `if ((flags >> 4) & 1)`) gives the
  baserom's untied shape for the head test (v9) but derails x/y.
- TAIL CONSTANT (the one non-colouring residual): `bank &= 1` puts `(set one2
  1)` in the join block; cse's wider-mode constant lookup (cse.c "See if we have
  a CONST_INT that is already in a register in a wider mode") rewrites the
  later `gIwram_3610 = 1` store as `(subreg:QI one2)`, so `one2` crosses the
  call and lands in r4 (`strb r4`). The baserom re-materialises `movs r0,#1`.
  Tested and REJECTED: volatile store, `u8`/`s32` bank, `% 2`, `(u8)1`, store
  via pointer/inline helper, `asm volatile("" ::: "memory")` (cse ignores it),
  `do{}while(0)` around call/stores/tail (cse2 re-shares), a `frame` variable
  guarding the store (cc0 compare survives: gcse cprop cannot fold cc0 jumps),
  per-TU `-fno-gcse/-fno-rerun-cse-after-loop/-fno-expensive-optimizations/
  -fno-caller-saves/-fno-strength-reduce/-O1/-fno-cse-follow-jumps` (none
  help; several break PickEntitySpawnPos). Only a CODE_LABEL between the call
  and the store (cse ebb boundary) or a hard-reg mask (`asm("r0")`) defeats it.
  Tilemap_BlitTileRows (sub_08012bc4.c) carries the identical `one asm("r0")`
  pin for the same reason — treat as a shared open question, possibly a
  toolchain-snapshot cse difference.
- Reload spill picks explained (reload1.c `order_regs_for_reload` is
  PER-INSN in this gcc, then `finish_spills` makes every reg not holding a
  live pseudo at the insn available, and `allocate_reload_reg` round-robins
  over the function-wide `spill_regs` set in regno order): the baserom's
  ldrsh zero-index `r7` twice, `ldr r0,=0x694`, `mov r8,r2` follow from a
  global spill set {r0,r2,r3,r7}; ours adds r6 (from the `y*stride` mul with y
  in r8) and r1, which shifts every pick.
- Global alloc order (priority = floor_log2(refs)*refs/live_length): ours
  col 1.63 > row 1.33 > src 1.07 > dst 0.85 so col takes r1, src r2, dst r3
  (baserom: src r1, dst r2, col r3 => src, dst allocated BEFORE col). Splitting
  `mirror`/`dst` pseudos (v13) moves dst to r2 but src then takes r3. No
  natural shape found that lowers col below src/dst (refs are fixed by the
  u8 counter shape; loop-depth weighting via do-while macros bumps src/dst
  too little). This is the cascade that also keeps x in r2 instead of r8.
- Permuter from the clean base: 1870 -> 1460 in 51k iters (`s32` temp for
  `x = xw >> 16`, i.e. pseudo-number shuffles), then plateau.

Harness note: `compile_and_view_assembly.py` run back-to-back on rewritten
sources can report a STALE byte_diff (identical values for consecutive
variants); `rm -f src/<tu>.s src/<tu>.o` before each run, and clean-rebuild
before believing a 0.

## Session 2026-09-07 — src/engine/sub_08016824.c (de-pin agent): 9 pins -> 0

- `TileBlit_DrawEntry` (3 pins r2/ip/r3 -> 0, pure C, no permuter, no
  flags). The pinned body carried an `entry` pointer plus hand-written
  `loopBase`/`loopEntry`/`loopStride` copies. The baserom's three preheader
  copies (`mov ip, r5; adds r5, r2; adds r7, r3`) are gcse PRE replacing the
  loops' recomputed `&gTileBlitTable[index]`: spell EVERY record access
  through the symbol (`gTileBlitTable_08306840[index].field`) with no entry
  local and the copies appear by themselves; keeping `entry->x` in the outer
  loop leaves the original pseudo live (byte_diff 125, extra push {r7}/r8).
  The destination sum is `(u16 *)0x0600f800 + colStart + tileRow * 32`:
  fold's split_tree groups the constant with colStart and re-associates to
  `A*2 + (B*64 + C)`; `(u16 *)(C + tileRow*64) + colStart` and
  `colStart*2 + (tileRow*64 + C)` both come out as `B*64 + (A*2 + C)`
  (byte_diff 26).
- `Icon_DmaLoadSprite` (2 pins r1/r0 -> 0) and `Icon_DmaUpdateSprite`
  (4 pins ip/r1/r0/r1 -> 0), pure C. The shared `movs r1, #15; switch;
  adds rN, r1, #0` prologue is a `static inline u8` selector (the same body
  ships out-of-line as sub_08017270): a u8 return makes integrate.c give the
  inlined result its own pseudo and copy it into the u32 `idx`, where a u32
  return expands straight into `idx` (no copy, byte_diff 4/site). Field
  reads are symbol-form `gDmaDescTable[idx].srcPtrTable/.destAddr` (cse
  rewrites them through the live base: `adds r0, r3, #4`, `adds r0, #8`),
  the count read goes through an `entry`/table pointer, `srcTable =
  ...srcPtrTable;` as its own statement puts that load before the DMA3
  pool load, gGameStuff is read as the linker symbol (`gIwram_5330`) so
  PRE emits the `ldr r0; mov ip, r0` copy, and a `table` pointer local
  puts `ldr r7, =table` before `lsls r4, r2, #4` (the last byte_diff 4).
- TU is pin-free; the prototype-less `void TileBlit_DrawEntry();` crutch
  is gone too (combine's nonzero_bits elides the u8 argument extension).

Lesson: three PRE copies at a loop preheader (base/entry/stride into new
registers) mean the loop body re-derives `&sym[i]` from the symbol — write
the accesses through the symbol, do not introduce the pointer the pins were
copying.

## First evidence campaign: hitbox interface checkpoint

The recovered `c9f57c15` comparison-order depin is integrated: RegisterGridPoints
has seven pins, down from eight. Its current wide-argument implementation and
callers now share an explicit header declaration, with low-byte consumption
documented. This does not settle the original parameter types. Simple all-u8
parameter and narrow SpriteGrid callee trials did not match; their outcomes
and the next structural question are recorded in `docs/campaigns/hitbox-01.md`.
The historical tractability labels above are clues, not allocation verdicts.
