# Deferred analysis: sub_08013DFC

**Range**: 0x08013DFC–0x08013E94 (152 bytes, Thumb)
**Classifier**: ATTEMPT_MATCH — advisory: 3 high regs (r8/r9/sl) across bl (class-1 advisory only). NOT STRONG_UNMATCHABLE → must NOT ship NAKED.
**Best byte_diff**: 99 (prior Opus round, clean) / 103 (this round, for-loop form, cleaner & 1 closer in diff_count)

## Algorithm (draw-without-replacement shuffle; confirmed, re-derived from asm this round)

`arr = gIwram_53A0` (256-byte buffer), `table = gIwram_3610` (deck being compacted):
- `arr[0xff]` = remaining size (`limit`, decremented each outer iter); also reachable as `gIwram_549F` (0x53A0+0xFF == 0x549F)
- `arr[0xfe]` = write-index counter (`writeIdx`, incremented each outer iter)
- For `n` outer iterations: `rnd = sub_0801185C(*limit)`; mark `arr[rnd]=1`;
  copy `arr[*writeIdx + 100] = table[rnd]`; `(*writeIdx)++`; if `rnd < *limit`
  left-shift `table[rnd .. *lim2-1]` by one (remove slot rnd); `(*limit)--`.
  The inner-loop limit `*lim2` reads the SAME byte as `*limit` but via a distinct
  pool literal 0x0300549f (so it needs a separate `gIwram_549F` linker symbol to
  avoid CSE-merging with `arr+0xff`).

`nextI = i+1` is saved before the inner loop because the inner loop reuses `i`'s
register (r4) as the table base — a register-pressure artifact, not semantics.

## ROOT CAUSE — definitive this round (DIRECT compiler instrumentation, gated patch)

The divergence is TWO agbcc -O2 optimizations the baserom does NOT have, and
**defeating either from source is impossible; defeating the hoist in the compiler
makes the match WORSE.**

1. **loop.c hoists the `&gIwram_3610` constant-address load out of the outer loop**
   into a callee-saved reg (sl). It is a single-set loop-invariant; agbcc's CSE
   merges every `&gIwram_3610` reference to ONE pseudo before loop.c, so it is
   always single-set → always hoisted. No source shape, flag, or pin avoids this.

2. **combine merges `&tbl[j]` and `&tbl[j+1]` into a walking pointer** (`adds r0,
   base,j; ldrb [r0,#1]; strb [r0,#0]`). The baserom instead computes BOTH
   addresses as separate `index+base` sums (`adds r2,j,base; adds r1,j,#1;
   adds r0,r1,base`) — the UNMERGED dual-index form. agbcc's combine merges them
   regardless of how the C splits the load/store or names j+1. There is no
   `-fno-combine` in gcc 2.x.

### Instrumentation proof (this round)
Built a private debug `old_agbcc` from `tools/agbcc-src/gcc/loop.c` (NOT gcc_arm/ —
old_agbcc/agbcc come from `gcc/`, only cc1=agbcc_arm comes from `gcc_arm/`) with an
env-gated patch (`AGBCC_NOHOIST`) that skips treating SYMBOL_REF/CONST+PLUS loads as
movable. Result with hoist removed: **byte_diff 131, size 144** (vs 152 baserom) —
WORSE than the hoisted 103. The function loses 8 bytes because the inner loop is
still the walking-pointer form (shorter), and removing the hoist reshuffles the
register file into a different non-matching layout. So the hoist is NOT the sole
defect; the dual-index inner loop is independently unreachable. Sandbox deleted.

## Levers tried (ALL fail — exhausted across two Opus rounds)

Prior round: clean no-pin C 99; lim2-held pointer 99; 3 high-reg pins 117-123;
`register table asm("r2")` 117-128; double-assign / walking / reassign 99-123;
`-ffixed-r8/r9/sl` 129; `-fno-gcse/-fno-caller-saves/-fno-move-all-movables/
-fforce-addr/-fno-strength-reduce` no change (99); permuter 2430 iters base 3345
best 1120 (plateau).

This round (sub_08013DFC moved to its OWN TU `src/engine/sub_08013dfc.c` so per-TU
CFLAGS/compiler-swap are SAFE — they no longer disturb the 3 matching functions in
sub_08013d1c.c):
- for-loop + plain `i++` form: **byte_diff 103, diff_count 51** (BEST diff_count, cleanest C).
- array-index globals (no table ptr cache): 118.
- tbl/lim2 declared inside the if (un-hoists lim2 via single-use deletion, table
  still hoisted): 104.
