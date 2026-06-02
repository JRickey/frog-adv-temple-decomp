#include "game.h"
#include "gba/intr.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* sub_08009D9C — per-tick entity-record advance. Called from sub_08000918
 * (the 14-case mode-state-machine). Drives a small state byte at [arg0]:
 *
 *   - First, calls sub_080004C4 to produce a value cached at
 *     0x03005398 (a "tick RNG" / per-frame seed).
 *   - If *(s8 *)arg0 == 0 (first-time init): load [gGameStuff], stash at
 *     +20 (snapshotted base?), set *arg0=1, bump gGameStuff[26] += 29,
 *     OR bit 1 into gGameStuff[0x34], cache r7=gGameStuff.
 *   - Otherwise: r1=gUnk_03003720[0]; test 0x8000 bit of [r1+0x34]; if set,
 *     toggle to (val|2) & 0x7fff and bump *arg0.
 *   - Common tail:
 *     - bl sub_080059C4 with r7 as arg (frame setup / palette refresh)
 *     - bl _call_via_r0 with ROM table 0x080c0cb8 indexed by
 *       gGameStuff[10]<<2 (state-keyed handler dispatch)
 *     - bl _call_via_r0 with ROM table 0x080c0d40 same index
 *     - bl sub_08009A58 (hit-test loop) + sub_08009188 (entity advance)
 *       + sub_080008DC (VBlank wait)
 *     - clear bit 0xfffe of [REG_IE] (top bit clear)
 *     - bl sub_0800FCC8 with arg0 = ROM byte-table 0x080c0d84[gGameStuff[10]]
 *     - bl sub_08005FC8 (?)
 *     - DMA-style call sub_0802D558 with src=0x030054a0, dst=0x07000000,
 *       count=0x100 (probably sprite OAM copy)
 *     - manually copy 6 halfwords from 0x03003550[0..5] to REG_DISPSTAT+0xc
 *       and 5 successive halfwords (BG0/BG1 affine? bg-scroll DMA write)
 *     - set bit 0 of REG_IE (or whatever sits at gUnk_03005398 — it's a
 *       u16 at the top of the function).
 *     - End-of-tick: if *arg0 != 8 AND [gUnk_03005398]==0, return 0
 *       (early-out). Else: if [r7+26] > 28 then [r7+26]-=29, OR bit 1
 *       into [r7+0x34]. If [gUnk_03005398] != 0, store it into
 *       [gUnk_030035e0+18] and return 1. Else fall through and return 0.
 *
 * Shipped NAKED + NON_MATCHING. The asm has 80+ instructions with pooled
 * loads, ROM-table indirection through _call_via_r0, and a control-flow
 * shape (two early exit paths, fallthroughs into a shared tail) that is
 * the same general pattern as the sibling fifth-class cluster
 * (sub_08009984/A58/BA0/C14 — all NAKED+NON_MATCHING). Recovering this
 * shape from pure C is out of scope for this pass; the NAKED body lands
 * byte-identical and the NON_MATCHING reference documents intent for the
 * phase-3 PC port.
 */

extern u16 sub_080004C4(void);
extern void sub_080059C4(void *a);
extern void sub_08009A58(void);
extern void sub_08009188(void);
extern void sub_080008DC(void);
extern void sub_0800FCC8(u32 a);
extern void sub_08005FC8(void);
extern void sub_0802D558(void *dst, void *src, u32 count);

