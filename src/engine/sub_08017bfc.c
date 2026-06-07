#include "gfx.h"
#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "gba/io.h"
#include "iwram.h"

asm(".global sub_08015EC4\n"
    ".thumb_set sub_08015EC4, 0x08015EC5\n"
    ".global sub_08015F9C\n"
    ".thumb_set sub_08015F9C, 0x08015F9D\n"
    ".global sub_0801629C\n"
    ".thumb_set sub_0801629C, 0x0801629D\n"
    ".global sub_080162FC\n"
    ".thumb_set sub_080162FC, 0x080162FD");

extern u16 gIwram_5398;
extern const void *const sUiAssetSlots[];

struct IwramAt5330 {
    u8 _pad00[9];
    u8 _field_09;
    u8 _field_0A;
};

extern struct IwramAt5330 gIwram_5330;

u32 GetFrameTick(void);
int Blend_StepFade(void);
u16 Blend_StartFade(u16 arg);
void sub_08015EC4(u32 x, u32 y, const void *src, void *dst);
void sub_08015F9C(u32 x, u32 y, const void *src, void *dst);
void sub_0801629C(u32 x, u32 y, const void *src, void *dst);
void sub_080162FC(u32 x, u32 y, const void *src, void *dst);
void Menu25_InitKeyTable(void);
void Menu25_PollInput(u8 arg);
void FrogSelect_ValidateSelection(void);
void FrogSelect_ClearInputState(void);
void Sound_PlayIfEnabled(u32 arg);
void Sound_Reset(void);

void Menu25_LoadAssets(void)
{
    vu16 *displayControl;
    const void *const volatile *assets;
    register void *layout asm("r5");
    struct IwramAt3480 *state;
    volatile DmaChannel *dma;
    const void *tiles;
    int fade;

    gIwram_5398 = 0;

    state = &gIwram_3480;
    state->_data[3] = 0;
    state->_data[1] = 0;
    state->_data[2] = 0;
    state->_data[7] = 0;
    state->_data[5] = 0;
    state->_data[8] = 0;

    FrogSelect_ClearInputState();
    Menu25_InitKeyTable();
    Sound_Reset();
    Sound_PlayIfEnabled(20);

    fade = Blend_StepFade();
    if (fade != 0) {
        return;
    }

    gIwram_3550._data[0] = fade;
    gIwram_3550._data[1] = fade;
    *(vu16 *)0x0400000C = fade;

    displayControl = (u16 *)0x04000000;
    {
        register u16 displayValue asm("r0") = 0x1F04;
        *displayControl = displayValue;
    }

    dma = &REG_DMA3;
    assets = sUiAssetSlots;
    dma->src = assets[34];
    dma->dst = (void *)0x05000000;
    dma->cnt = DMA_ENABLE | 0x100;
    (void)dma->cnt;

    tiles = assets[33];
    layout = gIwram_3470;
    sub_0801629C(0, 0, tiles, layout);
    sub_080162FC(0, 0, tiles, layout);

    tiles = assets[36];
    layout = gIwram_3474;
    sub_08015F9C(0x28, 0x21, tiles, layout);

    if (state->_data[6] != 0) {
        sub_08015EC4(0x28, 0x21, tiles, layout);

        {
            const void *const *assetCursor = (const void *const *)((const u8 *)assets + 0x9C);
            sub_08015EC4(0x50, 0x6E, *assetCursor, gIwram_3478);
        }
    }
    if ((*displayControl & 0x10) != 0) {
        vu16 *displayControlForRead = displayControl;
        u16 value = *displayControlForRead;
        value ^= 0x10;
        *displayControl = value;
    }

    Screen_BeginFlash(0xBF);
    state->_data[0]++;
}

void Menu25_WaitAndBlink(void)
{
    struct IwramAt3480 *state;
    const void *tiles;
    int fade;

    state = &gIwram_3480;
    state->_data[5] = 0;

    fade = Screen_TickFlash();
    if (fade != 0) {
        return;
    }

    if (state->_data[6] == 0) {
        if (GetFrameTick() - state->_unk0C <= 59) {
            return;
        }

        state->_data[0]++;
        state->_unk0C = GetFrameTick();
        state->_unk10 = GetFrameTick();
        gIwram_5398 = fade;

        if ((*(vu16 *)0x04000000 & 0x10) == 0) {
            *(vu16 *)0x04000000 ^= 0x10;
        }

        tiles = sUiAssetSlots[36];
        sub_08015EC4(0x28, 0x21, tiles, gIwram_3474);

        tiles = sUiAssetSlots[39];
        sub_08015EC4(0x50, 0x6E, tiles, gIwram_3478);
        return;
    }

    state->_data[0]++;
    state->_unk0C = GetFrameTick();
    state->_unk10 = GetFrameTick();
    gIwram_5398 = fade;
}

