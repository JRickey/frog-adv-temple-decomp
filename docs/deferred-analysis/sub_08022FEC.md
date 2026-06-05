# sub_08022FEC — deferred analysis

Engine routine at 0x08022FEC (520 bytes), an entity-scene setup pass. Lives in
`asm/disasm_0x08022fec.s`; destination `src/engine/sub_08022fec.c`. Sibling of
`sub_08022DDC` / `sub_08022BB0` (same `gEntities`/`gIwram_6110` cluster).

Callees (all peeled): sub_08020CDC (entity SFX/hitbox), sub_080210A0 (spawn),
sub_0800696C, sub_08005D10, sub_0800A580, sub_08020FE4.

## Behaviour (fully understood — unchanged from round 1)
- Early exit: `if (gEntities[0].y > 0x198 && gEntities[0].x > 0xF0) return;`
- Loop 1 over `i = 0..1`, entity = `gEntities[i + 0x5B]`, stride 56:
  - `field_1A == 0`: if `(status & 2) == 0 && (status & 0x8000)` →
    `status = (status | 2) & 0x7FFF`.
  - `field_1A == 1`: if `(status & 2) == 0`:
      - if `field_1B == field_1C[0] - 2`: (i==1 → `sub_08020CDC(&gEntities[0x5C], 0x13, 3, 3)`),
        `sub_080210A0(i+0x5D, sLevelLayoutPtrs_311F28[i], 16, 24, 0x211, 12, 3, 3)`,
        `sub_0800696C(&gIwram_6110, i+0x5D)`.
      - recompute entity (from idx=r6); if `(status & 0x8000)`: `field_1A = 0; status |= 2`.
- `sub_08005D10(0x5B, 0x5C);`
- Loop 2 over `i = 0..1`, entity = `gEntities[i + 0x5D]`:
  - `if (status & 8) continue;`  (uses bit8 in r9 to keep loop-2 register pressure HIGH)
  - `field_1A == 0`: if `(status&2)==0 && (status&0x8000)`:
      `gEntities[i+0x5B].status |= 2; gEntities[i+0x5B].field_1A = 1; entity->status |= 8`.
  - `field_1A == 4`: if `(u16)(status&2)==0`:
      - if `x > 0x86`: `field_1A = 0; status |= 2;
        sub_0800A580(&gEntities[0x5D + i], 0, 0, 0);` (the +0x1458 base = slot 0x5D)
        (i==1 → `sub_08020CDC(&gEntities[0x5C], 0x5E, 3, 3)`).
      - recompute entity; if `(status & 0x8000)`: `status = (status | 2) & 0x7FFF`.
- `sub_08020FE4(0x5D, 0x5E); sub_08005D10(0x5D, 0x5E);`

NOTE the loop-2 case dispatch order in the baserom: `cmp #0; beq <case0 fwd>;
cmp #4; bne <continue>; <case4 falls through>`. So **case 4 is the physical
fall-through body and case 0 is the forward-jumped body** — i.e. in C source
the `switch` must list `case 4:` BEFORE `case 0:` (codegen-notes
"Case-number ≠ source-block-order"). This single reordering dropped diff_count
from 211 to 141.

## Round-2 progress (THIS is the new base — DO NOT restart from round 1's 425)
Best clean byte_diff: **405** (diff_count 121, down from round-1 425 / 232).
Instruction COUNT now matches exactly (252 == 252); the residual is pure
register-coloring + a 2-insn local schedule in loop-1 `case 0`.

### Levers that WORKED (keep these — they are real structural wins)
1. **Defeat the loop-1 0x8000 hoist via a reused scratch local.** Round 1's #1
   blocker was gcc/loop.c `move_movables` hoisting `0x8000` into a callee-saved
   reg in the loop pre-header (combine_movables merged the two single-set 0x8000
   loads → combined lifetime 4 > threshold → hoisted, stealing r7 from base).
   FIX: a function-scope `u32 mask;` assigned `mask = 0x8000;` at BOTH 0x8000
   use-sites in loop 1. That makes the pseudo `n_times_set == 2`, so
   `combine_movables` (requires `n_times_set==1`) skips it → no combine → each
   use stays lifetime ~2 < threshold → NOT hoisted → materialised inline as
   `movs #0x80; lsls #8` exactly like the baserom. CONFIRMED via the agbcc loop
   dump (`old_agbcc … -dL`, reads `<file>.i.loop`): with the trick, regno for
   0x8000 no longer appears as `move-insn … moved to N`. DO NOT apply this trick
   to loop 2 — loop 2 already has enough pressure (bit8 r9 continue-check +
   sub_0800A580 idx calc) that it never hoists; forcing the mask local there
   regresses to 424/481.