NAKED u32 sub_08009D9C(u8 *arg)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    adds    r6, r0, #0\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08009D9C_pool_5398_a\n"
        "    strh    r0, [r1, #0]\n"
        "    ldrb    r3, [r6, #0]\n"
        "    movs    r0, #0\n"
        "    ldrsb   r0, [r6, r0]\n"
        "    cmp     r0, #0\n"
        "    bne     1f\n"
        "    ldr     r1, _sub_08009D9C_pool_5330_a\n"
        "    ldr     r0, [r1, #0]\n"
        "    str     r0, [r1, #20]\n"
        "    movs    r0, #1\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r0, _sub_08009D9C_pool_3720_a\n"
        "    ldrb    r1, [r0, #26]\n"
        "    adds    r1, #29\n"
        "    strb    r1, [r0, #26]\n"
        "    movs    r1, #2\n"
        "    ldrh    r2, [r0, #52]\n"
        "    orrs    r1, r2\n"
        "    strh    r1, [r0, #52]\n"
        "    adds    r7, r0, #0\n"
        "    b       2f\n"
        "    .align  2, 0\n"
        "_sub_08009D9C_pool_5398_a: .4byte 0x03005398\n"
        "_sub_08009D9C_pool_5330_a: .4byte 0x03005330\n"
        "_sub_08009D9C_pool_3720_a: .4byte 0x03003720\n"
        "1:\n"
        "    ldr     r1, _sub_08009D9C_pool_3720_b\n"
        "    ldrh    r2, [r1, #52]\n"
        "    movs    r0, #128\n"
        "    lsls    r0, r0, #8\n"
        "    ands    r0, r2\n"
        "    adds    r7, r1, #0\n"
        "    cmp     r0, #0\n"
        "    beq     2f\n"
        "    movs    r0, #2\n"
        "    orrs    r0, r2\n"
        "    ldr     r1, _sub_08009D9C_pool_7fff\n"
        "    ands    r0, r1\n"
        "    strh    r0, [r7, #52]\n"
        "    adds    r0, r3, #1\n"
        "    strb    r0, [r6, #0]\n"
        "2:\n"
        "    adds    r0, r7, #0\n"
        "    bl      sub_080059C4\n"
        "    ldr     r1, _sub_08009D9C_pool_c0cb8\n"
        "    ldr     r4, _sub_08009D9C_pool_5330_b\n"
        "    ldrb    r2, [r4, #10]\n"
        "    lsls    r0, r2, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    bl      _call_via_r0\n"
        "    ldr     r1, _sub_08009D9C_pool_c0d40\n"
        "    ldrb    r2, [r4, #10]\n"
        "    lsls    r0, r2, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    bl      _call_via_r0\n"
        "    bl      sub_08009A58\n"
        "    bl      sub_08009188\n"
        "    bl      sub_080008DC\n"
        "    ldr     r5, _sub_08009D9C_pool_ie\n"
        "    ldrh    r1, [r5, #0]\n"
        "    ldr     r0, _sub_08009D9C_pool_fffe\n"
        "    ands    r0, r1\n"
        "    strh    r0, [r5, #0]\n"
        "    ldr     r0, _sub_08009D9C_pool_c0d84\n"
        "    ldrb    r4, [r4, #10]\n"
        "    adds    r0, r4, r0\n"
        "    ldrb    r0, [r0, #0]\n"
        "    bl      sub_0800FCC8\n"
        "    bl      sub_08005FC8\n"
        "    ldr     r0, _sub_08009D9C_pool_54a0\n"
        "    movs    r1, #224\n"
        "    lsls    r1, r1, #19\n"
        "    movs    r2, #128\n"
        "    lsls    r2, r2, #1\n"
        "    bl      sub_0802D558\n"
        "    ldr     r1, _sub_08009D9C_pool_400010\n"
        "    ldr     r2, _sub_08009D9C_pool_3550\n"
        "    ldrh    r0, [r2, #0]\n"
        "    strh    r0, [r1, #0]\n"
        "    adds    r1, #2\n"
        "    ldrh    r0, [r2, #2]\n"
        "    strh    r0, [r1, #0]\n"
        "    adds    r1, #2\n"
        "    ldrh    r0, [r2, #4]\n"
        "    strh    r0, [r1, #0]\n"
        "    adds    r1, #2\n"
        "    ldrh    r0, [r2, #6]\n"
        "    strh    r0, [r1, #0]\n"
        "    adds    r1, #2\n"
        "    ldrh    r0, [r2, #8]\n"
        "    strh    r0, [r1, #0]\n"
        "    adds    r1, #2\n"
        "    ldrh    r0, [r2, #10]\n"
        "    strh    r0, [r1, #0]\n"
        "    ldrh    r0, [r5, #0]\n"
        "    movs    r1, #1\n"
        "    orrs    r0, r1\n"
        "    strh    r0, [r5, #0]\n"
        "    ldrb    r6, [r6, #0]\n"
        "    cmp     r6, #8\n"
        "    beq     3f\n"
        "    ldr     r0, _sub_08009D9C_pool_5398_b\n"
        "    ldrh    r0, [r0, #0]\n"
        "    cmp     r0, #0\n"
        "    beq     4f\n"
        "3:\n"
        "    ldrb    r0, [r7, #26]\n"
        "    cmp     r0, #28\n"
        "    bls     5f\n"
        "    subs    r0, #29\n"
        "    strb    r0, [r7, #26]\n"
        "    movs    r0, #2\n"
        "    ldrh    r1, [r7, #52]\n"
        "    orrs    r0, r1\n"
        "    strh    r0, [r7, #52]\n"
        "5:\n"
        "    ldr     r0, _sub_08009D9C_pool_5398_b\n"
        "    ldrh    r1, [r0, #0]\n"
        "    cmp     r1, #0\n"
        "    beq     6f\n"
        "    ldr     r0, _sub_08009D9C_pool_35e0\n"
        "    strh    r1, [r0, #18]\n"
        "6:\n"
        "    movs    r0, #1\n"
        "    b       7f\n"
        "_sub_08009D9C_pool_3720_b: .4byte 0x03003720\n"
        "_sub_08009D9C_pool_7fff:   .4byte 0x00007fff\n"
        "_sub_08009D9C_pool_c0cb8:  .4byte 0x080c0cb8\n"
        "_sub_08009D9C_pool_5330_b: .4byte 0x03005330\n"
        "_sub_08009D9C_pool_c0d40:  .4byte 0x080c0d40\n"
        "_sub_08009D9C_pool_ie:     .4byte 0x04000200\n"
        "_sub_08009D9C_pool_fffe:   .4byte 0x0000fffe\n"
        "_sub_08009D9C_pool_c0d84:  .4byte 0x080c0d84\n"
        "_sub_08009D9C_pool_54a0:   .4byte 0x030054a0\n"
        "_sub_08009D9C_pool_400010: .4byte 0x04000010\n"
        "_sub_08009D9C_pool_3550:   .4byte 0x03003550\n"
        "_sub_08009D9C_pool_5398_b: .4byte 0x03005398\n"
        "_sub_08009D9C_pool_35e0:   .4byte 0x030035e0\n"
        "4:\n"
        "    movs    r0, #0\n"
        "7:\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r1}\n"
        "    bx      r1\n"
        ".syntax divided\n");
}

