# Deferred analysis: sub_08013DFC

**Range**: 0x08013DFC–0x08013E94 (152 bytes, Thumb)
**Classifier**: ATTEMPT_MATCH — advisory: 3 high regs (r8/r9/sl) across bl (class-1 advisory only)
**Best byte_diff**: 110 (40 instruction-level mismatches), 3 high-reg pins + -fno-gcse

## Algorithm

Outer loop (`n` iterations):
1. Pick a random index `rnd` in `[0, arr[0xff])` via `sub_0801185C(arr[0xff])`
2. Set `arr[rnd] = 1`
3. Copy `gIwram_3610[rnd]` to `arr[(*writeIdx) + 100]`; increment `*writeIdx`
4. If `rnd < arr[0xff]`: left-shift `gIwram_3610[rnd..limit-1]` (remove slot `rnd`)
5. Decrement `arr[0xff]`

IWRAM addresses:
- `sl = arr = 0x030053A0` (256-byte buffer, indices 0–255)
- `arr[0xff]` = limit/size sentinel (decrements each iteration)
- `arr[0xfe]` = write-index counter (incremented each iteration; stored in r9)
- `r9 = writeIdx = arr + 0xfe`
- `gIwram_3610 = 0x03003610` = source table for copy + shift

## Register map (baserom)

| reg | variable | notes |
|-----|----------|-------|
| r4 | outer loop index `i` | u8, updated via lsl/lsr zero-extension |
| r5 | `nextI` temp (i+1 save) | unrestricted u32 before truncation to r4 |
| r6 | inner loop limit ptr `lim2` (&gIwram_549F = arr+0xff addr) | loaded from 3rd pool entry |
| r7 | outer loop limit ptr `limit` (arr+0xff) | computed as `mov r7, sl; adds r7, #255` ONCE before loop |
| r8 | `count` (parameter n, u8) | high reg across bl |
| r9 | `writeIdx` (arr+0xfe) | high reg across bl |
| sl | `arr` base (0x030053A0) | high reg across bl |
| r2 | table address (gIwram_3610) | FRESH pool load inside loop each iteration, NOT hoisted |
| r3 | `rnd` result (from bl, zero-extended) | also starting `j` in inner loop |
| r4 | inner loop tbl base (REUSED from outer index) | `adds r4, r2, #0` copies r2 to r4 inside inner if |

## Pool entries (3 entries)

1. `gIwram_53A0` → sl (arr base)
2. `gIwram_3610` → r2, loaded INSIDE the outer loop body (NOT hoisted), fresh each iteration
3. `gIwram_549F` (= arr+0xff addr) → r6, loaded inside inner if (lim2)

## Drift and root cause

With 3 high-reg pins (`r8 = count`, `r9 = writeIdx`, `sl = arr`):
- agbcc puts `limit` in r4 (highest priority: more references, longer lifetime) and `i` in r5
- The baserom needs r4=i and r7=limit
- Priority formula: `refs * log(refs) / live_length`. `limit` wins because it has more dereferences.
- Attempted: named limit vs loop-local, all variations of -ffixed-rN, 5-pin approach (r4=i + r7=limit),
  -fno-gcse, -fno-strength-reduce, inline table vs named variable, raw address vs symbol.
- None resolved the r4/r5 swap.
- The 5-pin approach (r4=i + r7=limit explicit pins) violates ARM ABI (r7 not saved in prologue).

Additionally: the table (gIwram_3610) is ALWAYS hoisted before the loop by loop.c's invariant
motion, even with -fno-gcse. The baserom loads it fresh each iteration in r2. Loop.c hoists it
because the unconditional outer copy makes its savings ≥ 1.

-fno-gcse helps by preventing the count-pre-shifting (`lsl r8, count, #24`) but doesn't stop
loop.c's table hoisting.

## Levers tried

- 3 high-reg pins (r8/r9/sl): best match, byte_diff 110
- -fno-gcse: removes count pre-shifting, keeps byte_diff at 110
- -fno-gcse + -fno-strength-reduce: no change
- -fno-gcse + -fno-cse-follow-jumps: no change
- -ffixed-r5, -ffixed-r5 -ffixed-r6: wrong allocation (still limit before i)
- 5-pin (r4=i, r7=limit + 3 high): ABI violation, byte_diff 139
- No named limit (arr[0xff] inline): prologue wrong ({r4-r6} not {r4-r7})
- Loop-local limit declaration: same allocation, table still hoisted

## Best-effort C

```c
/* 3 high-reg pins + -fno-gcse: closest match (byte_diff 110, 40 mismatches).
 * i ends up in r5 (need r4), limit ends up in r4 (need r7).
 * Table (gIwram_3610) is hoisted before loop (need it fresh in r2 each iteration). */
extern u8 gIwram_53A0;
extern u8 gIwram_549F;
extern u8 gIwram_3610;
extern u8 sub_0801185C(u8 range);

void sub_08013DFC(u8 n)
{
    register u8 count asm("r8");
    register u8 *arr asm("sl");
    register u8 *writeIdx asm("r9");
    u8 i;
    u8 *limit;

    count = n;
    i = 0;
    if (i >= count)
        return;

    arr = &gIwram_53A0;
    limit = arr + 0xff;
    writeIdx = arr + 0xfe;

    do {
        u8 rnd;
        u32 nextI;

        rnd = sub_0801185C(*limit);
        arr[rnd] = 1;

        {
            u8 wi = *writeIdx;
            arr[wi + 100] = (&gIwram_3610)[rnd];
        }
        (*writeIdx)++;

        nextI = i + 1;

        if (rnd < *limit) {
            u8 *tbl2 = &gIwram_3610;
            u8 *lim2 = &gIwram_549F;
            u8 j = rnd;
            do {
                u8 *dst = tbl2 + j;
                u8 next = j + 1;
                *dst = tbl2[next];
                j = (u8)next;
            } while (j < *lim2);
        }

        i = nextI;
        (*limit)--;
    } while (i < count);
}
```

Required Makefile flag: `src/engine/sub_08013d1c.s: CFLAGS += -fno-gcse`

## Next-agent strategy

The key to matching: force `i` into r4 and `limit` into r7 WITHOUT explicit register pins. Options:
1. Find a C structure where `i` has HIGHER priority than `limit` in agbcc's local-alloc.
   This requires `i` to have more refs/live_length ratio. One approach: reduce limit's
   live_length by putting it in a VERY narrow scope that local-alloc processes separately.
2. Instrument agbcc (see codegen-notes.md "Instrumenting agbcc itself") to understand
   exactly WHY limit gets r4 over i. Then structure C to flip the decision.
3. Use the permuter AFTER getting byte_diff ≤ 40 through structural work.
4. Also need: table (gIwram_3610) NOT hoisted before loop. The only reliable way seems to
   be making the table's use loop-VARIANT somehow, or preventing loop.c from seeing it as
   profitable to hoist. The loop body has ~35 instructions; the heuristic threshold might
   be beatable by restructuring the loop to be larger.
