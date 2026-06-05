# sub_0802A8FC — deferred

`void sub_0802A8FC(void)` at 0x0802a8fc, 256 bytes. Operates on entity-pool
slots 10 and 11 (`gEntities[10]`/`gEntities[11]`), then calls
`sub_08005D10(10, 11)`. Callees `sub_08020C78` and `sub_08005D10` are both
peeled. `classify_unmatchable.py` reports `ATTEMPT_MATCH`; this is not a
NAKED candidate.

## Drift

Best result in this pass: **byte_diff 85, diff_count 39**, size 260, old agbcc.
This improves the prior best (225/75) by using a small set of register pins and
source ordering:

- `base asm("r2")`, `offset asm("r1")`, and `state asm("r0")` make the opening
  dispatch match through the `0x24a -> adds r1,#1 -> field_1B` idiom, avoiding
  the extra `0x24b` literal.
- Branch-local raw status pointers avoid reloading `gEntities` in the first
  toggle block and reproduce the `0x264 - 0x64 = 0x200` mask derivation.
- Splitting `!(status & 2) && (status & 0x8000)` into nested `if`s prevents the
  `0x8002` combined-mask fold.
- Reloading `gEntities` into `promoteBase asm("r3")`, with `promoteStatus
  asm("r5")`, `status asm("r2")`, and `moved asm("r4")`, gets the promote block
  close to the baserom live ranges.
- Reordering the promote body to write slot 10 state, update the local status,
  write slot 11 state, then update slot 11 status removed the previous extra
  `r6` prologue.

Remaining drift at best:

- The set path still uses `r3`/`r5` where baserom uses `r1`/`r2` for
  `status |= 0x200`:
  target `mov r1,#0x99; lsls r1,#2; ... mov r2,#0x80; lsls r2,#2`,
  built `mov r3,#0x99; ... mov r5,#0x80`.
- The promote block is physically close but still has a four-byte branch/pool
  skew: built branch tails go to `0x2a9ec` where target goes to `0x2a9e8`.
- Slot-11 status update and the final else branch are mostly register-coloring
  drift (`r4/r5/r3` vs target `r3/r4/r1`) after the promotion pins.

New levers tried in this pass:

- Source-only byte-base offset, pointer-walk, and pre-increment forms. All
  folded back to a fresh `0x24b` literal unless `offset asm("r1")` was present.
- `base asm("r2")` + `state asm("r0")` fixed the opening add order; `state`
  without `base` did not.
- Raw branch-local status pointers improved from 225/75 to 143/58; precomputing
  status pointers at function entry moved work before the dispatch and worsened
  layout.
- A separate `promoteBase asm("r3")` improved the promote block to 124/55.
- Promotion-local pins for `promoteStatus/status/moved` improved to 110/60 but
  first introduced `r6`; reordering the statements removed `r6` and reached
  88/43, then separating the test constant from `moved` reached 85/39.
- `setMask asm("r2")` for the set path worsened slightly (89/44).
- Per-TU `-fno-gcse` and `-fno-cse-follow-jumps` made no difference; `-ffixed-r3`
  forced `r6` and worsened the prologue. Newer `AGBCC_BIN` worsened to 96/44.
- `corpus_asm_search.py` could not be used here because
  `tools/agent/corpus-mirrors/` is absent.
- Permuter could not be run in this worktree because `vendor/decomp-permuter`
  contains no `.venv` or permuter files; `setup_permuter.py` wrote
  `nonmatchings/sub_0802A8FC/target.{s,o}` but failed on the missing interpreter.

## Best-effort C

