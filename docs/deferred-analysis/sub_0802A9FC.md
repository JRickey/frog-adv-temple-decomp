# sub_0802A9FC — deferred

Entity slot-12 state machine (`gEntities[12]` == 0x030039c0; base `gEntities`
== 0x03003720). Switches on `gEntities[12].field_1A` (offset 0x2ba) and
normalizes `gEntities[12].status` (offset 0x2d4) around bit 1 (queued) and bit
15 (busy); fires sounds 0x22 (state 2) / 0x73 (state 3) when bit 1 is set;
state 3 also sets `gIwram_6110.inputFlags |= 8`; always tail-calls
`sub_080059C4(&gEntities[12])`.

VERDICT: ATTEMPT_MATCH. NOT NAKED-able — this is a single-scratch-register
coloring tail, matchable in principle.

## Drift

Best reached this round: **byte_diff 4, diff_count 4, size 236 exact** — a
DRAMATIC improvement over the prior round's 44/35. The structure is now fully
correct; the ONLY remaining mismatch is one scratch register in case 1.

Re-derived from scratch (NOT extending the prior near-match). Key structural
findings that the prior attempt missed:

1. **Base must be `gEntities` (0x03003720) + big offsets 0x2ba/0x2d4**, NOT
   `&gEntities[12]` (which folds to slot base 0x030039c0 + small offsets 0x1A/
   0x34 → size 204/224, too short). Use a byte-base local
   `u8 *base = (u8*)gEntities;` and `base + SLOT12_STATUS_OFFSET`.
2. **`statePtr = base + 0x2ba` computed ONCE at top, kept (r3)** for the
   switch AND the commit's `*statePtr = queued` (`strb r2,[r3]`). This is what
   lets cases 1+2 share the commit tail without the gEntities base needing to
   survive the merge (which otherwise spills to `ip` — `mov ip, r2` — or forces
   `push {r4,r5,lr}`).
3. **Shared commit via `goto commit`** (case 1 falls through, case 2 falls in)
   — matches baserom's `b 0x2aa7e`. statusPtr (r4) set per-case before the merge.
4. **Case 0 must use a DIFFERENT statusPtr register (r2) than the commit (r4)**
   so the two stores DON'T tail-merge (target keeps them separate; with status
   pinned r1 and case-0 statusPtr unpinned they cross-jump → size 224). Pin
   case-0's pointer `asm("r2")`.
5. **Staged store to defeat the recolour-before-store fold**: write
   `newStatus = status | 2; status = 0x7fff; newStatus &= status; *p = newStatus;`
   (reusing the dead `status` reg for the 0x7fff mask, `newStatus asm("r0")`).
   The naive `*p = (status|2)&0x7fff` emits an extra `adds r0,r4,#0` copy.
6. **Case 1 needs a u32 temp** `q = status & 2; queued = (u16)q;` to emit the
   `lsls #16; lsrs #16` u16-cast that the baserom has in case 1 (case 2 elides
   it by reusing r0=2 from the dispatch `cmp r0,#2`). Without the temp the cast
   is optimized away → byte_diff 134.

### The remaining 4-byte wall (case 1 scratch register)

Target case 1:  `movs r0,#2; ands r0,r1; lsls r0,#16; lsrs r2,r0,#16`
Built  case 1:  `movs r2,#2; ands r2,r1; lsls r2,#16; lsrs r2,r2,#16`

The `status & 2` scratch (`q`) lands in **r2** (queued's pinned reg) instead of
**r0** (the freed statusPtr-offset const reg, which the target reuses). agbcc's
local-alloc gives `q` a **copy-suggestion** toward queued's r2 (from the near-copy
`queued = (u16)q`), and `find_free_reg` honors that suggestion over reusing the
free r0. Confirmed by an instrumented old_agbcc build (printed
`qty ... copy_sugg=1 sugg=1 -> phys=2` for the case-1 `& 2`/queued quantity).

Levers tried (all left byte_diff at 4 or worse):
- `register u32 q asm("r0")` pin: forces `q` into r0 but then agbcc copies
  r0→r2 BEFORE truncating (`adds r2,r0; lsls r0,r2,#16`) or truncates r0
  in-place then copies (`lsrs r0,r0; adds r2,r0`) — never the fused
  `lsls r0; lsrs r2,r0`. (byte_diff 5 / 136)
- q types: u8/u16/u32/s32/int — all byte_diff 4.
- Explicit `(q<<16)>>16` / `q<<=16; queued=q>>16`: agbcc adds a redundant
  second cast (size 240, byte_diff 136).
