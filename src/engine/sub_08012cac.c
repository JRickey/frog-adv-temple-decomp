#include "macros.h"
#include "types.h"
#include "iwram.h"
#include "game.h"

extern u8 gIwram_6400[];
extern u8 gIwram_6410[];
extern u8 gIwram_60A0[];

void sub_08012CAC(void)
{
    register u8 *scrollState asm("r5");
    register GameStuff *gs asm("r4");
    register u32 anchor asm("r1");
    register struct IwramAt3550 *bg asm("r3");
    register struct IwramAt3550 *bgSave;
    register u32 prev asm("r0");
    s32 delta;
    register u32 elapsed asm("r1");
    u32 oldCur;
    u32 newCur;
    register u8 maxFrames asm("r0");
    u8 state;

    bg = &gIwram_3550;
    oldCur = bg->_data[5];
    scrollState = gIwram_60A0;
    anchor = *(u32 *)(scrollState + 16);
    {
        register u8 *anim0 asm("r2") = gIwram_6400;

        prev = *(u32 *)(anim0 + 4);
        delta = anchor;
        delta -= prev;
        newCur = delta + oldCur;
        bg->_data[5] = newCur;
        *(u32 *)(anim0 + 4) = anchor;
        gs = &gGameStuff;
        elapsed = gs->_unk00;
        prev = *(u32 *)(anim0 + 8);
        elapsed -= prev;
        bgSave = bg;
        maxFrames = anim0[12];
        if (elapsed >= maxFrames) {
            state = anim0[0];
            if (state == 1)
                goto case1;
            if (state == 2)
                goto case2;
            goto skip1;
        case1:
            bgSave->_data[5] = newCur + 1;
            goto done1;
        case2:
            bgSave->_data[5] = newCur - 1;
        done1:
        skip1:
            *(u32 *)(anim0 + 8) = gs->_unk00;
        }
    }

    {
        register struct IwramAt3550 *bg2 asm("r6") = bgSave;
        register u32 oldCurB asm("r5");
        register u32 newCurB asm("r3");

        anchor = *(u32 *)(scrollState + 12);
        {
            register u8 *anim1 asm("r2") = gIwram_6410;
            u8 maxFrames1;

            prev = *(u32 *)(anim1 + 4);
            delta = anchor;
            delta -= prev;
            oldCurB = bg2->_data[4];
            newCurB = oldCurB + delta;
            bg2->_data[4] = newCurB;
            *(u32 *)(anim1 + 4) = anchor;
            prev = gs->_unk00;
            elapsed = *(u32 *)(anim1 + 8);
            prev -= elapsed;
            maxFrames1 = anim1[12];
            if (prev >= maxFrames1) {
                state = anim1[0];
                if (state == 3)
                    goto case3;
                if (state == 4)
                    goto case4;
                goto skip2;
            case3:
                prev = newCurB + 1;
                bg2->_data[4] = prev;
                goto done2;
            case4:
                prev = newCurB - 1;
                bgSave->_data[4] = prev;
            done2:
            skip2:
                *(u32 *)(anim1 + 8) = gs->_unk00;
            }
        }
    }
}
