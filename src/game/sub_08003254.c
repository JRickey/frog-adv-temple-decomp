#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* sub_08003254 — per-tick scene-step for one game-mode branch. Called from
 * sub_0800336C (the mode-state-machine at 0x08003498).
 *
 *   - sub_08007660(6) + sub_08007DD0() — frame/state setup.
 *   - Branch on the word at 0x03006110[+16] (a scene-phase selector):
 *       == 0 -> sub_0800793C(24, 24)   (intro / spawn)
 *       == 2 -> sub_080031D4(2)
 *   - sub_08008174() + sub_080090B0() + sub_0800A4D0() — subsystem ticks.
 *   - Handler dispatch through sEntityProcB[gGameStuff.pendingMode]().
 *   - Again branch on 0x03006110[+16]:
 *       == 0 -> sub_0800F24C(sEntitySubtypeLut[pendingMode])
 *       else -> sub_08002EE8((s8)sEntitySubtypeLut[pendingMode], arg)
 *   - Handler dispatch through sEntityProcD[gGameStuff.pendingMode](),
 *     then sub_08009A58 / sub_08009188 / sub_080008DC / sub_0800A328 /
 *     sub_080094F8 / sub_08009984.
 *   - Late-tick check: when neither bit 4 of gIwram_3720[+0x34] is set
 *     and 0x03006110[+16] == 2, query sub_0800CD88 over the entity tile
 *     coords; if its result is 2 and gGameStuff._unk10 bit 0 is clear,
 *     fire sub_08006B88(0x030035e0, 0x400) + sub_08020C78(93).
 *   - gGameStuff._unk14++ on every tick.
 *
 * Matching notes (old_agbcc):
 *   - The newer agbcc allocates the dispatch-table index in r0/r1 and uses
 *     ldrsb for the subtype byte. old_agbcc keeps the gGameStuff base in r4/r5
 *     and lets us reuse it as the index, producing the baserom's r2/r4/r3
 *     scratch-register shape and ldrb + lsls/asrs sign extension.
 *   - The 0x03006110 tests use short-lived local base pointers so agbcc emits
 *     pool loads of 0x03006110 followed by `ldr [base,#0x10]`, instead of
 *     folding the address to 0x03006120.
 *   - The function-pointer dispatches are spelled through byte addresses so
 *     the table index is materialized before the indirect call helper.
 *   - The final sub_0800CD88 argument bundle is written as GNU C statement
 *     expressions and this TU is compiled with -ffixed-r3. Together they make
 *     old_agbcc use r6, not r3, as the first ldrsh offset scratch while still
 *     passing the fourth argument in r3. */

typedef void (*GameProc)(void);

#define FIXED_ARG_U8(reg, expr)                                                                                        \
    ({                                                                                                                 \
        register u8 value asm(reg) = (expr);                                                                           \
        value;                                                                                                         \
    })
#define FIXED_ARG_S32(reg, expr)                                                                                       \
    ({                                                                                                                 \
        register s32 value asm(reg) = (expr);                                                                          \
        value;                                                                                                         \
    })

extern const GameProc sEntityProcB[17];
extern const GameProc sEntityProcD[17];
extern const u8 sEntitySubtypeLut[20];

extern void sub_08007660(u32 arg);
extern void sub_08007DD0(void);
extern void sub_0800793C(u32 a, u32 b);
extern void sub_080031D4(u32 arg);
extern void sub_08008174(void);
extern void sub_080090B0(void);
extern void sub_0800A4D0(void);
extern void sub_0800F24C(u8 arg);
extern void sub_08002EE8(s32 a, void *b);
extern void sub_08009A58(void);
extern void sub_08009188(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern u8 sub_0800CD88();
extern void sub_08006B88(void *a, u32 b);
extern void sub_08020C78(u32 arg);

void sub_08003254(void *arg)
{
    u8 result;

    sub_08007660(6);
    sub_08007DD0();

    {
        u8 *p6110 = (u8 *)0x03006110;

        if (*(u32 *)(p6110 + 16) == 0) {
            sub_0800793C(24, 24);
        } else if (*(u32 *)(p6110 + 16) == 2) {
            sub_080031D4(2);
        }
    }

    sub_08008174();
    sub_080090B0();
    sub_0800A4D0();

    {
        register const GameProc *procs asm("r1") = sEntityProcB;
        register GameStuff *g asm("r4") = &gGameStuff;
        register u8 id asm("r2");
        register u32 offset asm("r0");

        id = g->pendingMode;
        offset = id << 2;
        offset += (u32)procs;
        (*(GameProc *)offset)();
    }

    {
        register GameStuff *g asm("r4") = &gGameStuff;
        u8 *p6110 = (u8 *)0x03006110;

        if (*(u32 *)(p6110 + 16) == 0) {
            register const volatile u8 *lut asm("r0") = sEntitySubtypeLut;

            g = (GameStuff *)(u32)g->pendingMode;
            sub_0800F24C(lut[(u32)g]);
        } else {
            register const volatile u8 *lut asm("r0") = sEntitySubtypeLut;
            s32 subtype;

            g = (GameStuff *)(u32)g->pendingMode;
            subtype = lut[(u32)g];
            subtype <<= 24;
            subtype >>= 24;
            sub_08002EE8(subtype, arg);
        }
    }

    {
        register const GameProc *procsD asm("r1") = sEntityProcD;
        register GameStuff *gTail asm("r5");

        gTail = &gGameStuff;
        {
            register u8 id asm("r3");
            register u32 offset asm("r0");

            id = gTail->pendingMode;
            offset = id << 2;
            offset += (u32)procsD;
            (*(GameProc *)offset)();
        }

        sub_08009A58();
        sub_08009188();
        sub_080008DC();
        sub_0800A328();
        sub_080094F8();
        sub_08009984();

        {
            register struct IwramAt3720 *p3720 asm("r1") = &gIwram_3720;

            if ((p3720->_field_34 & 4) != 0)
                goto inc_timer;
        }

        {
            u8 *p6110 = (u8 *)0x03006110;

            if (*(u32 *)(p6110 + 16) != 2)
                goto inc_timer;
        }

        {
            register struct IwramAt35E0 *ent asm("r4") = &gIwram_35E0;

            result = sub_0800CD88(FIXED_ARG_U8("r0", ent->_field_18), FIXED_ARG_U8("r1", ent->_field_19),
                                  FIXED_ARG_S32("r2", ent->_field_8), FIXED_ARG_S32("r3", ent->_field_A));
            gTail = (GameStuff *)(u32)gTail->_unk10;
            if (((u32)gTail & 1) == 0) {
                if (result == 2) {
                    register struct IwramAt35E0 *entArg asm("r0") = (struct IwramAt35E0 *)ent;

                    sub_08006B88(entArg, 0x400);
                    sub_08020C78(93);
                }
            }
        }

    inc_timer:
        gGameStuff._unk14++;
    }
}