- double-assign `tbl=&g; ...; tbl=&g`: CSE folds the second → 131.
- `tbl2 = tbl` copy in inner: copy-prop folds → 104.
- separate load temp `v = tbl[j+1]; tbl[j]=v`: combine still merges to walking ptr.
- explicit `k=j+1; tbl[j]=tbl[k]; j=k`: +1 insn (156 bytes), 133.
- scratch-reg pins table `asm("r1"/"r2"/"r3")`: 127 each (defeats hoist but pin reg is
  caller-saved → reloaded after the bl anyway + reschedule).
- high-reg pins n=r8/writeIdx=r9/arr=sl: 123 (pins emit extra movs, grow fn to 164).
- FULL flag sweep on OLD_AGBCC: `-fno-strength-reduce`, `-fno-gcse`, both, `-fno-force-mem`(121),
  `-fforce-addr`(121), `-fno-expensive-optimizations`, `-fcaller-saves`,
  `-fno-omit-frame-pointer`(103), `-O1`(103), `-O3` — none below 103.
- NEW agbcc (AGBCC_BIN) + flag combos: 104-121.

## Corpus
`testyourmine/cvaos` (Konami, same agbcc) `code_08039340.c:3351` does the SAME
draw-without-replacement compaction `subroutine_arg0[var_r3] = subroutine_arg0[var_r3+1]`
in pure C — BUT its base is a PARAMETER pointer (already in a register, not hoisted,
and addressed differently). Our base is a CONSTANT global → hoisted + merged. The
prior art does not transfer; it confirms the constant-global is the discriminator.

## Next-agent strategy (genuinely DIFFERENT levers — everything above is exhausted)

The baserom's UNMERGED dual-index inner loop + non-hoisted constant load together
are characteristic of a compiler that did neither optimization. Hypotheses to test
that this round did NOT try:
1. **A different agbcc revision / a `gcc/loop.c`+`combine.c` behavior probe**: the
   baserom may have been built by an agbcc whose combine does not merge adjacent
   byte addresses. Instrument `combine.c` (try_combine / the address +1 fold) to
   confirm whether ANY -fXXX or a small source change keeps the two addresses
   separate. If a source shape keeps `&tbl[j]` and `&tbl[j+1]` as two pseudos past
   combine, the dual-index emerges and only the hoist remains.
2. **Make `table` genuinely NON-invariant** so loop.c never hoists AND combine sees
   two addresses: e.g. derive the table base from a value that changes per outer
   iteration but algebraically equals `&gIwram_3610` WITHOUT agbcc simplifying it
   back (a volatile-laundered base, or a base read from a memory slot the loop
   writes). Risk: extra insns. Net-zero-insn version is the bar.
3. If both remain unreachable, this is a true "compiler built differently" case —
   keep DEFERRED (do NOT NAKED: classifier is ATTEMPT_MATCH, not STRONG_UNMATCHABLE).

## Best-effort C (byte_diff 103, clean, NO pins/asm/flags — RESUME FROM HERE)

Requires NEW linker symbol `        . = 0x0000549F; gIwram_549F = .;` in linker.ld
(IWRAM block, between gIwram_53A0 and gIwram_60A0) so the inner-loop limit is a
distinct pool constant 0x0300549f (matches the baserom's 3rd pool entry). Best to
put this function in its OWN TU `src/engine/sub_08013dfc.c` (wired in linker.ld after
`src/engine/sub_08013d1c.o(.text)`) so any per-TU flag/compiler experiment does not
disturb the 3 already-matching functions in sub_08013d1c.c.

```c
extern u8 gIwram_53A0;
extern u8 gIwram_3610[];
extern u8 gIwram_549F;
extern u8 sub_0801185C(u8 range);

void sub_08013DFC(u8 n)
{
    u8 *arr;
    u8 *limit;
    u8 *writeIdx;
    u8 i;

    arr = &gIwram_53A0;
    limit = arr + 0xff;
    writeIdx = arr + 0xfe;

    for (i = 0; i < n; i++) {
        u8 rnd;

        rnd = sub_0801185C(*limit);
        arr[rnd] = 1;
        arr[*writeIdx + 100] = gIwram_3610[rnd];
        (*writeIdx)++;

        if (rnd < *limit) {
            u8 *tbl = gIwram_3610;
            u8 *lim2 = &gIwram_549F;
            u8 j = rnd;
            do {
                tbl[j] = tbl[j + 1];
                j++;
            } while (j < *lim2);
        }

        (*limit)--;
    }
}
```
