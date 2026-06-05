# Deferred analysis: sub_08013DFC

**Range**: 0x08013DFC–0x08013E94 (152 bytes, Thumb)
**Classifier**: ATTEMPT_MATCH — advisory: 3 high regs (r8/r9/sl) across bl (class-1
advisory only). NOT STRONG_UNMATCHABLE → must NOT ship NAKED.
**Best byte_diff this round (Opus retry #2): 35 CLEAN (no levers); 30 with `-ffixed-r2`
(but that lever is structurally INCOMPATIBLE — see below).**
RESUME FROM THE "## Best-effort C" BLOCK BELOW. The drift is now ROOT-CAUSED via direct
agbcc global-allocator instrumentation (gcc/global.c `find_reg`) — read "## Instrumented
root cause" before trying anything; it tells you EXACTLY which allocator decision diverges.

## What this round established (instrumentation-backed — the definitive picture)

Two complementary CLEAN forms, neither matches, and they are mutually exclusive:

1. **35-form** (`(&G)[j] = (&G)[j+1]; j++;`): byte_diff **35**, size 152 (EXACT),
   **3 high regs (correct prologue)**. Drift is the INNER loop only: agbcc CSE folds the
   source address `&G + (j+1)` into a HOISTED loop-invariant `&G+1` (an `adds rX, table,
   #1` before the inner loop) + a SEPARATE `j++`. Baserom instead computes `j+1` ONCE and
   reuses it for BOTH the src address AND the new `j`. This fold is core -O2 CSE
   (`simplify_plus_minus` reassociates `symbol + var + const` → `(symbol+const) + var`);
   confirmed UNREACHABLE by any `-fno-*` flag (gcse/cse-follow-jumps/strength-reduce/
   force-addr/expensive-opt all = 35 or worse). NOTE: the 35-form ALSO has rnd in r2 /
   table in r3, SWAPPED vs baserom's rnd=r3 / table=r2 (the prior note missed this — the
   first diff is at 0x2c `lsrs r3`(target) vs `lsrs r2`(built)).

2. **int-t form** (`int t = j+1; (&G)[j] = (&G)[t]; j = t;`): byte_diff **133**, size 144,
   **only 2 high regs (WRONG prologue, `push {r6,r7}`)**. But the INNER loop is now
   STRUCTURALLY PERFECT — single table base + a shared `j+1` value, EXACTLY baserom's
   factoring (verified by objdump: `adds r0,j,#1`; `adds dst,j,table`; `adds src,jp1,
   table`). The `int t` (NOT `u8 t`) is the key: `u8 t` truncates `t` early (extra
   lsls/lsrs before the address); `int t` truncates only at `j = t`, matching baserom.
   So **`int t` SOLVES the inner fold cleanly.** Its only failure is the OUTER allocation
   regressing to 2 high regs.

**The escape that worked before was wrong-headed.** The 35-form's 3 high regs are a SIDE
EFFECT of the fold: the hoisted `&G+1` is an extra live value that raises register
pressure enough to spill `n` to r8. Remove the fold (int-t) and that pressure vanishes →
n drops to a low reg → 2 high regs. So "no fold + 3 high regs" is the target and no single
clean source shape reaches it.

## Instrumented root cause (NEW — built a private debug agbcc, probed gcc/global.c)

Probe at `reg_renumber[allocno_reg[allocno]] = best_reg;` in gcc/global.c `find_reg`,
compiled the int-t form with the instrumented old_agbcc. Pseudo→hard-reg map:
- pseudo22 = **n** (zero-extended param) → **r7**  (baserom wants r8)
- pseudo27 = **i** (loop counter) → r4
- pseudo60 = **&gIwram_549F** (inner bound-ptr) → **r4 (SHARES with i!)**
- pseudo29 = limit-ptr (arr+0xFF) → r6
- pseudo28 = arr → r9 ;  pseudo30 = writeIdx-ptr → r8 ;  pseudo34 = rnd → r2 ; 41 = table → r3

Allocation order (priority): `50 34 52 41 60 27 73 29 22 30 28`. n (pseudo22) is allocated
9th. Before it, the callee-class (r4-r7) pseudos used only **3 distinct callee regs**
(r4 via 60+27 SHARED, r5 via 73, r6 via 29) → n gets the next free callee, **r7**.

