# Deferred analysis: sub_08013DFC

**Range**: 0x08013DFC–0x08013E94 (152 bytes, Thumb)
**Classifier**: ATTEMPT_MATCH — advisory: 3 high regs (r8/r9/sl) across bl (class-1 advisory only)
**Best byte_diff (this round, Opus + agbcc instrumentation)**: 99 (clean, NO pins, `i` correctly in r4)

## Algorithm (draw-without-replacement shuffle; confirmed)

`arr = gIwram_53A0` (256-byte buffer), `table = gIwram_3610` (deck being compacted):
- `arr[0xff]` = remaining size (decrements each iteration)
- `arr[0xfe]` = write-index counter (increments each iteration)
- For `n` outer iterations: pick `rnd = sub_0801185C(*size)`, mark `arr[rnd]=1`,
  copy `arr[wi+100] = table[rnd]`, `wi++`; if `rnd < *size` left-shift
  `table[rnd .. 0x549f-1]` (remove slot rnd); `(*size)--`.

Companion functions: sub_08019984 (compares gIwram_53A0 vs gIwram_3610), sub_08012100
(zeroes gIwram_53A0[1], [0xff]). The shuffle/compaction reading is solid.

## Register map (baserom — ground truth)

| reg | var | note |
|-----|-----|------|
| r4 | `i` (outer idx) | ALSO reused as inner `tbl` base after `i` dies (`adds r4,r2,#0`) |
| r5 | `nextI` (i+1 saved before inner loop) | callee-saved |
| r6 | `lim2` = `&gIwram_549F` | loaded INSIDE the inner-if (0x13e54), pool 0x0300549f |
| r7 | `limit` = `arr+0xff` | `mov r7,sl; adds r7,#0xff` once before loop |
| r8 | `count` (param n) | high reg |
| r9 | `writeIdx` = `arr+0xfe` | high reg |
| sl | `arr` = `&gIwram_53A0` | high reg |
| r2 | `table` = `&gIwram_3610` | **loaded FRESH each outer iter (NOT hoisted)**, then copied to r4 |
| r3 | `rnd` | bl result, zero-extended |

## ROOT CAUSE (new this round — instrumented agbcc, definitive)

Built a private debug `old_agbcc` (probes in `gcc/loop.c` move_movables + `gcc/global.c`
find_reg). The function is **structurally 1:1** with the baserom in pure C; the ENTIRE
diff is one register-coloring divergence that cascades:

**agbcc unconditionally HOISTS the `&gIwram_3610` load out of the outer loop into a
callee-saved register (r9), but the baserom keeps it in scratch r2, reloaded each
iteration.**

- loop.c hoist test: `threshold(=13) * savings(=1) * lifetime(=15) >= insn_count(=46)`
  → 195 ≥ 46 → ALWAYS hoists. `threshold = 1 + n_non_fixed_regs` is a per-FILE constant
  (~13 for thumb), so it cannot be lowered per-function. `savings` and `lifetime` are
  already minimal. No `-fXXX` (gcse, move-all-movables, strength-reduce, caller-saves,
  force-addr, expensive-opt) changes the hoist.
- Why the baserom does NOT hoist: its table-holding register (r2) is **reused as an
  address scratch inside the inner loop** (`adds r2,r3,r4`). That makes `set_in_loop[r2]
  != 1`, so loop.c never treats the load as a single-set movable. This is a
  REGISTER-level property that emerges from the baserom allocator's scratch reuse — and
  agbcc's CSE/GCSE collapses every `&gIwram_3610` reference to ONE value BEFORE loop.c
  runs, so the load is always single-set from any C I can write. I could not induce the
  scratch-reuse from source.

Once the table eats a callee-saved reg, the 3 high-reg vars permute:
mine `count→r6 arr→r8 writeIdx→r7 limit→r5 table→r9 lim2→sl`; baserom needs
`count→r8 arr→sl writeIdx→r9 limit→r7 lim2→r6` with table in scratch r2.
Critically, in the clean no-pin version **`i` is ALREADY correctly in r4** (priority
`log2(8)*8/66 = 0.36` > limit `0.28`); the prior round's claim that limit steals r4 was
an artifact of its pins. The sole defect is the table hoist.

