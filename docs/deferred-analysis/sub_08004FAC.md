# sub_08004FAC — deferred analysis (round 52)

mode-22 scene handler (`gGameStuff.mode == GAME_MODE_SCENE_22`). Sibling of
`sub_08002844` (mode_15.c) and `sub_08002AE8`: a `while (mode == 22) { sub_08020BC0();
switch (state) {0..9} }` dispatcher with the canonical scene state machine. The asm
`mov pc, r0` at 0x08004fe0 is the C `switch` (10-entry inline .text jump table at
0x4fec). VERDICT from classify_unmatchable.py: ATTEMPT_MATCH (NOT structurally
unmatchable). Do NOT ship NAKED.

## Status

Structurally complete, readable C reaches **byte_diff 80 / diff_count 22** (size-correct,
788 bytes, no layout cascade). All 10 cases decoded and correct; cases 0-4 and 6-9 are
byte-exact in size. The residual is pure agbcc register-coloring / CSE that resisted
every source-level lever tried (no permuter available — see below).

## Drift (what does NOT work — pick a DIFFERENT lever next time)

Three independent residual coloring sites, all in the `while`-loop body / case 5:

1. **Entry `state = 0`** (4 diffs): target `ldr r0=&state; movs r1=#0; strb r1,[r0]`
   (address in r0, value in r1). agbcc default emits the SWAP (`ldr r1=&state; movs r0=#0;
   strb r0,[r1]`). The mode_15 idiom (`register u8 *statepInit asm("r0")` + volatile store)
   FIXES the register choice but SHIFTS THE STACK LAYOUT (the large 0x300-byte buf frame
   reallocates → byte_diff jumps to ~700). Any `register asm()`/volatile on state at entry
   blows up the frame. NEXT: try a `statep`-pointer rewrite where the WHOLE function uses
   `*statep` (like mode_15) AND the frame is a single struct sized so statep lands without
   reallocating buf — i.e. fix layout and entry together, not entry alone.

