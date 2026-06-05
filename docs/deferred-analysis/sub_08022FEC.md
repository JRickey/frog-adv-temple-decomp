# sub_08022FEC — deferred analysis

Engine routine at 0x08022FEC (520 bytes), an entity-scene setup pass. Lives in
`asm/disasm_0x08022fec.s`; destination `src/engine/sub_08022fec.c`. Sibling of
`sub_08022DDC` / `sub_08022BB0` (same `gEntities`/`gIwram_6110` cluster).

Callees (all peeled): sub_08020CDC (entity SFX/hitbox), sub_080210A0 (spawn),
sub_0800696C, sub_08005D10, sub_0800A580, sub_08020FE4.

## Behaviour (fully understood — confirmed against the asm slice, byte-exact)
- Early exit: `if (gEntities[0].y > 0x198 && gEntities[0].x > 0xF0) return;`
  (both x/y via `ldrsh`, signed).
- Loop 1 over `i = 0..1`, entity = `gEntities[i + 0x5B]`, stride 56:
  - `field_1A == 0`: if `(status & 2) == 0 && (status & 0x8000)` →
    `status = (status | 2) & 0x7FFF`.
  - `field_1A == 1`: if `(status & 2) == 0`:
      - if `field_1B == field_1C[0] - 2`: (i==1 → `sub_08020CDC(&gEntities[0x5C], 0x13, 3, 3)`),
        `sub_080210A0(i+0x5D, sLevelLayoutPtrs_311F28[i], 16, 24, 0x211, 12, 3, 3)`,
        `sub_0800696C(&gIwram_6110, i+0x5D)`. NOTE physical order: i==1/CDC FIRST,
        THEN `slot = i+0x5D` materialised (target computes `&gEntities[0x5C]` as
        `base + (0xa1<<5)` = base+0x1420, NOT a pool load).
      - recompute entity (from saved idx in r6); if `(status & 0x8000)`:
        `field_1A = 0; status |= 2`.
- `sub_08005D10(0x5B, 0x5C);`
- Loop 2 over `i = 0..1`, entity = `gEntities[i + 0x5D]`:
  - `if (status & 8) continue;`  (continue-check uses LITERAL 8; bit8 kept in r9
    only for the case-0 `entity->status |= 8` write).
  - `field_1A == 0`: if `(status&2)==0 && (status&0x8000)`:
      `gEntities[i+0x5B].status |= 2; gEntities[i+0x5B].field_1A = 1; entity->status |= 8`.
  - `field_1A == 4`: if `(u16)(status&2)==0`:
      - if `x > 0x86`: `field_1A = 0; status |= 2`(target holds the 2 in ip/r12 here);
        `sub_0800A580(&gEntities[0x5D + i], 0, 0, 0);` (the +0x1458 base = slot 0x5D)
        (i==1 → `sub_08020CDC(&gEntities[0x5C], 0x5E, 3, 3)`).
      - recompute entity; if `(status & 0x8000)`: `status = (status | 2) & 0x7FFF`.
- `sub_08020FE4(0x5D, 0x5E); sub_08005D10(0x5D, 0x5E);`

Loop-2 case dispatch is `cmp #0; beq <case0 fwd>; cmp #4; bne <continue>;
<case4 falls through>`, so in C source **`case 4` must precede `case 0`** in
loop-2's switch (codegen-notes "Case-number != source-block-order").

## Round-3 progress (THIS is the new base — byte_diff 383, down from r2's 405)
diff_count 115 (from 121). Instruction COUNT matches exactly (252==252). The
residual is PURE register-coloring + 2-3 hoists, isolated and mutually
ANTAGONISTIC across the two loops (every source-level fix that improves loop 1
coloring regresses loop 2 and vice-versa — this is the sharp local-minimum case
CLAUDE.md describes; it wants the permuter, which is NOT installed in the
worktree, or codex).

### Levers that WORKED in round 3 (cumulative, all PURE-C register pins; 405->383)
1. `register u32 two asm("r3")` assigned `two = 2;` AFTER `st = entity->status;`
   in loop-1 case 0. Produces the baserom's early `movs r3,#2` right after the
   status load. (A plain `u32 two=2` local is CSE'd/propagated back to an inline
   `movs r0,#2` — the PIN is required.) 405->394.
2. `register u32 mask asm("r4")` for the 0x8000 mask. Forces the 2-insn 0x8000
   to be built in r4 then COPIED to the AND dest (`movs r4,#0x80; lsls r4,#8;
   adds r0,r4,#0; ands r0,r1`) like the baserom, instead of building inline in
   r0. 394->387.
3. **`st` must be `u32` (not u16) AND `register ... asm("r1")`.** With `u16 st`
   the `(st|two)` OR zero-extends st (`lsls #16; lsrs #16`) — wrong. With
   `register u32 st asm("r1")` the loop-1-case-0 OR becomes EXACTLY the baserom
   `adds r0,r3,#0; orrs r0,r1` (result in r0, st stays in r1). 387->383.
4. `register u32 acc asm("r0")` + write the case-0 store as STAGED statements
   `acc = two; acc |= st; acc &= 0x7FFF; entity->status = acc;` — keeps the
   running result in r0. 387->383 (vs 387 with the fused `(st|two)&0x7FFF`).
