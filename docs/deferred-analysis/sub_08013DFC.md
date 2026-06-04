# Deferred analysis: sub_08013DFC

**Range**: 0x08013DFC–0x08013E94 (152 bytes, Thumb)
**Classifier**: ATTEMPT_MATCH — advisory: 3 high regs (r8/r9/sl) across bl (class-1
advisory only). NOT STRONG_UNMATCHABLE → must NOT ship NAKED.
**Best byte_diff this round (Opus retry): 35, diff_count 23, size 152 (EXACT)** —
a 3x improvement over the prior plateau (99/103). Pure C, no pins/asm/flags.
RESUME FROM THE "## Best-effort C (byte_diff 35)" BLOCK BELOW, not the prior 103 form.

## What changed this round vs prior rounds (the plateau escape that worked)

The prior rounds' root-cause was INVERTED. Re-tracing the baserom asm directly:
- `&gIwram_53A0` (arr) IS hoisted to sl — correct, expected (arr/limit/writeIdx all
  derive from it and are used every outer iteration).
- `&gIwram_3610` (table) is NOT hoisted — it is reloaded via `ldr r2,[pc]` at 0x13e3a
  INSIDE the outer loop body, every iteration. The prior note claimed loop.c hoists it;
  it does not. The prior C used `u8 *tbl = gIwram_3610` (a hoistable/walkable local),
  which IS what got hoisted+walked. Using the literal `(&gIwram_3610)[...]` at every use
  site stops both the hoist AND the walking-pointer merge — this is the key escape and
  what drops byte_diff from 103 to 35.

Two more structural fixes that mattered:
1. Compute `arr`/`limit`/`writeIdx` INSIDE the outer-loop body (not before the loop).
   This makes loop.c place the invariant load AFTER the `cmp i,n; bcs end` entry guard
   (baserom only loads arr if the loop runs >= once), fixing the top-of-function diff.
2. `for (i=0;i<n;i++)` (NOT a while with explicit i++). The for-loop lets agbcc split the
   induction-var update (`nextI=i+1` early, `(u8)` truncation at the bottom) like baserom.

## Remaining drift at byte_diff 35 (ONE root cause + its coloring cascade)

The 35-form is structurally PERFECT: dual-index inner loop, correct hoist placement,
correct algorithm, EXACT 152-byte size, 68 instructions (same count as baserom). All 23
remaining diffs are a SINGLE CSE decision plus the register coloring it forces:

**ROOT CAUSE (confirmed by direct agbcc RTL instrumentation this round, `-dc -ds`):**
In the inner copy `(&gIwram_3610)[j] = (&gIwram_3610)[j+1]`, CSE materializes the SRC
address as `(&gIwram_3610 + 1) + j` — i.e. it creates a `const (plus (symbol_ref G)
(const_int 1))` pseudo (the `.cse` dump shows `REG_EQUAL (const:SI (plus (symbol_ref
"G") (const_int 1)))`). The baserom instead computes `j+1` ONCE and reuses it for BOTH
the src address (`(j+1)+G`) AND the new loop value (`j = (u8)(j+1)`) — the unmerged
dual-index form with a single G base.

So: baserom keeps ONE table base (G) + a live `j+1`; agbcc-35 keeps TWO bases (G and
G+1) + a separate `j+1` for the increment. Same instruction count, different factoring.
This cascades into the register coloring: agbcc colors {rnd/j=r2, table=r3}; baserom
colors {rnd/j=r3, table-outer=r2, table-inner=r4 (reuses freed i-reg)}.

**Why the obvious fix fails:** writing `u8 t = j+1; (&G)[j]=(&G)[t]; j=t;` produces the
EXACT baserom `j+1`-reuse form in a MINIMAL repro (verified: even with an outer for-loop
and an outer `(&G)[k]` read present). But in the FULL function it regresses to byte_diff
~119-132 (the named temp `t` adds register pressure that tips the allocator into a
walking-pointer merge). The `(&G)[j+1]` literal form (no temp) is the lower-pressure
choice and gives 35, but CSE then folds `G+1`. There is a register-pressure cliff: the
full function's live set (arr/sl, writeIdx/r9, n/r8, limit/r7 + i + table) is just dense
enough that CSE prefers the `G+1` const over a live `j+1`, while the minimal repro is not.

## Levers tried this round (ALL stall at >= 35; everything else regresses)

- Loop forms: for / while+i++ (51) / do-while inner / `++j` in cond — for-loop = 35.
- arr/limit/writeIdx inside vs outside loop — INSIDE = 35 (fixes top), outside = 55.
- Inner copy variants: `[j+1];j++` = 35 (best); `u8 k=j+1` = 130; `int t=j+1;j=t` = 133;
  `u8 t=j+1;j=t` = 119-132; `dst=j;j++;[dst]=[j]` = 130; `v=[j+1];[j]=v` = 59;
  `[j]=[1+j]` = 35 (commutative no-op); `(&G+j)[1]` walks; explicit `(u32)&G + j` cast = 127.