void Menu25_HandleInput(void)
{
    struct IwramAt3480 *state;
    vu16 *inputState;
    register u32 input asm("r4");
    u32 zero;

    state = &gIwram_3480;
    zero = 0;
    state->_data[6] = zero;
    inputState = &gIwram_5398;
    Menu25_PollInput(*(vu8 *)inputState);
    input = *inputState;

    if (input == 0x40) {
        FrogSelect_ValidateSelection();
        gIwram_34A0._field_08 = 1;
        gIwram_5330._field_09 = 0x1B;
        state->_data[0] += 2;
        state->_unk14 = zero;
        Blend_StartFade(0xBF);
        *inputState = zero;
        state->_data[5] = 0;
        return;
    }

    if (input == 0) {
        if (GetFrameTick() - state->_unk10 > 15) {
            if (state->_data[8] == 0) {
                if ((*(vu16 *)0x04000000 & 0x10) != 0) {
                    *(vu16 *)0x04000000 ^= 0x10;
                }
                state->_data[8] = 1;
            }
            {
                struct IwramAt3480 *stateForTick;
                u32 now;

                now = GetFrameTick();
                stateForTick = &gIwram_3480;
                stateForTick->_unk10 = now;
            }
        } else if (state->_data[7] == 50) {
            if (state->_data[8] != 0) {
                if ((*(vu16 *)0x04000000 & 0x10) == 0) {
                    *(vu16 *)0x04000000 ^= 0x10;
                }
                state->_data[8] = input;
                state->_data[7] = input;
            } else {
                goto checkTimeout;
            }
        }

        {
            struct IwramAt3480 *stateForBlink;

            stateForBlink = &gIwram_3480;
            if (stateForBlink->_data[8] != 0) {
                stateForBlink->_data[7]++;
            }
        }

    checkTimeout: {
        struct IwramAt3480 *stateForTimeout;
        u32 now;

        now = GetFrameTick();
        stateForTimeout = &gIwram_3480;
        if (now - stateForTimeout->_unk0C > 599) {
            gIwram_5330._field_0A = 1;
            gIwram_34C0.holdFlag = 0;
            gIwram_34C0.cursor = 0;
            gIwram_34C0.stepTick = 0;
            gIwram_34C0.lastTick = 0;
            gIwram_34C0.delay = 0;
            stateForTimeout->_data[5] = 4;
            stateForTimeout->_data[0] = 0;
            stateForTimeout->_unk0C = GetFrameTick();
            Sound_Reset();
        }
    }
    } else {
        state->_unk0C = GetFrameTick();
    }
}

void Menu25_SetupRects(void)
{
    gIwram_3480._data[0]++;

    gIwram_3470[0] = 0;
    gIwram_3470[1] = 0;
    gIwram_3470[2] = 0xF0;
    gIwram_3470[3] = 0xA0;

    gIwram_34B8._data[0] = 0;
    gIwram_34B8._data[1] = 0;
    gIwram_34B8._data[2] = 0x50;
    gIwram_34B8._data[3] = 0x18;
}

struct ScreenInstallArgs {
    u32 _unk00;
    const void *tilemap1;
    const void *tilemap2;
    u32 _unk0C;
};

extern void Screen_ClearBlocks(s32 mode);
extern void Screen_Install(s32 flag, s32 a, s32 b, struct ScreenInstallArgs args, s32 last);
extern void WinPoseScreen_LoadSprites(void);
extern void FrogSelect_LoadCharTilemap(void);

extern const u16 sBgTilemap_E6C18[];

void Menu25_InstallBg(void)
{
    struct IwramAt3480 *state;
    u32 field08;
    s32 count;
    u32 tableBase;
    struct ScreenInstallArgs args;

    args._unk00 = 0;
    args.tilemap1 = sBgTilemap_E6C18;

    /* Anchor the ROM table literal into a register before the gIwram_34B0 index
       load; without the fence agbcc defers the table base and emits the index
       load into r0 first (ARGUMENT_MISMATCH at +0x12). Same idiom as FrogSelect_LoadCharTilemap. */
    tableBase = 0x08308f70;
    asm volatile("" : "+r"(tableBase));
    args.tilemap2 = (const void *)*(const u32 *)(tableBase + gIwram_34B0._data * 4);
    args._unk0C = 0;

    REG_DISPCNT &= ~DISPCNT_BG1_ON;

    state = &gIwram_3480;
    state->_data[0] = 10;
    if (gIwram_34A0._field_08 != 0) {
        state->_unk14 = 0;
    }

    Screen_ClearBlocks(14);

    field08 = gIwram_34A0._field_08;
    count = (field08 != 0) ? 23 : 25;
    Screen_Install((field08 == 0), count, 6, args, 2);

    REG_DMA3.src = sBgTilemap_E6C18;
    REG_DMA3.dst = (void *)0x0600e800;
    REG_DMA3.cnt = DMA_ENABLE | 0x400;
    (void)REG_DMA3.cnt;

    WinPoseScreen_LoadSprites();

    REG_DISPCNT |= DISPCNT_BG3_ON;
    FrogSelect_LoadCharTilemap();
}