## Levers tried this round (all fail)

- Clean no-pin C: **byte_diff 99**, i→r4 correct, table hoisted to r9 (BEST, readable).
- Held `lim2 = &gIwram_549F` pointer (NEW linker symbol `gIwram_549F = 0x549F`, added to
  linker.ld between gIwram_53A0 and gIwram_60A0): raises pressure, byte_diff 99.
  Without it (inner reads `(&gIwram_53A0)[0xff]` fresh): byte_diff 104.
- 3 high-reg pins (r8/r9/sl): byte_diff 117–123, grows fn (pins emit extra movs + flip
  i/limit priority by shortening limit's live range 98→55).
- `register u8 *table asm("r2")` (scratch pin): DEFEATS the hoist (HOIST:NONE) but
  prevents `i`↔`tbl` r4 coalescing and reschedules → byte_diff 117–128. Combining with
  3 high pins → 117 with i↔limit swap.
- Table set twice / reassigned in inner loop / walking pointer: CSE folds or adds insns
  → 99–123, never un-hoists cleanly.
- `-ffixed-r8/-r9/-sl`: 129 (can't place high vars). `-fno-gcse/-fno-caller-saves/
  -fno-move-all-movables/-fforce-addr/-fno-strength-reduce`: no change (99).
- decomp-permuter, ~2430 iters from the clean-99 base: base score 3345, best 1120
  (plateau, never approaches 0). Its "best" mutations are garbage (`long long`
  aliases). Statement reordering does not reach the scratch-reuse the match needs.

## Next-agent strategy (DIFFERENT levers — the above are exhausted)

1. The match hinges on getting `&gIwram_3610` into a SCRATCH register that is ALSO used
   as an address scratch in the inner loop (so `set_in_loop>1` blocks the hoist), WITHOUT
   the `asm("r2")` pin's rescheduling cost. Investigate whether a SINGLE-pointer inner
   loop that genuinely reuses the table pointer's storage as the `&table[j]` address (a
   union/aliasing trick, or computing `&table[j]` INTO `table` then restoring) can make
   agbcc reuse r2 the way the baserom does — the earlier attempts added an extra insn;
   find one that nets zero extra insns.
2. Instrument `gcc/cse.c`/`gcse.c` to see exactly where the two `&gIwram_3610` refs are
   merged into one pseudo, and whether a source shape keeps them as two pseudos (one of
   which the inner loop overwrites) past loop.c.
3. If a clean un-hoist is found, the rest should fall into place (i→r4 already correct;
   only 6 vars remain for r5–sl with the table out of the pool).

## Best-effort C (byte_diff 99, clean, NO pins — RESUME FROM HERE)

Requires NEW linker symbol: `        . = 0x0000549F; gIwram_549F = .;` in linker.ld
(IWRAM block, between gIwram_53A0 and gIwram_60A0). The `extern u8 gIwram_549F;` makes
the inner-loop limit a distinct pool constant 0x0300549f (matches the baserom's 3rd pool
entry), instead of CSE-merging with `arr+0xff`.

```c
extern u8 gIwram_53A0;
extern u8 gIwram_3610;
extern u8 gIwram_549F;
extern u8 sub_0801185C(u8 range);

void sub_08013DFC(u8 n)
{
    u8 *arr;
    u8 *limit;
    u8 *writeIdx;
    u8 *lim2;
    u8 i;

    i = 0;
    if (i >= n)
        return;

    arr = &gIwram_53A0;
    limit = arr + 0xff;
    writeIdx = arr + 0xfe;
    lim2 = &gIwram_549F;

    do {
        u8 rnd;
        u8 nextI;

        rnd = sub_0801185C(*limit);
        arr[rnd] = 1;
        arr[*writeIdx + 100] = (&gIwram_3610)[rnd];
        (*writeIdx)++;

        nextI = i + 1;

        if (rnd < *limit) {
            u8 *tbl = &gIwram_3610;
            u8 j = rnd;
            do {
                tbl[j] = tbl[j + 1];
                j++;
            } while (j < *lim2);
        }

        i = nextI;
        (*limit)--;
    } while (i < n);
}
```
