# sub_08022FEC — deferred analysis

Engine routine at 0x08022FEC (520 bytes), a two-phase entity-scene setup pass in
`asm/disasm_0x08022fec.s`; destination `src/engine/sub_08022fec.c`.

Classifier verdict: `ATTEMPT_MATCH`. The only advisory is high registers
`r8/r9` held across calls; this is NOT a NAKED-eligible class. All callees are
peeled. This IS matchable in pure C — it is a sharp register-coloring local
minimum, not a structural wall.

## Drift

**Best result this round: `byte_diff 285`, `diff_count 82`, built size 508.**
(Prior round plateaued at `byte_diff 317`.) Loop 2 and the function tail are
BYTE-IDENTICAL — every remaining diff is in loop 1 (offsets 0x0a..0xd4). The
control-flow / semantic model is fully solved; only loop-1 register coloring
diverges.

### What is fully solved (do not re-derive)
- The whole control-flow shape, all callee args, all struct offsets, both loops.
- **The `i`/saved-slot r5/r6 assignment** (was the dominant prior-round drift):
  fixed by declaring `register u8 slot asm("r6") = i + 0x5B;` and using `slot`
  ONLY in the case-1 re-fetch (NOT the loop-top entity compute, which stays a
  fresh `(i + 0x5B) * 56` temp). This reproduces the target's `adds r1,r5,#0;
  adds r1,#0x5b; ... adds r6,r1,#0` (compute-in-temp, save-to-r6) with NO `(u8)`
  truncation. Pinning `i` itself, or making `slot` wider than `u8`, or using
  `slot` for the loop-top compute, all REGRESS (truncation or 442+).
- Loop 2 (slot pinned implicitly via natural alloc) matches with zero pins.

### The two coupled residuals (loop 1 only)
1. **`0x8000` is hoisted into r9** (a callee-saved reg) and reused at both loop-1
   uses, instead of the target's per-use `movs r4,#0x80; lsls #8` re-materialize.
   ROOT CAUSE confirmed via `-da` loop dump: `combine_movables` (loop.c ~line
   1454) unifies the case-0 and case-1-tail `0x8000` HImode movables (each
   `n_times_set==1`, equal const) into one; the combined lifetime then crosses
   `move_movables`' threshold `(threshold*savings*lifetime) >= insn_count` and it
   is hoisted to the loop preheader. The target does NOT combine them (each stays
   a "not desirable" solo movable, life 2, savings 2). loop.c on OUR source ALSO
   marks each solo as "not desirable" — the hoist appears ONLY after the combine.
   - DEFEATING the combine works (`u32 st = entity->status; if (st & 0x8000)…`
     forces SImode and breaks the HImode-pair combine → per-use materialize, pool
     realigns toward 520) BUT the extra `st` register copy costs more than the
     hoist saves → net `byte_diff 316` (worse than 285). `(u32)status` cast alone
     is optimized back to HImode (no effect). Operand-order flip (`0x8000 &
     status`) is canonicalized away (no effect).
2. **case-0 OR-seed order**: target emits `adds r0,r3(=2),#0; orrs r0,r1(status)`
   (the fresh `2` is the carrier); ours emits `adds r0,r1(status),#0; orrs
   r0,r3(=2)` because agbcc canonicalizes `2 | status` to put the constant
   second. A staged write (`u32 t = 2; t |= entity->status; entity->status = t &
   0x7FFF;`) DOES fix the seed (`adds r0,r3,#0; orrs r0,r1`) BUT perturbs the rest
   of loop-1 coloring (`0x7fff` moves r3→r4, cascade) → `byte_diff 430`. Applying
   it to loop 2 BREAKS loop 2's match. So it must be applied to loop-1-case-0
   ONLY and reconciled with the rest — not achieved this round.

These two are COUPLED: each individual fix perturbs the global loop-1 allocation,
so no single source edit lowers the total below 285. This is the textbook
"sharp register-coloring local minimum" the agent guide describes.

### Levers tried and ruled out (don't repeat)
- All of: `-fno-gcse`, `-fno-rerun-cse-after-loop`, `-fno-rerun-loop-opt`,
  `-fno-strength-reduce`, `-fno-cse-skip-blocks`, `-fno-cse-follow-jumps`,
  `-ffixed-r9`, `-fno-loop-optimize`, `-fno-caller-saves`, `-fomit-frame-pointer`
  — none beat 285 on the clean-slot-pin source (most are no-ops; `-fno-gcse`
  breaks loop-2's `8`→r9 hoist that the target WANTS).
- Whole-function pins for `bit2 asm("r8")`/`bit8 asm("r9")`: 416–489 (worse —
  they force the bad alloc).
- Array indexing `&base[i+0x5B]`: adds a `0x5B*0x38` pool literal (target uses
  `(i+0x5B)*56` direct) → 366, worse structure.
- The OLD_AGBCC vs AGBCC swap: OLD_AGBCC (the default) is correct; AGBCC is worse.

### Recommended next work
- **Permuter from the 285 base** — this is now well within range (`byte_diff <=
  ~40`-tier reasoning does not apply; the residual is pure statement-ordering /
  scope coloring the permuter is built for). NOTE: the permuter was UNAVAILABLE
  this run (`vendor/decomp-permuter` is a self-referential broken symlink in BOTH
  main and the worktree — `.venv` resolves to "Too many levels of symbolic
  links"). FIX THE SUBMODULE/symlink first, then permute the "## Best-effort C"
  below.
- If hand-finishing: the goal is to make loop-1-case-0's `0x8000` re-materialize
  per-use AND its OR seed be the fresh `2`, WITHOUT perturbing the slot/`0x7fff`
  coloring. Likely needs a `register u32 two asm("r3")` + a `register`-pinned
  `0x8000` carrier, reconciled by reading `local-alloc.c`/`global.c` coloring
  priority (instrument the hard-reg pick for the case-0 block).

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
