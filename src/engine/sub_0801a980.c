#include "game.h"
#include "iwram.h"
#include "types.h"

u16 Input_Poll(void);
void WaitVblank(void);
void Room_InitWindowAndState(u8 mode);
void IrisOpen(u8 flags, u8 count);
void Credits_InitStateB(u8 mode);
u8 CreditsRoll_StepThrottled(u8 mode);

extern u16 gIwram_5398;

struct Sub0801AB44RoomState {
    u8 _pad00[8];
    u32 field_8;
};

struct Sub0801AB44Penalty {
    u8 _pad00[2];
    u16 value;
};

void IrisClose(u8 flags, u8 count_)
{
    register s32 count asm("r4") = count_;
    u32 left = 104;
    u8 step = 56 / count;
    u8 top = 56;
    u32 stepc = step;
    register s32 countPlusOne asm("r0") = count + 1;
    u8 n = countPlusOne;

    if (n != 0) {
        do {
            *(vu16 *)0x04000040 = 0xf0;
            *(vu16 *)0x04000044 = (left << 8) | 0xa0;
            *(vu16 *)0x04000042 = 0xf0;
            *(vu16 *)0x04000046 = top;
            WaitVblank();
            {
                u32 newLeft = left + step;
                left = (u8)newLeft;
            }
            top = (u8)(top - stepc);
            n = n - 1;
        } while (n != 0);
    }

    *(vu16 *)0x04000040 = 0xf0;
    *(vu16 *)0x04000044 = 0xa0;
    *(vu16 *)0x04000042 = 0xf0;
    *(vu16 *)0x04000046 = 0;
    *(vu16 *)0x04000000 &= 0xf7ff;

    if (flags & 1) {
        *(vu16 *)0x04000000 &= 0xdfff;
    }

    if (flags & 2) {
        *(vu16 *)0x04000000 &= 0xbfff;
    }
}

void Credits_DmaLoadTiles(u8 index)
{
    vu32 *dma;
    const u32 *sourceA;
    const u32 *sourceB;
    const u32 *palette;
    u32 offset;

    offset = (u32)index << 24;
    sourceA = (const u32 *)0x081DAB78;
    sourceB = (const u32 *)0x081DAB58;
    dma = (vu32 *)0x040000D4;

    palette = (const u32 *)0x08308F3C;
    dma[0] = palette[0];
    dma[1] = 0x050001E0;
    dma[2] = 0x80000010;
    dma[2];

    dma[0] = (u32)sourceB;
    dma[1] = 0x0600FBF4;
    dma[2] = 0x80000004;
    dma[2];

    dma[0] = (u32)sourceB + 8;
    dma[1] = 0x0600FC34;
    dma[2] = 0x80000004;
    dma[2];

    dma[0] = (u32)sourceB + 16;
    dma[1] = 0x0600FC74;
    dma[2] = 0x80000004;
    dma[2];

    dma[0] = (u32)sourceB + 24;
    dma[1] = 0x0600FCB4;
    dma[2] = 0x80000004;
    dma[2];

    offset = offset >> 22;
    offset += 4;
    dma[0] = *(const u32 *)(offset + (u32)palette);
    dma[1] = 0x050001E0;
    dma[2] = 0x80000010;
    dma[2];

    dma[0] = (u32)sourceA;
    dma[1] = 0x0600F841;
    dma[2] = 0x80000004;
    dma[2];

    dma[0] = (u32)sourceA + 8;
    dma[1] = 0x0600F881;
    dma[2] = 0x80000004;
    dma[2];

    dma[0] = (u32)sourceA + 16;
    dma[1] = 0x0600F8C1;
    dma[2] = 0x80000004;
    dma[2];

    dma[0] = (u32)sourceA + 24;
    dma[1] = 0x0600F901;
    dma[2] = 0x80000004;
    dma[2];
}

u32 LevelSelect_Enter(u8 arg)
{
    u8 mode;
    s8 i;
    u32 bits;
    s32 highest;
    vu16 *win;
    struct Sub0801AB44RoomState *roomState;
    struct Sub0801AB44Penalty *penalty;

    mode = (u8)(arg - 1);
    if (mode % 3 == 0) {
        mode = (u8)(mode / 3);
        goto mode_ready;
    }

    if (mode != 13) {
        return 1;
    }
    mode = 5;

mode_ready:
    if (mode == 5) {
        i = 15;
        bits = gGameStuff._unk0C;
        while (i >= 0) {
            if (((bits >> i) & 1) != 0) {
                highest = i + 1;
                goto check_mode5;
            }
            i--;
        }
        highest = 0;

    check_mode5:
        if ((u8)highest > 13) {
            return 1;
        }
    }

    if (mode == 4) {
        i = 15;
        bits = gGameStuff._unk0C;
        while (i >= 0) {
            if (((bits >> i) & 1) != 0) {
                highest = i + 1;
                goto check_mode4;
            }
            i--;
        }
        highest = 0;

    check_mode4:
        if ((u8)highest > 12) {
            return 1;
        }
    }

    Room_InitWindowAndState(mode);
    IrisOpen(3, 20);
    Credits_DmaLoadTiles(mode);
    Credits_InitStateB(mode);

    do {
        gIwram_5398 = Input_Poll();
    } while (CreditsRoll_StepThrottled(mode) != 0xFE);

    IrisClose(3, 20);

    win = (vu16 *)0x04000040;
    *win = 0;
    win += 2;
    *win = 0;
    win--;
    *win = 0;
    win += 2;
    *win = 0;
    win++;
    *win = 0;
    win++;
    *win = 0;

    if (mode == 4) {
        /* Fixed pointer regs force the case-4 `ldr r0; ldr r1; adds r2, r0` shared-store tail. */
        register struct Sub0801AB44RoomState *case4RoomState asm("r2");
        register struct Sub0801AB44RoomState *loadedRoomState asm("r0");
        u32 case4Result;

        loadedRoomState = (struct Sub0801AB44RoomState *)0x03003540;
        case4Result = loadedRoomState->field_8;
        case4RoomState = loadedRoomState;
        if (case4Result != 0) {
            roomState = case4RoomState;
            penalty = (struct Sub0801AB44Penalty *)&gIwram_35E0;
            penalty->value -= 50;
            goto return_room_result;
        }
    }

    roomState = (struct Sub0801AB44RoomState *)0x03003540;
    if (mode == 5 && roomState->field_8 != 0) {
        penalty = (struct Sub0801AB44Penalty *)&gIwram_35E0;
        penalty->value -= 75;
    }

return_room_result:
    return roomState->field_8;
}
