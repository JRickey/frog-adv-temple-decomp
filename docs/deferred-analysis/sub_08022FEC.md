# sub_08022FEC — deferred analysis

Engine routine at 0x08022FEC (520 bytes), an entity-scene setup pass. Lives in
`asm/disasm_0x08022fec.s`; destination `src/engine/sub_08022fec.c`. Sibling of
`sub_08022DDC` / `sub_08022BB0` (same `gEntities`/`gIwram_6110` cluster).

Callees (all peeled): sub_08020CDC (entity SFX/hitbox), sub_080210A0 (spawn),
sub_0800696C, sub_08005D10, sub_0800A580, sub_08020FE4.

## Behaviour (fully understood)
- Early exit: `if (gEntities[0].y > 0x198 && gEntities[0].x > 0xF0) return;`
- Loop 1 over `i = 0..1`, entity = `gEntities[i + 0x5B]`, stride 56:
  - `field_1A == 0`: if `(status & 2) == 0 && (status & 0x8000)` →
    `status = (status | 2) & 0x7FFF`.
  - `field_1A == 1`: if `(status & 2) == 0`:
      - if `field_1B == field_1C[0] - 2`: (i==1 → `sub_08020CDC(&gEntities[0x5C], 0x13, 3, 3)`),
        `sub_080210A0(i+0x5D, sLevelLayoutPtrs_311F28[i], 16, 24, 0x211, 12, 3, 3)`,
        `sub_0800696C(&gIwram_6110, i+0x5D)`.
      - recompute entity (`gEntities[i+0x5B]`); if `(status & 0x8000)`:
        `field_1A = 0; status |= 2`.
- `sub_08005D10(0x5B, 0x5C)`.
- Loop 2 over `i = 0..1`, entity = `gEntities[i + 0x5D]`:
  - `if (status & 8) continue;`
  - `field_1A == 0`: if `(status&2)==0 && (status&0x8000)`:
      `gEntities[i+0x5B].status |= 2; gEntities[i+0x5B].field_1A = 1; entity->status |= 8`.
  - `field_1A == 4`: if `(status&2)==0`:
      - if `x > 0x86`: `field_1A = 0; status |= 2;
        sub_0800A580(&gEntities[0x5D + i], 0, 0, 0);` (the +0x1458 base = slot 0x5D)
        (i==1 → `sub_08020CDC(&gEntities[0x5C], 0x5E, 3, 3)`).
      - recompute entity; if `(status & 0x8000)`: `status = (status | 2) & 0x7FFF`.
- `sub_08020FE4(0x5D, 0x5E); sub_08005D10(0x5D, 0x5E);`

## Drift
Best clean byte_diff: **425** (diff_count 232 of ~239 — but cascading: a single
extra hoisted-constant insn pair shifts every later offset, so the *operations*
agree). Confirmed by register-agnostic mnemonic diff: **loop 2 and the entire
epilogue match instruction-for-instruction**; the divergence is isolated to
**loop 1**.

Root cause: in loop 1 agbcc's loop-invariant code motion (gcc/loop.c
`move_movables`) **hoists the `0x8000` status mask** into a callee-saved register
(`movs r3,#0x80; lsls r3,#8; adds r7,r3,#0`) in the loop pre-header, then uses
`ands r0,r7`. The baserom does NOT hoist it — it re-materialises `0x8000`
inline at each use, into whatever scratch reg is free (r4 in case0, r3 in
case1-tail). The hoist also steals r7 from `base`, so my prologue/`base` handling
drifts. Loop 2 does NOT hoist (it has higher register pressure: bit8=r9, the
`continue` early-out, the `sub_0800A580` index calc, the `prev` pointer) so the
mask stays scratch there — which is exactly why loop 2 matches.

The baserom register file in loop1: r5=i, r6=idx(i+0x5B), r7=base, r8=2 (mask,
genuinely high-reg-hoisted), r4=pure scratch (reused for 0x8000 AND slot AND
status — so 0x8000 is never a single-set movable → never hoisted).

## Levers tried (none defeat the loop-1 0x8000 hoist)
- Structure: nested-if vs `&&` (nested is closer); `(s16)status < 0` sign-test
  (changes the mask insn, wrong — baserom uses explicit mask); array-index
  `base[idx]` vs `(struct Entity*)(idx*56+(s32)base)`; explicit `idx`/`slot`
  locals to raise pressure; caching `u16 st = status`.
