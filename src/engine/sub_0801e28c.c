#include "game.h"
#include "gfx.h"
#include "sound.h"
#include "gba/dma.h"
#include "gba/io.h"
#include "iwram.h"
#include "save.h"
#include "constants/input.h"
#include "types.h"

extern void text_0800e76c(void);
extern void Sound_DrainActiveSlots(void);
extern void Sound_DrainIfActive(void);
extern void Sound_Reset(void);
extern s32 Blend_StepFade(void);
extern void DrawByteDecimal(u8 value, u8 x, u8 y, u16 a, u16 b, u8 c);
extern void DrawNumber(u16 value, u8 x, u8 y, u16 a, u16 b, u8 c, u32 forceZeros);
extern u32 GetFrameTick(void);
extern u16 Input_Poll(void);
extern void Screen_ClearBlocks(s32 mode);
extern void Screen_Install(s32 flag, s32 a, s32 b, struct ScreenInstallArgs args, s32 last);
extern void Screen_InstallOamA(s32 a, s32 b, s32 c, s32 d);
extern void Sprite_CycleDmaFrame(u32 a, u32 b, u32 c, u32 d);
extern void sub_0801EA08(void);
extern void SoundSlot_EnableAndLoad(u32 arg);
extern void Music_Resume(void);
extern void Music_Stop(void);
extern void Sound_ClearActiveFlag(void);

extern u16 gIwram_5398;
extern const u32 sOamDmaCfg_08100[4];
extern const u16 sScreenAuxTilesC578[];
extern const u16 text_08219378[];
extern const u16 sScreenTilemap_E9C18[1024];
extern const u16 sScreenTilemap_EA418[1024];

/* Per-language tilemap tables (linker-assigned, see linker.ld). */
extern const void *const sContinueTilemapTable_308F98[];
extern const void *const sScreenTilemapTable_308F84[];

/* Palette entry 253: the countdown digits' colour. Deliberately NOT a vu16:
 * a volatile access recolours the save/restore around it (r0/r1/r2 rotate). */
#define PAL_CONTINUE_TIMER   (*(u16 *)0x050001FA)

#define CONTINUE_SECONDS     10
#define CONTINUE_TIMER_RGB   0x2D7
#define CONTINUE_WINDOW_TILE 0xF039 /* screenblock-31 fill behind the prompt */

/* Fade out, flash the aux tiles onto screenblock 31, hold, then fade and
 * wipe screenblocks 28..31. A `static inline` rather than a macro: both
 * inlined copies share one 4-byte frame temp for `fill` (sp+0xC), which is
 * what keeps `window` at sp+0x10 in Level_Load. */
static inline void GameOver_Sequence(void)
{
    u16 fill;

    gSoundState.flags &= ~2;
    Sound_DrainIfActive();
    Sound_PlayIfEnabled(0x11);

    Blend_StartFade(0xBF);
    while (Blend_StepFade() != 0)
        WaitFrames(2);

    REG_DMA3.src = sScreenAuxTilesC578;
    REG_DMA3.dst = (void *)0x0600F800;
    REG_DMA3.cnt = DMA_ENABLE | 0x400;
    (void)REG_DMA3.cnt;

    Screen_BeginFlash(0xBF);
    while (Screen_TickFlash() != 0)
        WaitFrames(2);
    WaitFrames(250);

    gSoundState.flags |= 2;
    Sound_Reset();

    Blend_StartFade(0xBF);
    while (Blend_StepFade() != 0)
        WaitFrames(2);

    fill = 0;
    REG_DMA3.src = &fill;
    REG_DMA3.dst = (void *)0x0600E000;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)REG_DMA3.cnt;
    fill = 0;
    REG_DMA3.src = &fill;
    REG_DMA3.dst = (void *)0x0600E800;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)REG_DMA3.cnt;
    fill = 0;
    REG_DMA3.src = &fill;
    REG_DMA3.dst = (void *)0x0600F000;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)REG_DMA3.cnt;
    fill = 0;
    REG_DMA3.src = &fill;
    REG_DMA3.dst = (void *)0x0600F800;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)REG_DMA3.cnt;
}

/* "Continue?" prompt, run from Scene_EntityTick when the last life is lost.
 * Counts down from 10 s; LEFT/RIGHT pick YES/NO, A confirms, B or timeout
 * means NO. Returns 1 to continue (one continue consumed) or 0 for game over. */
