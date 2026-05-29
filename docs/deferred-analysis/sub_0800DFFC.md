# Deferred analysis: sub_0800DFFC (slice 0x0800dffc..0x0800e048, 76 bytes)

The slice `asm/disasm_0x0800dffc.s` is **three** separate signed-16-bit
fixed-point helpers, not one function (detect-fn-boundary peeled the whole
range as one symbol):

| addr        | name          | semantics                  | bx |
|-------------|---------------|----------------------------|----|
| 0x0800dffc  | sub_0800DFFC  | `(a * b) / 256`  (8.8 mul)  | `bx lr` (leaf) |
| 0x0800e014  | sub_0800E014  | `(a * b) / 0x10000` (16.16) | `bx lr` (leaf) |
| 0x0800e030  | sub_0800E030  | `((s32)a << 8) / b` (8.8 div via `__divsi3`) | frame |

The single callee `0x08033d14` is `__divsi3` (already peeled, linker.ld:540).

## What MATCHES

- **sub_0800E030 is a byte-exact pure-C match** under `old_agbcc`:
  `return ((s32)a << 8) / b;` produces `push {lr} … bl __divsi3 …
  pop {r1}; bx r1` identical to baserom.
- The **`old_agbcc` per-TU override is required** (Makefile:
  `src/engine/sub_0800dffc.s: CC = $(OLD_AGBCC_BIN)`). Default `agbcc`
  wraps the two leaf functions in the spurious `push {lr}; pop {r1}; bx r1`
  frame (the known join-point-exit bug — docs/codegen-notes.md "old_agbcc
  vs agbcc"). `old_agbcc` correctly emits `bx lr` for the leaves.

## Drift (the blocker — sub_0800DFFC and sub_0800E014 only)

Pure register-coloring difference in gcc's **signed-division-by-power-of-2
RTL expander**. The baserom makes an EAGER non-destructive copy of the
product; both `agbcc` and `old_agbcc` bias the product in place (r0).

Baserom sub_0800DFFC:
```
muls r0, r1
adds r1, r0, #0      ; <-- eager copy: keep product in r0, dividend in r1
cmp  r0, #0          ; test ORIGINAL product (r0)
bge  .L
adds r1, #255        ; bias the COPY (r1)
.L: lsls r0, r1, #8  ; result = (r1 << 8) >> 16  -> r0
asrs r0, r0, #16
bx lr
```
Our build (old_agbcc, `return a * b / 256;`):
```
muls r0, r1
cmp  r0, #0
bge  .L
adds r0, #255        ; bias IN PLACE (r0)
.L: lsls r0, r0, #8
asrs r0, r0, #16
bx lr
```
sub_0800E014 is the same drift; baserom additionally loads the 0xffff bias
into **r2** and does the three-register `adds r1, r0, r2` (product r0 stays
live, dividend r1, mask r2). The 1-instruction-shorter body in our build
also shifts the func2 literal-pool alignment.

Whole-slice byte_diff with the simplest source: **31 / 76** (all in the two
leaf bodies; sub_0800E030 + lengths are exact, both 76 bytes).

## Levers already tried (ALL fail to produce the eager copy)

Reach for a DIFFERENT lever than these:
- `return a * b / 256;` (simplest)            -> bias in place (r0)
- `s32 prod = a*b; return prod / 256;`         -> optimized away, in place
- `register s32 prod asm("r1") = a*b; …`       -> pin ignored, in place
- explicit `if (r<0) r += 0xff; return r>>8;`  -> coalesced, in place
- two-variable `s32 t=p; if(p<0)t+=…; t>>n`    -> coalesced (t==p dead), in place
- ternary `(p<0 ? p+0xff : p) >> 8`            -> coalesced, in place
- `b*a` operand swap                           -> flips input narrow order only
- `(s16)(a*b/256)` explicit narrow cast        -> in place
- branchless `(p>>31)&0xff`                    -> wrong (branchless) shape
- `-O1`                                        -> in place
- default `agbcc` (not old)                    -> in place + spurious frame

CONFIRMED mechanism: the eager copy ONLY appears when the product is
genuinely **live past the divide** (e.g. `s32 p=a*b; s32 r=p/256; if
(p==0x7fffffff) r=0; return r;` emits `add r0, r1, #0`). Baserom has NO
later use of the product, yet keeps the copy — i.e. the baserom compiler's
divmod expander makes the copy *unconditionally*, ours only under a real
later-use / register-pressure. This is a fixed per-compiler-version
behavior we cannot drive from clean C with either available agbcc binary.

Permuter NOT run: it mutates C statement order / scope / temps, none of
which can change which physical register `expand_divmod` picks for the
dividend. The drift is below the C level.

Corpus: `csm3:src/main.c:603 return a * b >> 8;` exists but uses a plain
arithmetic shift (no `+255` round-toward-zero bias) — different op. No
corpus C reproduces the eager-copy signed-`/256` form.

## Next idea to try

A THIRD agbcc build (a different pret/agbcc snapshot than the two we have)
may match the baserom's divmod expander. If/when one is added to
`tools/agbcc/`, point this TU at it via a per-`.s` `CC=` override and retry
`return a * b / 256;` / `return a * b / 0x10000;` directly — the structure
is already correct, only the expander's register choice differs.

## Best-effort C

```c
#include "types.h"

/* Three signed-16-bit fixed-point helpers packed into one slice.
 * sub_0800E030 is a byte-exact match under old_agbcc; the two leaf
 * multiplies drift only in gcc's divmod-expander dividend register. */

/* 8.8 fixed-point multiply: (a * b) >> 8. */
s16 sub_0800DFFC(s16 a, s16 b)
{
    return a * b / 256;
}

/* 16.16 fixed-point multiply: (a * b) >> 16. */
s16 sub_0800E014(s16 a, s16 b)
{
    return a * b / 0x10000;
}

/* 8.8 fixed-point divide: (a << 8) / b. */
s16 sub_0800E030(s16 a, s16 b)
{
    return ((s32)a << 8) / b;
}
```

linker.ld + Makefile changes needed when this is finally matched:
- linker.ld: collapse `src/engine/sub_0800dffc.o(.text);` +
  `asm/disasm_0x0800dffc.o(.text)` into the single src .o line.
- Makefile: add `src/engine/sub_0800dffc.s: CC = $(OLD_AGBCC_BIN)`.
- rm asm/disasm_0x0800dffc.s.
