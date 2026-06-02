# Deferred Analysis: sub_0801CEC0

## Function Overview
- Range: 0x0801CEC0 – 0x0801CF18 (88 bytes, Thumb leaf)
- Purpose: decimal string-to-integer with bounded length
  - Args: `const char *str` (r0), `u8 len` (r1)
  - Returns: decimal integer value, or -1 if non-digit found
  - Uses u8 arithmetic throughout (digit *= 10 for positional weighting)

## Drift
- **byte_diff: 4** (2 halfwords at offsets 0x42 and 0x44)
- Target: `lsls r0, r4, #24; lsrs r1, r0, #24` (0620 0e01)
- Mine:   `lsls r1, r4, #24; lsrs r1, r1, #24` (0621 0e09)
- Both compute `r1 = (u8)r4` (i = (u8)next_i) after the inner loop
- The difference: target uses r0 as the intermediate for the first shift;
  my code uses r1 directly (in-place since r1 is the destination)

## Root Cause
The target was likely compiled WITHOUT a `register ... asm("r1")` pin on `i`.
Without the pin, agbcc allocates `i` to some register and when computing
`(u8)r4 -> r1`, it sees r1 as LIVE (still holding the old `i` value until the
(u8)r4 cast writes it). So it uses r0 (dead, lowest available) as temp.

With `register u32 i asm("r1")`, agbcc knows r1 is the DESTINATION and uses
r1 directly as the intermediate (in-place), generating `lsls r1, r4, #24`.

## Inner Loop Structure (both match correctly)
The function has a very specific inner loop pattern:
1. Before inner loop: `adds r4, r1, #1` (next_i = i+1 stored in r4)
2. `exp = len - i` (in r0 via `subs r0, r5, r1; subs r0, #1`)
3. Initial check: `cmp r3, r0; bge done` (j >= exp → skip)
4. Save exp: `adds r1, r0, #0` (r1 = exp, reusing i's register)
5. Inner loop body: r0 used for digit*10 computation
6. Back-check: `cmp r3, r1` (j vs saved_exp)
7. After loop: `lsls r0, r4, #24; lsrs r1, r0, #24` (i = (u8)next_i)

The save instruction (`adds r1, r0, #0`) exists because exp (in r0) will be
trashed by the inner loop mult, but exp is needed for the back-edge check.
agbcc reuses r1 (old i) for saved_exp since i+1 is already in r4.

## Levers Tried
- `register u32 i asm("r1")` pin — correct overall layout but wrong 2 bytes
- Various exp types: `s32`, `u32`, `u8`, `int`
- Two-step exp computation: `exp = len - i; exp--;`
- Explicit `saved_exp` variable with block scoping
- Block-scoped `register s32 exp asm("r0")` — correct r0/r4 usage but inner loop
  uses r1 as scratch (misses the `adds r1, r0, #0` save instruction)
- Block-scoped `register s32 exp asm("r0")` + `s32 saved_exp` — CLOSEST match
  (42/44 halfwords correct, but `lsls r1, r4, #24` instead of `lsls r0, r4, #24`)
- `goto done/error` structure — correct code layout
- `for(;;)` vs `do-while` loop — same result
- Various declaration orderings and block scopes
- Per-TU flags: `-fno-schedule-insns` (not supported by old_agbcc)
- Switching from old_agbcc to agbcc — same result
- Permuter: base score 10 (= 2 register differences), ran for 45s, no improvement found

## Best-Effort C
The C below matches 42/44 halfwords (88/92 bytes correct), with only the
`lsls r1, r4, #24; lsrs r1, r1, #24` vs `lsls r0, r4, #24; lsrs r1, r0, #24`
difference remaining:

```c
#include "macros.h"
#include "types.h"

s32 sub_0801CEC0(const char *str, u8 len)
{
    register u32 i asm("r1");
    u32 result;
    u32 digit;
    u8 val;
    u8 j;

    result = 0;
    i = 0;

    if (result >= len)
        goto done;

    for (;;) {
        s32 saved_exp;

        digit = (u8)(str[i] - 0x30);

        if (digit > 9)
            goto error;

        {
            s32 exp;
            val = digit;
            j = 0;
            exp = len - i;
            exp--;

            if (j < exp) {
                saved_exp = exp;
                do {
                    val = (u8)(val * 10);
                    j = (u8)(j + 1);
                } while (j < saved_exp);
            }
        }

        result += val;
        i = (u8)(i + 1);

        if (i >= len)
            break;
    }

done:
    return result;

error:
    return -1;
}
```

## Next Approach to Try
The next agent should try WITHOUT the `register asm("r1")` pin on `i`, but 
find a way to ensure agbcc naturally assigns i to r1. One approach: after
`lsrs r5, r1, #24` (extracting len), immediately set `i = 0` (which reuses r1).
The variable declaration order matters. Or use `-ffixed-r4` flag to prevent
agbcc from using r4 for i (which might push it to r1 instead).

Also try: `-ffixed-r4 -ffixed-r3` (with no register pins) to force r1 for i
and r2-range for j/digit, leaving r4 free for next_i computation.