u32 Level_Load(void)
{
    TilemapRect yesRect;
    TilemapRect noRect;
    u32 result = 1;
    u16 savedPal;
    u8 savedUnk18;
    u32 secondsLeft = CONTINUE_SECONDS;
    u32 start;
    u16 color;

    text_0800e76c();

    REG_DMA3.src = sContinueTilemapTable_308F98[gIwram_34B0._data];
    REG_DMA3.dst = (void *)0x0600B000;
    REG_DMA3.cnt = DMA_ENABLE | 0x600;
    (void)REG_DMA3.cnt;

    /* The colour goes through a u16 local so the palette store is a plain
     * strh (a constant store would add a truncation copy). */
    color = CONTINUE_TIMER_RGB;
    savedPal = PAL_CONTINUE_TIMER;
    PAL_CONTINUE_TIMER = color;

    yesRect.x = 11;
    yesRect.y = 11;
    yesRect.w = 3;
    yesRect.h = 3;
    noRect.x = 16;
    noRect.y = 12;
    noRect.w = 3;
    noRect.h = 2;

    Sound_DrainActiveSlots();

    if (gSaveData.header._field2 == 0) {
        Sound_DrainActiveSlots();
        GameOver_Sequence();
        return 0;
    }

    {
        /* volatile + this block scope: the volatile store reproduces the
         * baserom's truncation copy before the strh, and declaring it after
         * the early return above lands its slot past the inlined frame temp. */
        volatile u16 window;

        savedUnk18 = gGameStuff._unk18;
        gGameStuff._unk18 = 0;

        window = CONTINUE_WINDOW_TILE;
        REG_DMA3.src = (const void *)&window;
        REG_DMA3.dst = (void *)0x0600F800;
        REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
        (void)REG_DMA3.cnt;

        REG_DMA3.src = text_08219378;
        REG_DMA3.dst = (void *)0x0600F800;
        REG_DMA3.cnt = DMA_ENABLE | 0x400;
        (void)REG_DMA3.cnt;

        DrawByteDecimal(CONTINUE_SECONDS, 14, 9, 0x1B2, 14, 3);
        DrawNumber(gSaveData.header._field2, 19, 6, 0x1B2, 14, 3, 0);

        gIwram_5398 = 0;
        start = GetFrameTick();

        while (gIwram_5398 != INPUT_A && gIwram_5398 != INPUT_B) {
            if (GetFrameTick() - start >= 60) {
                secondsLeft -= (GetFrameTick() - start) / 60;
                if (secondsLeft <= 5)
                    Sound_Play(0x68);
                if (secondsLeft == 0) {
                    result = 0;
                    break;
                }
                start = GetFrameTick();
            }

            DrawByteDecimal(secondsLeft, 14, 9, 0x1B2, 14, 3);

            gIwram_5398 = Input_Poll();
            switch (gIwram_5398) {
            case INPUT_LEFT:
                Sound_Play(2);
                Tilemap_SwapPalette(&yesRect, 15, 14, 3);
                Tilemap_SwapPalette(&noRect, 14, 15, 3);
                result = 1;
                break;
            case INPUT_RIGHT:
                Sound_Play(2);
                Tilemap_SwapPalette(&yesRect, 14, 15, 3);
                Tilemap_SwapPalette(&noRect, 15, 14, 3);
                result = 0;
                break;
            case INPUT_B:
                Sound_Play(0);
                result = 0;
                break;
            }
        }

        if (gIwram_5398 == INPUT_A && result != 0)
            gSaveData.header._field2--;
        gIwram_5398 = 0;

        if (result == 0)
            GameOver_Sequence();

        PAL_CONTINUE_TIMER = savedPal;

        window = 0;
        REG_DMA3.src = (const void *)&window;
        REG_DMA3.dst = (void *)0x0600F800;
        REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
        (void)REG_DMA3.cnt;

        gGameStuff._unk18 = savedUnk18;
        return result;
    }
}

/* Unreferenced in the ROM: fills screenblock 31 with the prompt tile (show)
 * or clears it. Both arms carry the full DMA so cross-jumping merges only
 * from the `str` on (each arm keeps its own DMA3 base load). */
void Continue_SetWindowFill(u32 show)
{
    volatile u16 fill;

    if (show != 0) {
        fill = CONTINUE_WINDOW_TILE;
        REG_DMA3.src = (const void *)&fill;
        REG_DMA3.dst = (void *)0x0600F800;
        REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
        (void)REG_DMA3.cnt;
    } else {
        fill = 0;
        REG_DMA3.src = (const void *)&fill;
        REG_DMA3.dst = (void *)0x0600F800;
        REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
        (void)REG_DMA3.cnt;
    }
}

