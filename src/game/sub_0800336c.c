#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* sub_0800336C — per-frame handler for game-mode 17 (re-entered for mode 24).
 * Same family as sub_08002844 (mode 15): an on-stack sub-state machine that
 * loops while gGameStuff.mode stays at 17 or 24, dispatching each tick through
 * a 9-entry computed-jump table after a per-frame sub_08020BC0() tick.
 *
 * Three stack cells drive it: a dispatch sub-state byte, a 0x87-seeded
 * halfword, and a signed counter byte. The 72-byte head of the frame is the
 * scratch buffer handed to sub_08006BB4 on entry.
 *
 * Built with old_agbcc (see Makefile): the newer agbcc schedules the case-3
 * `ldrh` flag reads ahead of the shared `8`-constant materialisation, while
 * the baserom (and old_agbcc) defer them. The case-3 local base pointers keep
 * each flag read in the expected block, and the case-6 split `c0`/`c` locals
 * keep the two signed counter probes distinct.
 */

extern void sub_08020BC0(void);
extern void sub_08006BB4(u32 arg, void *buf);
extern u8 sub_0800A104(u8 *state, u32 callbackTable);
extern u32 sub_08009D9C(u8 *state);
extern u16 sub_080004C4(void);
extern u16 sub_08000678(void);
extern void sub_0800E060(void);
extern void sub_08003254(void *arg, void *buf);
extern u32 sub_08009C14(u8 *state);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800A1C8(void);
extern void sub_080008DC(void);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void sub_0800336C(void)
{
    u8 buf[72];
    u8 counter;
    u16 hw;
    u8 state;

    state = 0;
    hw = 0x87;

    while (gGameStuff.mode == 17 || gGameStuff.mode == 24) {
        sub_08020BC0();
        if (state > 8)
            continue;

        switch (state) {
        case 0:
            gGameStuff.pendingMode = 10;
            sub_08006BB4(6, buf);
            state = 1;
            counter = 0;
            break;
        case 1:
            if (sub_0800A104(&counter, 0x0800359D) == 0)
                goto finalize;
            state = 2;
            gGameStuff._unk14 = 0;
            counter = 0;
            goto finalize;
        case 2:
            if (sub_08009D9C(&counter) == 0)
                break;
            state = 3;
            gGameStuff._unk14 = 0;
            break;
        case 3:
            if (gIwram_6110._field_10 == 0)
                gIwram_5398 = sub_080004C4();
            else
                gIwram_5398 = sub_08000678();
            if (gIwram_5398 == 0x40) {
                state = 5;
                sub_0800E060();
                break;
            }
            {
                struct IwramAt3720 *p3720 = &gIwram_3720;
                if ((p3720->_field_34 & 8) != 0) {
                    state = 4;
                    break;
                }
            }
            {
                struct IwramAt6110 *p6110 = &gIwram_6110;
                if ((p6110->_field_2e & 8) != 0) {
                    state = 8;
                    break;
                }
            }
            sub_08003254(&hw, buf);
            break;
        case 4:
            if (sub_08009C14(&state) == 0)
                state = 7;
            gIwram_6110._field_10 = 0;
            hw = 0x87;
            counter = 0;
            break;
        case 5:
            gIwram_5398 = sub_080004C4();
            if (sub_0800E6A8() == 0) {
                state = 6;
                counter = 0;
            }
            if (gIwram_5328 == 0)
                state = 3;
            break;
        case 6: {
            s32 c0;
            s32 c;
            c0 = (s8)counter;
            if (c0 != 0)
                goto state6_check;
            sub_08010694(0xBF);
            counter++;
        state6_check:
            c = (s8)counter;
            if (c != 1)
                break;
            if (sub_080106B8() != 0)
                break;
            gIwram_3480._data[0] = 4;
            gIwram_3480._data[6] = c;
            gGameStuff.mode = 4;
            break;
        }
        case 7:
            if (sub_0800A104(&counter, 0x0800A26D) != 0) {
                state = 2;
                gGameStuff._unk14 = 0;
                counter = 0;
                sub_0800A1C8();
            }
            /* fall through */
        finalize:
            sub_080008DC();
            break;
        case 8:
            sub_0800DE80();
            break;
        }
    }
}

void sub_08003584(void *buf)
{
    gGameStuff.pendingMode = 10;
    sub_08006BB4(6, buf);
}

extern void sub_0800658C(void *p, u32 a, u32 b, const void *table, u32 e, u32 f);
extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

/* Sibling of sub_08001D18/sub_08001484. Installs config table 0x082f9aec into
 * the gGameStuff_6110 cluster via the shared 6-arg setup helper, then primes
 * the post-setup state (sub_0800CE98(0xb, 0); sub_08009CBC()). */
void sub_0800359C(void)
{
    sub_0800658C((void *)0x03006110, 0x80, 0xb, (const void *)0x082f9aec, 1, 3);
    sub_0800CE98(0xb, 0);
    sub_08009CBC();
}

void sub_080035D0(u8 *state, u16 *hw)
{
    if (sub_08009C14(state) == 0)
        *state = 7;
    gIwram_6110._field_10 = 0;
    *hw = 0x87;
}

void sub_080035F8(void)
{
    sub_0800DE80();
}

extern u32 sub_0800CD88(u8 col, u8 row, s16 tileX, s16 tileY);
extern void sub_08006B88(struct IwramAt35E0 *p, u32 mask);
extern void sub_08020C78(u32 arg);

void sub_08003604(void)
{
    struct IwramAt35E0 *p;
    u8 tile;

    if ((gIwram_3720._field_34 & 4) != 0)
        return;

    if (gIwram_6110._field_10 != 2)
        return;

    p = &gIwram_35E0;
    tile = (u8)sub_0800CD88(p->_field_18, p->_field_19, p->_field_8, p->_field_A);

    if ((gGameStuff._unk10 & 1) != 0)
        return;

    if (tile != 2)
        return;

    sub_08006B88(p, 0x400);
    sub_08020C78(0x5d);
}