2. **case 5 `sub_08009C14(&state)` + `state = 8`** (the 4-byte / 2-instr site): baserom
   materializes `&state` (= sp+0x301) TWICE — once into r4 (kept callee-saved for the
   `state = 8` store) and a SEPARATE `ldr r0=&state; add r0,sp` for the call arg, with the
   r5/r7/r6 BE18-pointer setup computed between them. agbcc here CSE-folds `&state` to ONE
   register and reuses it (`adds r0,r4`), saving 2 bytes. Tried: `u8 *sp2=&state` alias,
   `register u8 *cp asm("r0")` pin, reordering q0/q1 after the call, `-fno-cse-follow-jumps`,
   `-fno-rerun-cse-after-loop`, `-fno-cse-skip-blocks` — none force the double-materialize
   (it's a reload-pass rematerialization-under-pressure decision, gcc_arm/reload.c). NEXT:
   read gcc_arm/reload.c rematerialize logic; or permuter (it mutates exactly this).

3. **case 5 buf1 (= sp+0x180)**: SOLVED in the topfence variant (below) — `u32 off = 0x180;
   asm("" : "+r"(off));` at case-5 top makes agbcc materialize `movs r7,#0xc0; lsls r7,#1`
   and use `add r0,sp,#384` for the 1st buf1 and `mov r1,sp; adds r0,r1,r7` for the 2nd
   (matching baserom). WITHOUT the fence, agbcc CSE-caches the pointer in one reg (377).
   WARNING: pinning `off` to r7 directly (`register u32 off asm("r7")`) triggers an agbcc
   reload BUG that rematerializes off as `lsl r7, sp, #1` (garbage). Use the unpinned
   `off` + `asm("" : "+r"(off))` fence form only. The topfence variant has case-5 buf1 AND
   case 9 byte-exact; its only residual is (1) + (2), but the (2) double-load makes it
   4 bytes short (cascade → byte_diff 376). So topfence is structurally closer but
   numerically worse than v80.

## Tooling gap

The permuter — the correct tool for these coloring/reload residuals — is UNAVAILABLE:
main's `vendor/decomp-permuter` is a broken self-referential symlink (points to itself),
so the submodule was never populated and no `.venv` exists. A private venv built from the
source still hits the self-symlink. FIX THE SUBMODULE (`git submodule update --init
vendor/decomp-permuter` in main, then `bash scripts/setup-decomp-permuter.sh`) before the
next attempt; from byte_diff 80 (v80) or the topfence base, the permuter should close it.

## Callee signatures (all peeled, confirmed)

```c
extern void sub_08020BC0(void);
extern u32 sub_0800A214(void);
extern u8 sub_0800A104(u8 *localState, u32 callbackTable);   /* case 1: 0x080052CD, case 8: 0x0800A26D */
extern void sub_0801B514(u32 arg);
extern void sub_0800A258(u32 arg);
extern u32 sub_08009D9C(u8 *localState);
extern void sub_08006600(u8 *base, u32 selector, u32 bit);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_0800A2D8(void); sub_080008DC(); sub_0800A328(); sub_080094F8(); sub_08009984();
extern void sub_08004D10(u8 *buf0, u32 *out0, u8 *buf1, u32 *out1);  /* buf0=sp, out0=sp+0x304, buf1=sp+0x180, out1=sp+0x30c */
extern u32 sub_08009C14(u8 *localState);
extern void sub_0800BE18(u8 *slots, u32 *out, s8 type);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg); u8 sub_080106B8(void);
extern void sub_08015A00(void); void sub_0800DE80(void);
```

Frame layout (788 bytes): `u8 buf[0x300]` @0, `s8 accept` @0x300, `u8 state` @0x301,
`u32 out0[2]` @0x304, `u32 out1[2]` @0x30c. `handle` (sub_0800A214 result) lives in r8
across the loop (case 0 sets, cases 2 & 8 pass to sub_0800A258). case 9 = `gEntities[22].status |= 8`.

## Best-effort C (byte_diff 80, size-correct — the v80 base)

```c
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_08020BC0(void);
extern u32 sub_0800A214(void);
extern u8 sub_0800A104(u8 *localState, u32 callbackTable);
extern void sub_0801B514(u32 arg);
extern void sub_0800A258(u32 arg);
extern u32 sub_08009D9C(u8 *localState);
extern void sub_08006600(u8 *base, u32 selector, u32 bit);
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
    u8 buf[0x300];
    s8 accept;
    u8 state;
    u32 out0[2];
    u32 out1[2];
    register u32 handle asm("r8");

    state = 0;

    while (gGameStuff.mode == GAME_MODE_SCENE_22) {
        sub_08020BC0();

        switch (state) {
        default:
            goto tail;
        case 0:
            gGameStuff.pendingMode = 15;
            handle = sub_0800A214();
            state = 1;
            accept = 0;
            break;
        case 1:
            if (sub_0800A104((u8 *)&accept, 0x080052CD) == 0)
                goto finalize;
            state = 2;
            gGameStuff._unk14 = 0;
            accept = 0;
            goto finalize;
        case 2:
            sub_0801B514(15);
            sub_0800A258(handle);
            state = 3;
            break;
        case 3:
            if (sub_08009D9C((u8 *)&accept) == 0)
                goto tail;
            state = 4;
            gGameStuff._unk14 = 0;
            sub_08006600((u8 *)&gIwram_6110, 3, 4);
            break;
        case 4: {
            gIwram_5398 = sub_080004C4();
            if (gIwram_5398 == 0x40) {
                state = 6;
                sub_0800E060();
                goto tail;
            }
            if ((gEntities[0].status & 8) != 0) {
                state = 5;
                goto tail;
            }
            if ((gIwram_6110.inputFlags & 8) != 0) {
                state = 9;
                goto tail;
            }
            {
                register u32 *p0 asm("r4") = out0;
                register u32 *p1 asm("r5") = out1;
                sub_0800A2D8();
                sub_080008DC();
                sub_0800A328();
                sub_080094F8();
                sub_08009984();
                sub_08004D10(buf, p0, buf + 0x180, p1);
            }
            gGameStuff._unk14++;
            break;
        }
        case 5: {
            register u32 *q0 asm("r5") = out0;
            register u32 *q1 asm("r6") = out1;
            register u8 *maskp asm("r4");
            u32 off = 0x180;
            if (sub_08009C14(&state) == 0)
                state = 8;
            gIwram_6110.scenePhase = 0;
            gIwram_6110.byteFlags8 = 0;
            gIwram_6110.gateByte = 0;
            maskp = &gIwram_6110.spawnMask;
            if (*maskp == 1) {
                sub_0800BE18(buf, q0, 29);
                sub_0800BE18(buf + 0x180, q1, 30);
                if (*maskp == 1) {
                    sub_0800BE18(buf, q0, 29);
                    asm("" : "+r"(off));
                    sub_0800BE18(buf + off, q1, 30);
                }
            }
            accept = 0;
            break;
        }
        case 6:
            gIwram_5398 = sub_080004C4();
            if (sub_0800E6A8() == 0) {
                state = 7;
                accept = 0;
            }
            if (gIwram_5328 != 0)
                goto tail;
            state = 4;
            break;
        case 7: {
            s32 counter;
            if (accept == 0) {
                sub_08010694(0xBF);
                accept++;
            }
            counter = (s8)accept;
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
            if (sub_0800A104((u8 *)&accept, 0x0800A26D) == 0)
                goto finalize;
            state = 3;
            gGameStuff._unk14 = 0;
            accept = 0;
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
    }
}
```
