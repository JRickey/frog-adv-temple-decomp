# Deferred analysis: sub_08013DFC

Range: 0x08013DFC-0x08013E94 (152 bytes, Thumb)

Classifier: `ATTEMPT_MATCH`. Advisory only: high regs (`r8`, `r9`, `sl`) live across
`bl sub_0801185C`. This is not `STRONG_UNMATCHABLE`, so do not ship NAKED.

## Drift

Best result remains the clean 35-byte plateau: size 152, correct prologue/high-reg save,
no pins, no asm, no volatile. The residual diff is the inner compaction and two swapped
colors:

- Baserom keeps `rnd` in `r3` and loads `gIwram_3610` into `r2`.
- Clean C keeps `rnd` in `r2`, loads `gIwram_3610` into `r3`, and CSE-folds
  `&gIwram_3610 + (j + 1)` into a hoisted `&gIwram_3610 + 1` plus separate `j++`.
- The `int next = j + 1` form fixes the inner factoring but drops to a 144-byte,
  two-high-reg prologue (`n` in `r7` instead of `r8`).

Newly ruled out in this attempt:

- `CC=$(AGBCC_BIN)` for this TU: same 144-byte allocator failure on the `int next` form.
- `-fno-gcse`: size 152 but worse allocation (`i`/limit move to `r7`/`r6`), byte_diff 54.
- `-fno-cse-follow-jumps`: neutral, still byte_diff 35.
- `-fno-rerun-cse-after-loop`: worse, size 160 and extra literal loads.
- `-fno-strength-reduce`: neutral, still byte_diff 35.
- `register u8 count asm("r8")`: restores high-reg save but grows to 160 with dead
  QImode re-extension; byte_diff 89 on the `int next` path.
- `register u32 count asm("r8")`: neutral on 35-form, worse/shrinks on `int next`.
- Scoped pins for `arr/sl`, `limit/r7`, `writeIdx/r9`, `count/r8`, `i/r4`: worse
  lifetime shape, size 168.
- `register u8 rnd asm("r3")`: grows to 164 with repeated QImode re-extension.
- `register u8 *table asm("r2")`: collapses to the two-high-reg prologue, size 144.
- Pinning both `rnd` and `table`: worse, size 156.
- Ordinary `u8 *table = &gIwram_3610`: pointer-walking shape, size 140.
- Bound pointer local `u8 *bound = &gIwram_549F`: worsens allocation, byte_diff 123.
- Typed struct view of `gIwram_53A0`: emits extra output-offset literal, size 156.
- `while` loop with explicit `i++`: still the 144-byte two-high-reg allocation.
- Output expression order `arr[0x64 + *writeIdx]`: optimized back to the same 35-form.
- Current-tree corpus has pure-C `opponents[j] = opponents[j + 1]` examples, but those use
  stack/object bases rather than this constant-symbol IWRAM base. History search could not
  run because `tools/agent/corpus-mirrors` is absent in this worktree.
- Permuter setup could not run: `vendor/decomp-permuter` has no `.venv` or package files in
  this worktree, and Python dependencies such as `tomlkit` are unavailable.

Likely root cause is still `gcc_arm/global.c::find_reg` live-range sharing plus
`gcc_arm/cse.c` address reassociation. The desired escape is to get the `int next` inner
factoring while forcing the inner bound pointer to take a fresh callee register instead of
sharing outer `i`'s `r4`, which should push `n` into `r8` and recover the baserom prologue.

Prerequisite for any C attempt: add linker symbol `gIwram_549F` at `0x0300549F` between
`gIwram_53A0` and `gIwram_60A0`. Do not leave that linker change behind when deferring.

## Best-effort C

Clean 35-byte plateau:

```c
#include "types.h"

extern u8 gIwram_53A0;
extern u8 gIwram_3610;
extern u8 gIwram_549F;
extern u8 sub_0801185C(u8 range);

enum {
    SHUFFLE_OUTPUT_OFFSET = 0x64,
    SHUFFLE_WRITE_INDEX_OFFSET = 0xFE,
    SHUFFLE_LIMIT_OFFSET = 0xFF,
};

void sub_08013DFC(u8 n)
{
    u8 i;

    for (i = 0; i < n; i++) {
        u8 *arr = &gIwram_53A0;
        u8 *limit = arr + SHUFFLE_LIMIT_OFFSET;
        u8 *writeIdx = arr + SHUFFLE_WRITE_INDEX_OFFSET;
        u8 rnd = sub_0801185C(*limit);

        arr[rnd] = 1;
        arr[*writeIdx + SHUFFLE_OUTPUT_OFFSET] = (&gIwram_3610)[rnd];
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

Correct-inner but wrong-prologue variant:

```c
        if (rnd < *limit) {
            u8 j = rnd;
            do {
                int next = j + 1;
                (&gIwram_3610)[j] = (&gIwram_3610)[next];
                j = next;
            } while (j < gIwram_549F);
        }
```
