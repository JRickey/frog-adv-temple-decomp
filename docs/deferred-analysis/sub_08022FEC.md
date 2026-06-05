# sub_08022FEC — deferred analysis

Engine routine at 0x08022FEC (520 bytes), an entity-scene setup pass in
`asm/disasm_0x08022fec.s`; destination `src/engine/sub_08022fec.c`.

Classifier verdict: `ATTEMPT_MATCH`. The only advisory is high registers
`r8/r9` across calls; this is not a NAKED-eligible class. All callees are peeled.

## Drift

Best new result: `byte_diff 317`, `diff_count 93`, built slice size 516. This
used readable C plus pure-C register pins, computed `&base[0x5C]` call operands,
and a private test compile with `-fno-rerun-cse-after-loop`.

What improved:
- Clean unpinned source matched behavior but started around `byte_diff 412`.
- Restoring the prior bit live ranges (`bit2` in `r8`, `bit8` in `r9`) returned
  to the known `byte_diff 383` plateau.
- Computed `base[0x5C]` operands plus `-fno-rerun-cse-after-loop` improved the
  plateau to `byte_diff 317`.

Remaining divergence:
- Loop 1 still copies the 0x8000 test through the loaded status register:
  built `adds r0, r1, #0; ands r0, r4`, target `adds r0, r4, #0; ands r0, r1`.
- The recomputed entity pointer after helper calls still lands in `r2`, while
  target wants `r1` (`adds r1, r0, r7; ldrh r2, [r1,#0x34]`).
- Literal pool placement remains short by 4 bytes under the best flag; branch
  and BL offsets therefore still cascade.
- Loop 2 still differs around repeated `0x8000` materialization and `|= 2`
  pseudos. The target materializes per-use; agbcc keeps finding shared pseudos
  or different low-register colors.

New levers tried and ruled out:
- Source-only clean C, no pins/asm/volatile: behavior matches but codegen is far
  from target (`byte_diff 412`, size 528).
- ROM-shaped C with no pins: exact slice size but worse register allocation
  (`byte_diff 461`).
- Prior pin baseline with `bit8` live in `r9`: `byte_diff 383`, size 508.
- `&gEntities[0x5C]` pool-load call operands: regressed to `byte_diff 453`.
- Computed `&base[0x5C]` call operands: improved to `byte_diff 371`.
- `-fno-gcse`, `-fno-strength-reduce`, `-fforce-addr`,
  `-fno-expensive-optimizations`, `-O1`, and newer `agbcc`: all worse than the
  best point. `-fno-rerun-cse-after-loop` was the only useful flag.
- Narrowing the `st asm("r1")` pin to the case-0 block was a no-op.
- Removing the `r1` pin entirely regressed slightly (`byte_diff 318`) and did not
  move the recomputed entity pointer to `r1`.
- Current-tree corpus grep found only a few explicit high-register pin examples;
  history search could not run because this worktree has no
  `tools/agent/corpus-mirrors`.

Recommended next work:
- Instrument `local-alloc.c` around hard-register choice for the recomputed
  pointer pseudo and the case-0 0x8000 test result. The source levers above do
  not explain why `r1` remains unavailable.
- If a future attempt gets below roughly 40 bytes, run the permuter from the
  computed-address + `-fno-rerun-cse-after-loop` base. Current drift is still too
  large for permuter-first work.

## Best-effort C

```c
#include "iwram.h"
#include "types.h"

#define ENTITY_STATUS_TRIGGERED 0x0002
#define ENTITY_STATUS_DONE 0x0008
#define ENTITY_STATUS_PENDING 0x8000
#define ENTITY_STATUS_PENDING_CLEAR 0x7FFF

enum {
    ENTITY_STATE_WAITING = 0,
    ENTITY_STATE_SPAWN_READY = 1,
    ENTITY_STATE_ACTIVE = 4,
};

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

    if (gEntities[0].y > 0x198 && gEntities[0].x > 0xF0)
        return;

    i = 0;
    base = gEntities;
    bit2 = 2;
    for (; i <= 1; i++) {
        entity = (struct Entity *)((i + 0x5B) * 56 + (s32)base);
        switch (entity->field_1A) {
        case ENTITY_STATE_WAITING: {
            register u32 st asm("r1");
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
        }
        case ENTITY_STATE_SPAWN_READY:
            if ((bit2 & entity->status) == 0) {
                if (entity->field_1B == entity->field_1C[0] - 2) {
                    u32 slot = i + 0x5D;
                    if (i == 1)
                        sub_08020CDC(&base[0x5C], 0x13, 3, 3);
                    sub_080210A0(slot, (const void *)sLevelLayoutPtrs_311F28[i], 16, 24, 0x211, 12, 3, 3);
                    sub_0800696C(&gIwram_6110, slot);
                }
                entity = (struct Entity *)((i + 0x5B) * 56 + (s32)base);
                mask = 0x8000;
                if ((entity->status & mask) != 0) {
                    entity->field_1A = ENTITY_STATE_WAITING;
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
        case ENTITY_STATE_ACTIVE:
            if ((u16)(entity->status & bit2) == 0) {
                if (entity->x > 0x86) {
                    entity->field_1A = ENTITY_STATE_WAITING;
                    entity->status |= ENTITY_STATUS_TRIGGERED;
                    sub_0800A580((struct Entity *)(i * 56 + 0x1458 + (s32)base), 0, 0, 0);
                    if (i == 1)
                        sub_08020CDC(&base[0x5C], 0x5E, 3, 3);
                }
                entity = (struct Entity *)((i + 0x5D) * 56 + (s32)base);
                if ((entity->status & ENTITY_STATUS_PENDING) != 0)
                    entity->status = (entity->status | ENTITY_STATUS_TRIGGERED) & ENTITY_STATUS_PENDING_CLEAR;
            }
            break;
        case ENTITY_STATE_WAITING:
            if ((entity->status & bit2) == 0) {
                if ((entity->status & ENTITY_STATUS_PENDING) != 0) {
                    struct Entity *prev = (struct Entity *)((i + 0x5B) * 56 + (s32)base);
                    prev->status |= ENTITY_STATUS_TRIGGERED;
                    prev->field_1A = ENTITY_STATE_SPAWN_READY;
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