#ifdef NON_MATCHING
/* Reference body for the phase-3 PC port. The shape mirrors the asm:
 * an init-or-advance branch on *arg, a fixed handler dispatch via two
 * ROM tables, a sprite/OAM transfer, and a late-tick state check.
 *
 * Audit (post-iter-30): permuter ran 12K iterations and improved the
 * score by 5.4% (9205 → 8705). Two mutations from the best candidate
 * are preserved below as documented improvements:
 *   - The `|= 2; &= 0x7fff;` split write (vs the combined
 *     `= (... | 2) & 0x7fff;`) — permuter found this lands closer to
 *     baserom's two-instruction `orrs + ands` than the combined form.
 *   - Wrapping the post-tail in a `do { ... } while (0)` block — a
 *     permuter trick to force a different basic-block boundary that
 *     emits slightly different epilogue code.
 * The function still does NOT match in pure C — too many simultaneous
 * register-coloring choices. NAKED below is the source-of-truth.
 */
u32 sub_08009D9C(u8 *arg)
{
    u8 *r7;

    *(u16 *)0x03005398 = sub_080004C4();

    if (*(s8 *)arg == 0) {
        /* First-time init */
        *(u32 *)(0x03005330 + 20) = *(u32 *)0x03005330;
        *arg = 1;
        r7 = (u8 *)0x03003720;
        *(r7 + 26) += 29;
        *(u16 *)(r7 + 0x34) |= 2;
    } else {
        r7 = (u8 *)0x03003720;
        if ((*(u16 *)(r7 + 0x34) & 0x8000) != 0) {
            /* Split-write form (per permuter audit, +5% score). */
            *(u16 *)(r7 + 0x34) |= 2;
            *(u16 *)(r7 + 0x34) &= 0x7fff;
            *arg += 1;
        }
    }

    sub_080059C4(r7);
    (*(void (**)(void))(0x080c0cb8 + (*(u8 *)(0x03005330 + 10) << 2)))();
    (*(void (**)(void))(0x080c0d40 + (*(u8 *)(0x03005330 + 10) << 2)))();
    sub_08009A58();
    sub_08009188();
    sub_080008DC();

    *(vu16 *)0x04000200 &= 0xfffe;
    sub_0800FCC8(*(u8 *)(0x080c0d84 + *(u8 *)(0x03005330 + 10)));
    sub_08005FC8();
    sub_0802D558((void *)0x07000000, (void *)0x030054a0, 0x100);

    /* Manually copy 6 halfwords to MMIO at 0x04000010 (BG0 scroll regs) */
    {
        vu16 *dst = (vu16 *)0x04000010;
        u16 *src = (u16 *)0x03003550;
        s32 i;
        for (i = 0; i < 6; i++) {
            dst[i] = src[i];
        }
    }

    *(vu16 *)0x04000200 |= 1;

    if (*arg != 8 && *(u16 *)0x03005398 == 0) {
        return 0;
    }

    if (*(r7 + 26) > 28) {
        *(r7 + 26) -= 29;
        *(u16 *)(r7 + 0x34) |= 2;
    }

    if (*(u16 *)0x03005398 != 0) {
        *(u16 *)(0x030035e0 + 18) = *(u16 *)0x03005398;
    }
    return 1;
}
#endif