/* Options menu (sound / music / lives / continues): gHandlerTable_08308AD4[0]. */
void OptionsMenu_Init(void)
{
    struct ScreenInstallArgs args;
    u32 lang;
    u32 reentry;
    s32 a;

    args._unk00 = 0;
    lang = gIwram_34B0._data;
    args.tilemap1 = (lang == 3) ? sScreenTilemap_EA418 : sScreenTilemap_E9C18;
    args.tilemap2 = sScreenTilemapTable_308F84[lang];
    args._unk0C = 0;

    gIwram_3480.cursorIndex = 0;

    REG_DISPCNT |= DISPCNT_BG1_ON;

    Screen_ClearBlocks(14);

    reentry = gIwram_34A0.reentryFlag;
    a = 29;
    if (reentry != 0)
        a = 27;
    Screen_Install(reentry == 0, a, 6, args, 2);

    REG_DMA3.src = args.tilemap1;
    REG_DMA3.dst = (void *)0x0600e800;
    REG_DMA3.cnt = DMA_ENABLE | 0x400;
    (void)REG_DMA3.cnt;

    sub_0801EA08();

    gIwram_34A0._field_04 = 0;
    gIwram_3480.menuStep++;
}

/* gHandlerTable_08308AD4[1]. Cursor rows: 0 sound, 1 music, 2 starting
 * lives, 3 continues (the last two step through 3 / 5 / 9). */
void OptionsMenu_Update(void)
{
    gIwram_5398 = Input_Poll();

    switch (gIwram_5398) {
    case INPUT_UP:
        Sound_Play(2);
        if (gIwram_3480.cursorIndex == 0) {
            gIwram_3480.cursorIndex = 3;
            break;
        }
        gIwram_3480.cursorIndex--;
        break;
    case INPUT_DOWN: {
        /* Two read-modify-writes on the cursor byte. `next` is assigned twice, so
         * global-alloc colours it (r1) and the block keeps exactly three local
         * pseudos: agbcc's 3-qty hand sort in local-alloc is a broken compare on
         * qty numbers, which lets the base pointer (born first) take r0. See
         * docs/codegen-notes.md "local-alloc's <=3-qty hand sort". */
        u32 three;
        u32 next;

        Sound_Play(2);
        next = gIwram_3480.cursorIndex + 1;
        gIwram_3480.cursorIndex = next;
        three = 3;
        next = three & *(volatile u8 *)&gIwram_3480.cursorIndex;
        gIwram_3480.cursorIndex = next;
        break;
    }
    case INPUT_LEFT:
        Sound_Play(2);
        switch (gIwram_3480.cursorIndex) {
        case 0:
            if (gIwram_34B4._data[0] != 1)
                SoundSlot_EnableAndLoad(20);
            gIwram_34B4._data[0] = 1;
            break;
        case 1:
            Music_Resume();
            gIwram_34B4._data[1] = 1;
            break;
        case 2:
            switch (gIwram_34B4._data[2]) {
            case 5:
                gIwram_34B4._data[2] = 3;
                break;
            case 9:
                gIwram_34B4._data[2] = 5;
                break;
            }
            gIwram_35E0.lives = gIwram_34B4._data[2];
            break;
        case 3:
            switch (gIwram_34B4._data[3]) {
            case 5:
                gIwram_34B4._data[3] = 3;
                break;
            case 9:
                gIwram_34B4._data[3] = 5;
                break;
            }
            break;
        }
        break;
    case INPUT_RIGHT:
        Sound_Play(2);
        switch (gIwram_3480.cursorIndex) {
        case 0:
            Sound_ClearActiveFlag();
            gIwram_34B4._data[0] = 0;
            break;
        case 1:
            Music_Stop();
            gIwram_34B4._data[1] = 0;
            break;
        case 2:
            switch (gIwram_34B4._data[2]) {
            case 3:
                gIwram_34B4._data[2] = 5;
                break;
            case 5:
                gIwram_34B4._data[2] = 9;
                break;
            }
            gIwram_35E0.lives = gIwram_34B4._data[2];
            break;
        case 3:
            switch (gIwram_34B4._data[3]) {
            case 3:
                gIwram_34B4._data[3] = 5;
                break;
            case 5:
                gIwram_34B4._data[3] = 9;
                break;
            }
            break;
        }
        break;
    case INPUT_A:
    case INPUT_START:
        Sound_Play(1);
        gIwram_34A0.reentryFlag = 0;
        Screen_InstallOamA(0, 29, 6, 2);
        gIwram_3480.menuStep++;
        break;
    }

    if (gIwram_5398 == INPUT_B) {
        Sound_Play(0);
        gIwram_34A0.reentryFlag = 0;
        Screen_InstallOamA(0, 29, 6, 2);
        gIwram_3480.menuStep++;
    } else if (gIwram_5398 != 0 && gIwram_5398 != INPUT_A && gIwram_5398 != INPUT_START) {
        sub_0801EA08();
    } else {
        Sprite_CycleDmaFrame(sOamDmaCfg_08100[0], sOamDmaCfg_08100[1], sOamDmaCfg_08100[2], sOamDmaCfg_08100[3]);
    }

    gIwram_5398 = 0;
}
