# sub_0802A9FC — deferred (round 32)

State machine for entity slot 12 (`&gEntities_03003720[12]` == 0x030039c0).
Dispatches on the slot's `field_1A` state byte; normalises the `status`
halfword (+0x34) around bit 1 (queued) and bit 15 (busy); fires a sound on
states 2/3 when bit 1 is set; always tail-calls `sub_080059C4(slot)`.

VERDICT: ATTEMPT_MATCH (classify_unmatchable). The STRUCTURE is fully solved
and confirmed correct — the wall is a sharp **per-case non-uniform register
allocation** that no single pinned C shape reproduces, plus an agbcc
**cross-jump** that merges two identical store tails the baserom keeps split.

## Compiler

This TU matches the NEWER agbcc, not old_agbcc. Use:
`src/engine/sub_0802a9fc.s: CC = $(AGBCC_BIN)` in the Makefile.
(old_agbcc folds &gEntities[12] far more aggressively: byte_diff 180 / diff 146.
 newer agbcc plain: byte_diff 180 / diff 84.)

## Address model (verified)

- base `gEntities_03003720` = 0x03003720 loaded once into r1, kept across cases.
- dispatch byte: `*(u8*)(base + 0x2ba)` = `gEntities[12].field_1A` (0x030039da).
  0x2ba (= 12*0x38 + 0x1a) is a POOL literal (no clean shift decomposition).
- status halfword: `*(u16*)(base + 0x2d4)` = `gEntities[12].status` (0x030039f4).
  0x2d4 (= 12*0x38 + 0x34 = 0xb5<<2) is computed `movs #0xb5; lsls #2` per case.
- tail arg: `&gEntities_03003720[12]` (fresh literal 0x030039c0), base dies.

## Key idioms found (all required, all reproduced)

1. **Defeat the &gEntities[12] fold** so agbcc keeps base+large-offset (not the
   folded 0x030039c0 with small field offsets): `u8 *base = (u8*)gEntities; asm("":"+r"(base));`
   then `pState = base + 0x2ba; pStatus = (u16*)(base + 0x2d4)` per case. The
   barrier is mandatory — without it the address folds (byte_diff 180).
2. **`queued = flags & 2`** variable: cases 1 & 2 store the *computed* `(flags & 2)`
   (==0) into `*pState`, NOT a literal 0 (baserom reuses the zero-extended value
   in r2). Case 1 zero-extends via `lsls #16; lsrs #16` (u16 cast); case 2 reuses
   the state value (==2) still in r0 as the mask (`ands r2, r0`).
3. Tail passes `&gEntities_03003720[12]` (fresh literal) so base dies.

## Drift (the wall)

Best reached: **byte_diff 48, diff_count 37, size 236 (EXACT)** with FOUR pins:
`base asm("r1")`, `pState asm("r3")`, `pStatus asm("r2")`, `flags asm("r1")`,
plus the barrier + `queued` var. (See Best-effort C.)

Two coupled blockers remain:

A. **Per-case non-uniform allocation.** The baserom uses `flags=r1` in cases
   0/1/2 but `flags=r2, pStatus=r3` in **case 3** — because case 3's
   `gIwram_6110.inputFlags |= 8` needs r1 for the 0x6110 base, so flags must
   vacate r1 there. A global `register u16 flags asm("r1")` pin forces flags=r1
   in ALL cases, mis-coloring case 3. Un-pinning flags (to let agbcc choose
   per-case) makes agbcc spill to r3+ and need an extra callee-saved reg
   (byte_diff jumps to ~107-115). No single pin/shape expresses
   "flags=r1 for cases 0-2, flags=r2 for case 3".

