# sub_0802EA2C — Deferred analysis

Range: 0x0802ea2c..0x0802ea80 (84 bytes)
Destination: src/system/sound_envelope_dual.c

## Summary

Envelope-A0 parameter setter. Sets step, countdown, and reload for
channel ch's A0 envelope. Two paths:
- ch <= 2: inline channel blocks at (*gpSoundSystem)[ch*36+54..57]
- ch == 3: no-op
- ch >= 4: dynamic swSlots via `swSlots + ch*64 - 0xec`, at slot[ch-4].envelopeA0

## Drift

**Best byte_diff: 5, diff_count: 3**

Exact mismatches:
1. fn+0x14: `adds r0, r1, r0` (0x1808) vs target `adds r0, r0, r1` (0x1840) — 1 byte (low byte 0x08 vs 0x40)
2. fn+0x1e: INSERTION of `adds r0, #56` (scheduling)
3. fn+0x20: DELETION of `adds r0, #56` (scheduling — same instruction, wrong position)

Mismatches 2+3 are a 2-instruction scheduling swap: target has `lsrs r2, r4, #1; adds r0, #56` but built has `adds r0, #56; lsrs r2, r4, #1`.

**Root cause analysis:**

First store (ch*36 inline, no prior `off` assignment):
- agbcc treats r1 (ch*36 CSE result) as "primary" in the RTL ADD node → encodes as `adds r0, r1, r0` (0x1808)
- Target requires r0 (*pss reload) as "primary" → `adds r0, r0, r1` (0x1840)

Second store scheduling: agbcc computes address offset (`adds r0, #56`) before value shift (`lsrs r2, r4, #1`). Target interleaves the shift BETWEEN the add and the constant.

**Levers tried (all in the context of maintaining byte_diff=5 for the big slot):**

1. `off = ch * 36` before first store → caused ch to move to r1 (11 bytes diff)
2. `register s32 off asm("r1")` with pre-first-store off assignment → same ch-saves problem
3. `register s32 off asm("r1")` with AFTER-first-store off assignment → same 5 bytes
4. `register u8 *ptr0 asm("r0")` + asm barrier for first store → 88 bytes (too large)
5. `u8 *base` variable for all three stores → ch moved to r3 (worse)
6. `u8 *base` for 3rd store only → fixed 3rd store encoding but not 1st and 2nd
7. `int new_var = ch * 36` after first store (permuter find) → fixed 2nd and 3rd store
8. Explicit `half = param1 >> 1` variable → register pressure (ch→r3)
9. `-fno-gcse`, `-fno-schedule-insns`, `old_agbcc` flags → no change
10. asm("" : "=r"(ptr0) : "0"((u32)ptr0)) barrier → function became 88 bytes
11. Various `asm("")` + `(u32)` casts for big slot → fixed big slot to 3 bytes diff
12. asm barriers: `asm("" : "=r"(ss) : "0"((u8 *)ss + 0xc8))` — fixes big slot to 0 bytes diff

**Working big slot pattern (asm barriers required):**
```c
register SoundSystem *ss asm("r1");
register u8 *env asm("r0");
ss = gpSoundSystem;
asm("" : "=r"(ss) : "0"((u8 *)ss + 0xc8));  /* r1 = &swSlots */
env = (u8 *)(u32)(ch << 6);  /* r0 = ch*64 */
asm("" : "=r"(env) : "0"((u32)env));
env = (u8 *)((u32)env + (u32)*(void **)ss - 0xec);
```

This forces: `ldr r1,[r0]; adds r1,#200; lsls r0,r2,#6; ldr r1,[r1]; adds r0,r0,r1; subs r0,#236`

**Permuter results:**
- Base score: 125 (initial attempt at ~75 bytes diff)
- Best score found: 95 (from score-105 base, by adding `new_var = ch * 36` after first store)
- Permuter could NOT find score=0 even after 200+ iterations from score-95/105 base
- Permuter was NOT re-run from the final byte_diff=5 base (asm barriers not permuter-compatible)

**Next agent should try:**
- Consider removing asm barriers from big slot and finding a pure-C approach that gives
  the same scheduling naturally (avoiding the asm("") complication)
- The LINKED nature of issues 1 and 2: fixing the add encoding by pre-computing off breaks
  the ldr r0 scheduling; fixing the scheduling by asm barriers in big slot works but the
  first-block issues persist
- Try: can the first store be written to get `adds r0, r0, r1`? The second store uses
  `off = ch*36` (named variable) and gets the right encoding. The first store uses
  inline `ch*36` and gets the wrong encoding. Key question: is there a way to make
  the first store reference `off` without computing it before the ldr r0?
- Try: `*(u8 *)((u8 *)*pss + off + 57)` where off is zero-initialized but ASSIGNED
  to ch*36 AFTERWARDS would be UB. But can we fake this somehow?
- Try: `-fno-rerun-cse-after-loop` or other obscure flags

## Best-effort C

```c
void sub_0802EA2C(s32 step, u32 param1, s32 ch)
{
    s32 off;

    if (ch <= 2) {
        SoundSystem **pss = &gpSoundSystem;
        *(u8 *)((u8 *)*pss + ch * 36 + 57) = param1;
        off = ch * 36;
        *(u8 *)((u8 *)*pss + off + 56) = param1 >> 1;
        *(s16 *)((u8 *)*pss + off + 54) = step;
        return;
    }
    if (ch <= 3)
        return;

    {
        register SoundSystem *ss asm("r1");
        register u8 *env asm("r0");
        ss = gpSoundSystem;
        asm("" : "=r"(ss) : "0"((u8 *)ss + 0xc8));  /* r1 = &swSlots */
        env = (u8 *)(u32)(ch << 6);  /* r0 = ch*64 */
        asm("" : "=r"(env) : "0"((u32)env));
        env = (u8 *)((u32)env + (u32)*(void **)ss - 0xec);
        *(u8 *)(env + 5) = param1;
        *(u8 *)(env + 4) = param1 >> 1;
        *(s16 *)(env + 2) = step;
    }
}
```

This C achieves byte_diff=5, diff_count=3. The remaining 5 bytes are in:
- 1 byte: `adds r0, r1, r0` (0x1808) at fn+0x14 vs target `adds r0, r0, r1` (0x1840)
- 4 bytes: scheduling swap of `lsrs r2, r4, #1` and `adds r0, #56` at fn+0x1e/0x20
