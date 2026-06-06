# sub_08022FEC — deferred analysis

Engine routine at 0x08022FEC (520 bytes), a two-phase entity-scene setup pass in
`asm/disasm_0x08022fec.s`; destination `src/engine/sub_08022fec.c`.

Classifier verdict: `ATTEMPT_MATCH`. The only advisory is high registers
`r8/r9` held across calls; this is NOT a NAKED-eligible class. All callees are
peeled. This IS matchable in pure C — it is a sharp register-coloring local
minimum, not a structural wall.

## Drift

**Best result (two rounds running): `byte_diff 285`, `diff_count 82`, built size 508.**
Loop 2 and the function tail are BYTE-IDENTICAL — every remaining diff is in loop 1
(offsets 0x0a..0xd4). The control-flow / semantic model is fully solved; only loop-1
register coloring + the case-0 OR-seed operand order diverge.

### What is fully solved (do not re-derive)
- The whole control-flow shape, all callee args, all struct offsets, both loops.
- **The `i`/saved-slot r5/r6 assignment**: `register u8 slot asm("r6") = i + 0x5B;`
  used ONLY in the case-1 re-fetch (NOT the loop-top entity compute, which stays a
  fresh `(i + 0x5B) * 56` temp). Reproduces target's compute-in-temp / save-to-r6
  split. Pinning `i`, widening `slot`, or using `slot` in the loop-top compute all
  REGRESS (verified again this round: s32 slot → 404, no-pin single-slot → 370/406).
- Loop 2 + tail match with zero pins.

### ROOT CAUSE re-confirmed at the agbcc-source level (loop dump `-dL`)
The two `entity->status & 0x8000` HImode tests (case-0 at asm 0x54, case-1-tail at
0xd2) are EACH a `reg <- const_int 32768` movable with `n_times_set==1`, equal const.
`combine_movables` (loop.c ~1456) unifies them (identical RTL `set_src`, both HImode).
The combined movable (savings 2, lifetime 2+2=4) then crosses `move_movables`' hoist
test `threshold*savings*lifetime >= insn_count` (loop.c ~1835; `threshold =
(loop_has_call?1:2)*(1+n_non_fixed_regs)`, loop-1 HAS calls). → `0x8000` is hoisted to
a callee-saved reg (r9) and reused at both sites. The TARGET does NOT combine: each
`0x8000` stays a SOLO "not desirable" movable (savings 1, lifetime 2) → re-materialized
per use (`movs r4,#0x80; lsls #8` in case-0; `movs r3,#0x80; lsls #8` in case-1-tail,
different regs). The `2` mask (used 3x) DOES combine into one movable → hoisted to r8 —
the target wants this. So loop 1 must keep `2` hoisted AND `0x8000` un-combined.

### The TWO coupled residuals (loop 1 only)
1. **`0x8000` combine+hoist** (dominant; accounts for the size delta).
2. **case-0 OR-seed operand order**: target `adds r0,r3(=2); orrs r0,r1(status)`
   (the fresh `2` is the carrier); agbcc canonicalizes `status|2` → status carrier
   (`add r0,r1; orr r0,r3`). gcc-2.9 normalizes commutative operand order regardless
   of source order (`2 | status` ≡ `status | 2`, verified no-op).

### Levers tried this round — ALL three hoist-defeats WORK but cost > savings
The hoist CAN be defeated three independent ways (each verified via `-dL` preheader
dump showing no `0x8000` hoisted), but each perturbs the coupled coloring so total
byte_diff RISES above 285:
- **SImode break on case-1-tail ONLY** (`u32 st = entity->status; if (st & 0x8000)`):
  the FIRST movable (case-0) stays HImode, the SECOND (case-1-tail) is SImode, so
  `combine_movables`' `BITSIZE(m) >= BITSIZE(m1)` gate (16>=32 = false) FAILS → no
  combine → no hoist, AND case-0 re-materializes 0x8000 per-use exactly like target.
  BUT the `st` SImode load costs a register copy → **byte_diff 316** (was the closest
  hoist-defeated variant). (Forcing case-0 SImode instead = wrong direction, combine
  still succeeds. `(u32)status` cast alone is folded back to HImode = no-op.)