- Pins: `base asm("r7")` (fixes the prologue to the exact 2-high-reg form
  `mov r7,r9; mov r6,r8; push {r6,r7}` but 0x8000 then overrides r7); `bit2
  asm("r8")`, `bit8 asm("r9")` (these two ARE the genuine baserom high-reg
  hoists and are needed); a `u32 hi=0x8000` local reassigned per use (drops r7
  from the save set entirely — worse).
- Flags: `-fno-gcse`, `-fno-expensive-optimizations`, `-fforce-addr`, `-O1`,
  `-funroll-loops`/`-funroll-all-loops` (do not unroll the 2-trip loop),
  `-ffixed-r3`/`-ffixed-r4`/`-ffixed-r10`, `-fno-schedule-insns{,2}`,
  `-fno-strength-reduce`. None move below 425; -ffixed-r10 forces a stack spill
  (451, worse). Both compilers (OLD_AGBCC default, AGBCC_BIN) hoist (432/433).
- Permuter: not attempted — 425 is far outside its useful range (<=40) and the
  divergence is a constant-hoist, not statement order.

## Next attempt ideas
1. Instrument a PRIVATE `old_agbcc` (gcc/loop.c `move_movables`, ~line 1855)
   with an fprintf to log which movable+regno is moved, to find the exact
   cost/availability gate, then craft source that keeps loop 1's register
   pressure high enough that no callee-saved reg is free for 0x8000 (mirror
   loop 2's pressure profile — e.g. a 5th genuinely-live value across the calls).
2. The baserom keeps r4 as a multiply-set scratch holding 0x8000 / slot / status;
   try a single C scratch local explicitly reused for all three so agbcc colours
   them to one register (defeats the single-set-movable rule that triggers the
   hoist).

## Best-effort C (clean, readable; byte_diff 425)
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
    register struct Entity *base asm("r7"); /* pins the exact 2-high-reg prologue */
    struct Entity *entity;
    register u32 bit2 asm("r8"); /* baserom hoists the 0x2 status mask to r8 */
    register u32 bit8 asm("r9"); /* baserom hoists the 0x8 status mask to r9 */

    if (gEntities[0].y > 0x198 && gEntities[0].x > 0xF0)
        return;

    base = gEntities;
    bit2 = 2;
    for (i = 0; i <= 1; i++) {
        entity = (struct Entity *)((i + 0x5B) * 56 + (s32)base);
        if (entity->field_1A == 0) {
            if ((entity->status & bit2) == 0) {
                if ((entity->status & 0x8000) != 0)
                    entity->status = (entity->status | 2) & 0x7FFF;
            }
        } else if (entity->field_1A == 1) {
            if ((entity->status & bit2) == 0) {
                if (entity->field_1B == entity->field_1C[0] - 2) {
                    u32 slot = i + 0x5D;
                    if (i == 1)
                        sub_08020CDC(&gEntities[0x5C], 0x13, 3, 3);
                    sub_080210A0(slot, (const void *)sLevelLayoutPtrs_311F28[i], 16, 24, 0x211, 12, 3, 3);
                    sub_0800696C(&gIwram_6110, slot);
                }
                entity = (struct Entity *)((i + 0x5B) * 56 + (s32)base);
                if ((entity->status & 0x8000) != 0) {
                    entity->field_1A = 0;
                    entity->status |= 2;
                }
            }
        }
    }

    sub_08005D10(0x5B, 0x5C);

    base = gEntities;
    bit2 = 2;
    bit8 = 8;
    for (i = 0; i <= 1; i++) {
        entity = (struct Entity *)((i + 0x5D) * 56 + (s32)base);
        if ((entity->status & bit8) != 0)
            continue;
        if (entity->field_1A == 0) {
            if ((entity->status & bit2) == 0) {
                if ((entity->status & 0x8000) != 0) {
                    struct Entity *prev = (struct Entity *)((i + 0x5B) * 56 + (s32)base);
                    prev->status |= 2;
                    prev->field_1A = 1;
                    entity->status |= bit8;
                }
            }
        } else if (entity->field_1A == 4) {
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
        }
    }

    sub_08020FE4(0x5D, 0x5E);
    sub_08005D10(0x5D, 0x5E);
}
```
