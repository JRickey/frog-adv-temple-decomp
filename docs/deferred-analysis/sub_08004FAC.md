# sub_08004FAC — deferred analysis (round 2 / Opus escalation)

> **Update (2026-06-06):** the standalone asm slice `asm/disasm_0x08004fac.s` was
> absorbed into this function's TU `src/game/sub_08004fac.c` as an `#else` NAKED `.incbin`
> (matching bytes unchanged) and the slice file removed. The readable C stays under
> `#ifdef NON_MATCHING` in that TU — resume the match there.

mode-22 scene handler (`gGameStuff.mode == GAME_MODE_SCENE_22`). Canonical
scene state machine: `while (mode == 22) { sub_08020BC0(); switch (state)
{0..9} }`. The `mov pc, r0` at 0x08004fe0 is the C `switch` (10-entry inline
.text jump table at 0x4fec, physical case order == numeric order 0..9).
VERDICT from classify_unmatchable.py: ATTEMPT_MATCH (NOT structurally
unmatchable). Do NOT ship NAKED.

## Status

**byte_diff 74 / diff_count 19** (size-correct, 788 bytes, no layout cascade).
This BEATS the prior round-52 attempt (80/22). The improvement came from
RE-DERIVING from the matching large-frame sibling **`src/game/sub_08004938.c`**
(mode-21 handler) instead of tweaking the v80 near-match.

What is now BYTE-EXACT that was NOT in the round-52 v80:
- **Entry `state = 0`** (was residual #1, 4 diffs): FIXED. The fix is the
  sub_08004938 idiom — a STRUCT frame (not separate locals) + `{ u8 *statep;
  register u8 zero asm("r1"); statep = &frame.state; zero = 0; *(volatile u8
  *)statep = zero; }` + `goto tail;` + `do {...} while (mode == 22)` +
  `switch (frame.state) { default: goto tail; ... }`. The struct frame is what
  makes the statep/volatile entry idiom NOT shift the stack (separate-locals +
  statep reorganizes the frame -> byte_diff ~700; struct keeps it fixed).
- **Case 3** (`state=4` + `_unk14=0`): FIXED via `*(volatile u8 *)&frame.state
  = 4;` (volatile store stops agbcc from hoisting the `_unk14=0` value `movs
  r2,#0` ahead of the state store).

## Drift (what does NOT work — the remaining 19 diffs, all reload/CSE/coloring)

Three residual sites, ALL in case 5 + case 9, ALL pure agbcc reload-pass /
allocator-foresight artifacts that resist every source-level lever. The
permuter (the correct tool) is STILL BROKEN in the repo — `vendor/decomp-
permuter` is a self-referential symlink (points to itself), submodule never
initialized, no `.venv`. FIX THE SUBMODULE FIRST next round.

1. **case 5 `&state` double-materialization** (the dominant cluster, ~6 diffs
   at +0x1a8..+0x1b8). baserom materializes `&frame.state` (= sp+0x301) TWICE:
   `ldr r4=0x301; add r4,sp` (kept callee-saved for the `state=8` store) AND a
   SEPARATE `ldr r0=0x301; add r0,sp` for the `sub_08009C14(&state)` arg, with
   out0(r5)/0x180(r7)/out1(r6) hoisted BETWEEN them. agbcc instead materializes
   ONCE into r0 (call arg) and COPIES to r4 (`adds r4,r0,#0`) — single
   materialize + copy. This is reload rematerialization-under-pressure
   (gcc_arm/reload1.c `reg_equiv_address`): baserom's `&state` pseudo got
   spilled+rematerialized because out0/out1/0x180 consume the callee-saved
   regs between the two uses; agbcc keeps it in r4. TRIED (all fail to force
   the double-materialize): `statep asm("r4")` pin (causes the copy), plain
   `frame.state = 8` store (v76, still single+copy), `asm("":"+r"(statep))`
   fence with/without `:"memory"` clobber, opaque `callp` for the arg
   (`asm("":"+r"(callp))` -> 82/39 worse), lazy q0/q1 assignment. NEXT: read
   gcc_arm/reload1.c spill/rematerialize decision and find what register
   pressure shape forces it; OR permuter (it mutates exactly this).

2. **case 5 first `buf+0x180` CSE-fold** (2 diffs at +0x1e8). baserom uses the
   IMMEDIATE `add r0,sp,#0x180` for the FIRST pair's second-buf, and `mov
   r1,sp; adds r0,r1,r7` (via r7=0x180) only for the SECOND pair's second-buf.
   agbcc CSE-folds 0x180 into r7 at the case-5 top and reuses r7 for BOTH.
   TRIED: `asm("":"+r"(off))` fence before the 2nd-pair use (folds anyway);
   `register u32 off asm("r7")` pin (triggers the agbcc reload BUG that
   rematerializes off as `lsl r7, sp, #1` — garbage; confirmed AGAIN, do NOT
   r7-pin off); scoping off to the inner `if` only (uninit `u32 off;` ->
   byte_diff 693 spill cascade). The first pair must lower `frame.buf + 0x180`
   to the immediate form while the second uses r7 — agbcc won't split them.