**THE divergence:** the inner **bound-ptr (pseudo60) REUSES i's freed r4** instead of
taking a 4th distinct callee reg. In the baserom, **`table` reuses freed-i's r4** and the
bound-ptr takes a FRESH r6 → that is the 4th distinct callee value → n is forced to r8 →
3 high regs, and the rnd/table coloring falls into r3/r2.

Why agbcc differs: baserom loads `table` into a CALLER reg (r2) for the outer read, then
COPIES it to r4 AFTER i dies (r4 = r2+0), because the inner dst-addr clobbers r2. agbcc
instead keeps `table` in r3 (caller) the whole if-block (inner dst-addr uses r2, so r3 is
never clobbered → no copy → table never claims a callee reg → bound grabs the freed r4).

## Levers tried this round (ALL fail to bridge "no fold + 3 high regs")

- int-t + `-ffixed-r2` = **30** (best number) but STRUCTURALLY INCOMPATIBLE: baserom USES
  r2 in 3 places (table-outer, dst-inner); -ffixed-r2 forbids it, so the 30 residual is
  exactly those r2-usages shifted to r4/r3 + i→r5. CANNOT reach 0 with -ffixed-r2.
- int-t + `-ffixed-r3/r4/r5/r6/r7` = 81/38/36/34/40 (all worse, all shift coloring wrong).
- int-t + `-ffixed-r0/r1` = 81.  int-t no-flag = 133.
- cnt pin `register u8 cnt asm("r8") = n` (force n high directly): 83-89 — gives the
  CORRECT prologue + correct inner, BUT a u8-register re-truncation artifact emits a DEAD
  `mov r0,r8; lsls r4,r0,#24` (twice) and pushes i→r5. `register u16/u32/int cnt` = 88/125
  (worse). The dead trunc is the QImode hard-reg re-extension; no shape killed it.
- pin i asm("r4") = 125; pin table asm("r4") (pointer) = 130 (hoists/walks).
- pointer table local `u8 *table=&G` (to get a callee-reg table): always WALKS (loop.c
  strength-reduces `table[j]`/`table[j+1]` to incrementing ptrs, size 140-148) OR hoists
  table to a persistent callee reg (still only 2 high regs). `-fno-strength-reduce` stops
  the walk but the form then either keeps 2 high regs (130) or grows (49 w/ -ffixed-r2).
- inner `u8 *p = table` copy (mimic baserom r4=r2 copy) + -fno-strength-reduce: size 156
  (agbcc emits a SEPARATE symbol load for p instead of a register copy) → 131.
- bound via pointer `u8 *bound=&gIwram_549F` (permuter's best mutation, score 640→470):
  helps the bound-check bytes on the 35-form but does NOT change the n-allocation; = 132
  on int-t.
- Compiler swap (AGBCC_BIN new agbcc): 132-133, no help.
- Permuter from the 35-form base (4 min, ~1000 iters, -j4): base 640 → best **470**, NO
  zero. Only cosmetic mutations (the bound-ptr one). Confirms no mutation escape — this is
  a coloring MINIMUM, not a coloring tail.

## Next-agent strategy (genuinely DIFFERENT, informed by the instrumented root cause)

The lever is now precise: make **`table` reuse i's freed r4** (so the bound-ptr is forced
to a 4th distinct callee reg → n spills to r8 → 3 high regs → rnd/table fall into r3/r2).
Equivalently: get agbcc to load `table` into a CALLER reg (r2) for the outer read and
COPY it to a callee reg for the inner (baserom's `r4 = r2+0`), NOT keep it in r3 the whole
if-block. Untried angles:
1. Force the inner dst-address to use the SAME caller reg that holds `table` (r3), so
   table MUST evacuate to a callee reg (the freed r4) before the inner loop — e.g. a source
   shape where the dst pointer and the table share a coloring class. (The baserom evacuates
   because the dst-addr clobbers r2=table.)
2. A `register u8 *p asm("r4")` COPY of the table for the inner ONLY (not the outer), where
   the outer read uses the literal — but force it to be a register COPY (`adds r4,r2,#0`)
   not a fresh symbol load. The 156-byte failure was agbcc re-loading the symbol; need to
   make it copy the already-live value. Try assigning `p` from a `u8 *table` that the OUTER
   read also uses (so the value is live → copy, not reload), + `-fno-strength-reduce`, and
   accept/trim the size.
3. Instrument gcc/global.c further: the decision is the conflict graph + allocation
   priority. Watch WHY pseudo60(bound) coalesces onto i's r4 (live-range copy / reg_share
   logic, the "CYGNUS LOCAL live range" block right after the probe site). If bound's
   live range can be made to OVERLAP i's (so they conflict and can't share), bound takes a
   fresh reg. e.g. reference `i` (or nextI) once more INSIDE/after the inner loop to extend
   its live range past the bound load.