/* sub_08009EEC — per-tick mode-state advance (sibling of sub_08009D9C).
 *
 * Drives a small state byte at *arg. First refreshes the per-frame seed at
 * gIwram_5398, then either runs a one-time init (when *arg == 0) or a
 * flag-toggle (when gIwram_3720._field_34 has bit 0x8000 set). The shared
 * tail dispatches two entity-handler tables (sEntityProcB/D) by
 * gGameStuff.pendingMode, advances the subsystems, masks VBlank, commits the
 * deferred OAM + BG-scroll state, then runs a late state-check.
 *
 * agbcc levers that carry the match (all load-bearing register pins below):
 *   - gIwram_3720's base is pinned in a high register (r8) across the whole
 *     tail of bl's, mirroring the baserom's `ldr r0; mov r8, r0` /
 *     `mov r2, r8` reload. A plain local would be spilled/reloaded.
 *   - The state byte is pinned to r3 so the unsigned read (kept for the
 *     else-branch `+1`) and the signed `== 0` test stay separate loads.
 *   - The handler dispatch reads gGameStuff through the linker-assigned
 *     gIwram_5330 symbol with an explicit `(idx << 2) + table` so agbcc
 *     emits the baserom's pendingMode chain (same idiom as sub_0800A2D8).
 *   - The else-branch flag rewrite is staged through an r0-pinned temp
 *     (`t = 2; t |= flags; t &= 0x7fff;`) so the mask result lands in r0
 *     and `& 0x7fff` loads the pooled constant instead of a shift pair.
 *   - The early `return 0` is reached via `goto ret0` to a shared bottom
 *     label so agbcc places it after the return-1 path (baserom layout).
 *
 * Built with -fforce-addr -fno-expensive-optimizations -fno-gcse (the same
 * state-byte-dispatcher flag combo as mode_15 / sub_080019B4).
 */