5. loop-1 case-1 tail: `entity->status |= bit2;` (bit2/r8) instead of `|= 2`
   reproduces the baserom `mov r0,r8; orrs r0,...`.

### Remaining divergence (the hard, antagonistic part) — ranked by impact
A. **Loop-2 hoists 0x8000 (and the literal 2) into the loop pre-header and the
   0x8000 invariant gets r7, COLLIDING with `base asm("r7")`** (you can see
   `movs r2,#0x80; lsls; adds r7,r2,#0` then `movs r6,#2` in the loop-2
   pre-header). loop.c `combine_movables`+`move_movables` see the two loop-2
   0x8000 uses (case-4-tail + case-0) as one combinable invariant. The baserom
   materialises each 0x8000 per-use (case-4-tail r4, case-0 r1) and the two `2`
   writes as DIFFERENT pseudos (case-4 holds 2 in ip/r12, case-0 uses a literal
   in r4), so they never combine -> never hoisted.
   - The mask-local n_times_set=2 trick (worked for loop 1) DEFEATS the hoist
     in loop 2 (confirmed: the r7 clobber disappears) BUT the extra `mask=0x8000`
     stores cost more than the hoist saved -> regresses 383->406. Same for a
     second `mask2` local (428) and `(0x4000<<1)` (CSE-folded, no change).
   - `-Os` would disable move_movables entirely (`if (! optimize_size)
     move_movables` in loop.c:1153) but is wrong for this title.
   - NEXT IDEA (untried): make the two loop-2 `|= 2` sites distinct pseudos like
     the baserom — case-4 `status |= 2` via a pinned r12/ip value, case-0
     `prev->status |= 2` via a literal — AND make the two 0x8000 sites distinct
     so combine_movables can't merge them, WITHOUT adding a store (e.g. a pinned
     high-reg for one, literal for the other). The goal: zero loop-2 hoists with
     zero extra stores.
B. **The RECOMPUTED entity pointer lands in r2 (mine) vs r1 (baserom)** in
   loop-1 case-1 tail and throughout loop 2 — a pervasive cascade. The baserom
   saves `i+0x5B` / `i+0x5D` in r6 at the FIRST entity compute and reuses it; an
   explicit `idx = i+0x5B` reused at both computes REGRESSED (399) because it
   perturbs case-0 coloring. The `st asm("r1")` pin also reserves r1
   function-wide, pushing the case-1 `0xa1<<5` into r4 instead of the baserom's
   r1. A single `entity` pin can't satisfy both (first=r2, recompute=r1).
C. The 0x8000-test copy DIRECTION: mine `adds r0,r1,#0; ands r0,r4` (copies st),
   baserom `adds r0,r4,#0; ands r0,r1` (copies mask). Flipping to `(mask & st)`
   makes it in-place `ands r4,r1` (worse, 409). Staging `acc=mask; acc&=st`
   builds 0x8000 in r0 directly (worse, 411).

### Levers tried that did NOT help (avoid re-trying)
- base un-pinned (let agbcc choose r7): 437. (r7 pin IS needed.)
- loop-2 continue-check via `bit8` var vs literal 8 + swapped pre-header order
  (bit8 first): 443.
- mask-local trick on loop 2 (single shared, or separate mask2): 406-428.
- explicit `idx = i+0x5B` reused in loop 1: 399.
- `base[0x5C]` + slot-reorder in case-1 spawn (STRUCTURALLY correct — gives the
  baserom's `movs rN,#0xa1; lsls #5; adds r0,r7,rN` instead of a pool load) but
  the freed register is r4 not r1 (st pin), so net 392. Worth re-trying once the
  r1/r2 entity coloring (B) is solved — the structure is right.
- `(u16) st`, `(mask & st)` flip, `0x4000<<1`, `two` reused in loop 2 (it's only
  in scope in loop-1 case 0 — uninitialised in loop 2).

### Next attempt ideas (ranked)
1. Solve B (entity recompute -> r1) — it is the largest cascade. Read agbcc
   `local-alloc.c`/`reload.c` for WHY the recompute pseudo gets r2 not r1.
   Likely the `st asm("r1")` function-wide reservation is the culprit; try a
   per-loop scope for st (e.g. compute case 0's status into a block-local pinned
   to r1 only inside case 0) so r1 is free in case 1 / loop 2 for the entity ptr.
2. Solve A (zero loop-2 hoists, zero extra stores) per the NEXT IDEA above.
3. Re-apply the `base[0x5C]` + slot-reorder spawn fix once B frees r1.
4. From byte_diff <= ~40 (after 1-3), run decomp-permuter (set it up first —
   `scripts/setup-permuter.sh`; it is NOT installed in fresh worktrees) for the
   final coloring; it mutates exactly the statement-order/var-scope this needs.

## Best-effort C (clean, readable; byte_diff 383, diff_count 115)
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
    register u32 mask asm("r4");
    register u32 two asm("r3");
    register u32 acc asm("r0");
    register u32 st asm("r1");

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
            two = 2;
            if ((bit2 & st) == 0) {
                mask = 0x8000;
                if ((st & mask) != 0) {
                    acc = two;
                    acc |= st;
                    acc &= 0x7FFF;
                    entity->status = acc;
                }
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
                    entity->status |= bit2;
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