- `if (q)` vs `if (queued)`, fused read `q=(status=*sp)&2`, separate test
  expr, fresh `*statusPtr` re-read, block-local intermediates: all 4 / worse.
- Per-TU flags: -fno-gcse, -fno-cse-follow-jumps, -fno-expensive-optimizations,
  -fno-schedule-insns[2], -fno-rerun-cse-after-loop/-loop-opt, -fno-strength-reduce,
  -fno-force-mem — ALL still byte_diff 4. Newer agbcc (CC=AGBCC_BIN): also 4.
- decomp-permuter: ~17,000 iterations across two runs (-j4 and -j6,
  --stop-on-zero --better-only), base score 25, never improved below base.
  This coloring is not reachable by source-statement mutation.

## Next ideas (for the reclamation pass)

- The fix is to make `q` (the `status & 2` scratch) prefer r0 over the copy-
  suggestion to r2. The instrumented-agbcc trace location is
  `gcc/local-alloc.c` `find_free_reg` / the `qty_phys_copy_sugg` honor order
  (~line 1340 and ~1619-1675). A source shape that gives `q` a STRONGER r0
  hard-reg preference than the copy-suggestion (e.g. tying `q` to a value that
  must be r0 for an unrelated reason) would flip it. corpus_asm_search for a
  deleted asm `(u16)(x & k)` cast whose scratch is the freed pointer-offset
  reg (idiom regex `movs r[0-7], #2 ; ands r[0-7], r[0-7] ; lsls .* #16 ; lsrs r[0-7], r[0-7], #16`).
- Or: an instrumented old_agbcc with the copy-suggestion DISABLED for this
  qty to confirm it then produces the byte-match, proving the lever.

## Best-effort C

byte_diff 4 / diff_count 4 / size 236, default OLD_AGBCC (no Makefile override),
linker.ld collapses the scaffold+asm into the single src .o (asm slice removed).

```c
#include "iwram.h"
#include "types.h"

extern void sub_08020C78(u32 sound);
extern void sub_080059C4(void *p);

enum {
    SLOT12_STATE_OFFSET = 0x2ba,
    SLOT12_STATUS_OFFSET = 0x2d4,
    ENTITY_STATUS_QUEUED = 0x0002,
    ENTITY_STATUS_BUSY = 0x8000,
    ENTITY_STATUS_BUSY_CLEAR = 0x7fff,
};

void sub_0802A9FC(void)
{
    u8 *base;
    u8 *statePtr;
    register u16 *statusPtr asm("r4");
    register u16 status asm("r1");
    register u16 queued asm("r2");
    register u16 newStatus asm("r0");

    base = (u8 *)gEntities;
    statePtr = base + SLOT12_STATE_OFFSET;

    switch (*statePtr) {
    case 0: {
        register u16 *sp asm("r2") = (u16 *)(base + SLOT12_STATUS_OFFSET);
        status = *sp;
        if (status & ENTITY_STATUS_QUEUED)
            break;
        if (!(status & ENTITY_STATUS_BUSY))
            break;
        newStatus = status | ENTITY_STATUS_QUEUED;
        status = ENTITY_STATUS_BUSY_CLEAR;
        newStatus &= status;
        *sp = newStatus;
        break;
    }
    case 1: {
        u32 q;
        statusPtr = (u16 *)(base + SLOT12_STATUS_OFFSET);
        status = *statusPtr;
        q = status & ENTITY_STATUS_QUEUED;
        queued = (u16)q;
        if (queued)
            break;
        goto commit;
    }
    case 2:
        statusPtr = (u16 *)(base + SLOT12_STATUS_OFFSET);
        status = *statusPtr;
        queued = (u16)(status & ENTITY_STATUS_QUEUED);
        if (queued) {
            sub_08020C78(0x22);
            break;
        }
    commit:
        if (!(status & ENTITY_STATUS_BUSY))
            break;
        *statePtr = (u8)queued;
        newStatus = status | ENTITY_STATUS_QUEUED;
        status = ENTITY_STATUS_BUSY_CLEAR;
        newStatus &= status;
        *statusPtr = newStatus;
        break;
    case 3: {
        register u16 *sp asm("r3") = (u16 *)(base + SLOT12_STATUS_OFFSET);
        queued = *sp;
        if (queued & ENTITY_STATUS_QUEUED) {
            sub_08020C78(0x73);
            break;
        }
        if (!(queued & ENTITY_STATUS_BUSY))
            break;
        gIwram_6110.inputFlags |= 8;
        *sp = queued & ENTITY_STATUS_BUSY_CLEAR;
        break;
    }
    }

    sub_080059C4(&gEntities[12]);
}
```
