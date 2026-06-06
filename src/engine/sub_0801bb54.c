#include "macros.h"
#include "types.h"

/* --- ShowWinLoseMessage: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "types.h"

extern void text_0800e76c(void);
extern void DrawTextGlyphs(const u8 *str, int len, int x, int y, int a, int b, int c);
extern u16 Input_Poll(void);
extern void FrogStatusBar_Update(void);
extern u32 SoundSystem_IsActive(void);
extern u32 GetFrameTick(void);
extern void Sound_DrainIfActive(void);

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

void ShowWinLoseMessage(u8 kind)
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
        DrawTextGlyphs(msgs.p[gIwram_34B0._data], len, x, yArg, 278, 14, 3);

        if (gIwram_34B4._data[0] != 0) {
            while (SoundSystem_IsActive() != 0 && gIwram_5398 == 0) {
                FrogStatusBar_Update();
                gIwram_5398 = Input_Poll();
            }
            goto done;
        }

        startFrame = GetFrameTick();
        if (gIwram_5398 != 0)
            goto done;
        do {
            gIwram_5398 = Input_Poll();
            FrogStatusBar_Update();
            if (GetFrameTick() - startFrame > 120)
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
        DrawTextGlyphs(WORLD_CLEARED_TABLES[gIwram_34B0._data][idx], len, x, yArg, 278, 14, 3);

        GetFrameTick();
        if (gIwram_34B4._data[0] != 0) {
            while (SoundSystem_IsActive() != 0 && gIwram_5398 == 0) {
                gIwram_5398 = Input_Poll();
                FrogStatusBar_Update();
            }
            goto done;
        }

        startFrame = GetFrameTick();
        if (gIwram_5398 != 0)
            goto done;
        do {
            gIwram_5398 = Input_Poll();
            FrogStatusBar_Update();
            if (GetFrameTick() - startFrame > 120)
                gIwram_5398 = 16;
        } while (gIwram_5398 == 0);
        goto done;

    case 3:
        DrawTextGlyphs(MSG_YOU_WIN, 7, 11, yArg, 278, 14, 3);
        startFrame = GetFrameTick();
        do {
            FrogStatusBar_Update();
            gIwram_5398 = Input_Poll();
            if (GetFrameTick() - startFrame > 179)
                goto cleanup;
        } while (gIwram_5398 == 0);
        goto cleanup;

    case 4:
        DrawTextGlyphs(MSG_YOU_LOSE, 8, 11, yArg, 278, 14, 3);
        startFrame = GetFrameTick();
        do {
            FrogStatusBar_Update();
            gIwram_5398 = Input_Poll();
            if (GetFrameTick() - startFrame > 179)
                goto cleanup;
        } while (gIwram_5398 == 0);
        goto cleanup;

    default:
        goto cleanup;
    }

done:
    Sound_DrainIfActive();
    gStructAt3003570 |= 2;

cleanup:
    gIwram_5398 = 0;
    BG_PAL_1DA = savedPal;
    DrawTextGlyphs(MSG_BLANK, 30, 0, yArg, 278, 14, 3);

epilogue:;
}
#else
NAKED void ShowWinLoseMessage(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x1bb54, 0x328\n");
}
#endif /* NON_MATCHING */
