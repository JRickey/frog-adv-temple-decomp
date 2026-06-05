#include "types.h"

typedef struct SoundSlot {
    u8 _pad00[0x38];
    u32 active;
    u8 _pad3C[4];
} SoundSlot;

typedef struct SoundSystem {
    u8 count;
    u8 status;
    u8 _pad02[0xc6];
    SoundSlot *swSlots;
    u32 *resetTable;
    u8 _padD0[0x44];
    u32 *channelSeqs;
    SoundSlot *activeSlot;
    u32 _pad11C;
    u32 *slotTable;
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

extern void sub_0802E724(s32 ch);
extern void sub_08030264(void);

void sub_0802D8F8(void)
{
    SoundSystem **pp;
    SoundSystem **channelPp;
    SoundSystem *ss;
    s32 i;

    *(u8 *)((u8 *)gpSoundSystem->activeSlot + 0x151) = 0;

    i = 0;
    if (i < (s32)gpSoundSystem->count + 4) {
        channelPp = &gpSoundSystem;
        {
            u32 zero = 0;

            do {
                ss = *channelPp;
                ss->channelSeqs[i * 4] = zero;
                ss->slotTable[i] = zero;
                sub_0802E724(i);
                i++;
            } while (i < (s32)(*channelPp)->count + 4);
        }
    }

    i = 0;
    {
        SoundSystem **pool = &gpSoundSystem;
        SoundSystem *head;

        head = *pool;
        pp = pool;
        if (i < (s32)head->count) {
            register SoundSystem **loopPp asm("r5");

            loopPp = pp;
            {
                u32 zero = 0;

                do {
                    ss = *loopPp;
                    ss->resetTable[i] = zero;
                    ss->swSlots[i].active = zero;
                    i++;
                } while (i < (s32)ss->count);
            }
        }
    }

    (*pp)->status = 0;
    sub_08030264();
}
