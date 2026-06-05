# sub_0802A9FC — deferred

State machine for entity slot 12 (`&gEntities_03003720[12]` == 0x030039c0).
Dispatches on the slot's `field_1A` state byte; normalizes the slot `status`
halfword around bit 1 (queued) and bit 15 (busy); fires a sound on states 2/3
when bit 1 is set; always tail-calls `sub_080059C4(slot)`.

VERDICT: ATTEMPT_MATCH (`classify_unmatchable.py`). No NAKED fallback is
justified.

## Drift

Best reached this round: **byte_diff 44, diff_count 35, size 236 exact** with
pure C register pins and **old_agbcc**. This improves the previous `48/37`
floor and removes the old inline `asm("")` base barrier: using
`extern u8 gEntities_03003720[]` plus explicit offsets is enough to keep the
baserom's `0x03003720 + 0x2ba/0x2d4` address form.

The remaining mismatch is still the same structural wall:

- Case 0 wants `offset=r4`, `statusPtr=r2`, `status=r1`, and an inline
  `newStatus=r0` store. The best C colors `offset=r3` and then cross-jumps the
  store through the shared commit tail.
- Cases 1/2 want `statusPtr=r4` and `queued=r2`, while case 0 wants the status
  pointer in `r2`. A single function-scope status-pointer pin cannot express
  that non-uniform allocation.
- Case 3 wants `statusPtr=r3`, `status=r2` because `gIwram_6110.inputFlags |= 8`
  uses `r1` for the 0x03006110 base. The best C keeps `status=r1`.

Levers tried:

- Clean readable `&gEntities[12]` switch with newer agbcc: folded to
  `gEntities+0x2a0`, size 192, byte_diff 184.
- Byte-base source rewrite (`gEntities_03003720 + 0x2ba/0x2d4`), no pins: size
  232, byte_diff 116.
- Pure-C pins `base=r1`, `state=r3`, `statusPtr=r2`, `status=r1`: size 236,
  byte_diff 48 with newer agbcc, **44 with old_agbcc**.
- Per-case/block-scope pins to force case 0/3 offset registers and case 1/2
  commit registers: worsened to byte_diff ~142/143 and size 232.
- Unpinned status pointer with `queued=r2`: worsened to size 220, byte_diff 161.
- Per-TU flags on the 48-byte floor: `-fno-gcse` neutral; `-fforce-addr
  -fno-expensive-optimizations -fno-gcse`, `-fno-cse-follow-jumps`, and `-O1`
  all regressed size and diff.
- Corpus current-tree grep did not surface a useful analogue. History search
  could not run because `tools/agent/corpus-mirrors/` is not populated in this
  worktree.
- `agbcc_oracle.py --pass greg` confirms the allocator is juggling the same
  low-register set (`r0`-`r4`) across many short basic blocks; no single global
  pin surfaced that matches the per-case coloring.

Next ideas:

- Use a populated `corpus_asm_search.py` mirror to find a deleted asm
  four-state dispatcher where one arm touches a second IWRAM base and forces a
  per-arm recolor.
- Build a private instrumented agbcc and trace local-alloc/jump cross-jump
  decisions for the case 0 store tail. The useful probe is around
  `jump.c:find_cross_jump`/`do_cross_jump` plus local-alloc hard-reg assignment
  for the status pointer and queued mask pseudos.

## Best-effort C

Best score: byte_diff 44 / diff_count 35 / size 236, using default old_agbcc
(no `src/engine/sub_0802a9fc.s: CC = $(AGBCC_BIN)` override).

```c
#include "iwram.h"
#include "types.h"

enum {
    ENTITY_SLOT_12 = 12,
    ENTITY_SLOT_12_STATE_OFFSET = 0x2ba,
    ENTITY_SLOT_12_STATUS_OFFSET = 0x2d4,
    ENTITY_SLOT_12_OFFSET = ENTITY_SLOT_12 * sizeof(struct Entity),
    ENTITY_STATUS_QUEUED = 2,
    ENTITY_STATUS_BUSY = 0x8000,
    ENTITY_STATUS_BUSY_CLEAR = 0x7fff,
    MODE_INPUT_FLAG_8 = 8,
    SOUND_22 = 0x22,
    SOUND_73 = 0x73,
};

extern u8 gEntities_03003720[];
extern u32 sub_08020C78(u32 sound);
extern void sub_080059C4(void *p);

void sub_0802A9FC(void)
{
    register u8 *base asm("r1") = gEntities_03003720;
    register u8 *state asm("r3") = base + ENTITY_SLOT_12_STATE_OFFSET;
    register u16 *statusPtr asm("r2");
    register u16 status asm("r1");
    struct Entity *entity;
    u16 queued;

    switch (*state) {
    case 0:
        statusPtr = (u16 *)(base + ENTITY_SLOT_12_STATUS_OFFSET);
        status = *statusPtr;
        if ((status & ENTITY_STATUS_QUEUED) != 0)
            break;
        if ((status & ENTITY_STATUS_BUSY) == 0)
            break;

        *statusPtr = (status | ENTITY_STATUS_QUEUED) & ENTITY_STATUS_BUSY_CLEAR;
        break;
    case 1:
        statusPtr = (u16 *)(base + ENTITY_SLOT_12_STATUS_OFFSET);
        status = *statusPtr;
        queued = (u16)(status & ENTITY_STATUS_QUEUED);
        if (queued != 0)
            break;
        goto commit;
    case 2:
        statusPtr = (u16 *)(base + ENTITY_SLOT_12_STATUS_OFFSET);
        status = *statusPtr;
        queued = status & ENTITY_STATUS_QUEUED;
        if (queued != 0) {
            sub_08020C78(SOUND_22);
            break;
        }
    commit:
        if ((status & ENTITY_STATUS_BUSY) == 0)
            break;

        *state = queued;
        *statusPtr = (status | ENTITY_STATUS_QUEUED) & ENTITY_STATUS_BUSY_CLEAR;
        break;
    case 3:
        statusPtr = (u16 *)(base + ENTITY_SLOT_12_STATUS_OFFSET);
        status = *statusPtr;
        if ((status & ENTITY_STATUS_QUEUED) != 0) {
            sub_08020C78(SOUND_73);
            break;
        }
        if ((status & ENTITY_STATUS_BUSY) == 0)
            break;

        gIwram_6110.inputFlags |= MODE_INPUT_FLAG_8;
        *statusPtr = status & ENTITY_STATUS_BUSY_CLEAR;
        break;
    }

    entity = (struct Entity *)(gEntities_03003720 + ENTITY_SLOT_12_OFFSET);
    sub_080059C4(entity);
}
```