3. **case 9 offset register** (2 diffs at +0x2da). `gEntities[22].status |= 8`
   = `*(u16*)((u8*)gEntities + 0x504) |= 8`. baserom: `ldr r0=base; ldr r2=off;
   adds r0,r0,r2; movs r1,#8; ...` (offset in r2, r1 RESERVED for the `8`
   even though `movs r1,#8` is emitted AFTER the adds). agbcc puts the offset
   in r1 (first free), then `8` reuses r1. Allocator foresight: baserom skips
   r1 for the short-lived offset because r1 will hold the longer-lived `8`.
   TRIED: `u16 bit=8` first / `register u16 bit asm("r1")` — both get the
   offset into r2 correctly BUT force `movs r1,#8` to be emitted FIRST (before
   the base load), which baserom emits AFTER the adds. Net worse (80-86).
   Cannot get "reserve r1 + materialize late" from C.

NB: the `bl 0x9c14` (`fd56`/`fd57`) and `bl 0xbe18` (`fe42`/`fe43`) OPCODE_
MISMATCHes and the `bne 0x5170/0x516e` ARG mismatches are NOT real — they are
relative-offset deltas that resolve once the size shifts above them close.

## Callee signatures (all peeled, confirmed) + frame

```c
extern void sub_08020BC0(void);                                   /* per-frame tick */
extern u32  sub_0800A214(void);                                   /* -> handle (kept in r8) */
extern u8   sub_0800A104(u8 *localState, u32 callbackTable);      /* case1 0x52CD, case8 0xA26D */
extern void sub_0801B514(u32 arg);
extern void sub_0800A258(u32 handle);
extern u32  sub_08009D9C(u8 *localState);
extern void sub_08006600(void *base, u32 selector, u32 bit);
extern u16  sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_0800A2D8(void); sub_080008DC(); sub_0800A328(); sub_080094F8(); sub_08009984();
extern void sub_08004D10(u8 *buf0, u32 *out0, u8 *buf1, u32 *out1); /* buf0=buf,out0,buf1=buf+0x180,out1 */
extern u32  sub_08009C14(u8 *localState);
extern void sub_0800BE18(u8 *slots, u32 *out, s8 type);
extern u8   sub_0800E6A8(void);
extern u8   sub_08010694(u8 arg); u8 sub_080106B8(void);
extern void sub_08015A00(void); void sub_0800DE80(void);
```

Frame (788 bytes, single struct so layout is fixed): `u8 buf[0x300]` @0,
`s8 accept` @0x300, `u8 state` @0x301, `u8 pad[2]`, `u32 out0[2]` @0x304,
`u32 out1[2]` @0x30c. `handle` (sub_0800A214 result) is plain `u32 handle`
(agbcc naturally colors it r8, no pin needed). case 9 = `gEntities[22].status
|= 8` (= base+0x504). `default: goto tail;` in the switch generates the
`cmp #9; bls; b tail` bound check that matches cases 0-4 exactly.

## Best-effort C (byte_diff 74 — the v74 base; entry + case 3 + cases 0-2,4,6-8 byte-exact)