- Table access: `(&gIwram_3610)[...]` literal = 35 (REQUIRED); `extern u8 g[]; g[...]` = 134
  (hoists base); `u8 *table=&g` local = 129 (walks); `u8 *p=&g` inside the if = 103 (walks).
- writeIdx line `arr[*writeIdx+0x64]`: `(arr+0x64)[*writeIdx]` = 35 (agbcc reassociates
  `+sl` before `+0x64` regardless — minor 1-2 byte diff, not fixable from source);
  `int wpos=...` temp = 84 (regresses).
- Reorder `arr[rnd]=1` vs table-read = 48; read table into `picked` temp = 84.
- Register pins: rnd asm("r3") = 113; rnd+j asm("r3") = 118 (pins force a mov from r0).
- Flags (per-TU, OLD_AGBCC default): -fno-strength-reduce / -fno-gcse / -fforce-addr /
  -fno-expensive-optimizations / -fno-schedule-insns / -fno-schedule-insns2 /
  -fno-cse-follow-jumps / -ffixed-r2 / -ffixed-r3 — ALL = 35 (no effect; the fold is core
  -O2 CSE, no `-fno-cse` granularity reaches it). -O1 / -fno-force-mem / -fno-peephole = 125
  (regress). NEW agbcc (AGBCC_BIN) + flag combos = 35 or worse.
- Inner bound via `*limit` (r7) instead of the `gIwram_549F` constant = 126 (the distinct
  0x0300549f pool literal IS required — needs the linker symbol below).
- Permuter: base score 640 (for byte_diff 35 — the scorer weights the cascade heavily),
  ~6 min / >1000 iters, plateaued at best 475. Only cosmetic mutations (do/while(0) wrap,
  side-effect assign); NO structural escape. The minimum is unreachable by mutation.

## Next-agent strategy (genuinely DIFFERENT from anything tried)

The minimal-repro proof is the lead: the `u8 t=j+1; ...[t]; j=t;` form gives the EXACT
baserom dual-index IN ISOLATION; the full function only fails it on register PRESSURE.
So the path is to REDUCE inner-loop pressure so `j+1` stays live instead of CSE folding
`G+1`. Untried pressure-reduction ideas:
1. Free a low register during the inner loop. The baserom holds arr=sl, writeIdx=r9,
   n=r8 in HIGH regs across the inner loop, and reuses the freed i-register (r4) for the
   inner table base. Try `-ffixed-r2` or `-ffixed-r3` COMBINED with the `u8 t=j+1;j=t`
   form (this round tested -ffixed only with the 35-form, where it was a no-op — NOT with
   the t-form, where freeing a reg might let `j+1` survive).
2. Force the OUTER table read and the INNER table base to be the SAME pseudo held in a
   callee-saved reg across the inner loop (baserom's r4). A `register u8 *tbl asm("r4")`
   pin on a table local — but only if it does not re-trigger the walk. Untested combo.
3. Instrument agbcc's CSE (`cse.c` fold_rtx / the const-materialization of
   `plus(symbol,const)`) in a PRIVATE sandbox to find the pressure threshold, then shed
   exactly one live value (e.g. recompute `*limit`/`*writeIdx` instead of caching the
   pointers) to drop under it WITHOUT growing the function past 152 bytes.

If pressure cannot be shed without growing the function, this is a genuine
register-pressure-dependent CSE minimum — keep DEFERRED (do NOT NAKED; ATTEMPT_MATCH).

## Prerequisites for the best-effort C

Requires a NEW linker symbol in linker.ld's IWRAM block, between gIwram_53A0 and
gIwram_60A0, so the inner-loop bound is the distinct pool constant 0x0300549f the baserom
uses (3rd pool entry), instead of CSE-merging with arr+0xff (r7):

    . = 0x000053A0; gIwram_53A0 = .;
    . = 0x0000549F; gIwram_549F = .;
    . = 0x000060A0; gIwram_60A0 = .;

And this function in its OWN TU `src/engine/sub_08013dfc.c`, wired in linker.ld AFTER
`src/engine/sub_08013d1c.o(.text)` (replacing the `asm/disasm_0x08013dfc.o(.text)` line),
so per-TU CFLAGS/compiler-swap experiments do not disturb the 3 matching functions in
sub_08013d1c.c.

## Algorithm (draw-without-replacement shuffle / left-shift deck compaction)

`arr = gIwram_53A0` (256-byte buffer), `table = gIwram_3610` (deck being compacted):
- `arr[0xff]` (= gIwram_549F) = remaining deck size (`*limit`, decremented each outer iter)
- `arr[0xfe]` = output write-index (`*writeIdx`, incremented each outer iter)
- For `n` outer iterations: `rnd = sub_0801185C(*limit)` (random in [0,*limit));
  mark `arr[rnd]=1`; emit `arr[*writeIdx+0x64] = table[rnd]`; `(*writeIdx)++`;
  if `rnd < *limit` shift `table[rnd..*limit-1]` left by one (remove slot rnd);
  `(*limit)--`.

## Best-effort C (byte_diff 35) — RESUME FROM HERE

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