typedef void (*EntityProc)(void);

extern const EntityProc sEntityProcB[17];
extern const EntityProc sEntityProcD[17];
extern const u8 sEntitySubtypeLut[20];

extern void sub_0800F24C(u8 arg);
extern void sub_0801D048(u8 value);
extern void sub_0801D094(void);
extern u8 gIwram_5330;
extern u16 gIwram_5398;

u32 sub_08009EEC(u8 *arg, u8 kind)
{
    register struct IwramAt3720 *e3720 asm("r8");
    register GameStuff *initGs asm("r1");
    register struct IwramAt3720 *e3720init asm("r0");
    register struct IwramAt3720 *e3720else asm("r2");
    register struct IwramAt3720 *e3720end asm("r2");
    register GameStuff *gs asm("r5");
    register const EntityProc *procs asm("r1");
    const u8 *lut;
    u8 idx;
    u32 offset;
    register u8 nextState asm("r0");
    register u8 stateByte asm("r3");
    register u16 flags asm("r1");
    register vu16 *dst asm("r1");
    u16 *src;

    gIwram_5398 = sub_080004C4();
    stateByte = arg[0];

    if (*(s8 *)arg == 0) {
        initGs = (GameStuff *)&gIwram_5330;
        initGs->_unk14 = initGs->_unk00;
        *arg = 1;
        sub_0801D048(kind);
        e3720init = &gIwram_3720;
        e3720init->_field_1A += 29;
        e3720init->_field_34 |= 2;
    } else {
        e3720else = &gIwram_3720;
        flags = e3720else->_field_34;
        if (flags & 0x8000) {
            register u32 t asm("r0");
            t = 2;
            t |= flags;
            t &= 0x7fff;
            e3720else->_field_34 = t;
            nextState = stateByte + 1;
            *arg = nextState;
        }
    }

    e3720 = &gIwram_3720;
    sub_080059C4(&gIwram_3720);

    procs = sEntityProcB;

    gs = (GameStuff *)&gIwram_5330;
    idx = gs->pendingMode;
    offset = ((u32)idx << 2) + (u32)procs;
    ((EntityProc)(*(const u32 *)offset))();

    procs = sEntityProcD;
    idx = gs->pendingMode;
    offset = ((u32)idx << 2) + (u32)procs;
    ((EntityProc)(*(const u32 *)offset))();

    lut = sEntitySubtypeLut;
    idx = gs->pendingMode;
    sub_0800F24C(*(const u8 *)(idx + (u32)lut));

    sub_08009A58();
    sub_08009188();
    sub_080008DC();

    REG_IE &= ~IRQ_VBLANK;
    sub_0800FCC8(*(const u8 *)(gs->pendingMode + (u32)lut));
    sub_08005FC8();
    sub_0802D558((void *)0x030054a0, (void *)0x07000000, 0x100);

    dst = (vu16 *)0x04000010;
    src = (u16 *)0x03003550;
    *dst++ = src[0];
    *dst++ = src[1];
    *dst++ = src[2];
    *dst++ = src[3];
    *dst++ = src[4];
    *dst = src[5];

    REG_IE |= IRQ_VBLANK;

    if (*arg == 8)
        goto check3720;
    if (gIwram_5398 == 0)
        goto ret0;

check3720:
    e3720end = e3720;
    if (e3720end->_field_1A > 28) {
        e3720end->_field_1A -= 29;
        e3720end->_field_34 |= 2;
    }

    if (gIwram_5398 != 0) {
        gIwram_35E0._field_12 = gIwram_5398;
    }

    sub_0801D094();
    return 1;

ret0:
    return 0;
}