```c
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_08020BC0(void);
extern u32 sub_0800A214(void);
extern u8 sub_0800A104(u8 *localState, u32 callbackTable);
extern void sub_0801B514(u32 arg);
extern void sub_0800A258(u32 handle);
extern u32 sub_08009D9C(u8 *localState);
extern void sub_08006600(void *base, u32 selector, u32 bit);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_08004D10(u8 *buf0, u32 *out0, u8 *buf1, u32 *out1);
extern u32 sub_08009C14(u8 *localState);
extern void sub_0800BE18(u8 *slots, u32 *out, s8 type);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_08015A00(void);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void sub_08004FAC(void)
{
    struct {
        u8 buf[0x300];
        s8 accept;
        u8 state;
        u8 pad[2];
        u32 out0[2];
        u32 out1[2];
    } frame;
    u32 handle;

    {
        u8 *statep;
        register u8 zero asm("r1");
        statep = &frame.state;
        zero = 0;
        *(volatile u8 *)statep = zero;
    }
    goto tail;

    do {
        sub_08020BC0();
        switch (frame.state) {
        default:
            goto tail;
        case 0:
            gGameStuff.pendingMode = 15;
            handle = sub_0800A214();
            frame.state = 1;
            frame.accept = 0;
            break;
        case 1:
            if (sub_0800A104((u8 *)&frame.accept, 0x080052CD) == 0)
                goto finalize;
            *(volatile u8 *)&frame.state = 2;
            gGameStuff._unk14 = 0;
            frame.accept = 0;
            goto finalize;
        case 2:
            sub_0801B514(15);
            sub_0800A258(handle);
            frame.state = 3;
            break;
        case 3:
            if (sub_08009D9C((u8 *)&frame.accept) == 0)
                goto tail;
            *(volatile u8 *)&frame.state = 4;
            gGameStuff._unk14 = 0;
            sub_08006600(&gIwram_6110, 3, 4);
            break;
        case 4: {
            gIwram_5398 = sub_080004C4();
            if (gIwram_5398 == 0x40) {
                frame.state = 6;
                sub_0800E060();
                goto tail;
            }
            if ((gEntities[0].status & 8) != 0) {
                frame.state = 5;
                goto tail;
            }
            if ((gIwram_6110.inputFlags & 8) != 0) {
                frame.state = 9;
                goto tail;
            }
            {
                register u32 *p0 asm("r4") = frame.out0;
                register u32 *p1 asm("r5") = frame.out1;
                sub_0800A2D8();
                sub_080008DC();
                sub_0800A328();
                sub_080094F8();
                sub_08009984();
                sub_08004D10(frame.buf, p0, frame.buf + 0x180, p1);
            }
            gGameStuff._unk14++;
            break;
        }
        case 5: {
            register u8 *statep asm("r4") = &frame.state;
            register u32 *q0 asm("r5") = frame.out0;
            register u32 *q1 asm("r6") = frame.out1;
            register u8 *maskp asm("r4");
            u32 off = 0x180;
            if (sub_08009C14(&frame.state) == 0)
                *statep = 8;
            gIwram_6110.scenePhase = 0;
            gIwram_6110.byteFlags8 = 0;
            gIwram_6110.gateByte = 0;
            maskp = &gIwram_6110.spawnMask;
            if (*maskp == 1) {
                sub_0800BE18(frame.buf, q0, 29);
                sub_0800BE18(frame.buf + 0x180, q1, 30);
                if (*maskp == 1) {
                    sub_0800BE18(frame.buf, q0, 29);
                    asm("" : "+r"(off));
                    sub_0800BE18(frame.buf + off, q1, 30);
                }
            }
            frame.accept = 0;
            break;
        }
        case 6:
            gIwram_5398 = sub_080004C4();
            if (sub_0800E6A8() == 0) {
                frame.state = 7;
                frame.accept = 0;
            }
            if (gIwram_5328 != 0)
                goto tail;
            frame.state = 4;
            break;
        case 7: {
            s32 counter;
            if ((s8)frame.accept == 0) {
                sub_08010694(0xBF);
                frame.accept += 1;
            }
            counter = (s8)frame.accept;
            if (counter != 1)
                goto tail;
            if (sub_080106B8() != 0)
                goto tail;
            gIwram_3480._data[0] = 4;
            gIwram_3480._data[6] = counter;
            gGameStuff.mode = GAME_MODE_ROUTER;
            break;
        }
        case 8:
            if (sub_0800A104((u8 *)&frame.accept, 0x0800A26D) == 0)
                goto finalize;
            *(volatile u8 *)&frame.state = 3;
            gGameStuff._unk14 = 0;
            frame.accept = 0;
            sub_0800A258(handle);
        finalize:
            sub_080008DC();
            break;
        case 9:
            gEntities[22].status |= 8;
            sub_08015A00();
            sub_0800DE80();
            break;
        }

    tail:;
    } while (gGameStuff.mode == GAME_MODE_SCENE_22);
}
```