```c
#include "iwram.h"
#include "types.h"

enum {
    ENTITY_SLOT_MAIN = 10,
    ENTITY_SLOT_NEXT = 11,
};

enum {
    ENTITY_SLOT_MAIN_STATE_OFFSET = 0x24a,
    ENTITY_SLOT_MAIN_STATUS_OFFSET = 0x264,
    ENTITY_SLOT_NEXT_STATE_OFFSET = 0x282,
    ENTITY_SLOT_NEXT_STATUS_OFFSET = 0x29c,
};

enum {
    ENTITY_STATE_READY = 3,
    ENTITY_STATE_PROMOTED_MAIN = 5,
    ENTITY_STATE_PROMOTED_NEXT = 6,
};

enum {
    ENTITY_MODE_2 = 2,
    ENTITY_MODE_6 = 6,
    ENTITY_MODE_10 = 10,
};

enum {
    ENTITY_STATUS_MOVED = 2,
    ENTITY_STATUS_TOGGLE = 0x200,
    ENTITY_STATUS_PENDING = 0x8000,
    ENTITY_STATUS_VISIBLE_MASK = 0x7fff,
};

enum {
    SOUND_2B = 43,
};

extern void sub_08020C78(u32 sound);
extern void sub_08005D10(s32 first, s32 last);

void sub_0802A8FC(void)
{
    register u8 *base asm("r2");
    u8 mode;
    register u8 *state asm("r0");
    register s32 offset asm("r1");
    u16 *mainStatus;
    register u16 *nextStatus asm("r1");
    register u8 *promoteBase asm("r3");
    register u16 *promoteStatus asm("r5");
    register u16 status asm("r2");
    register u16 moved asm("r4");

    base = (u8 *)gEntities;
    offset = ENTITY_SLOT_MAIN_STATE_OFFSET;
    if (*(base + offset) == ENTITY_STATE_READY) {
        offset++;
        state = base + offset;
        mode = *state;
        if (mode == ENTITY_MODE_2 || mode == ENTITY_MODE_6 || mode == ENTITY_MODE_10) {
            mainStatus = (u16 *)(base + ENTITY_SLOT_MAIN_STATUS_OFFSET);
            if (*mainStatus & ENTITY_STATUS_TOGGLE) {
                sub_08020C78(SOUND_2B);
                *mainStatus &= ~ENTITY_STATUS_TOGGLE;
            }
        } else {
            state = base + ENTITY_SLOT_MAIN_STATUS_OFFSET;
            *(u16 *)state |= ENTITY_STATUS_TOGGLE;
        }

        promoteBase = (u8 *)gEntities;
        promoteStatus = (u16 *)(promoteBase + ENTITY_SLOT_MAIN_STATUS_OFFSET);
        status = *promoteStatus;
        moved = ENTITY_STATUS_MOVED;
        if (!(status & ENTITY_STATUS_MOVED)) {
            if (status & ENTITY_STATUS_PENDING) {
                *(promoteBase + ENTITY_SLOT_MAIN_STATE_OFFSET) = ENTITY_STATE_PROMOTED_MAIN;
                status |= moved;
                *(promoteBase + ENTITY_SLOT_NEXT_STATE_OFFSET) = ENTITY_STATE_PROMOTED_NEXT;
                nextStatus = (u16 *)(promoteBase + ENTITY_SLOT_NEXT_STATUS_OFFSET);
                *nextStatus |= ENTITY_STATUS_MOVED;
                status &= ENTITY_STATUS_VISIBLE_MASK;
                *promoteStatus = status;
            }
        }
    } else {
        mainStatus = (u16 *)(base + ENTITY_SLOT_MAIN_STATUS_OFFSET);
        if (*mainStatus & ENTITY_STATUS_PENDING)
            *mainStatus = (*mainStatus | ENTITY_STATUS_MOVED) & ENTITY_STATUS_VISIBLE_MASK;

        nextStatus = (u16 *)(base + ENTITY_SLOT_NEXT_STATUS_OFFSET);
        if (*nextStatus & ENTITY_STATUS_PENDING)
            *nextStatus = (*nextStatus | ENTITY_STATUS_MOVED) & ENTITY_STATUS_VISIBLE_MASK;
    }

    sub_08005D10(ENTITY_SLOT_MAIN, ENTITY_SLOT_NEXT);
}
```