- **s32 slot + SImode st**: ALSO removes the `(u8)` truncation in the re-fetch
  (`lsl r6,#24; lsr r6,#24` → clean `lsl r0,r6,#3`), giving the CLEANEST loop-1
  STRUCTURE (case-0 0x8000 ✓, re-fetch ✓, no trunc ✓; only 4 small diffs remain) but
  **byte_diff 404** — almost all of it is BRANCH-OFFSET CASCADE from the 16-byte size
  delta, diff_count only 86. This is the most promising base for the permuter.
- **Pinned 0x8000 carriers** (`register u16 hi asm("r4")=0x8000` in case-0,
  `asm("r3")` in case-1-tail): defeats the hoist (pinned reg is not a movable) but
  the pins clobber slot/OR regs → **byte_diff 416**.
- **Staged OR seed** (`u32 t=2; t|=status; status=t&0x7fff`) applied to case-0 ONLY:
  FIXES the carrier flip (`add r0,r3(2); orr r0,r1` ✓) BUT INVERTS the hoist
  (now `0x8000`→r8 hoisted, `2` fresh) and moves `0x7fff` r3→r4 → **byte_diff 430**.
- **Combinations** (SImode + staged seed; s32 + SImode + staged seed): 451–459 (the
  fixes perturb each other, never reconcile).