2. **`switch (field_1A)` instead of `if/else-if`** for BOTH loops. The baserom
   dispatch is `cmp #0; beq; cmp #1; beq; b default` (loop 1) — the canonical
   agbcc sparse-switch lowering, NOT if/else-if (which falls through case 0).
3. **`case 4:` before `case 0:`** in loop-2's switch (see NOTE above).
4. **`register u16 st asm("r1");` cached status in loop-1 case 0.** Pinning
   status to r1 makes the bit2 test compile to the 2-insn `mov r0,r8; ands r0,r1`
   (baserom form) instead of the 3-insn `add r0,r1,#0; mov r3,r8; and r0,r0,r3`
   (the extra status-copy). dropped diff_count 141→124.
5. **`i = 0;` BEFORE `base = …; bit2 = …;`** (split the for-init out) in both
   loops. Baserom materialises `movs r5,#0` (i) FIRST in the pre-header; the
   default `for(i=0;…)` schedules it last. Splitting it fixes the pre-header
   order. 413→405.

### Remaining divergence (isolated to loop-1 `case 0`, ~all of the 405 bytes)
Everything is a CASCADE from two coupled coloring/schedule artifacts in case 0:
- Baserom pre-loads the OR constant `2` EARLY (`movs r3,#2` right after the
  `ldrh r1` status load, kept in r3 until the `status | 2`). agbcc-mine
  materialises it LATE (`mov r0,#0x2` just before the orr). The `2` having a
  long live-range from block-top to the OR is what frees the downstream
  coloring. A `u32 two = 2;` read early did NOT help (agbcc CSE'd it back to a
  late `mov`).
- Baserom keeps 0x8000 in a *named* scratch (r4 in case0, r3 in case1-tail) and
  COPIES it for the AND (`movs r4,#0x80; lsls; adds r0,r4,#0; ands r0,r1` — 4
  insns), whereas agbcc-mine builds it directly in the AND dest (`movs r0,#0x80;
  lsls; ands r0,r1` — 3 insns). i.e. baserom treats 0x8000 as a live value
  copied into r0; mine consumes it. The `mask` local read-once doesn't force the
  copy.
- Net: case 0 in the baserom is ~1 insn LONGER (early-2) and the 0x8000 build is
  ~1 insn LONGER (separate copy); my case 0 lacks both, so every later branch
  offset shifts and the byte compare diverges even though the OPERATIONS agree.

The OR/AND-result register in case 0 also differs (baserom result r0, status r1
dies and is reused for 0x7FFF; with `st asm("r1")` the result reuses r1). The
result reg is downstream of the early-2 / 0x8000-copy choices — fix those first.

### Levers tried that did NOT help (avoid re-trying)
- `entity asm("r2")` pin (global): 407/164 — pins entity right but forces the
  3-insn AND back and exhausts scratch (spills base to r7). A *separate* loop-1
  `entity1 asm("r2")` was 421/161.
- Dropping the bit2 pin (let agbcc hoist `2` to r8 itself): gives the 2-insn AND
  for FREE but colors `entity` to r3 instead of r2 in BOTH loops (a consistent
  off-by-one), and loop-2 then re-hoists 0x8000 (pressure drops). 418/135.
- `(u16)` cast on the loop-1 bit2 test (mimicking loop-2 case4): forces a status
  RELOAD (worse). Flipping AND/OR operand order: no effect (commutative
  canonicalisation). `two = 2` early local: CSE'd away.
- per-TU CFLAGS: `-ffixed-r3` 445, `-fno-gcse -fno-expensive-optimizations` 447,
  `-fno-schedule-insns{,2}` no entity-reg change. `-ffixed-r10` (round 1) spills.
- Mask trick on loop-2 0x8000: 424/481 (regresses).

### Next attempt ideas (ranked)
1. The early-`2`-in-r3 + 0x8000-copy-in-r4 are a register-PRESSURE signature:
   the baserom run had a 5th live value across case 0 that forced both constants
   into named callee/scratch regs with long live-ranges. Mirror loop-2's
   pressure: add a genuinely-live value (e.g. keep `idx`/`slot` live, or a
   second mask) so local-alloc can't fold 0x8000 into the AND dest and must
   schedule the `2` early. Instrument `old_agbcc` local-alloc.c / `reload.c`
   privately (copy to a sandbox prefix, NEVER rebuild the shared symlink) and
   log the coloring decision for the case-0 block.