B. **Cross-jump tail-merge.** With pStatus pinned r2 globally, case 0's store
   `(flags|2)&0x7fff; strh [r2]` is byte-identical to the commit-block store, so
   agbcc's final jump_optimize (JUMP_CROSS_JUMP, optimize>0, no disabling flag)
   merges case 0 into the commit tail (case 0 emits `b.n shared` instead of an
   inline store). The baserom does NOT merge them: there case 0's store is `[r2]`
   (inline) and the commit/shared store is `[r4]` — different registers because
   `queued` occupies r2 in cases 1/2, pushing pStatus to r4 there. Reproducing
   that split needs case-0-pStatus=r2 AND commit-pStatus=r4 simultaneously;
   two separate register-pinned pointers (ps0 asm("r2"), ps1 asm("r4")) add
   prologue/move bloat (byte_diff ~84, size 240).

## Levers tried (none reached 0)

- old_agbcc vs newer agbcc (newer is correct: 84 vs 146 on plain).
- plain `&gEntities[12]` (folds, 180/84); index-first cast `(s32)base + 12*0x38`
  (folds, 180); `-fforce-addr` (folds to abs addr, 180/84).
- barrier-on-base unpinned + `queued` var: byte_diff 116 / diff 66 (clean, readable;
  flags lands in r3 because base stays live in r1).
- 4 pins (base/pState/pStatus/flags) + queued: byte_diff 48 / diff 37 (FLOOR).
- pin queued asm("r2"); pin pState asm("r3"); separate ps0/ps1 pins — all worse.
- permuter (newer-agbcc target, --agbcc-new): pinned base score 865 -> plateau 665
  at ~6700 iters (the asm("") barrier + heavy pins starve its mutations);
  unpinned base scores 2175 (cross-jumps). Did NOT reach 0.

## Next ideas for a future attempt

- Build a private debug agbcc (codegen-notes "Instrumenting agbcc") and trace
  local-alloc's qty ordering for `flags`/`pStatus` to learn the exact pressure
  that makes the baserom split case-3's flags into r2 — then find the C shape
  (statement order / temp scope) that reproduces it WITHOUT a global flags pin.
- Try a per-case explicit `register ... asm()` only inside case 3's block (block-scope
  reg var) to move flags->r2 there while leaving cases 0-2 to the r1 pin — the
  block-scope pin may localise without disturbing the global allocation.
- Hunt the corpus history for a 4-way switch dispatcher where one arm needs a 2nd
  IWRAM base mid-arm (forces a per-arm recolour) to see the idiomatic C.

## Best-effort C (byte_diff 48 / diff 37, size 236 exact; Makefile: newer agbcc)

```c
#include "iwram.h"
#include "types.h"

extern void sub_08020C78(u32 sound);
extern void sub_080059C4(void *p);

extern struct Entity gEntities_03003720[];

void sub_0802A9FC(void)
{
    register u8 *base asm("r1") = (u8 *)gEntities_03003720;
    register u8 *pState asm("r3");
    register u16 *pStatus asm("r2");
    register u16 flags asm("r1");
    u16 queued;

    asm("" : "+r"(base));
    pState = base + 0x2ba;

    switch (*pState) {
    case 0:
        pStatus = (u16 *)(base + 0x2d4);
        flags = *pStatus;
        if (flags & 2)
            break;
        if (!(flags & 0x8000))
            break;
        *pStatus = (flags | 2) & 0x7fff;
        break;
    case 1:
        pStatus = (u16 *)(base + 0x2d4);
        flags = *pStatus;
        queued = flags & 2;
        if (queued)
            break;
        goto commit;
    case 2:
        pStatus = (u16 *)(base + 0x2d4);
        flags = *pStatus;
        queued = flags & 2;
        if (queued) {
            sub_08020C78(0x22);
            break;
        }
    commit:
        if (!(flags & 0x8000))
            break;
        *pState = queued;
        *pStatus = (flags | 2) & 0x7fff;
        break;
    case 3:
        pStatus = (u16 *)(base + 0x2d4);
        flags = *pStatus;
        if (flags & 2) {
            sub_08020C78(0x73);
            break;
        }
        if (!(flags & 0x8000))
            break;
        gIwram_6110.inputFlags |= 8;
        *pStatus = flags & 0x7fff;
        break;
    }
    sub_080059C4(&gEntities_03003720[12]);
}
```