- **Flags**: `-ffixed-r9/-r4/-sl/-ip`, `-fno-force-mem`, `-fcaller-saves`,
  `-fno-thread-jumps` — none defeat the hoist (agbcc just hoists to another reg;
  lowering `n_non_fixed_regs` via fixing high regs doesn't flip the threshold).
  OLD_AGBCC (default, correct) rejects `-fschedule-insns*` (no scheduler).
- **mask-local reuse** to disqualify the movable (`u32 mask=0x8000`): 454 (each gets
  its own movable, re-combines/hoists differently).
- **Recompute re-fetch fresh** (no slot save): 370 (agbcc CSEs, structure diverges).

### Why 285 is the floor without the permuter
The two residuals are COUPLED through agbcc's single loop-invariant hoist slot and the
commutative OR canonicalizer: every source edit that fixes one inverts/perturbs the
other (the hoist of `2` vs `0x8000`, and `0x7fff` register coloring, all move
together). No SINGLE source shape lowers the total below 285. This is exactly the
"sharp register-coloring local minimum" the agent guide describes.

### Recommended next work — PERMUTER (was UNAVAILABLE both rounds)
This is squarely a permuter problem (statement-ordering / variable-scope coloring the
permuter is built for). **The permuter is BROKEN in BOTH main and worktrees:**
`vendor/decomp-permuter` is a SELF-REFERENTIAL symlink
(`-> /Users/.../vendor/decomp-permuter`, i.e. it points at its own path), the git
submodule is UNINITIALIZED, and there is NO real checkout anywhere on disk — so
`.venv/permuter.py` resolves to "Too many levels of symbolic links". A worktree cannot
fix this safely (cloning into main's `vendor/` races the shared run). **FIX FIRST:**
de-init the bad symlink and `git submodule update --init vendor/decomp-permuter` (or
clone simonlindholm/decomp-permuter) in MAIN, run `scripts/setup-permuter.sh` to build
the .venv, THEN regenerate the permuter target (`make_permuter_target.py` — there was a
$t/$d bug; regen target.o before trusting scores) and permute from the **s32-slot +
SImode-st base (byte_diff 404, diff_count 86, structurally cleanest)** — NOT the 285
base. The 404 base has only 4 real diffs (preheader order, slot-save schedule
position, OR-seed carrier, case-1-tail status/0x8000 order); the rest is offset
cascade the permuter resolves once it matches the missing instructions. Bounded ~2000
iters, `--stop-on-zero --better-only`, process-group kill per docs/permuter-howto.md.

If hand-finishing without the permuter: the unsolved scheduling diff is the slot-save
`add r6,r1,#0` position — target emits it AFTER the `ldrb field_1A` load (asm 0x38),
agbcc emits it at the declaration (early). OLD_AGBCC has no instruction scheduler, so
this is RTL/reload insn-emission order — read `local-alloc.c`/`reload.c` to learn where
the live-range-split copy is inserted, then shape the C so the copy is "born" after the
load.

## Best-effort C (byte_diff 285, diff_count 82; loop 2 + tail byte-identical)

```c
#include "iwram.h"
#include "types.h"

extern void sub_08020CDC(struct Entity *entity, u8 sound, u8 a, u8 b);
extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern void sub_0800696C(void *p, s32 slot);
extern void sub_08005D10(s32 a0, s32 a1);
extern void sub_0800A580(void *m, u8 sel, u8 a, u8 b);
extern void sub_08020FE4(s32 a0, s32 a1);

extern const u32 sLevelLayoutPtrs_311F28[2];

void sub_08022FEC(void)
{
    struct Entity *base;
    struct Entity *entity;
    u8 i;

    if (gEntities[0].y > 0x198 && gEntities[0].x > 0xF0)
        return;

    base = gEntities;
    i = 0;
    do {
        /* slot pinned to r6 and used ONLY in the case-1 re-fetch: reproduces the
         * target's compute-in-temp / save-to-r6 split with no (u8) truncation. */
        register u8 slot asm("r6") = i + 0x5B;

        entity = (struct Entity *)((i + 0x5B) * 56 + (s32)base);
        switch (entity->field_1A) {
        case 0:
            if ((entity->status & 2) == 0) {
                if ((entity->status & 0x8000) != 0)
                    entity->status = (entity->status | 2) & 0x7FFF;
            }
            break;
        case 1:
            if ((entity->status & 2) == 0) {
                if (entity->field_1B == entity->field_1C[0] - 2) {
                    if (i == 1)
                        sub_08020CDC((struct Entity *)((s32)base + 0x5C * 56), 0x13, 3, 3);
                    sub_080210A0(i + 0x5D, (const void *)sLevelLayoutPtrs_311F28[i], 16, 24, 0x211, 12, 3, 3);
                    sub_0800696C(&gIwram_6110, i + 0x5D);
                }
                entity = (struct Entity *)(slot * 56 + (s32)base);
                if ((entity->status & 0x8000) != 0) {
                    entity->field_1A = 0;
                    entity->status |= 2;
                }
            }
            break;
        }
        i++;
    } while (i <= 1);

    sub_08005D10(0x5B, 0x5C);

    base = gEntities;
    i = 0;
    do {
        entity = (struct Entity *)((i + 0x5D) * 56 + (s32)base);
        if ((entity->status & 8) == 0) {
            switch (entity->field_1A) {
            case 4:
                if ((u16)(entity->status & 2) == 0) {
                    if (entity->x > 0x86) {
                        entity->field_1A = 0;
                        entity->status |= 2;
                        sub_0800A580((void *)((i + 0x5D) * 56 + (s32)base), 0, 0, 0);
                        if (i == 1)
                            sub_08020CDC((struct Entity *)((s32)base + 0x5C * 56), 0x5E, 3, 3);
                    }
                    entity = (struct Entity *)((i + 0x5D) * 56 + (s32)base);
                    if ((entity->status & 0x8000) != 0)
                        entity->status = (entity->status | 2) & 0x7FFF;
                }
                break;
            case 0:
                if ((entity->status & 2) == 0) {
                    if ((entity->status & 0x8000) != 0) {
                        struct Entity *prev = (struct Entity *)((i + 0x5B) * 56 + (s32)base);
                        prev->status |= 2;
                        prev->field_1A = 1;
                        entity->status |= 8;
                    }
                }
                break;
            }
        }
        i++;
    } while (i <= 1);

    sub_08020FE4(0x5D, 0x5E);
    sub_08005D10(0x5D, 0x5E);
}
```

## Alternate base for the permuter (byte_diff 404, diff_count 86 — STRUCTURALLY CLEANEST)
Same as above but with two changes that DEFEAT the 0x8000 hoist + remove the (u8)
truncation (only 4 real diffs remain; the rest is offset cascade):
- `register s32 slot asm("r6") = i + 0x5B;` (s32, not u8 — kills the re-fetch `(u8)`
  truncation; re-fetch stays `slot * 56`, loop-top stays fresh `(i+0x5B)*56`).
- case-1-tail wrapped: `{ u32 st = entity->status; if ((st & 0x8000) != 0) {
  entity->field_1A = 0; entity->status |= 2; } }` (SImode `st` breaks the
  combine_movables HImode-pair → no hoist; case-0 then re-materializes 0x8000 per-use).
