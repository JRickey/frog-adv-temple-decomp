#include "macros.h"
#include "types.h"

/* --- Credits_DrawLineAlt: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
register u16 *dr2 asm("r2");
dr2 = (u16 *)(rowBase << 6);
dr2 = (u16 *)((u32)dr2 + (u32)(colBase * 2 + (u32)(u8 *)base));
``` The split is load - bearing : the one - expression form `(rowBase << 6) +
                                  (col..+ base)` evaluates the SECOND operand into r2 first(`adds r2, r0, r2`); the split forces
   the baserom's `adds r2,r2,r0`. WITH the split + pin, the digit index `t` also
   colors to **r1** (baserom), not r4. The digit branch then matches exactly.
   Bottom store value is `palLow + (glyph + 1)` (parenthesize so `+1` is on
   glyph, matching `adds r0,#1` before the palLow add).

3. **letter branch matches** with the same split + `t` MUTATED in place for the
   bottom (mirrors the baserom's `add r1,r9; adds r1,#21` in-place on the t reg):
   ```c
   u = t + GLYPH_LETTER_OFFSET; u += (u32)tileBase; *dr2 = palBits + u;   /* top */
   t += (u32)tileBase; t += 21; *(u16 *)((u8*)dr2+0x40) = palLow + t;     /* bottom */
   ```
   Staging top into `u` forces `adds r0,r1,#0; adds r0,#20; add r0,r9` (t copied
   to r0, NOT `mov r0,r9`); mutating `t` for the bottom keeps t in r1 and does the
   in-place `add r1,r9`. The `(u32)tileBase` casts are load-bearing (u16 tileBase
   promotes wrong: byte_diff explodes to 339 without them).

4. **switch + count-guard are CORRECT only WITHOUT the pin.** See drift below.

## Drift — the ONE remaining residual: agbcc local-reuses dead global regs

ROOT CAUSE (confirmed by reading `tools/agbcc-src/gcc_arm/config/arm/arm.h`
`REG_ALLOC_ORDER = {
    3, 2, 1, 0, 12, 14, 4, 5, ...}` and `local-alloc.c find_free_reg`):
the baserom's original compiler **globally reserves** r2 for `c` (the char) and
r3 for `p`=`str+i` across the WHOLE loop body and does NOT locally reuse them in a
block where they are dead — EXCEPT it reuses r2 in the digit/letter branches.
agbcc's `local-alloc` AGGRESSIVELY reuses any dead register inside a block (r3
first per alloc order), so:

- **digit/letter dst** naturally wants r3 (p's dead reg) → wrong; the `asm("r2")`
  pin fixes it (→ 172).
- BUT the `asm("r2")` pin is a FUNCTION-GLOBAL reservation (block-scoping the
  `register` decl does NOT narrow it — verified). So it pushes the switch case-2
  literal and BOTH `i<count` guard loads from r2 (baserom) to r3 (~6 bytes).
- **space/star/tilde dst** = r3 in BOTH pin and no-pin builds; baserom = r0/r0/r1
  (because baserom holds r2=c AND r3=p reserved, forcing dst to r0/r1). agbcc
  reuses the dead r3. ~the bulk of the residual.
- **bracket** dst/table are an r2↔r3 swap, same cause.

The remaining 172 is ALL register-NUMBER renumbering (r0↔r3, r1↔r2, r2↔r3) with
identical instruction shape (233 vs 233 lines, 1 extra insn). diff_count is
structural-near-zero.

### The decisive un-tried lever: extend `p`=str+i liveness across the branches
If `p` (str+i) were genuinely LIVE across the digit/letter/space/star/tilde
bodies, r3 would be busy everywhere and the WHOLE function would color like the
baserom with NO pins (dst→r2 in digit/letter where c dies; dst→r0/r1 in
space/star/tilde where both c,p reserved; t→r1). The baserom achieves this via
global reservation; agbcc kills p locally because p's only uses are the loop-top
read and the bracket case (dead on every other path). NO pin or `-fXXX` flag
extends liveness (verified: pinning p to r3 is still locally reused; an
`asm("" ::"r"(p))` barrier forces reloads, +instructions, 361). This is the
exact statement-reorder/scope mutation decomp-permuter is built for.

### Levers TRIED this round (none closed the local-reuse gap)
- Best path: `u8 i` + split-dst + `asm("r2")` pin on digit/letter dst + staged
  letter top + mutated letter t  → **172**.
- no-pin (digit dst→r2 via split alone, but t→r3; switch/guard correct) → 229.
- block-scoped `asm("r2")` (still global reservation) → 172, no change.
- pin t to r1 (no-pin base) → 236. pin p to r3 + live pointer → 172/229 (no-op,
  p locally reused regardless). unify all branches to one `dst` (no pin) → 210.
- pin space/star/tilde dst to r0/r0/r1 → 311 (conflicts with the store-value
  scratch; spills).
- flags swept (all no-op on the coloring): `-fno-{
    gcse, cse - follow - jumps, thread - jumps, rerun - cse - after - loop, strength - reduce, schedule - insns,
        defer - pop, function - cse, peephole, caller - saves}`; `-ffixed-r3` → 420; `-fno-omit-frame-
  pointer` → 481.
- `(u32)tileBase` casts REQUIRED (dropping → 339). dst operand order REQUIRED
  (rowBase<<6 first via split). col/row update: original order `if (colBase<=30)
  colBase++; else if (rowBase>30) break; else {
    colBase = 0;
    rowBase++;}` matches the
  baserom's `bls` (do NOT invert to colBase>30-first; that's +1).

## Best-effort C (byte_diff 172, ONE `asm("r2")` pin — resume from THIS)
#else
NAKED void Credits_DrawLineAlt(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x1dea0, 0x1d8\n");
}
#endif /* NON_MATCHING */
