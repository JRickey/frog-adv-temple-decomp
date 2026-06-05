# sub_0802A8FC — deferred (round 38, opus)

`void sub_0802A8FC(void)` at 0x0802a8fc, 256 bytes. Operates on entity-pool
slots 10 and 11 (`gEntities[10]`/`gEntities[11]`), then tail-calls
`sub_08005D10(10, 11)`. Callees `sub_08020C78` (sound, arg 0x2b) and
`sub_08005D10` are both peeled.

The C is fully understood and reads cleanly (see Best-effort C). The block is
a state dispatch on `gEntities[10].field_1A`:
- `field_1A == 3`: branch on `field_1B`; toggle `gEntities[10].status` bit 0x200
  (play sound 43 + clear when set, set otherwise); then if `!(status&2) &&
  (status&0x8000)` promote slots 10/11 (`field_1A=5`/`6`, set bit 2, clear 0x8000).
- else: for slots 10 and 11, if `status & 0x8000` then `status = (status|2)&0x7fff`.

VERDICT from classify_unmatchable.py: ATTEMPT_MATCH (no structural-impossibility
signature; prologue `push {r4,r5,lr}`). NOT a NAKED candidate.

## Drift

Best result: **byte_diff 225, diff_count 75** (Thumb), with the struct-index C
below compiled by `old_agbcc` (the Makefile default). The STRUCTURE is correct —
all branches land at the same relative offsets and the else-branch + tail
(`sub_08005D10(10,11)` + `pop {r4,r5}; pop {r0}; bx r0` epilogue) match exactly.
The 75 diffs are a register-coloring/CSE cascade rooted in TWO baserom idioms
agbcc will not reproduce from any C shape tried:

1. **field_1B offset reuse.** Baserom reads `field_1A` via `r1=0x24a; r0=r2+r1;
   ldrb`, then reads `field_1B` via `r1+=1; r0=r2+r1; ldrb` (reuses the 0x24a
   offset register, `adds r1,#1`). agbcc instead loads `0x24b` as a FRESH pool
   word — this extra pool word shifts the whole pool layout (+8 bytes on the
   else target) and is what inflates byte_diff. This is `cse.c` constant
   equivalence (`0x24b ≡ 0x24a+1`) that only fires when agbcc keeps the offset
   reg live across the `cmp/bne`; it doesn't here.

2. **base reuse + mask derivation for the status block.** Baserom keeps base in
   r2 across the field_1B test and computes `r4 = r2 + 0x264` (status10 ptr) with
   `0x264` via `movs 153; lsls 2`, THEN derives the mask `0x200` as `subs r0,#0x64`
   (= 0x264 - 0x64, reusing the live offset constant). agbcc instead RELOADS base
   into r0 (`ldr r0,[pool]`) and materializes `0x200` independently — so the
   offset/mask registers differ and the derivation never happens. This is
   downstream of agbcc not carrying r2's value across the `||`-chain branch joins
   (cse-follow-jumps is on but doesn't propagate it).

Note the baserom DOES reload base into r3 for the final promote-block and again
in the top-level else branch, so "pin base to one register" is wrong (and v9,
`register T *base asm("r2")`, made it far worse — 187 — because the
caller-saved pin forces reloads around the `sub_08020C78` call).

### Levers tried (none closed the gap)
Structures (best diff_count in parens):
- struct index `gEntities[10].field` — **75 (best)**
- `(u8*)gEntities` macro + explicit byte offsets `E[0x24a]`, `*(u16*)(E+0x264)` — 114 (folds base+offset into one address)
- cached `struct Entity *e = &gEntities[10]` — 120
- cached `struct Entity *base = gEntities; base[10].field` — 132
- explicit `u16 *status10 = &gEntities[10].status` — 126
- `switch(field_1B){case 2: case 6: case 10:}` — 115 (jump table)
- inverted `if (mode!=2 && !=6 && !=10)` — 91 (wrong branch direction)
- `mode` local, non-inverted — 75 (tie, no change)
- `u8 *p; p[0x24a]` for 1A/1B + struct for status — 83 (got the `base+0x24a` reg
  form right, but `p[0x24a+1]` const-folds to 0x24b, no `+1` reuse)
- `s32 off=0x24a; base[off]; base[off+1]` — 94 (off var spills, pushes r6; `off+1`
  still const-folds to 0x24b)
- `register struct Entity *base asm("r2")` pin — 187 (caller-saved pin → reloads)

Flags (all left old_agbcc/v1 at 75, or worse): -fforce-addr, -fno-gcse,
-fno-cse-follow-jumps, -fno-cse-skip-blocks, -fno-rerun-cse-after-loop,
-fno-thread-jumps, -fno-strength-reduce, -ffixed-r3/r4/r5, -fcaller-saves,
-O1, -fpeephole/-fno-peephole, and combos. Newer agbcc (`AGBCC_BIN`) gives 87
(worse than old's 75); newer + flags ≥ 91.

Permuter: base score **4475** (≈60×/diff, NOT the ~5×/diff of a coloring tail),
improving only to ~3800 over 60 iters — confirms this is NOT a near-match
register-coloring tail the permuter can crack from this base. Did not pursue
a long run (the howto explicitly excludes "huge byte_diff, not a coloring tail").

### Next lever to try (untried directions)
- corpus_asm_search.py HISTORY search once the full mirrors are populated at
  tools/agent/corpus-mirrors/ (absent in this worktree): find a commit that
  REPLACED `adds r[0-7], #1` following a `add r[0-7], rX, rY; ldrb` (the offset
  +1 reuse) with C, to learn the exact source shape that makes agbcc CSE the
  offset constant. That asm<->C pairing is the missing piece.
- Read tools/agbcc-src/gcc_arm/cse.c around `fold_rtx`/const equivalence to find
  the precise condition under which `0x24b` is synthesized from a live `0x24a`,
  then shape the C to satisfy it (likely requires the offset to be a genuine
  non-folded induction value — but a plain `off` var didn't do it; may need the
  two byte reads to be the ONLY uses with no intervening const-fold).

## Best-effort C

```c
#include "iwram.h"
#include "types.h"

extern void sub_08020C78(u32 sound);
extern void sub_08005D10(s32 a0, s32 a1);

void sub_0802A8FC(void)
{
    if (gEntities[10].field_1A == 3) {
        if (gEntities[10].field_1B == 2 || gEntities[10].field_1B == 6 ||
            gEntities[10].field_1B == 10) {
            if (gEntities[10].status & 0x200) {
                sub_08020C78(43);
                gEntities[10].status &= 0xfdff;
            }
        } else {
            gEntities[10].status |= 0x200;
        }

        if (!(gEntities[10].status & 2) && (gEntities[10].status & 0x8000)) {
            gEntities[10].field_1A = 5;
            gEntities[11].field_1A = 6;
            gEntities[11].status |= 2;
            gEntities[10].status = (gEntities[10].status | 2) & 0x7fff;
        }
    } else {
        if (gEntities[10].status & 0x8000)
            gEntities[10].status = (gEntities[10].status | 2) & 0x7fff;
        if (gEntities[11].status & 0x8000)
            gEntities[11].status = (gEntities[11].status | 2) & 0x7fff;
    }

    sub_08005D10(10, 11);
}
```