4. The cnt-pin (`register u8 cnt asm("r8")=n`) gets the prologue + inner BOTH right; the
   ONLY residual is the dead u8-trunc `lsls r4` ×2 + i→r5. If that re-truncation can be
   killed (a shape where cnt is read without QImode re-extension — maybe compare `i != cnt`
   via a pre-masked SImode value, or keep cnt's high bits provably zero), this path likely
   closes to 0. This is the most promising untried direction — the prior round only tried
   cnt with the u8-t inner (83); with int-t it's 89 but the dead-trunc is the SOLE blocker.

If none sheds the pressure / kills the dead-trunc without growing past 152 bytes, this is
a genuine register-pressure-dependent allocation minimum — keep DEFERRED (do NOT NAKED;
ATTEMPT_MATCH). The corpus proves the left-shift idiom (`opponents[j]=opponents[j+1]`,
pret pokeruby contest_2.c, pokeemerald contest.c) is pure-C matchable — but those use a
STACK array (frame-relative base, not a constant symbol_ref), which is why they don't fold.

## Prerequisites for the best-effort C

Requires a NEW linker symbol in linker.ld's IWRAM block, between gIwram_53A0 and
gIwram_60A0, so the inner-loop bound is the distinct pool constant 0x0300549f the baserom
uses (3rd pool entry), instead of CSE-merging with arr+0xFF:

    . = 0x000053A0; gIwram_53A0 = .;
    . = 0x0000549F; gIwram_549F = .;
    . = 0x000060A0; gIwram_60A0 = .;

And this function in its OWN TU `src/engine/sub_08013dfc.c`, wired in linker.ld replacing
the `asm/disasm_0x08013dfc.o(.text)` line with `src/engine/sub_08013dfc.o(.text)` (right
after `src/engine/sub_08013d1c.o(.text)`), so per-TU CFLAGS experiments don't disturb the
3 matching functions in sub_08013d1c.c.

## Algorithm (draw-without-replacement shuffle / left-shift deck compaction)

`arr = gIwram_53A0` (256-byte buffer), `table = gIwram_3610` (deck being compacted):
- `arr[0xFF]` (= gIwram_549F) = remaining deck size (`*limit`, decremented each outer iter)
- `arr[0xFE]` = output write-index (`*writeIdx`, incremented each outer iter)
- For `n` outer iterations: `rnd = sub_0801185C(*limit)` (random in [0,*limit));
  mark `arr[rnd]=1`; emit `arr[*writeIdx+0x64] = table[rnd]`; `(*writeIdx)++`;
  if `rnd < *limit` shift `table[rnd..*limit-1]` left by one (remove slot rnd);
  `(*limit)--`.

## Best-effort C — RESUME FROM HERE

Two forms below. The **35-form** is the cleanest base (byte_diff 35, NO levers, correct
prologue). The **int-t form** has the correct INNER loop (use its inner once you crack the
outer 3-high-reg allocation per the strategy above).

35-form (byte_diff 35, no levers — correct prologue, folded inner):
```c
#include "types.h"

extern u8 gIwram_53A0;
extern u8 gIwram_3610;
extern u8 gIwram_549F;
extern u8 sub_0801185C(u8 range);

void sub_08013DFC(u8 n)
{
    u8 i;

    for (i = 0; i < n; i++) {
        u8 *arr = &gIwram_53A0;
        u8 *limit = arr + 0xFF;
        u8 *writeIdx = arr + 0xFE;
        u8 rnd = sub_0801185C(*limit);

        arr[rnd] = 1;
        arr[*writeIdx + 0x64] = (&gIwram_3610)[rnd];
        (*writeIdx)++;

        if (rnd < *limit) {
            u8 j = rnd;
            do {
                (&gIwram_3610)[j] = (&gIwram_3610)[j + 1];
                j++;
            } while (j < gIwram_549F);
        }

        (*limit)--;
    }
}
```

int-t inner (correct inner factoring — combine with whatever cracks the 3-high-reg outer):
```c
        if (rnd < *limit) {
            u8 j = rnd;
            do {
                int t = j + 1;
                (&gIwram_3610)[j] = (&gIwram_3610)[t];
                j = t;
            } while (j < gIwram_549F);
        }
```
