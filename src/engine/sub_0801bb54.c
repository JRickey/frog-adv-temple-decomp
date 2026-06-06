#include "macros.h"
#include "types.h"

/* --- sub_0801BB54: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "types.h"

extern void text_0800e76c(void);
extern void sub_0801BE7C(const u8 *str, int len, int x, int y, int a, int b, int c);
extern u16 sub_080004C4(void);
extern void sub_08017000(void);
extern u32 sub_08032148(void);
extern u32 sub_08000900(void);
extern void sub_08020BAC(void);

extern u16 gIwram_5398;

#define gStructAt3003570 (*(u8 *)0x03003570)
#define BG_PAL_1DA       (*(vu16 *)0x050001DA)

typedef struct {
    const u8 *p[5];
} MsgTable;

#define LEVEL_CLEARED_TABLE  (*(const MsgTable *)0x081BDFF4)
#define WORLD_CLEARED_TABLES ((const u8 *const *const *)0x083087B4)

#define MSG_YOU_WIN          ((const u8 *)0x081BE008)
#define MSG_YOU_LOSE         ((const u8 *)0x081BE010)
#define MSG_BLANK            ((const u8 *)0x081BE01C)

void sub_0801BB54(u8 kind)
{
    MsgTable msgs;
    register const u8 *str asm("r4");
    register u8 len asm("r6");
    u8 i;
    u8 x;
    u8 idx;
    u32 startFrame;
    register u8 pendingMode asm("r5");
    register u16 savedPal asm("r9");
    register u32 yArg asm("r8");

    msgs = LEVEL_CLEARED_TABLE;
    text_0800e76c();
    savedPal = BG_PAL_1DA;
    yArg = 10;
    pendingMode = gGameStuff.pendingMode;

    if (pendingMode == 15)
        goto epilogue;

    switch (kind) {
    case 0:
        goto cleanup;

    case 1:
        str = msgs.p[gIwram_34B0._data];
        len = 0;
        i = 0;
        if (str[0] != '|') {
            do {
                if (str[i] == '[')
                    i = (u8)(i + 4);
                else
                    i = (u8)(i + 1);
                len = (u8)(len + 1);
            } while (str[i] != '|');
        }
        x = (u8)((30 - len) / 2);
        sub_0801BE7C(msgs.p[gIwram_34B0._data], len, x, yArg, 278, 14, 3);

        if (gIwram_34B4._data[0] != 0) {
            while (sub_08032148() != 0 && gIwram_5398 == 0) {
                sub_08017000();
                gIwram_5398 = sub_080004C4();
            }
            goto done;
        }

        startFrame = sub_08000900();
        if (gIwram_5398 != 0)
            goto done;
        do {
            gIwram_5398 = sub_080004C4();
            sub_08017000();
            if (sub_08000900() - startFrame > 120)
                gIwram_5398 = 16;
        } while (gIwram_5398 == 0);
        goto done;

    case 2:
        if (pendingMode % 3 != 0 || pendingMode == 0) {
            if (pendingMode != 16)
                goto done;
        }
        idx = (u8)(pendingMode / 3 - 1);
        str = WORLD_CLEARED_TABLES[gIwram_34B0._data][idx];
        len = 0;
        i = 0;
        if (str[0] != '|') {
            do {
                if (str[i] == '[')
                    i = (u8)(i + 4);
                else
                    i = (u8)(i + 1);
                len = (u8)(len + 1);
            } while (str[i] != '|');
        }
        x = (u8)((30 - len) / 2);
        sub_0801BE7C(WORLD_CLEARED_TABLES[gIwram_34B0._data][idx], len, x, yArg, 278, 14, 3);

        sub_08000900();
        if (gIwram_34B4._data[0] != 0) {
            while (sub_08032148() != 0 && gIwram_5398 == 0) {
                gIwram_5398 = sub_080004C4();
                sub_08017000();
            }
            goto done;
        }

        startFrame = sub_08000900();
        if (gIwram_5398 != 0)
            goto done;
        do {
            gIwram_5398 = sub_080004C4();
            sub_08017000();
            if (sub_08000900() - startFrame > 120)
                gIwram_5398 = 16;
        } while (gIwram_5398 == 0);
        goto done;

    case 3:
        sub_0801BE7C(MSG_YOU_WIN, 7, 11, yArg, 278, 14, 3);
        startFrame = sub_08000900();
        do {
            sub_08017000();
            gIwram_5398 = sub_080004C4();
            if (sub_08000900() - startFrame > 179)
                goto cleanup;
        } while (gIwram_5398 == 0);
        goto cleanup;

    case 4:
        sub_0801BE7C(MSG_YOU_LOSE, 8, 11, yArg, 278, 14, 3);
        startFrame = sub_08000900();
        do {
            sub_08017000();
            gIwram_5398 = sub_080004C4();
            if (sub_08000900() - startFrame > 179)
                goto cleanup;
        } while (gIwram_5398 == 0);
        goto cleanup;

    default:
        goto cleanup;
    }

done:
    sub_08020BAC();
    gStructAt3003570 |= 2;

cleanup:
    gIwram_5398 = 0;
    BG_PAL_1DA = savedPal;
    sub_0801BE7C(MSG_BLANK, 30, 0, yArg, 278, 14, 3);

epilogue:;
}
#endif /* NON_MATCHING */
