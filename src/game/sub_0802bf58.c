#include "game.h"
#include "iwram.h"
#include "types.h"

extern u32 sub_0800679C(u8 *base, u32 selector, u32 bit);
extern void sub_080066C4(u8 *base, u32 selector, u32 bit);
extern void sub_08006600(u8 *base, u32 selector, u32 bit);
extern void sub_0802C200(u32 sound);
extern u32 sub_08015194(void);
extern u8 sub_08014EE8(const void *a0, u8 a1, const void *a2, u8 a3);
extern u8 sub_08015044(const void *a0, u8 a1, const void *a2, u8 a3);
extern void sub_08006B88(void *p, u16 mask);

extern const u8 sSpawnTable_0830791C[];
extern const u8 sSpawnTable_083079DC[];
extern const u8 sSpawnRecords_08307CB0[];

struct IwramAt6540_2C000 {
    u8 field_00;
    u8 _pad01[0x33];
    s16 field_34;
    s16 field_36;
};

extern struct IwramAt6540_2C000 gIwram_6540;
extern u8 gIwram_64C0;

/* Mode-2 sibling of sub_0802C7EC (dispatched from sub_0800D8A0). When the
 * room's "start" flag (selector 3, bit 5) is set, snapshot the global timer
 * into the entity pool and arm the timeout; once more than 400 ticks elapse,
 * advance the gate counter and either re-arm (3,5) or trip it (3,6). */
void sub_0802BF58(void)
{
    u8 *base6110 = (u8 *)&gIwram_6110;
    u32 *startTime;
    u8 *base3720;

    if ((u8)sub_0800679C(base6110, 3, 5)) {
        u8 *p = (u8 *)gEntities;
        *(u32 *)(p + 0xb1c) = gGameStuff._unk00;
        *(u8 *)(p + 0x4ea) = 0;
        *(u16 *)(p + 0x504) |= 2;
        sub_080066C4(base6110, 3, 5);
    }

    /* startTime caches the gGameStuff pointer so its load is sequenced before
     * the entity base, matching the baserom's register order in the timer
     * subtraction (minuend loaded first). */
    startTime = &gGameStuff._unk00;
    base3720 = (u8 *)gEntities;
    if (*startTime - *(u32 *)(base3720 + 0xb1c) > 400) {
        if (++gIwram_6110.gateByte > 2) {
            gIwram_6110.gateByte = 0;
            sub_08006600(base6110, 3, 6);
        } else {
            sub_08006600(base6110, 3, 5);
        }
    }

    sub_0802C200(0x5c);
}

void sub_0802C000(void)
{
    u8 *base3720;
    s32 gateOffset;
    u8 result;

    {
        u8 *p = (u8 *)&gIwram_6110;
        u8 *base6110;
        u8 cond;

        cond = (u8)sub_0800679C(p, 3, 5);
        base6110 = p;
        if (cond) {
            p = (u8 *)gEntities;

            *(u8 *)(p + 0x4ea) = 0;
            *(u16 *)(p + 0x504) |= 2;
            sub_08015194();
            p += 0xb1c;
            *(u32 *)p = gGameStuff._unk00;
            sub_080066C4(base6110, 3, 5);
        }
    }

    result = 0;
    base3720 = (u8 *)gEntities;
    switch (*(s16 *)(base3720 + 0xaf2) % 3) {
    case 0:
        gIwram_64C0 = 1;
        result = sub_08015044(sSpawnTable_083079DC, 12, sSpawnRecords_08307CB0, 0);
        if (result)
            result = 2;
        break;
    case 1:
        gIwram_6540.field_00 = 1;
        result = sub_08014EE8(sSpawnTable_0830791C, 8, sSpawnRecords_08307CB0, 0);
        if (result)
            result = 2;
        break;
    case 2:
        result = sub_08014EE8(sSpawnTable_0830791C, 8, sSpawnRecords_08307CB0, 0);
        result += sub_08015044(sSpawnTable_083079DC, 12, sSpawnRecords_08307CB0, 0);
        break;
    }

    if (result == 2) {
        u8 *p = (u8 *)gEntities;
        u16 *counter;

        counter = (u16 *)(p + 0xaf2);
        *counter += 1;
        gateOffset = 0x2a;
        if ((s16)*counter == 3)
            ((u8 *)&gIwram_6110)[gateOffset] += 1;

        if ((s16)*counter > 2) {
            *counter = 0;
            ((u8 *)&gIwram_6110)[gateOffset] = 0;
            sub_08006600((u8 *)&gIwram_6110, 3, 6);
            sub_08006600((u8 *)&gIwram_6110, 3, 1);
            sub_080066C4((u8 *)&gIwram_6110, 3, 0);
        } else {
            sub_08006600((u8 *)&gIwram_6110, 3, 5);
        }
    }

    if (gGameStuff._unk10 & 1)
        return;
    if (gEntities[0].status & 4)
        return;

    if ((s16)(gIwram_6540.field_36 / 3) == gIwram_35E0._field_A) {
        if ((u8)(gEntities[0].field_1A - 8) > 3)
            sub_08006B88(&gIwram_35E0, 0x2000);
    }

    if ((s16)(gIwram_6540.field_34 / 3) == gIwram_35E0._field_8) {
        if ((u8)(gEntities[0].field_1A - 8) > 3)
            sub_08006B88(&gIwram_35E0, 0x2000);
    }
}
