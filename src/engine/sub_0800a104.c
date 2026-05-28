#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

typedef void (*GameProc)(void);

extern u16 sub_08010694(u16 arg);
extern int sub_080106B8(void);
extern u16 sub_080106EC(u16 arg);
extern int sub_08010710(void);

/* Fade-transition driver. *phase walks 0->1->2->3 across frames:
 *   0 -> kick off the fade-in (sub_08010694), advance, return 0.
 *   1 -> tick the fade-in; while it's still running return 0, and only
 *        advance once it finishes (ticker returns 0).
 *   2 -> run the caller's mid-transition callback, kick off the
 *        fade-out (sub_080106EC), advance, return 0.
 *   3 -> tick the fade-out; return 0 while it's still running, 1 once
 *        it finishes.
 * Any other phase is returned unchanged.
 *
 * Ships NAKED + #ifdef NON_MATCHING. The C body below is byte-correct
 * down to instruction selection (verified at -O2: same opcodes, same
 * order, same branch senses) but agbcc's -O2 cross-jumping tail-merges
 * phase 3's `return 0` into the shared `return 0` that phases 0/1/2 use,
 * dropping the standalone `movs r0, #0` the baserom keeps at the tail
 * (and the explicit `b` after phase 3's `return 1`). That collapses the
 * function from 84 to 80 bytes; byte_diff plateaus at 19, all of it the
 * 4-byte size delta plus the branch-target shifts it cascades into.
 * Expressing phase 3 as `return ticker() == 0` restores the 84-byte size
 * but swaps the branch-based `movs r0,#1`/`movs r0,#0` for an
 * adcs/negs-style boolean (byte_diff 53) — the two outcomes can't be had
 * together in pure C without defeating cross-jumping, which the global
 * -O2 CFLAGS don't allow per-function. */

#ifdef NON_MATCHING
int sub_0800A104(s8 *phase, GameProc callback)
{
    int p = (s8)*phase;

    if (p == 0) {
        sub_08010694(0xBF);
        goto advance;
    }
    if (p == 1) {
        if (sub_080106B8() != 0)
            return 0;
        goto advance;
    }
    if (p == 2) {
        callback();
        sub_080106EC(0xBF);
    advance:
        *phase = *phase + 1;
        return 0;
    }
    if (p == 3) {
        if (sub_08010710() != 0)
            return 0;
        return 1;
    }
    return p;
}
#else
NAKED
int sub_0800A104(s8 *phase, GameProc callback)
{
    asm(".syntax unified\n"
        "    push    {r4, lr}\n"
        "    adds    r4, r0, #0\n"
        "    movs    r0, #0\n"
        "    ldrsb   r0, [r4, r0]\n"
        "    cmp     r0, #0\n"
        "    bne     _0800A118\n"
        "    movs    r0, #191\n"
        "    bl      sub_08010694\n"
        "    b       _0800A134\n"
        "_0800A118:\n"
        "    cmp     r0, #1\n"
        "    bne     _0800A126\n"
        "    bl      sub_080106B8\n"
        "    cmp     r0, #0\n"
        "    bne     _0800A13A\n"
        "    b       _0800A134\n"
        "_0800A126:\n"
        "    cmp     r0, #2\n"
        "    bne     _0800A13E\n"
        "    bl      _call_via_r1\n"
        "    movs    r0, #191\n"
        "    bl      sub_080106EC\n"
        "_0800A134:\n"
        "    ldrb    r0, [r4, #0]\n"
        "    adds    r0, #1\n"
        "    strb    r0, [r4, #0]\n"
        "_0800A13A:\n"
        "    movs    r0, #0\n"
        "    b       _0800A150\n"
        "_0800A13E:\n"
        "    cmp     r0, #3\n"
        "    bne     _0800A150\n"
        "    bl      sub_08010710\n"
        "    cmp     r0, #0\n"
        "    bne     _0800A14E\n"
        "    movs    r0, #1\n"
        "    b       _0800A150\n"
        "_0800A14E:\n"
        "    movs    r0, #0\n"
        "_0800A150:\n"
        "    pop     {r4}\n"
        "    pop     {r1}\n"
        "    bx      r1\n"
        "    .syntax divided\n");
}
#endif