2. From the 405 base the function is at instruction-count parity; the residual
   is coloring, which is exactly the permuter's domain — BUT 405 is far above
   the ~40 useful range, so reduce case-0 to byte_diff <= ~40 by hand FIRST
   (idea 1), then run the permuter to close the last coloring gap.
3. Try a single multiply-set scratch reused for `2` AND `0x8000` AND `0x7FFF` in
   case 0 (round-1 idea #2, never fully tried with the round-2 switch base) — it
   may reproduce the baserom's r3/r4 "named scratch" allocation.

## Best-effort C (clean, readable; byte_diff 405, diff_count 121)
```c
#include "iwram.h"
#include "types.h"

extern u32 sub_08020CDC(struct Entity *entity, u32 sound, u8 halfW, u8 halfH);
extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern void sub_0800696C(void *p, s32 idx);
extern void sub_08005D10(s32 a0, s32 a1);
extern void sub_0800A580(struct Entity *e, s8 param, s8 deltaX, s8 deltaY);
extern void sub_08020FE4(s32 a0, s32 a1);

extern const u32 sLevelLayoutPtrs_311F28[2];

void sub_08022FEC(void)
{
    u8 i;
    register struct Entity *base asm("r7");
    struct Entity *entity;
    register u32 bit2 asm("r8");
    register u32 bit8 asm("r9");
    u32 mask;
    register u16 st asm("r1");

    if (gEntities[0].y > 0x198 && gEntities[0].x > 0xF0)
        return;

    i = 0;
    base = gEntities;
    bit2 = 2;
    for (; i <= 1; i++) {
        entity = (struct Entity *)((i + 0x5B) * 56 + (s32)base);
        switch (entity->field_1A) {
        case 0:
            st = entity->status;
            if ((bit2 & st) == 0) {
                mask = 0x8000;
                if ((st & mask) != 0)
                    entity->status = (st | 2) & 0x7FFF;
            }
            break;
        case 1:
            if ((bit2 & entity->status) == 0) {
                if (entity->field_1B == entity->field_1C[0] - 2) {
                    u32 slot = i + 0x5D;
                    if (i == 1)
                        sub_08020CDC(&gEntities[0x5C], 0x13, 3, 3);
                    sub_080210A0(slot, (const void *)sLevelLayoutPtrs_311F28[i], 16, 24, 0x211, 12, 3, 3);
                    sub_0800696C(&gIwram_6110, slot);
                }
                entity = (struct Entity *)((i + 0x5B) * 56 + (s32)base);
                mask = 0x8000;
                if ((entity->status & mask) != 0) {
                    entity->field_1A = 0;
                    entity->status |= 2;
                }
            }
            break;
        }
    }

    sub_08005D10(0x5B, 0x5C);

    i = 0;
    base = gEntities;
    bit2 = 2;
    bit8 = 8;
    for (; i <= 1; i++) {
        entity = (struct Entity *)((i + 0x5D) * 56 + (s32)base);
        if ((entity->status & bit8) != 0)
            continue;
        switch (entity->field_1A) {
        case 4:
            if ((u16)(entity->status & bit2) == 0) {
                if (entity->x > 0x86) {
                    entity->field_1A = 0;
                    entity->status |= 2;
                    sub_0800A580((struct Entity *)(i * 56 + 0x1458 + (s32)base), 0, 0, 0);
                    if (i == 1)
                        sub_08020CDC(&gEntities[0x5C], 0x5E, 3, 3);
                }
                entity = (struct Entity *)((i + 0x5D) * 56 + (s32)base);
                if ((entity->status & 0x8000) != 0)
                    entity->status = (entity->status | 2) & 0x7FFF;
            }
            break;
        case 0:
            if ((entity->status & bit2) == 0) {
                if ((entity->status & 0x8000) != 0) {
                    struct Entity *prev = (struct Entity *)((i + 0x5B) * 56 + (s32)base);
                    prev->status |= 2;
                    prev->field_1A = 1;
                    entity->status |= bit8;
                }
            }
            break;
        }
    }

    sub_08020FE4(0x5D, 0x5E);
    sub_08005D10(0x5D, 0x5E);
}
```
